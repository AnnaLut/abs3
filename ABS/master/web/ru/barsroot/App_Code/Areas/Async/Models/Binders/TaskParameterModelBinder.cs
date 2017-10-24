using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.Async.Models.Binders
{
    public class TaskParameterModelBinder : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            // Получаем поставщик значений
            var valueProvider = bindingContext.ValueProvider;
             
            var modelName = bindingContext.ModelName;

            string origDbType = valueProvider.GetValue(modelName + ".OriginalDbType") == null ? "" : (string)valueProvider.GetValue(modelName + ".OriginalDbType").ConvertTo(typeof(string));
            string min = valueProvider.GetValue(modelName + ".Minimum") == null ? "" : (string)valueProvider.GetValue(modelName + ".Maximum").ConvertTo(typeof(string));
            //string min = (string)valueProvider.GetValue(modelName + ".Minimum").ConvertTo(typeof(string));
            string max = valueProvider.GetValue(modelName + ".Maximum") == null ? "" : (string)valueProvider.GetValue(modelName + ".Maximum").ConvertTo(typeof(string));
            string uiType = valueProvider.GetValue(modelName + ".UiType") == null ? "" : (string)valueProvider.GetValue(modelName + ".UiType").ConvertTo(typeof(string));
            string direct = valueProvider.GetValue(modelName + ".Directory") == null ? "" : (string)valueProvider.GetValue(modelName + ".Directory").ConvertTo(typeof(string));
            var result = new TaskParameter
            {
                Name = (string)valueProvider.GetValue(modelName + ".Name").ConvertTo(typeof(string)),
                Type = (TypeCode)valueProvider.GetValue(modelName + ".Type").ConvertTo(typeof(TypeCode)),
                OriginalDbType = origDbType,
                Description = (string)valueProvider.GetValue(modelName + ".Description").ConvertTo(typeof(string)),
                Minimum = min,
                Maximum = max,
                UiType = uiType,
                Directory = direct,
                Position = (int?)valueProvider.GetValue(modelName + ".Position").ConvertTo(typeof(int?)),
                SchedulerCode = (string)valueProvider.GetValue(modelName + ".SchedulerCode").ConvertTo(typeof(string))
            };

            switch (result.Type)
            {
                case TypeCode.DateTime:
                    result.Value = valueProvider.GetValue(modelName + ".Value").ConvertTo(typeof (DateTime));
                    break;
                case TypeCode.Decimal:
                    result.Value = valueProvider.GetValue(modelName + ".Value").ConvertTo(typeof (Decimal));
                    break;
                default:
                    result.Value = valueProvider.GetValue(modelName + ".Value").ConvertTo(typeof (String));
                    break;
            }
            return result;
        }
    }
}
