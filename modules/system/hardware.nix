{pkgs, ...}: {
  # NOTE: hardware.enableAllFirmware if using laptop
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    graphics.extraPackages = with pkgs; [
      amdvlk
      libva
      libva-utils
      libvdpau-va-gl
      mesa
      mesa.drivers
      rocmPackages.clr.icd
      vaapiVdpau
      vulkan-loader
    ];
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
    i2c.enable = true;
  };
}
