{ pkgs ? import (
    fetchTarball "https://github.com/NixOS/nixpkgs/archive/9790f3242da2152d5aa1976e3e4b8b414f4dd206.tar.gz"
  ) {}
}:
let
  # TODO: when to use override LAMBDA vs. override SET
  # opencv = opencv.override (old: { enableGtk2 = true });
  opencv = pkgs.opencv.override { enableGtk2 = true; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    opencv
    pkg-config
    # https://shivjm.blog/a-more-complicated-docker-image-for-rust-with-nix/
    llvm
    clang
  ];

  # Needed for rust to access libclang-14.so
  LIBCLANG_PATH = "${pkgs.llvmPackages_14.libclang.lib}/lib";
  LOCALE_ARCHIVE = "/usr/lib/locale/locale-archive";
}