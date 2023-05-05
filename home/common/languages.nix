{ pkgs, ... }:

let
  my-python-packages = python-packages: with python-packages; [
    python-lsp-server
    rope
    flake8
    # pylsp-mypy
    pyls-isort
    pyls-flake8
    # pyls-black
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in
{
  config.home.packages = with pkgs; [
    # clang

    # tree-sitter
    tree-sitter

    # python
    # see emacx.nix for further information
    python-with-my-packages

    # bash
    nodePackages.bash-language-server

    # typescript
    nodePackages.typescript-language-server

    # dockerfile
    nodePackages.dockerfile-language-server-nodejs

    # c/c++
    ccls

    # rust
    rust-analyzer
    rustfmt
    lld

    # go
    # go # disabled becasuse on the macbook it installed with brew
    gopls

    # latex
    texlive.combined.scheme-full

    # nix
    nixpkgs-fmt
    nixpkgs-lint
    rnix-lsp
  ];
}
