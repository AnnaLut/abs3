using System;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders;

namespace BarsWeb.Core.Models.Binders.Api
{
    /// <summary>
    /// dateStart Model binder
    /// convertable DateStart parameter in format yyyy-MM-dd to date
    /// </summary>
    public class DateModelBinder : IModelBinder
    {
        public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext)
        {
            if (bindingContext.ModelType != typeof(DateTime?))
            {
                return false;
            }

            ValueProviderResult val = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
            if (val == null)
            {
                return false;
            }

            string paramValue;
            if (TryGetValue(bindingContext, bindingContext.ModelName, out paramValue))
            {
                DateTime? result = null;
                if (!string.IsNullOrEmpty(paramValue))
                {
                    var paramValueArray = paramValue.Split('-');
                    if (paramValueArray.Length == 3)
                    {
                        var year = Convert.ToInt32(paramValueArray[0]);
                        var month = Convert.ToInt32(paramValueArray[1]);
                        var day = Convert.ToInt32(paramValueArray[2]);
                        result = new DateTime(year, month, day);
                    }
                }
                
                bindingContext.Model = result;
                return true;
            }
            return false;
        }
        private bool TryGetValue<T>(ModelBindingContext bindingContext, string key, out T result)
        {
            ValueProviderResult value = bindingContext.ValueProvider.GetValue(key);
            if (value == null)
            {
                result = default(T);
                return false;
            }
            result = (T)value.ConvertTo(typeof(T));
            return true;
        }
    }
}
