using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    // Для синхронизации допустимых кассовых символов 
    public struct SKData
    {
        public string SKCode { get; set; }
        public string SKDescription { get; set; }
    }
}