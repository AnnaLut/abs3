using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for DocumentState
    /// </summary>
    public class DocumentState
    {
        public string ExternalDocumentId { get; set; }
        public string DocumentStateCode { get; set; }
        public string DocumentRef { get; set; }
        public string ErrorMessage { get; set; }
    }
}