using BarsWeb.Areas.Bills.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Bills.Infrastructure.ModelBinders
{
    /// <summary>
    /// Объект привязки данных для запроса изменения данных взыскателя
    /// </summary>
    public class EditReceiverModelBind : IModelBinder
    {
        public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext)
        {
            Receiver model = new Receiver();
            String requestText = actionContext.Request.Content.ReadAsStringAsync().Result;
            String jsObj = HttpUtility.UrlDecode(requestText);
            try
            {
                List<String> arr = jsObj.Split('&').ToList();
                model.CL_TYPE = Convert.ToInt32(arr.FirstOrDefault(x => x.StartsWith("CL_TYPE")).Split('=')[1]);
                String doc_date = arr.FirstOrDefault(x => x.StartsWith("DOC_DATE")).Split('=')[1];
                if(!String.IsNullOrEmpty(doc_date))
                    model.DOC_DATE = Convert.ToDateTime(arr.FirstOrDefault(x => x.StartsWith("DOC_DATE")).Split('=')[1]);
                model.DOC_NO = arr.FirstOrDefault(x => x.StartsWith("DOC_NO")).Split('=')[1];
                model.DOC_WHO = arr.FirstOrDefault(x => x.StartsWith("DOC_WHO")).Split('=')[1];
                model.EXP_ID = Convert.ToInt32(arr.FirstOrDefault(x => x.StartsWith("EXP_ID")).Split('=')[1]);
                model.INN = arr.FirstOrDefault(x => x.StartsWith("INN")).Split('=')[1];
                model.NAME = arr.FirstOrDefault(x => x.StartsWith("NAME")).Split('=')[1];
                model.PHONE = arr.FirstOrDefault(x => x.StartsWith("PHONE")).Split('=')[1];
                model.ADDRESS = arr.FirstOrDefault(x => x.StartsWith("ADDRESS")).Split('=')[1];
                String rnk = arr.FirstOrDefault(x => x.StartsWith("RNK")).Split('=')[1];
                if(!String.IsNullOrEmpty(rnk))
                    model.RNK = Convert.ToInt64(rnk);
                model.ACCOUNT = arr.FirstOrDefault(x => x.StartsWith("ACCOUNT")).Split('=')[1];
                bindingContext.Model = model;
            }
            catch { return false; }
            return true;
        }
    }
}