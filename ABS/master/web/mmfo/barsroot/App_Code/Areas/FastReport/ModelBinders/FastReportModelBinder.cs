using BarsWeb.Areas.FastReport.Helpers;
using BarsWeb.Areas.FastReport.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders;
//using System.Web.Mvc;

namespace BarsWeb.Areas.FastReport.ModelBinders
{
    /// <summary>
    /// Привязка модели к FastReportModel
    /// </summary>
    public class FastReportModelBinderd : IModelBinder
    {
        public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext)
        {
            Task<String> content = actionContext.Request.Content.ReadAsStringAsync();
            String body = content.Result;
            if (String.IsNullOrEmpty(body))
                return false;
            FastReportModel model = null;
            FastReportModelBindHelper helper = new FastReportModelBindHelper(body);
            try
            {
                model = helper.GetModel();
            }
            catch
            {
                return false;
            }
            if (model == null)
                return false;
            bindingContext.Model = model;
            return true;
        }
    }
}