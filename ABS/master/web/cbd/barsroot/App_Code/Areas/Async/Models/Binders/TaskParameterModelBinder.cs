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

            var result = new TaskParameter
            {
                Name = (string)valueProvider.GetValue(modelName + ".Name").ConvertTo(typeof(string)),
                Type = (TypeCode)valueProvider.GetValue(modelName + ".Type").ConvertTo(typeof(TypeCode)),
                Description = (string)valueProvider.GetValue(modelName + ".Description").ConvertTo(typeof(string)),
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
