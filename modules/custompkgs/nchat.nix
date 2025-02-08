{
  lib,
  fetchFromGitHub,
  file, # for libmagic
  ncurses,
  openssl,
  readline,
  sqlite,
  zlib,
  cmake,
  gperf,
  stdenv,
  darwin,
  go,
  ccache,
  buildGo122Module,
}:

stdenv.mkDerivation rec {
  pname = "nchat";
  version = "5.4.2";

  src = fetchFromGitHub {
    owner = "d99kris";
    repo = "nchat";
    tag = "v${version}";
    hash = "sha256-NrAU47GA7ZASJ7vCo1S8nyGBpfsZn4EBBqx2c4HKx7k=";
  }; + "/lib/wmchat/go/ext/whatsmeow/go.mod";

  goModules = buildGoModule {
    inherit pname version;
    src = src;
    vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash
  };

  # preBuild = ''
    # export HOME=$TMPDIR
    # export GOCACHE=$TMPDIR/go-build
    # cp -r ${goModules}/go/pkg/mod $TMPDIR/go-modules
    # export GOPATH=$TMPDIR/go-modules
  # '';

  postPatch = ''
    substituteInPlace lib/tgchat/ext/td/CMakeLists.txt \
      --replace "get_git_head_revision" "#get_git_head_revision"
    substituteInPlace lib/tgchat/CMakeLists.txt \
      --replace-fail "list(APPEND OPENSSL_ROOT_DIR" "#list(APPEND OPENSSL_ROOT_DIR"
  '';

  nativeBuildInputs = [
    cmake
    gperf
    go
  ];

  buildInputs =
    [
      file # for libmagic
      ncurses
      openssl
      readline
      sqlite
      zlib
    ]
    ++ lib.optionals stdenv.isDarwin (
      with darwin.apple_sdk.frameworks;
      [
        AppKit
        Cocoa
        Foundation
      ]
    );

  cmakeFlags = [
    "-DCMAKE_INSTALL_LIBDIR=lib"
    "-DHAS_DUMMY=OFF"
    "-DHAS_TELEGRAM=OFF"
    # "-DHAS_WHATSAPP=OFF" # go module build required
  ];

  meta = {
    description = "Terminal-based chat client with support for Telegram and WhatsApp";
    changelog = "https://github.com/d99kris/nchat/releases/tag/v${version}";
    homepage = "https://github.com/d99kris/nchat";
    license = lib.licenses.mit;
    mainProgram = "nchat";
    maintainers = with lib.maintainers; [
      luftmensch-luftmensch
      sikmir
    ];
    platforms = lib.platforms.unix;
  };
}

