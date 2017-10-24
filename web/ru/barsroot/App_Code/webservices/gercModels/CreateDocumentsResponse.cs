using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for CreateDocumentsResponse
    /// </summary>
    public class CreateDocumentsResponse
    {
        public CreateDocumentResult[] CreateDocumentResults { get; set; }
        public string ErrorMessage { get; set; }
    }
}