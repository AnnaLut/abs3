using System;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using clientregister;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web;
using System.IO;
using Oracle.DataAccess.Client;
using System.Data;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.Text;
using System.Net.Http;
using System.Net;
using Dapper;
using System.Xml;
using Areas.Finmon.Models;

namespace BarsWeb.Areas.Finmon.Controllers
{
    [AuthorizeUser]
    [CheckAccessPage]
    public class FinmonController : ApplicationController
    {
        private readonly IFinmonRepository _finmonRepository;
        public FinmonController(IFinmonRepository finmonRepository)
        {
            _finmonRepository = finmonRepository;
        }

        public ActionResult Index(int lastDays)
        {
            return View(model: lastDays);
        }

        //public ActionResult GetFmData([DataSourceRequest] DataSourceRequest request, int lastDays)
        //{
        //    DateTime fromDate = DateTime.Today.AddDays(lastDays * -1);
        //    var data = _finmonRepository.GetOperFm().Where(o => o.PDAT >= fromDate);
        //    return Json(data.ToDataSourceResult(request));
        //}
        
        [HttpGet]
        public ActionResult GetFmData([DataSourceRequest] DataSourceRequest request, int lastDays, string dateFrom, string dateTo)
        {
            IQueryable<V_OPER_FM> data = null;
            DateTime fromDate = DateTime.Today.AddDays(lastDays * -1);

            

            if (dateFrom != String.Empty && dateTo != String.Empty)
            {
                DateTime _df = DateTime.Parse(dateFrom);
                DateTime _dt = DateTime.Parse(dateTo);

                data = _finmonRepository.GetOperFm().Where(o => o.PDAT >= _df && o.PDAT <= _dt);
            }
            else
            {
                data = _finmonRepository.GetOperFm().Where(o => o.PDAT >= fromDate);
            }
            return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }


        public ActionResult PrintFmForm(decimal refDoc)
        {
            var service = new defaultWebService();
            var serviceResult = service.GetFileForPrint(refDoc.ToString(CultureInfo.CurrentCulture), "OPER_REF_FM", null);

            string fileName = serviceResult.Text;
            return File(fileName, "application/force-download", String.Format("Finmon_{0}.rtf", refDoc));
        }

        public ActionResult ImportTerrorists(string result)
        {
            if (!string.IsNullOrEmpty(result))
            {
                ViewBag.Result = result;
            }
            return View();
        }
        [HttpPost]
        public ActionResult UploadTerroristsFile(HttpPostedFileBase upload)
        {            
            if (upload == null || upload.InputStream == null)
            {

                return RedirectToAction("ImportTerrorists");
            }
            try
            {
                string data;
                //Хотя в файле указана кодировка UTF-8 для нормального отображения в базе файл считывается в кодировке Windows-1251
                using (StreamReader stream = new StreamReader(upload.InputStream, Encoding.GetEncoding("Windows-1251")))
                {
                    data = stream.ReadToEnd();
                }
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    OracleCommand command = new OracleCommand("BARS.FINMON_EXPORT.importXYToABS", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.Add("xmlXY", OracleDbType.Clob, data, ParameterDirection.InputOutput);
                    int i = 0;
                    command.Parameters.Add("id", OracleDbType.Decimal, i, ParameterDirection.InputOutput);
                    command.ExecuteNonQuery();
                }
                return RedirectToAction("ImportTerrorists", new { result = "Завантажено " + GetCountRecord(data) + " записів."});
            }
            catch (Exception ex)
            {
                return RedirectToAction("ImportTerrorists", new { result = "Помилка " + ex.Message });
            }
            
        }
        private int GetCountRecord(string xmlData)
        {
            XmlReaderSettings settings = new XmlReaderSettings();
            settings.DtdProcessing = DtdProcessing.Ignore;
            using (XmlReader reader = XmlReader.Create(new StringReader(xmlData), settings))
            {
                reader.ReadToFollowing("count-record");
                return reader.ReadElementContentAsInt();
            }
        }


        public ActionResult ImportPublicFigures(string result)
        {
            if (!string.IsNullOrEmpty(result))
            {
                ViewBag.Result = result;
            }
            return View();
        }

        [HttpPost]
        public ActionResult UploadPublicFiguresFile(HttpPostedFileBase upload)
        {
            if (upload == null || upload.InputStream == null)
            {

                return RedirectToAction("ImportPublicFigures");
            }
            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    string data;
                    using (StreamReader stream = new StreamReader(upload.InputStream, Encoding.GetEncoding("windows-1251")))
                    {
                        data = stream.ReadToEnd();
                    }
                    var insertCommand = connection.CreateCommand();
                    insertCommand.CommandText = "insert into IMP_FILE values(:FILE_NAME, :FILE_CLOB, :FILE_BLOB)";
                    insertCommand.Parameters.Clear();
                    insertCommand.Parameters.Add("FILE_NAME", OracleDbType.Varchar2, upload.FileName, ParameterDirection.Input);
                    insertCommand.Parameters.Add("FILE_CLOB", OracleDbType.Clob, data, ParameterDirection.Input);
                    insertCommand.Parameters.Add(":FILE_BLOB", OracleDbType.Blob, null, ParameterDirection.Input);
                    try
                    {
                        insertCommand.ExecuteNonQuery();
                    }
                    catch (OracleException ex)
                    {
                        if (ex.Message == "ORA-00001: unique constraint (BARS.PK_IMPFILE_ID) violated")
                        {
                            var updateCommand = connection.CreateCommand();
                            updateCommand.CommandText = "update IMP_FILE set FILE_CLOB=:FILE_CLOB where FILE_NAME=:FILE_NAME";
                            updateCommand.Parameters.Clear();
                            updateCommand.Parameters.Add("FILE_CLOB", OracleDbType.Clob, data, ParameterDirection.Input);
                            updateCommand.Parameters.Add("FILE_NAME", OracleDbType.Varchar2, upload.FileName, ParameterDirection.Input);
                            updateCommand.ExecuteNonQuery();
                        }
                        else throw;
                    }

                    OracleCommand command = new OracleCommand("bars.finmon_import_files", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.Add("p_mode", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    command.Parameters.Add("p_filename", OracleDbType.Varchar2, upload.FileName, ParameterDirection.Input);
                    command.ExecuteNonQuery();
                }

            }
            catch (Exception ex)
            {
                return RedirectToAction("ImportPublicFigures", new { result = "Помилка " + ex.Message });
            }
            return RedirectToAction("ImportPublicFigures", new { result = "Файл імпортовано" });
        }

    }
}