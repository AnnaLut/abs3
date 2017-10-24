﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for CreateDocumentResult
    /// </summary>
    public class CreateDocumentResult
    {
        public string ExternalDocumentId { get; set; }
        public decimal? DocumentId { get; set; }
        public string DocumentStateCode { get; set; }
        public string ErrorMessage { get; set; }
    }
}