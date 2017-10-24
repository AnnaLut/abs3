using System;
using System.Collections.Generic;
using System.Web.Mvc;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AdmSecurity.Controllers
{
    /// <summary>
    /// Stub for Attribute Confirm function
    /// </summary>
    public class AttrConfirmController : ApplicationController
    {
        public AttrConfirmController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public ActionResult Editor()
        {
            return View();
        }

        public ActionResult EditorGrid([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                var data = new List<EditorData>
                {
                    new EditorData() { Id = 1, Name = "FirstTestItem", Type = "text", Value = "Test value of 1st Item"},
                    new EditorData() { Id = 2, Name = "SecondTestItem", Type = "number", Value = "1234567890" },
                    new EditorData() { Id = 3, Name = "ThirdTestItem", Type = "date", Value = "18/12/1986"},
                    new EditorData() { Id = 4, Name = "FourthTestItem", Type = "dropdown", Value = "Ford"},
                    new EditorData() { Id = 5, Name = "FifthTestItem", Type = "grid", Value = ""}
                };
                return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult
                {
                    Errors = new
                    {
                        message = ex.Message
                    }
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
    public class EditorData
    {
        public decimal Id { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Value { get; set; }
    }
}