using System;

namespace Bars.WebServices.XRM.Services.SKRN.Models
{
    public class PrintDocByRefRequest
    {
        /// <summary>
        /// ref документу
        /// </summary>
        public string Reference { get; set; }
    }

    public class PrintDocByRefResponse
    {
        public string Content { get; set; }
        public string Extension { get; set; }
    }
}
