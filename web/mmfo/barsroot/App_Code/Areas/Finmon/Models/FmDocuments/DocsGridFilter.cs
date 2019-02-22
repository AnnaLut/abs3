using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;

namespace Areas.Finmom.Models
{
    public class DocsGridFilter
    {
        [JsonProperty("statuses")]
        public List<string> Statuses { get; set; }
        [JsonProperty("rules")]
        public List<int> Rules { get; set; }
        [JsonProperty("period")]
        public Period Period { get; set; }
        [JsonProperty("formType")]
        public string FormType { get; set; }

        [JsonProperty("from")]
        public string From { get; set; }
        [JsonProperty("to")]
        public string To { get; set; }
        [JsonProperty("customFilters")]
        public string CustomFilters { get; set; }
        [JsonProperty("showBlockedOnly")]
        public bool ShowBlockedOnly { get; set; }
    }

    public class Period
    {
        [JsonProperty("from")]
        public string From { get; set; }
        [JsonProperty("to")]
        public string To { get; set; }
    }
}