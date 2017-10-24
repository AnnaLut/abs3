using BarsWeb.Controllers;
using System;
using BarsWeb.Areas.SyncTablesEditor.Infrastructure.DI.Abstract;
using System.Web.Mvc;
using AttributeRouting.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Core.Models.Binders.Api;
using BarsWeb.Core.Models;
using Areas.SyncTablesEditor.Models;
using System.IO;
using System.Text;
using Bars.Classes;
using Dapper;
using System.Data;

namespace BarsWeb.Areas.SyncTablesEditor.Controllers
{
    [AuthorizeUser]
    public class SyncTablesEditorController : ApplicationController
    {
        public ActionResult Index()
        {
            //ViewBag.Title = "Редагування таблиць, що синхронізуються";
            ViewBag.Title = "BarsWeb";
            return View();
        }

        [HttpGet]
        public FileResult GetSqlFile(int tabId, string tabName)
        {
            string res = "";

            try
            {
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var p = new DynamicParameters();
                    p.Add("p_tbl_id", tabId, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_script", "", DbType.String, ParameterDirection.Output);

                    connection.Execute("NBUR_SYNC_DBF.EXPORT", p, commandType: CommandType.StoredProcedure);
                    res = p.Get<string>("p_script");
                }
                return File(new MemoryStream(Encoding.UTF8.GetBytes(res ?? "")), "attachment", tabName + ".sql");
            }
            catch (Exception ex)
            {
                return File(new MemoryStream(Encoding.UTF8.GetBytes(ex.Message ?? "")), "attachment", tabName + ".err");
            }
        }
    }
}
