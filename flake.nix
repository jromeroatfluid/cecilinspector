{
  description = "A .NET inspection tool for Cecil";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/ab472a7a8fcfd7c778729e7d7c8c3a9586a7cded";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cecilinspector-pkg = pkgs.buildDotnetModule {
          pname = "cecilinspector";
          version = "0.0.1";
          src = self;

          dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0;
          dotnet-runtime = pkgs.dotnetCorePackages.runtime_8_0;

          nugetDeps = ./deps.nix;

          projectFile = "CecilInspector.csproj";
        };
      in
      {
        packages = {
          default = cecilinspector-pkg;
          cecilinspector = cecilinspector-pkg;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            dotnet-sdk_8
          ];
        };
      });
}