using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for GetDocumentsStateResponse
    /// </summary>
    public class GetDocumentsStateResponse
    {
        public DocumentState[] DocumentStates { get; set; }
        public string ErrorMessage { get; set; }
    }
}