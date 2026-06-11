{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      disable_ligatures = "yes";
      enable_audio_bell = "no";
      shell = "zsh";
      shell_integration = "disabled";

      cursor_shape = "beam";
      cursor_trail = 10;
      cursor_trail_start_threshold = 0;
      cursor_trail_decay = "0.01 0.1";
      cursor_blink = "yes";

      url_style = "curly";
      remember_window_size = "no";

      scrollbar_handle_opacity = 0;
      scrollbar_track_opacity = 0;
      scrollbar_track_hover_opacity = 0;

      confirm_os_window_close = 0;
      sync_to_monitor = "no";
    };

    extraConfig = ''
      foreground           #ffffff
      background           #101010
      selection_foreground #b0b0b0
      selection_background #272727
      cursor               #b0b0b0
      cursor_text_color    #101010
      color0  #101010
      color1  #ff5733
      color2  #86cd82
      color3  #d9ba73
      color4  #b3b3b3
      color5  #f2a4db
      color6  #5abfb5
      color7  #a5adce
      color8  #666666
      color9  #ff7676
      color10 #a3d6a3
      color11 #ffffff
      color12 #666666
      color13 #f4b8e4
      color14 #fafafa
      color15 #b5bfe2
    '';
  };
}
