using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// класс результата поиска клиента
    /// </summary>
    public class SearchClientResult
    {
        public ClientReqvisites[] FoundClient { get; set; }
        public string ErrorMessage { get; set; }
    }
}