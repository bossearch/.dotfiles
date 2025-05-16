{pkgs,...}:
let
  hostname = builtins.getEnv "HOST";
in
{
  home.packages = [
    pkgs.hello
  ] ++ pkgs.lib.optionals (hostname == "vm") [
    pkgs.cowsay
  ];
}

