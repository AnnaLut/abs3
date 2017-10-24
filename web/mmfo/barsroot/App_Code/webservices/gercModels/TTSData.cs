using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    //Для синхронизации допустимых операций 
    public struct TTSData
    {
        public string TTSCode { get; set; }
        public string TTSName { get; set; }
    }
}