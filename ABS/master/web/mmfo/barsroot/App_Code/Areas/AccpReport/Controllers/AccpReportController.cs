using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.AccpReport.Infrastructure.Repository.DI.Abstract;
using Areas.AccpReport.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using System.Collections.Generic;
using Areas.AccpReportDocs.Models;

namespace BarsWeb.Areas.AccpReport.Controllers
{
    [AuthorizeUser]
    public class AccpReportController : ApplicationController
    {
        private readonly IAccpReportRepository _arRepository;

        public AccpReportController(IAccpReportRepository arRepository)
        {
            _arRepository = arRepository;
        }

        public ViewResult Index()
        {
            return View();
        }

        ///// <summary>
        ///// детальна підрозділи корпорації
        ///// </summary>
        ///// <param name="id">ID корпорації</param>
        ///// <returns></returns>
        //public ActionResult CorporationChilds(string id)
        //{
        //    return View(model: id);
        //}

        public ActionResult GetAccounts([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<V_ACCP_ACCOUNTS> session;
            session = _arRepository.GetAccounts();
            //        var data = JsonConvert.SerializeObject(session,
            //Formatting.None,
            //new JsonSerializerSettings()
            //{
            //    ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
            //});
            //        return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            return Json(session.Select(s => new { s.NAME, s.DDOG, s.NDOG, s.OKPO, s.MFO, s.NLS, s.SCOPE_DOG, s.ORDER_FEE, s.AMOUNT_FEE, s.FEE_MFO, s.FEE_NLS, s.FEE_OKPO, s.CHECK_ON, s.FEE_TYPE_ID, s.FEE_BY_TARIF  }).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

        }

        public ActionResult GetReportAccounts([DataSourceRequest] DataSourceRequest request, string OKPO)
        {
            IQueryable<V_ACCP_ACCOUNTS> session;
            session = _arRepository.GetAccounts();
            return Json(session.Select(s => new { s.NAME, s.DDOG, s.NDOG, s.OKPO, s.MFO, s.NLS, s.SCOPE_DOG, s.ORDER_FEE, s.AMOUNT_FEE, s.FEE_MFO, s.FEE_NLS, s.FEE_OKPO, s.CHECK_ON }).Where(s=>s.OKPO== OKPO) .ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

        }

    
        public ActionResult GetAccountsDocs([DataSourceRequest] DataSourceRequest request, string OKPO)
        {
            IEnumerable<ACCPDOCS> list = _arRepository.GetAccountsDocs(OKPO);
            return Json(new { Data = list }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void SetAccounts([DataSourceRequest] DataSourceRequest request, string OKPO, string NLS, bool Check)
        {
            _arRepository.SetAccounts(OKPO, NLS, Check);

        }

        [HttpPost]
        public void CreateReport([DataSourceRequest] DataSourceRequest request, string DateFrom, string DateTo, string OKPO)
        {
            _arRepository.CreateReport(DateFrom, DateTo, OKPO);

        }

        [HttpPost]
        public void CheckAccountsDoc([DataSourceRequest] DataSourceRequest request, decimal REF, bool Check)
        {
            _arRepository.CheckAccountsDoc(REF, Check);

        }

        //public ActionResult GetCoprData([DataSourceRequest] DataSourceRequest request, int? parentId )
        //{
        //    IQueryable<OB_CORPORATION> session;

        //    int parentID;

        //    if (!parentId.HasValue)
        //        parentID = 0;
        //    else
        //        parentID = Convert.ToInt32( parentId);

        //   session = _arRepository.GetCorporationChilds(parentID);
        //    //        var data = JsonConvert.SerializeObject(session,
        //    //Formatting.None,
        //    //new JsonSerializerSettings()
        //    //{
        //    //    ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
        //    //});
        //    //        return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        //    return Json(session.Select(s => new { s.ID, s.CORPORATION_NAME, s.CORPORATION_CODE, s.PARENT_ID, s.STATE_ID }).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);

        //}


    }
}