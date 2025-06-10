# CecilInspector

CecilInspector is a lightweight CLI tool built in C# using Mono.Cecil that extracts all public types (classes, interfaces, etc.) from a .NET assembly (.dll). It outputs a JSON array listing the fully qualified names of the exported types.

This tool is primarily used in static reachability analysis to identify which types a given NuGet package exposes — enabling precise import resolution for SCA pipelines.

## 🧰 Dependencies

- [.NET SDK 7.0+ or 8.0+](https://dotnet.microsoft.com/en-us/download)
- [Mono.Cecil](https://www.nuget.org/packages/Mono.Cecil) (installed via NuGet)

## 🛠 Build instructions

To build a self-contained binary for Linux or macOS:

```bash
dotnet publish -c Release -r linux-x64 --self-contained true -p:PublishSingleFile=true -o ./dist
```

For macOS:

```bash
dotnet publish -c Release -r osx-x64 --self-contained true -p:PublishSingleFile=true -o ./dist
```

The binary will be available at:

```
./dist/CecilInspector
```

Make it executable if needed:

```bash
chmod +x ./dist/CecilInspector
```

## 🚀 Usage

Run it against a NuGet .dll file:

```bash
./CecilInspector path/to/library.dll
```

Output:

```json
{
  "types": [
    "DocumentFormat.OpenXml.Spreadsheet.Worksheet",
    "DocumentFormat.OpenXml.Wordprocessing.Paragraph"
  ]
}
```

## 📦 Integration

This tool is meant to be used from Python scripts via subprocess. Example in Python:

```python
result = subprocess.run(
    ["./cecilinspector", "lib.dll"],
    stdout=subprocess.PIPE,
    check=True,
    text=True
)
types = json.loads(result.stdout)["types"]
```

## 📝 License

Internal use only – proprietary.