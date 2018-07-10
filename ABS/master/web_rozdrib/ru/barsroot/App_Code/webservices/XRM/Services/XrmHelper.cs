using System;
using Oracle.DataAccess.Client;
using System.IO;

namespace Bars.WebServices.XRM.Services
{
    public static class XrmHelper
    {
        public static DateTime? GmtToLocal(DateTime? dateTime)
        {
            if (dateTime.HasValue && dateTime != null)
            {
                TimeZoneInfo tz = TimeZoneInfo.Local;
                DateTime _dateTime = dateTime.Value;
                return TimeZoneInfo.ConvertTimeFromUtc(_dateTime, tz);
            }
            else { return null; }
        }

        public static string GetMfo(OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select f_ourmfo() from dual";
                object res = cmd.ExecuteScalar();
                if (null == res || string.IsNullOrWhiteSpace(res.ToString())) throw new System.Exception(@"Error getting branch or branch is '/'");
                return Convert.ToString(res);
            }
        }

        public static byte[] CreateFrxFile(string templateFileName, FrxParameters pars, FrxExportTypes type = FrxExportTypes.Pdf)
        {
            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(templateFileName), pars, null);

            byte[] content;
            using (MemoryStream str = new MemoryStream())
            {
                doc.ExportToMemoryStream(type, str);
                content = str.ToArray();
            }
            return content;
        }
    }
}


