using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for CancelDocumentsResponse
    /// </summary>
    public class CancelDocumentsResponse
    {
        public CancelDocumentResult[] CancelDocumentResults { get; set; }
        public string ErrorMessage { get; set; }
    }
}