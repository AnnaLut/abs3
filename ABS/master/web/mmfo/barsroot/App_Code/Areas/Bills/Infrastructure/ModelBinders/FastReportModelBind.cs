using BarsWeb.Areas.Bills.Model;
using BarsWeb.Areas.FastReport.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Mvc;

namespace BarsWeb.Areas.Bills.Infrastructure.ModelBinders
{
    /// <summary>
    /// Объект привязки данных модели для формирования отчета (FastReport)
    /// </summary>
    public class FastReportModelBind : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            CustomFastReportModel model = new CustomFastReportModel();
            try
            {
                Int32 index = 0;
                var form = controllerContext.HttpContext.Request.Form;
                model.ReportID = Convert.ToInt32(form["report_id"]);
                model.Parameters = new FrxParameters();
                while (form[String.Format("argument{0}", index)] != null)
                {
                    String argument = form[String.Format("argument{0}", index)].ToString();
                    String lowerArg = argument.ToLower();
                    String type = form[String.Format("type{0}", index)].ToString().ToLower();

                    switch (type)
                    {
                        case "number":
                            Int32 res = 0;
                            Int32.TryParse(form[lowerArg], out res);
                            model.Parameters.Add(new FrxParameter(argument, TypeCode.Decimal, res));
                            break;
                        case "varchar2":
                            model.Parameters.Add(new FrxParameter(argument, TypeCode.String, form[lowerArg].ToString()));
                            break;
                        case "date":
                            String[] arr = form[lowerArg].Split('.');
                            DateTime date = new DateTime(Convert.ToInt32(arr[2]), Convert.ToInt32(arr[1]), Convert.ToInt32(arr[0]));
                            //DateTime date = Convert.ToDateTime(form[lowerArg]);
                            model.Parameters.Add(new FrxParameter(argument, TypeCode.DateTime, date));
                            break;
                    }
                    ++index;
                }
            }
            catch(Exception e)
            {
                Debug.WriteLine(e.Message);
                return null; }
            return model;
        }
    }
}