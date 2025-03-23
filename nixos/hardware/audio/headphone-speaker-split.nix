# https://github.com/luisbocanegra/linux-guide-split-audio-ports
{
  codec,
  pcie-vendor-id,
  pcie-device-id,
  alsa-vendor-id,
  alsa-subsystem-id,
  alsa-speaker-device ? 0,
  alsa-headphones-device ? 2,
}:
{ pkgs, ... }:
let
  alsa-split-ports = pkgs.writeShellApplication {
    name = "alsa-split-ports.sh";
    runtimeInputs = [ pkgs.bash pkgs.gnugrep pkgs.alsa-utils  ];
    text = /* bash */ ''
      CODEC="${codec}"
      VENDOR_ID="${alsa-vendor-id}"
      SUBSYSTEM_ID="${alsa-subsystem-id}"
      HINTS="indep_hp = yes
      vmaster = no
      "

      get_codec_hwdep() {
        local codec=$1
        local vendor_id=$2
        local subsystem_id=$3
        local addr=""
        [[ -z "$codec" || -z "$vendor_id" || -z "$subsystem_id" ]] && { echo "ERROR: Not enough arguments given"; return; }
        for file in /sys/class/sound/hw*; do
          if [[ -n "$addr" ]]; then
            echo "$addr"
            return
          fi
          if grep -q "$codec" "$file/chip_name" && grep -q "$vendor_id" "$file/vendor_id" && grep -q "$subsystem_id" "$file/subsystem_id"; then
            addr=$file
          fi
        done
        if [[ -z "$addr" ]]; then
          echo "ERROR: Could not get address for c:$codec v:$vendor_id s:$subsystem_id"
          return
        fi
        echo "$addr"
        return
      }
      # get_codec_hwdep "$CODEC" "$VENDOR_ID" "$SUBSYSTEM_ID"
      hwdep="$(get_codec_hwdep "$CODEC" "$VENDOR_ID" "$SUBSYSTEM_ID")"

      if [[ "$hwdep" == *"ERROR"* || -z "$hwdep" ]]; then
      exit 1
      fi


      while IFS=$'\n' read -r line; do
      if [[ -z "$line" ]]; then
          continue
      fi
      echo "$line > $''\{hwdep}/hints"
      echo "$line" > "$''\{hwdep}/hints"
      done <<< "$HINTS"

      echo "echo 1 > $''\{hwdep}/reconfig"
      echo 1 > "$''\{hwdep}"/reconfig

      # wait some time to intialize before restoring
      sleep 5
      alsactl restore
    '';
  };
in
{
  environment.etc = {
    "alsa-card-profile/mixer/paths/analog-output-speaker-split.conf" = {
      source = pkgs.substitute {
        src = "${pkgs.pipewire.out}/share/alsa-card-profile/mixer/paths/analog-output-speaker.conf";
        substitutions = [
          "--replace-fail"
          /* ini */ ''
            [Jack Headphone]
            state.plugged = no
          ''
          /* ini */ ''
            [Jack Headphone]
            state.plugged = unknown
          ''
          "--replace-fail"
          /* ini */ ''
            [Element Headphone]
            switch = off
            volume = off
          ''
          /* ini */ ''
            ;[Element Headphone]
            ;switch = off
            ;volume = off
          ''
        ];
      };
    };
    "alsa-card-profile/mixer/profile-sets/split-ports-profile.conf" = {
      text = /* ini */ ''
        [General]
        auto-profiles = yes

        [Mapping analog-stereo-speaker]
        description = Speakers
        device-strings = hw:%f,${builtins.toString alsa-speaker-device}
        paths-output = analog-output-speaker-split
        channel-map = left,right
        direction = output

        [Mapping analog-stereo-headphones]
        description = Headphones
        device-strings = hw:%f,${builtins.toString alsa-headphones-device}
        paths-output = analog-output-headphones
        channel-map = left,right
        direction = output

        [Mapping analog-stereo-input]
        description = Microphone
        device-strings = hw:%f,0
        channel-map = left,right
        paths-input = analog-input-front-mic analog-input-rear-mic analog-input-internal-mic analog-input-dock-mic analog-input analog-input-mic analog-input-linein analog-input-aux analog-input-video analog-input-tvtuner analog-input-fm analog-input-mic-line analog-input-headphone-mic analog-input-headset-mic
        direction = input

        [Profile output:analog-stereo-headphones+output:analog-stereo-speaker+input:analog-stereo-input]
        description = Analog Stereo Duplex
        output-mappings = analog-stereo-headphones analog-stereo-speaker
        input-mappings = analog-stereo-input
        priority = 6000

        [Profile output:analog-stereo-headphones+output:analog-stereo-speaker]
        description = Analog Stereo Outputs Only
        output-mappings = analog-stereo-headphones analog-stereo-speaker
        priority = 70
      '';
    };
  };
  services.udev.extraRules = /* udev */ ''
    SUBSYSTEM!="sound", GOTO="pipewire_split_end"
    ACTION!="change", GOTO="pipewire_split_end"
    KERNEL!="card*", GOTO="pipewire_split_end"

    SUBSYSTEMS=="pci", ATTRS{vendor}=="${pcie-vendor-id}", ATTRS{device}=="${pcie-device-id}", \
    ENV{ACP_PROFILE_SET}="/etc/alsa-card-profile/mixer/profile-sets/split-ports-profile.conf", \
    RUN+="${alsa-split-ports}/bin/alsa-split-ports.sh"

    LABEL="pipewire_split_end"
  '';
}
