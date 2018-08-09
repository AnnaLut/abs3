using BarsWeb.Areas.FastReport.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Schema;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;

namespace BarsWeb.Areas.FastReport.Helpers
{
    /// <summary>
    /// Вспомогательный клас для привязки модели из xml в FastReportModel
    /// </summary>
    public class FastReportModelBindHelper
    {
        private readonly String xml;
        private FastReportModel model;
        public FastReportModelBindHelper(String xml)
        {
            this.xml = xml;
            model = new FastReportModel();
            model.Parameters = new FrxParameters();
        }

        public FastReportModel GetModel()
        {
            try
            {
                JObject jObj = JObject.Parse(xml);
                if (jObj.IsValid(JsonSchema.Parse(JsonConvert.SerializeObject(model))))
                    return JsonConvert.DeserializeObject<FastReportModel>(xml);
            }
            catch { }
            XDocument xDocument = XDocument.Parse(xml);
            Deserialize(xDocument);
            return model;
        }
        private void Deserialize(XDocument xDocument)
        {

            List<XElement> root = xDocument.Root.Descendants().ToList();
            XElement fileName = root.FirstOrDefault(x => x.Name.LocalName == "FileName");
            XElement responseFileType = root.FirstOrDefault(x => x.Name.LocalName == "ResponseFileType");
            XElement parameters = root.FirstOrDefault(x => x.Name.LocalName == "Parameters");

            model.FileName = fileName.Value;
            model.ResponseFileType = (FrxExportTypes)Convert.ToInt32(responseFileType.Value);
            model.Parameters = GetParameters(parameters);
        }

        private FrxParameters GetParameters(XElement xParameters)
        {
            FrxParameters parameters = new FrxParameters();

            List<XElement> xElements = new XDocument(xParameters).Root.Descendants().Where(x => x.Name.LocalName == "FrxParameter").ToList();
            foreach (XElement parameter in xElements)
            {
                List<XElement> values = parameter.Descendants().ToList();
                TypeCode typeCode = (TypeCode)Convert.ToInt32(values.FirstOrDefault(x => x.Name.LocalName == "Type").Value);
                String value = values.FirstOrDefault(x => x.Name.LocalName == "Value").Value;
                String name = values.FirstOrDefault(x => x.Name.LocalName == "Name").Value;
                parameters.Add(new FrxParameter(name, typeCode, value));
            }
            return parameters;
        }
    }
}