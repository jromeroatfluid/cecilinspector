# CecilInspector

CecilInspector is a small C# utility that analyzes a `.nupkg` (NuGet package) and extracts all its defined classes and namespaces using [Mono.Cecil](https://www.mono-project.com/docs/tools+libraries/libraries/Mono.Cecil/). The output is printed to stdout and can be consumed by other tools via subprocess.

This version is set up to be compiled using [Nix](https://nixos.org) with `buildDotnetModule`, and includes pinned dependencies via `nugetDeps`.

## How it works

It loads a `.nupkg` file, opens the `.dll` inside it, and uses Mono.Cecil to iterate over its types and namespaces. Results are printed as simple text lines.

## Build with Nix

To build the binary with Nix, make sure you're in the root of the project directory and run:

```bash
nix-build -A passthru.fetch-deps
nix-build
```

This will:
1. Fetch the NuGet dependencies and write them to `deps.nix`
2. Build the `CecilInspector` binary under the `./result/bin/` directory

### Sample `default.nix`

```nix
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
```

## Usage

```bash
CecilInspector path/to/package.nupkg
```

## Example Output

```
System.Text.Json
System.Text.Json.Serialization
System.Text.Json.Serialization.JsonConverter
```

## License

MIT