using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Docs.Infrastructure
{
    public class AttributesHelper
    {
        public AttributesHelper()
        {
             
        }

        public string AttributesToJsonKendoGridOptions(Type objType)
        {
            return JsonConvert.SerializeObject(AttributesToKendoGridOptions(objType));
        }

        public KendoGridOptions AttributesToKendoGridOptions(Type objType)
        {
            var options = new KendoGridOptions
            {
                fields = new Dictionary<string, Field>(),
                columns = new List<Column>()
            };

            foreach (var p in objType.GetProperties())
            {
                var field = new Field
                {
                    type = TypeToJsType(p.PropertyType)
                };
                options.fields.Add(p.Name, field);

                var column = new Column
                {
                    field = p.Name
                };
                foreach (var attr in p.GetCustomAttributes(false))
                {
                    var attribute = attr as DisplayAttribute;
                    if (attribute != null)
                    {
                        column.title = attribute.Name;
                    }
                }
                options.columns.Add(column);
            }
            return options;
        }

        private string TypeToJsType(Type info)
        {
            if (info == typeof (decimal) 
                || info == typeof (decimal?) 
                || info == typeof (int) 
                || info == typeof (int?) 
                || info == typeof (float)
                || info == typeof (float?))
            {
                return "number";
            }
            if (info == typeof (bool)
                || info == typeof (bool?))
            {
                return "bool";
            }
            if (info == typeof (DateTime)
                || info == typeof (DateTime?))
            {
                return "date";
            }
            return "string";
        }
    }

    public class Field
    {
        public string type { get; set; }
    }

    public class Column
    {
        public string field { get; set; }
        public string title { get; set; }
    }

    public class KendoGridOptions
    {
        public Dictionary<string, Field> fields { get; set; }
        public List<Column> columns { get; set; }
    }
}
