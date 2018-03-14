using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.F601.Helpers
{
    /// <summary>
    /// Summary description for LowerCaseContractResolver
    /// </summary>
    public class LowerCaseJsonSerializer
    {
        public LowerCaseJsonSerializer()
        {
        }

        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings()
        {
            ContractResolver = new LowerCaseContractResolver()
        };

        public static string SerializeObject(object o)
        {
            return JsonConvert.SerializeObject(o, Formatting.Indented, Settings);
        }

        public class LowerCaseContractResolver : DefaultContractResolver
        {
            protected override string ResolvePropertyName(string propertyName)
            {
                return propertyName.ToLower()[0] + propertyName.Substring(1);
            }
        }
    }
}