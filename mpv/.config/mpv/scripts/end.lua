mp.add_key_binding("b", "end", function()
  -- Path to the bash script
  local script_path = "/home/bosse/.config/mpv/script-opts/end.sh"

  -- Execute the bash script
  local result = os.execute(script_path)
end)
