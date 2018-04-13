using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Web;
using Newtonsoft.Json;

namespace BarsWeb.Infrastructure.Helpers
{
    public class AttributesHelper
    {
        public AttributesHelper()
        {
             
        }

        public string AttributesToKendoGridOptions(Type objType)
        {
            var fields = new Dictionary<string,Field>();
            var columns = new List<Column>();

            foreach (var p in objType.GetProperties())
            {
                var field = new Field
                {
                    type = TypeToJsType(p.GetType())
                };
                fields.Add(p.Name,field);

                var column = new Column
                {
                    field = p.Name
                };
                foreach (var attr in p.GetCustomAttributes(false))
                {
                    if (attr is DisplayNameAttribute)
                    {
                        column.title = attr.ToString();
                    }
                }
                columns.Add(column);
            }
            var result = JsonConvert.SerializeObject(new {fields, columns});

            return result;
        }

        private string TypeToJsType(Type info)
        {
            if (info.GetType() == typeof (decimal) 
                || info == typeof (int) 
                || info == typeof (float) )
            {
                return "number";
            }
            if (info == typeof (bool))
            {
                return "bool";
            }
            if (info == typeof (DateTime))
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
}
