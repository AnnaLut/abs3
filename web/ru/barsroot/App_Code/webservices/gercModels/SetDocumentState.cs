using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for SetDocumentState
    /// </summary>
    public class SetDocumentState
    {
        public DocumentState[] DocumentStates { get; set; }
        public string ErrorMessage { get; set; }
    }
}