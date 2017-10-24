using System;
using System.Web.Mvc;
using BarsWeb.Areas.FinView.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System.Linq;
using BarsWeb.Areas.FinView.Models;
using BarsWeb.Infrastructure.Helpers;
using Kendo.Mvc.Extensions;

namespace BarsWeb.Areas.FinView.Controllers
{
    /// <summary>
    /// Summary description for FinanceViewController
    /// </summary>
    public class FinanceViewController : ApplicationController
    {
        private readonly IFinanceRepository _finRepo;
        public FinanceViewController(IFinanceRepository finRepo)
        {
            _finRepo = finRepo;
        }

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DocumentsToExcelFile(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);
            return File(fileContents, contentType, fileName);
        }

        [HttpPost]
        public ActionResult AccountsToExcelFile(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);
            return File(fileContents, contentType, fileName);
        }

        [HttpPost]
        public ActionResult GetBalanceToExcelFile(string contentType, string base64, string fileName
            /*[DataSourceRequest] DataSourceRequest request,
            string date, decimal rowType, string branch*/)
        {
            var fileContents = Convert.FromBase64String(base64);
            return File(fileContents, contentType, fileName);
            /*IQueryable<Balance> data = _finRepo.BalanceViewData(date, rowType, branch);
            var modeType = "";
            switch ((int)rowType)
            {
                case 7:
                    modeType = "onBank";
                    var list7 = data.Select(i => new DataBank
                    {
                        kf_name = i.kf_name,
                        kf = i.kf,
                        dosq = i.dosq,
                        kosq = i.kosq,
                        ostdq = i.ostdq,
                        ostkq = i.ostkq
                    }).ToList();
                    var filterData7 = list7.ToDataSourceResult(request).Data;
                    IQueryable<DataBank> castResult7 = filterData7.Cast<DataBank>().AsQueryable();
                    var modeListData = new ExcelHelpers<DataBank>(castResult7, true);
                    return File(modeListData.ExportToMemoryStream(), "attachment", "Grid_" + modeType + ".xlsx");
                    break;
                case 8:
                    modeType = "onRegionalHeadquarter";
                    var list8 = data.Select(i => new DataRh
                    {
                        kf_name = i.kf_name,
                        kf = i.kf,
                        dosq = i.dosq,
                        kosq = i.kosq,
                        ostdq = i.ostdq,
                        ostkq = i.ostkq
                    }).ToList();
                    var filterData8 = list8.ToDataSourceResult(request).Data;
                    IQueryable<DataRh> castResult8 = filterData8.Cast<DataRh>().AsQueryable();
                    var modeListDataRh = new ExcelHelpers<DataRh>(castResult8, true);
                    return File(modeListDataRh.ExportToMemoryStream(), "attachment", "Grid_" + modeType + ".xlsx");
                    break;
                case 9:
                    modeType = "onRhBalance";
                    var list9 = data.Select(i => new DataRhBalance
                    {
                        kf_name = i.kf_name,
                        kf = i.kf,
                        nbs = i.nbs,
                        dosq = i.dosq,
                        kosq = i.kosq,
                        ostdq = i.ostdq,
                        ostkq = i.ostkq
                    }).ToList();
                    var filterData9 = list9.ToDataSourceResult(request).Data;
                    IQueryable<DataRhBalance> castResult9 = filterData9.Cast<DataRhBalance>().AsQueryable();
                    var modeListDataRhBalance = new ExcelHelpers<DataRhBalance>(castResult9, true);
                    return File(modeListDataRhBalance.ExportToMemoryStream(), "attachment", "Grid_" + modeType + ".xlsx");
                    break;
                case 10:
                    modeType = "onRhBalanceKv";
                    var list10 = data.Select(i => new DataRhBalanceKv
                    {
                        kf_name = i.kf_name,
                        kf = i.kf,
                        nbs = i.nbs,
                        kv = i.kv,
                        dosq = i.dosq,
                        kosq = i.kosq,
                        ostdq = i.ostdq,
                        ostkq = i.ostkq
                    }).ToList();
                    var filterData10 = list10.ToDataSourceResult(request).Data;
                    IQueryable<DataRhBalanceKv> castResult10 = filterData10.Cast<DataRhBalanceKv>().AsQueryable();
                    var modeListDataOrb = new ExcelHelpers<DataRhBalanceKv>(castResult10, true);
                    return File(modeListDataOrb.ExportToMemoryStream(), "attachment", "Grid_" + modeType + ".xlsx");
                    break;
                case 11:
                    modeType = "onRhBalanceKvBranch";
                    var list11 = data.Select(i => new DataRhBalanceKvBranch
                    {
                        kf_name = i.kf_name,
                        kf = i.kf,
                        branch = i.branch,
                        nbs = i.nbs,
                        kv = i.kv,
                        dosq = i.dosq,
                        kosq = i.kosq,
                        ostdq = i.ostdq,
                        ostkq = i.ostkq
                    }).ToList();
                    var filterData11 = list11.ToDataSourceResult(request).Data;
                    IQueryable<DataRhBalanceKvBranch> castResult11 = filterData11.Cast<DataRhBalanceKvBranch>().AsQueryable();
                    var modeListDataRbkb = new ExcelHelpers<DataRhBalanceKvBranch>(castResult11, true);
                    return File(modeListDataRbkb.ExportToMemoryStream(), "attachment", "Grid_" + modeType + ".xlsx");
                    break;
                default:
                    return null;
            }*/
        }
    }
}