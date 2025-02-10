{
  config,
  pkgs,
  ...
}: {
  # NOTE: hardware.enableAllFirmware if using laptop
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    graphics.extraPackages = with pkgs; [
      rocmPackages.clr.icd
      libva
      libva-utils
      mesa
      mesa.drivers
      vulkan-loader
      libva
      libva-utils
      vaapiVdpau
      libvdpau-va-gl
      amdvlk
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
