using System;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public static class XmlSerializerExtensions
    {
        /// <summary>Serializes an object of type T in to an xml string</summary>
        /// <typeparam name="T">Any class type</typeparam>
        /// <param name="obj">Object to serialize</param>
        /// <returns>A string that represents Xml, empty otherwise</returns>
        public static string XmlSerialize<T>(this T obj, Encoding encoding) where T : class, new()
        {
            if (obj == null) throw new ArgumentNullException("obj");
            var xmlSerializer = new XmlSerializer(typeof(T));
            var namespaces = new XmlSerializerNamespaces();
            namespaces.Add(string.Empty, string.Empty);
            var settings = new XmlWriterSettings();
            settings.Encoding = encoding;
            settings.Indent = false;
            settings.OmitXmlDeclaration = true;
            using (var stringWriter = new StringWriter())
            {
                using (var xmlWriter = XmlWriter.Create(stringWriter, settings))
                {
                    xmlSerializer.Serialize(xmlWriter, obj, namespaces);
                    return stringWriter.ToString();
                }
            }
        }


        /// <summary>Deserializes an xml string in to an object of Type T</summary>
        /// <typeparam name="T">Any class type</typeparam>
        /// <param name="xml">Xml as string to deserialize from</param>
        /// <returns>A new object of type T is successful, null if failed</returns>
        public static T XmlDeserialize<T>(this string xml, Encoding encoding)
            where T : class, new()
        {
            try
            {
                if (string.IsNullOrEmpty(xml))
                    throw new ArgumentException("XML рядок пустий або відсутній");

                T res;

                var xmlSerializer = new XmlSerializer(typeof(T));
                using (var memoryStream = new MemoryStream(encoding.GetBytes(xml)))
                {
                    using (var streamReader = new StreamReader(memoryStream, encoding))
                    {
                        res = (T)xmlSerializer.Deserialize(streamReader);
                    }
                }
                return res;
            }
            catch (Exception exception)
            {
                throw new Exception("Помилка при делесеріалізації відповіді.", exception.InnerException);
            }
        }
    }

}