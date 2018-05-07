namespace BarsWeb.Core.Models.Binders.Api
{
    using System.Web.Http.Controllers;
    using System.Web.Http.ModelBinding;
    public class WebApiDataSourceRequestModelBinder :IModelBinder //: Kendo.Mvc.UI.WebApiDataSourceRequestModelBinder
    {
        public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext)
        {
            DataSourceRequest dataSourceRequest = new DataSourceRequest();

            var kendoBinder = new Kendo.Mvc.UI.WebApiDataSourceRequestModelBinder();
            var kendoBindResult = kendoBinder.BindModel(actionContext, bindingContext);
            if (kendoBindResult)
            {
                var kendoBindingContext = (Kendo.Mvc.UI.DataSourceRequest)bindingContext.Model;
                dataSourceRequest.Page = kendoBindingContext.Page;
                dataSourceRequest.PageSize = kendoBindingContext.PageSize;
                dataSourceRequest.Filters = kendoBindingContext.Filters;
                dataSourceRequest.Sorts = kendoBindingContext.Sorts;
                dataSourceRequest.Groups = kendoBindingContext.Groups;
                dataSourceRequest.Aggregates = kendoBindingContext.Aggregates;

                bindingContext.Model = dataSourceRequest;
                return true;
            }

            return false;
        }
    }
}
