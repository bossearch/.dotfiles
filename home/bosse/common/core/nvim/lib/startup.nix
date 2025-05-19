{
  home.file.".config/nvim/lua/lib/startup.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      awk '/--- NVIM STARTED ---/ && $1 >= 10 {
        printf "\033[38;5;4m \033[0m \033[38;5;38mNixvim started in\033[0m \033[38;5;141m%.2fms\033[0m\n", $1
      }' /tmp/nvim-startup.log | tail -n 1
    '';
  };
}
