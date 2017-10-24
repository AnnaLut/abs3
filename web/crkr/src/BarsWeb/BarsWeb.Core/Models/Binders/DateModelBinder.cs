using System;
using System.Web.Mvc;

namespace BarsWeb.Core.Models.Binders
{
    /// <summary>
    /// dateStart Model binder
    /// convertable DateStart parameter in format yyyy-MM-dd to date
    /// </summary>
    public class DateModelBinder : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            // Получаем поставщик значений
            var valueProvider = bindingContext.ValueProvider;

            if (bindingContext.ModelType != typeof(DateTime?))
            {
                throw new Exception("Parameter type must by \"DateTime?\"");
            }

            var param = valueProvider.GetValue(bindingContext.ModelName);
            string paramValue= param == null ? "" : (string)param.ConvertTo(typeof(string));

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
            return result;
        }
    }
}
