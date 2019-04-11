using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Pfu.Models.Grids;
using BarsWeb.Controllers;
using BarsWeb.Infrastructure.Helpers;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Web.Mvc;

namespace BarsWeb.Areas.Pfu.Controllers
{
    public class PfuController : ApplicationController
    {
        private readonly IGridRepository _repo;
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult RecBlocked()
        {
            return View();
        }

        public ActionResult Ebp()
        {
            return View();
        }

        public ActionResult Sync()
        {
            return View();
        }

        public ActionResult Catalog()
        {
            return View();
        }

        public ActionResult Accept()
        {
            return View();
        }

        public ActionResult DestroyElPensCard()
        {
            return View();
        }

        public ActionResult RegistryEPC()
        {
            return View();
        }
        public ActionResult KvitTwo()
        {
            return View();
        }
        public ActionResult Receipts()
        {
            return View();
        }
        public ActionResult MonitorEnquiryKM()
        {
            return View();
        }
        public ActionResult EppPortfolio()
        {
            return View();
        }
        public ActionResult ErrorRows()
        {
            return View();
        }

        public ActionResult DeathsNotify()
        {
            return View();
        }
        
        public ActionResult RegistersAndRecords()
        {
            return View();
        }
        public PfuController(IGridRepository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        public ActionResult GetErrorRowsFile([DataSourceRequest] DataSourceRequest request,string MFO, string ID, string STATE)
        {

            IQueryable<ErrorRows> dbRecords = _repo.GetErrorRows(MFO, ID, STATE);

            //var listToDataSource = dbRecords.ToDataSourceResult(request);
            //List<ErrorRows> readyList = new List<ErrorRows>();
            //foreach (ErrorRows item in listToDataSource.Data)
            //{
            //    readyList.Add(item);
            //}

            var excelRows = dbRecords.Select(i => new ErrorRowsExcel
            {
                MFO = i.MFO,
                MFO_NAME = i.MFO_NAME,
                BRANCH = i.BRANCH,
                KF_BANK = i.KF_BANK,
                PFU_ENVELOPE_ID = i.PFU_ENVELOPE_ID,
                FILE_ID = i.FILE_ID,
                ID = i.ID,
                NLS_PFU = i.NLS_PFU,
                NLS_BANK = i.NLS_BANK,
                NMK_PFU = i.NMK_PFU,
                NMK_BANK = i.NMK_BANK,
                OKPO_BANK = i.OKPO_BANK,
                OKPO_PFU = i.OKPO_PFU,
                RNK_BANK = i.RNK_BANK,
                STATE_NAME = i.STATE_NAME,
                STATE = i.STATE,
                ERR_MESS_TRACE = i.ERR_MESS_TRACE
            });

           //var header = "Рахунки станом на " + DateTime.Now.ToShortDateString();
            var excel = new ExcelHelpers<ErrorRowsExcel>(excelRows, true);
            return File(excel.ExportToMemoryStream(), "attachment", "Інформаційні рядки з помилками.xlsx");
        }

    }
}