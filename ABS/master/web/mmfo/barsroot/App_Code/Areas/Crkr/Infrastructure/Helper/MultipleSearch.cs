using System.Collections.Generic;
using System.Dynamic;
using System.Linq;

namespace BarsWeb.Areas.Crkr.Infrastructure.Helper
{
    public class MultipleSearch
    {
        private void AddProperty(ExpandoObject expando, string propertyName, object propertyValue)
        {
            var expandoDict = expando as IDictionary<string, object>;
            if (expandoDict.ContainsKey(propertyName))
            {
                expandoDict[propertyName] = propertyValue;
            }
            else
            {
                expandoDict.Add(propertyName, propertyValue);
            }
        }
        public object GetParamsFromModel<T>(T t)
        {
            dynamic dynamParams = new ExpandoObject();
            foreach (var property in t.GetType().GetProperties())
            {
                var propVal = property.GetValue(t, null);
                if (propVal != null && property.Name != "load")
                {
                    AddProperty(dynamParams, property.Name, propVal);
                }
            }

            if (((IDictionary<string, object>)dynamParams).Any())
            {
                return (object)dynamParams;
            }
            return null;
        }
    }
}
