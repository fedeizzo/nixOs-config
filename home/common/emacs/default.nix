{ config, emacs-pkg, libs, ... }:
let
  myEmacs = (emacs-pkg.emacsPackagesFor emacs-pkg.emacs29-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      (import ./modules/checkers { epkgs = epkgs; }).packages
      (import ./modules/completion { epkgs = epkgs; }).packages
      (import ./modules/org { epkgs = epkgs; }).packages
      (import ./modules/ui { epkgs = epkgs; }).packages
      (import ./modules/prog { pkgs = emacs-pkg; epkgs = epkgs; }).packages
      (import ./modules/keys { epkgs = epkgs; }).packages
      (import ./modules/life-improvements { epkgs = epkgs; }).packages
      # nano-theme
      # nano-modeline
    ]
  );
  org-cv = emacs-pkg.fetchFromGitLab {
    owner = "fedeizzo";
    repo = "org-cv";
    rev = "master";
    sha256 = "sha256-OQ0WuMXHPusxLPpuVqkq7t1IDZx4ZvPyKdc4h+8QDAs=";
  };
  hideshowvis = emacs-pkg.fetchFromGitHub {
    owner = "sheijk";
    repo = "hideshowvis";
    rev = "3a605b78d88bb974a7346dce72a2508674db310c";
    hash = "sha256-VtOEr5xPvHl3ab2sjBu8j3/e8Mt1C0rShXgtSeoYBYA=";
  };
  hydra-posframe = emacs-pkg.fetchFromGitHub {
    owner = "Ladicle";
    repo = "hydra-posframe";
    rev = "master";
    sha256 = "sha256-9nVBnpaWZIYNDvS2WWBED0HsIRIv4AR4as6wEe463tI=";
  };
  org-outer-indent = emacs-pkg.fetchFromGitHub {
    owner = "rougier";
    repo = "org-outer-indent";
    rev = "master";
    sha256 = "sha256-Lxusc3FXag4qVJjObg6EVcILFnHZXXAyrYNqqCZZF3E=";
  };
  gotest-ui-mode = emacs-pkg.fetchFromGitHub {
    owner = "boinkor-net";
    repo = "gotest-ui-mode";
    rev = "master";
    sha256 = "sha256-220Aw6adN7tDW9f8lZQnWRPEX6Pt8YNO5Lrwb30NsWg=";
  };
  ts-fold = emacs-pkg.fetchFromGitHub {
    owner = "emacs-tree-sitter";
    repo = "ts-fold";
    rev = "01c9ecaaa89966cdcd250ac37c24a9c9f530b725";
    sha256 = "sha256-IwItJNBzaOJlAI1785QiwYLbi1YGRL8+fhv+V4gPhlA=";
  };
  all-the-icons-nerd-fonts = emacs-pkg.fetchFromGitHub {
    owner = "mohkale";
    repo = "all-the-icons-nerd-fonts";
    rev = "67a9cc9de2d2d4516cbfb752879b1355234cb42a";
    hash = "sha256-xgl5MP1w2fu/UQh/r052+f/VOMENlNe7CgUgSVXbdAI=";
  };
in
{
  programs.emacs = {
    enable = true;
    package = myEmacs;
  };
  home.packages = with emacs-pkg; [
    emacs-lsp-booster
    # poppler
    poppler_utils
    imagemagick
    # spell
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science it ]))
    enchant
  ];
  home.sessionVariables.ASPELL_CONF = "dict-dir ${emacs-pkg.aspellWithDicts (ds: with ds; [ en en-computers en-science it ])}/lib/aspell";

  xdg.configFile."emacs/early-init.el".source = ./early-init.el;
  xdg.configFile."emacs/init.el".source = ./init.el;
  xdg.configFile."emacs/welcome.png".source = ./welcome.png;
  xdg.configFile."emacs/modules".source = ./modules;
  xdg.configFile."emacs/org-cv".source = org-cv;
  xdg.configFile."emacs/hydra-posframe".source = hydra-posframe;
  xdg.configFile."emacs/org-outer-indent".source = org-outer-indent;
  xdg.configFile."emacs/gotest-ui-mode".source = gotest-ui-mode;
  xdg.configFile."emacs/ts-fold".source = ts-fold;
  xdg.configFile."emacs/hideshowvis".source = hideshowvis;
  xdg.configFile."emacs/all-the-icons-nerd-fonts".source = all-the-icons-nerd-fonts;
}
