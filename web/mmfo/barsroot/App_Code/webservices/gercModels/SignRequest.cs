using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for SignRequest
    /// </summary>
    public class SignRequest
    {
        public string TokenId { set; get; }
        public string ModuleName { set; get; }
        public string IdOper { set; get; }
        public string Buffer { set; get; }
    }
}