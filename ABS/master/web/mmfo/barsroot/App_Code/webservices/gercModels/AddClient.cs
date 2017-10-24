using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// класс добавления клиента
    /// </summary>
    public class AddClient
    {
        public ClientReqvisites[] GercClient { get; set; }
        public int IsFound { get; set; }
        public string ErrorMessage { get; set; }
    }
}