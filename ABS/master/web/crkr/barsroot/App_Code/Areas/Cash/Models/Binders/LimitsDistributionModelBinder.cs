using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders;
using Newtonsoft.Json.Linq;

namespace BarsWeb.Areas.Cash.Models.Binders
{
    public class LimitsDistributionModelBinder : IModelBinder
    {
        public LimitsDistributionModelBinder()
        {
        }

        public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext)
        {

            if (bindingContext.ModelType != typeof(LimitsDistributionAtm))
            {
                return false;
            }

            /*ValueProviderResult val = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
            if (val == null)
            {
                return false;
            }*/

            // Получаем поставщик значений
            var valueProvider = bindingContext.ValueProvider;
            var result = new LimitsDistributionAtm();

            int? id;
            if (TryGetValue<int?>(bindingContext, "Id", out id))
            {
                result.Id = id;
            }
            string branch;
            if (TryGetValue<string>(bindingContext, "Branch", out branch))
            {
                result.Branch = branch;
            }
            string kf;
            if (TryGetValue<string>(bindingContext, "Kf", out kf))
            {
                result.Kf = kf;
            }
            string accNumber;
            if (TryGetValue<string>(bindingContext, "AccNumber", out accNumber))
            {
                result.AccNumber = accNumber;
            }
            string name;
            if (TryGetValue<string>(bindingContext, "Branch", out name))
            {
                result.Name = name;
            }
            decimal? currency;
            if (TryGetValue<decimal?>(bindingContext, "Currency", out currency))
            {
                result.Currency = currency;
            }
            decimal? balance;
            if (TryGetValue<decimal?>(bindingContext, "Balance", out balance))
            {
                result.Balance = balance;
            }
            string cashType;
            if (TryGetValue<string>(bindingContext, "CashType", out cashType))
            {
                result.CashType = cashType;
            }
            DateTime? closedDate;
            if (TryGetValue<DateTime?>(bindingContext, "ClosedDate", out closedDate))
            {
                result.ClosedDate = closedDate;
            }

            bindingContext.Model = result;
            return true;


            /*var json = actionContext.Request.Content.ReadAsStringAsync().Result;
            if (!string.IsNullOrEmpty(json))
            {
                var jsonObject = (JObject)Newtonsoft.Json.JsonConvert.DeserializeObject(json);
                var jsonPropertyNames = jsonObject.Properties().Select(p => p.Name).ToList();

                var requiredProperties = bindingContext.ModelType.GetProperties().Where(p => p.GetCustomAttributes(typeof(RequiredAttribute),
                                                                                           false).Any()).ToList();

                var missingProperties = requiredProperties.Where(bindingProperty => !jsonPropertyNames.Contains(bindingProperty.Name)).ToList();

                if (missingProperties.Count > 0)
                {

                    missingProperties.ForEach(
                        prop =>
                        {
                            if (prop.PropertyType.IsEnum)
                                actionContext.ModelState.AddModelError(prop.Name, prop.Name + " is Required");

                        });
                }

                var nullProperties = requiredProperties.Except(missingProperties).ToList();

                if (nullProperties.Count > 0)
                {
                    nullProperties.ForEach(p =>
                    {
                        var jsonvalue = JObject.Parse(json);
                        var value = (JValue)jsonvalue[p.Name];
                        if (value.Value == null)
                        {
                            actionContext.ModelState.AddModelError(p.Name, p.Name + " is Required");
                        }

                    });
                }

            }
            // Now we can try to eval the object's properties using reflection.
            return true;*/

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
