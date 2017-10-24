using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using BarsWeb.Infrastructure.Helpers;
using System.IO;
using Newtonsoft.Json;
using BarsWeb.Areas.Kernel.Models.KendoViewModels;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Infrastructure;
using Bars.Classes;
using Ninject;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.Sep.Controllers
{
    public class SepProccessingController : ApplicationController
    {
        private readonly ISepTechAccountsRepository _repo;
        [Inject]
        public IDbLogger Logger { get; set; }
        string LoggerPrefix = "SepProccessingController";
        public SepProccessingController(ISepTechAccountsRepository repository)
        {
            _repo = repository;
        }

        public ActionResult Grid(ProccessingParams objParams)
        {
            ViewBag.oParams = objParams;
            return View(objParams);
        }

        public ActionResult Data([DataSourceRequest]DataSourceRequest request, 
            decimal acc, string tip, decimal? kv, string dat, string query)
        {
            try
            {
                Logger.Info("begin data base64query = " + query,LoggerPrefix);
                query = this.ConvertFormBase64ToUTF8(query);
                //if (!string.IsNullOrEmpty(query))
                //{
                //    query = this.ConvertFormBase64ToUTF8(query);
                //     query = query.Replace("NLSA", "NLS");
                //     query = query.Replace("NAM_B", "NAM");
                //}
                Logger.Info("query = " + query,LoggerPrefix);

                //DataSourceRequest req = new DataSourceRequest();
                //req.Filters = request.Filters;
                //req.Page = request.Page;
                //req.PageSize = request.PageSize;
                var data = _repo.GetProccessingData(acc, tip, kv, dat, query, request).ToList();
                Logger.Info(string.Format("data result  request.PageSize = {0} cuont: {1}", request.Page, data.Count()), LoggerPrefix);

                var total = _repo.GetProccessingDataCount(acc, tip, kv, dat, query, request);
                Logger.Info(string.Format("count result   cuont: {0}", total), LoggerPrefix);

                return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Logger.Error("data error error msg= " + ex.Message, LoggerPrefix);
                return  /*Json(new { status = "Error", msg = "Помилка вичитуванні даних " + GetErrorInfo(ex) + "<br />" + ex.Message });*/ DataSourceErrorResult(ex);
            }
        }

        public ActionResult GetOstByDate(decimal acc, string dat)
        {
            var ost = _repo.GetOstByDate(acc, dat);
            var result = new {Status = ost != null ? 1 : 0, DataResult = ost};
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetExcel(string model, decimal acc, string tip, decimal? kv, string dat, string query)
           //public ActionResult GetExcel(string model)
        {
            try
            {
                DataSourceAdapter dataSourceAdapter = new DataSourceAdapter();
                if (!string.IsNullOrEmpty(query))
                {
                    query = this.ConvertFormBase64ToUTF8(query);
                    query = query.Replace("NLSA", "NLS");
                }
                   

                WebDatasourceModel gridFilter = JsonToObject<WebDatasourceModel>(model) ?? new WebDatasourceModel();
                string firstCol = gridFilter.columns[0].Name;
                //DataSourceRequest req = dataSourceAdapter.ParsWebDataSourceToKendo(gridFilter);
                DataSourceRequest req = dataSourceAdapter.ParsDataSours(gridFilter);

                //gridFilter.filters[2].filters
                //req.Page = gridFilter.page;
                //req.PageSize = gridFilter.pageSize == 0 ? 10 : gridFilter.pageSize;
                // var total = _repo.GetProccessingDataCount(acc, tip, kv, dat, query, req);
               // req.Sorts = JsonToObject<IList<Kendo.Mvc.SortDescriptor>>(sort) ?? new List<Kendo.Mvc.SortDescriptor>();

                var data = _repo.GetProccessingData(acc, tip, kv, dat, query, req);
                //foreach (var item in data)
                //{
                //    string name = item.ToString();
                //}
                MemoryStream sream = _repo.ExportExcel(data);
                //return File(sream, "attachment", "ProccessingAccountDocs_Data.xlsx");
                return File(sream, "application/vnd.ms-excel", "ProccessingAccountDocs_Data.xlsx");

            }
            catch (Exception e)
            {
                Logger.Error(string.Format("Ошибка при выгрузке в excel файл: {0}.\nInput parameters: model - {1}, tip - {2}, kv - {3}, dat - {4}, query - {5}", e, model, tip, kv, dat, query));
                return DataSourceErrorResult(e);
            }
            
        }

    

        [HttpPost]
        public ActionResult GridToExcelFile(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);
            return File(fileContents, contentType, fileName);
        }

        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Data = {},
                Errors = new
                {
                    message = ex.ToString()
                }
            }, JsonRequestBehavior.AllowGet);
        }
        private string GetErrorInfo(Exception e)
        {
            var pg = new ErrorPageGenerator(e);
            return pg.GetBarsErrorText();
        }        
    }

}