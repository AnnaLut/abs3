using BarsWeb.Areas.Bills.Model;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.Bills.Infrastructure.ModelBinders
{
    /// <summary>
    /// объект привязки данных запроса для View поиска решения!
    /// </summary>
    public class SearchReceiverModelBind : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            SearchReceiverModel model = new SearchReceiverModel();
            var collection = controllerContext.HttpContext.Request.Params;
            model.ResolutionNumber = collection["ResolutionNumber"];
            try
            {
                model.ResolutionDate = DateTime.Parse(collection["ResolutionDate"]);
                return model;
            }
            catch { }
            return null;
        }
    }
}