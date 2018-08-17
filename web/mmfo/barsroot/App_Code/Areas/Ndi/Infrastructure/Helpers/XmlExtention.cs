using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

/// <summary>
/// Summary description for XmlExtention
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers
{
    public class XmlHelper
    {
        public XmlHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static string ObjToXML(object obj)
        {
            var stringwriter = new System.IO.StringWriter();
            var serializer = new XmlSerializer(obj.GetType());
            serializer.Serialize(stringwriter, obj);
            return stringwriter.ToString();
        }

    }
}