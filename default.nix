let
  nixpkgs = builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/ab472a7a8fcfd7c778729e7d7c8c3a9586a7cded.tar.gz";
  pkgs  = import nixpkgs {};
in
pkgs.buildDotnetModule {
  pname = "cecilinspector";
  version = "0.0.1";
  src = ./.;
  dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0;
  dotnet-runtime = pkgs.dotnetCorePackages.runtime_8_0;
  nugetDeps = ./deps.nix;
  projectFile = "CecilInspector.csproj";
}