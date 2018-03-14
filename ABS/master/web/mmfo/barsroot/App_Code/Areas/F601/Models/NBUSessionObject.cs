using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.F601.Models
{

    /// <summary>
    /// Summary description for NBUSessionObject
    /// </summary>
    public class NBUSessionObject
    {
        public NBUSessionObject()
        {
            Header = null;
        }

        public string Payload { get; set; }

        public string Protected { get; set; }

        public string Header { get; set; }

        public string Signature { get; set; }

    }
}