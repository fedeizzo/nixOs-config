
{ pkgs, inputs, system, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "JetBrains Mono";
    font.size = 11;
    settings = {
      "enable_audio_bell" = "no";
    };
    keybindings = {
      "alt+k" = "scroll_page_up";
      "alt+j" =  "scroll_page_down";
      "ctrl+t" =  "new_tab_with_cwd";
      "ctrl+tab" =  "next_tab";
    };
    extraConfig = ''
      include ./nord.conf
    '';
  };
  xdg.configFile."kitty/nord.conf" = {
    source = ../dotfiles/kitty/nord.conf;
  };
  xdg.configFile."kitty/open-actions.conf" = {
    source = ../dotfiles/kitty/open-actions.conf;
  };
}
