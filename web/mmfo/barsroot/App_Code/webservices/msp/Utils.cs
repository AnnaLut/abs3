using System;
using System.IO;
using System.Xml;
using System.Xml.Serialization;

namespace Bars.WebServices.MSP.Models
{
    public class Utils
    {
        public static string Serialize<T>(T req)
        {
            string xml = string.Empty;

            XmlWriterSettings settings = new XmlWriterSettings { OmitXmlDeclaration = true, CheckCharacters = false };
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            XmlSerializer ser = new XmlSerializer(typeof(T));

            using (MemoryStream ms = new MemoryStream())
            {
                using (XmlWriter writer = XmlWriter.Create(ms, settings))
                {
                    ser.Serialize(writer, req, names);
                    writer.Close();
                    ms.Flush();
                    ms.Seek(0, SeekOrigin.Begin);
                    using (StreamReader sr = new StreamReader(ms))
                    {
                        xml = sr.ReadToEnd();
                    }
                }
            }
            return xml;
        }

        public static T Deserialize<T>(byte[] buffer)
        {
            using (MemoryStream ms = new MemoryStream(buffer))
            {
                XmlSerializer ser = new XmlSerializer(typeof(T));
                return (T)ser.Deserialize(ms);
            }
        }
    }
}
