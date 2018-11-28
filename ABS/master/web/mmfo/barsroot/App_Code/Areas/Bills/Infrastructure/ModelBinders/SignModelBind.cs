using BarsWeb.Areas.Bills.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Bills.Infrastructure.ModelBinders
{
    /// <summary>
    /// Привязка модели подписи
    /// </summary>
    public class SignModelBind : IModelBinder
    {
        public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext)
        {
            Sign model = new Sign();
            String requestText = actionContext.Request.Content.ReadAsStringAsync().Result;
            String jsObj = HttpUtility.UrlDecode(requestText);
            try
            {
                List<String> arr = jsObj.Split('&').ToList();
                model.EXP_ID = Convert.ToInt32(arr.FirstOrDefault(x => x.StartsWith("EXP_ID")).Split('=')[1]);
                model.SIGNATURE = Encoding.UTF8.GetBytes(arr.FirstOrDefault(x => x.StartsWith("SIGNATURE")).Split('=')[1]);
                model.SignString = arr.FirstOrDefault(x => x.StartsWith("SIGNATURE")).Split('=')[1];
                model.SIGNER = arr.FirstOrDefault(x => x.StartsWith("SIGNER")).Split('=')[1];
                bindingContext.Model = model;
            }
            catch { return false; }
            return true;
        }
    }
}