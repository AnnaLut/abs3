using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    public class GetClientsInfo
    {
        public SearchClientResult[] ClientsList { get; set; }
        public string ErrorMessage { get; set; }
    }
}