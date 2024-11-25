{
  config,
  pkgs,
  lib,
  ...
}: let
  version = "5.3.0.382";
in
  pkgs.stdenv.mkDerivation {
    name = "cato-client";

    src = pkgs.fetchurl {
      inherit version;
      url = "https://clients.catonetworks.com/linux/5.3.0.382/cato-client-install.deb";
      sha256 = "sha256-2vjMSwGaVwzHr0NjqEKOZHwZu99vW/Ro7WK5YK8T1BQ=";
    };

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = with pkgs; [
      dpkg
      # Additional dependencies autoPatchelfHook discovered
      stdenv.cc.cc.lib
      zlib
    ];

    unpackPhase = ''
      runHook preUnpack

      dpkg -x $src ./cato-src

      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -r cato-src/* "$out"

      mv "$out/lib" "$out/orig_lib"
      mv "$out/usr/"* "$out/"

      mkdir -p "$out/lib/systemd/system/"
      mv "$out/orig_lib/systemd/system/"* "$out/lib/systemd/system/"

      rmdir "$out/orig_lib/systemd/system"
      rmdir "$out/orig_lib/systemd"
      rmdir "$out/orig_lib"
      rmdir "$out/usr"

      substituteInPlace "$out/lib/systemd/system/"*.service --replace "/usr/" "$out/"

      runHook postInstall
    '';
  }
