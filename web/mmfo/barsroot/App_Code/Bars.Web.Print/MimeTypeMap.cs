using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MimeTypeMap
/// </summary>
/// example taken from here: https://www.ryadel.com/en/get-file-content-mime-type-from-extension-asp-net-mvc-core/ 

public static class MimeTypeMap
{
    private static readonly Lazy<IDictionary<string, string>> _mappings = new Lazy<IDictionary<string, string>>(BuildMappings);

    private static IDictionary<string, string> BuildMappings()
    {
        var mappings = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
        {
             {".pdf", "application/pdf"},
             {".rtf", "application/rtf"},
             {".doc", "application/msword"},
             {".docx", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"},
             {".csv", "text/csv"},
             {".xls", "application/vnd.ms-excel"},
             {".xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"},
             {".htm", "text/html"},
             {".html", "text/html"},
             {".pptx", "application/vnd.openxmlformats-officedocument.presentationml.presentation"},
             {".txt", "text/plain"},
             {".xml", "text/xml"}
        };

        var cache = mappings.ToList(); // need ToList() to avoid modifying while still enumerating

        foreach (var mapping in cache)
        {
            if (!mappings.ContainsKey(mapping.Value))
            {
                mappings.Add(mapping.Value, mapping.Key);
            }
        }

        return mappings;
    }

    public static string GetMimeType(string extension)
    {
        if (extension == null)
        {
            throw new ArgumentNullException("extension");
        }

        if (!extension.StartsWith("."))
        {
            extension = "." + extension;
        }

        string mime;
        _mappings.Value.TryGetValue(extension, out mime);

        //return _mappings.Value.TryGetValue(extension, out mime) ? mime : "application/octet-stream";
        return mime;
    }

    public static string GetExtension(string mimeType)
    {
        if (mimeType == null)
        {
            throw new ArgumentNullException("mimeType");
        }

        if (mimeType.StartsWith("."))
        {
            throw new ArgumentException("Requested mime type is not valid: " + mimeType);
        }

        string extension;

        if (_mappings.Value.TryGetValue(mimeType, out extension))
        {
            return extension;
        }

        throw new ArgumentException("Requested mime type is not registered: " + mimeType);
    }
}