{ inputs, ... }: {
  overlays = [
    # # Yazi overlay
    # (final: prev: {
    #   yazi-unwrapped = prev.callPackage ./custompkgs/yazi/yazi-unwrapped.nix {
    #     Foundation = null;
    #   };
    #   yazi = prev.callPackage ./custompkgs/yazi/yazi.nix {
    #     yazi-unwrapped = final.yazi-unwrapped;
    #   };
    # })

    # Firefox Addons overlay
    (final: prev: {
      firefox-addons = import inputs.firefox-addons {
        fetchurl = final.fetchurl;
        lib = final.lib;
        stdenv = final.stdenv;
      };
    })
  ];
}

