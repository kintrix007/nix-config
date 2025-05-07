{
  lib,
  stdenv,
  appimageTools,
  makeWrapper,
}:

let
  pname = "drsprinto";
  version = "4.0.7";
  src = /opt/drsprinto/DrSprinto-${version}.AppImage;

  appimage = appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs =
      pkgs: with pkgs; [
        lsb-release # Otherwise it fails to get system info
        vulkan-tools # Maybe?

        libGL
        libglvnd
        ffmpeg
        amdvlk
      ];
  };
  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in

# appimageContents
stdenv.mkDerivation {
  inherit pname version;

  src = appimage;

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ ];

  strictDeps = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r bin $out/bin

    mkdir -p $out/share/${pname}
    cp -a ${appimageContents}/locales $out/share/${pname}
    cp -a ${appimageContents}/resources $out/share/${pname}
    cp -a ${appimageContents}/usr/share/icons $out/share/
    install -Dm 644 ${appimageContents}/${pname}.desktop -t $out/share/applications

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail "AppRun" "${pname}"

    runHook postInstall
  '';

  meta = {
    description = "Security policy compliance software";
    longDescription = ''
      DrSprinto helps you keep your machine compatible with your organisation’s
      security policies.
    '';
    homepage = "https://sprinto.com";
    # license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ kintrix007 ];
    platforms = [ "x86_64-linux" ];
  };
}
