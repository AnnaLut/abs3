using System.Xml.Serialization;
using System.IO;
using System.Xml;
using System;
using System.Text;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Infrastructure.DI.Implementation
{
    public static class XmlSerializerExtensions
    {
        public static string XmlSerialize<T>(this T obj, string xmlRoot, string prefix = "", string ns = "") where T : class, new()
        {
            if (obj == null) throw new ArgumentNullException("obj");

            XmlSerializer xmlSerializer = new XmlSerializer(typeof(T), string.IsNullOrEmpty(xmlRoot) ? null : new XmlRootAttribute(xmlRoot));
            XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces(new[] { XmlQualifiedName.Empty });
            namespaces.Add(string.IsNullOrEmpty(ns) ? "" : prefix, ns);
            XmlWriterSettings settings = new XmlWriterSettings { Encoding = Encoding.UTF8, Indent = false, OmitXmlDeclaration = true };

            using (StringWriter stringWriter = new StringWriter())
            using (XmlWriter xmlWriter = XmlWriter.Create(stringWriter, settings))
            {
                xmlSerializer.Serialize(xmlWriter, obj, namespaces);
                string res = stringWriter.ToString();

                if (string.IsNullOrWhiteSpace(prefix)) return res;

                string r1 = "<" + xmlRoot;
                string r2 = string.Format("</{0}>", xmlRoot);

                return res.Replace(r1, "<" + prefix + ":" + xmlRoot).Replace(r2, string.Format("</{0}:{1}>", prefix, xmlRoot));
            }
        }

        public static T XmlDeserialize<T>(this string xml, string xmlRoot) where T : class, new()
        {
            try
            {
                if (string.IsNullOrEmpty(xml))
                    throw new ArgumentException("XML рядок пустий або відсутній");

                XmlSerializer xmlSerializer = new XmlSerializer(typeof(T), string.IsNullOrEmpty(xmlRoot) ? null : new XmlRootAttribute(xmlRoot));
                using (MemoryStream memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(xml)))
                using (StreamReader streamReader = new StreamReader(memoryStream, Encoding.UTF8))
                {
                    return (T)xmlSerializer.Deserialize(streamReader);
                }
            }
            catch (Exception exception)
            {
                throw new Exception("Помилка при десеріалізації відповіді.", exception.InnerException);
            }
        }
    }
}
