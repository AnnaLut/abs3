using BarsWeb.Areas.FastReport.Models;
using System;
using System.IO;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// вспомогательный класс для формирования
    /// файла в Byte[], Base64String, MemoryStream
    /// </summary>
    public class FrxDocHelper
    {
        private FastReportModel Model { get; set; }
        public FrxDocHelper(FastReportModel model)
        {
            this.Model = model;
        }

        public FrxDocHelper(String fileName, FrxExportTypes exportType, FrxParameters parameters)
        {
            Model = new FastReportModel
            {
                FileName = fileName,
                Parameters = parameters,
                ResponseFileType = exportType
            };
        }

        public MemoryStream GetFileStream()
        {
            String filePath = FrxDoc.GetTemplatePathByFileName(Model.FileName);
            FrxDoc frxDoc = new FrxDoc(filePath, Model.Parameters, null);
            using(MemoryStream stream = new MemoryStream())
            {
                frxDoc.ExportToMemoryStream(Model.ResponseFileType, stream);
                return stream;
            }
        }

        public Byte[] GetFileInByteArray()
        {
            using(MemoryStream stream = GetFileStream())
                return stream.ToArray();
        }

        public String GetFileInBase64String()
        {
            Byte[] bytes = GetFileInByteArray();
            return Convert.ToBase64String(bytes);
        }

        public String GetContentType()
        {
            String result = String.Empty;
            switch (Model.ResponseFileType)
            {
                case FrxExportTypes.Csv:
                    result = "application/vnd.ms-excel";
                    break;
                case FrxExportTypes.Pdf:
                    result = "application/pdf";
                    break;
                case FrxExportTypes.Excel2007:
                    result = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    break;
                case FrxExportTypes.Text:
                    result = "text/plain";
                    break;
                case FrxExportTypes.Word2007:
                    result = "application/vnd.openxmlformats-officedocument.wordprocessingml.endnotes+xml";
                    break;
                case FrxExportTypes.Xps:
                    result = "application/vnd.ms-xpsdocument";
                    break;
                case FrxExportTypes.Html:
                    result = "text/html; charset=utf-8";
                    break;
                case FrxExportTypes.Mht:
                    result = "message/rfc822";
                    break;
                case FrxExportTypes.Odt:
                    result = "application/vnd.oasis.opendocument.text";
                    break;
                case FrxExportTypes.Ods:
                    result = "application/vnd.oasis.opendocument.spreadsheet";
                    break;
                case FrxExportTypes.PowerPoint2007:
                    result = "application/vnd.openxmlformats-officedocument.presentationml.presentation";
                    //application/vnd.ms-powerpoint.presentation.macroEnabled.12
                    //application/vnd.openxmlformats-officedocument.presentationml.slideshow
                    //application/vnd.ms-powerpoint.slideshow.macroEnabled.12
                    //application/vnd.openxmlformats-officedocument.presentationml.template
                    //application/vnd.ms-powerpoint.template.macroEnabled.12
                    //application/vnd.ms-powerpoint.addin.macroEnabled.12
                    //application/vnd.openxmlformats-officedocument.presentationml.slide
                    break;
                case FrxExportTypes.Rtf:
                    result = "	application/rtf";
                    break;
                case FrxExportTypes.XmlExcel:
                    result = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    break;
                default:
                    result = "application/pdf";
                    break;
            }
            return result;
        }

    //XmlExcel = 12,

        public String GetFileType()
        {
            String result = String.Empty;
            switch (Model.ResponseFileType)
            {
                case FrxExportTypes.Csv:
                    result = ".csv";
                    break;
                case FrxExportTypes.Pdf:
                    result = ".pdf";
                    break;
                case FrxExportTypes.Excel2007:
                    result = ".xlsx";
                    break;
                case FrxExportTypes.Text:
                    result = ".txt";
                    break;
                case FrxExportTypes.Word2007:
                    result = ".docx";
                    break;
                case FrxExportTypes.Xps:
                    result = ".xps";
                    break;
                case FrxExportTypes.Html:
                    result = ".html";
                    break;
                case FrxExportTypes.Mht:
                    result = ".mhtml";
                    break;
                case FrxExportTypes.Ods:
                    result = ".ods";
                    break;
                case FrxExportTypes.Odt:
                    result = "odt";
                    break;
                case FrxExportTypes.PowerPoint2007:
                    result = ".pptx";
                    // .pptm  .ppsx  .ppsm  .potx  .potm  .ppam  .sldx  .sldm
                    break;
                case FrxExportTypes.Rtf:
                    result = ".rtf";
                    break;
                case FrxExportTypes.XmlExcel:
                    result = ".xlsx";
                    // .xls
                    break;
                default:
                    result = ".pdf";
                    break;
            }
            return result;
        }
    }
}