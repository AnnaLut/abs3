using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Bars.EAD.Models
{
    public class EadType
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Method { get; set; }
        public decimal MsgLifetime { get; set; }
        public int MsgRetryInterval { get; set; }
        public int? IsUo { get; set; }
        public int? Order { get; set; }
    }
}