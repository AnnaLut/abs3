using Newtonsoft.Json;
using System;

namespace Bars.EAD.Structs.Result
{
    /// <summary>
    /// Ответ - Данные документа
    /// </summary>
    public class DocumentData
    {
        [JsonProperty("doc_link")]
        public String DocLink { get; set; }
        [JsonProperty("struct_code")]
        public String Struct_Code { get; set; }
        [JsonProperty("struct_name")]
        public String Struct_Name { get; set; }

        public DocumentData()
        {
        }
    }
}