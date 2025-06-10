using System;
using System.Collections.Generic;
using System.IO;
using Mono.Cecil;
using System.Text.Json;

class Program
{
    static void Main(string[] args)
    {
        if (args.Length < 1 || !File.Exists(args[0]))
        {
            Console.Error.WriteLine("Usage: CecilInspector <path_to_dll>");
            return;
        }

        try
        {
            var dllPath = Path.GetFullPath(args[0]);
            var assembly = AssemblyDefinition.ReadAssembly(dllPath);
            var classNames = new List<string>();

            foreach (var type in assembly.MainModule.Types)
            {
                if (!string.IsNullOrEmpty(type.Namespace) && type.IsPublic && !type.IsNested)
                {
                    classNames.Add($"{type.Namespace}.{type.Name}");
                }
            }

            var result = new Dictionary<string, object>
            {
                { "types", classNames }
            };

            string json = JsonSerializer.Serialize(result);
            Console.WriteLine(json);
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"Error: {ex.Message}");
        }
    }
}
