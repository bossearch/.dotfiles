{ config, pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   (nerdfonts.override { fonts = [ "Meslo" ]; })
  #   noto-fonts
  #   noto-fonts-lgc-plus
  #   noto-fonts-cjk-sans
  #   noto-fonts-color-emoji
  # ];
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "noto-fonts-color-emoji" ];
      };
      localConf = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>

            <!-- Add generic family. -->
            <match target="pattern">
                <test qual="any" name="family"><string>emoji</string></test>
                <edit name="family" mode="assign" binding="same"><string>Noto Color Emoji</string></edit>
            </match>

            <!-- This adds Noto Color Emoji as a final fallback font for the default font families. -->
            <match target="pattern">
                <test name="family"><string>sans</string></test>l.
                <edit name="family" mode="append"><string>Noto Color Emoji</string></edit>
            </match>

            <match target="pattern">
                <test name="family"><string>serif</string></test>
                <edit name="family" mode="append"><string>Noto Color Emoji</string></edit>
            </match>

            <match target="pattern">
                <test name="family"><string>sans-serif</string></test>
                <edit name="family" mode="append"><string>Noto Color Emoji</string></edit>
            </match>

            <match target="pattern">
                <test name="family"><string>monospace</string></test>
                <edit name="family" mode="append"><string>Noto Color Emoji</string></edit>
            </match>

            <!-- Block Symbola from the list of fallback fonts. -->
            <selectfont>
                <rejectfont>
                    <pattern>
                        <patelt name="family">
                            <string>Symbola</string>
                        </patelt>
                    </pattern>
                </rejectfont>
            </selectfont>
        </fontconfig>
      '';
    };
  };
}
