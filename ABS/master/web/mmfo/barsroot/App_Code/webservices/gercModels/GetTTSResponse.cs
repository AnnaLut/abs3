using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for GetTTSResponse
    /// </summary>
    public class GetTTSResponse
    {
        public int AskTTSSet { get; set; }
        public TTSData[] TTSDataSet { get; set; }
        public string ErrorMessage { get; set; }
    }
}