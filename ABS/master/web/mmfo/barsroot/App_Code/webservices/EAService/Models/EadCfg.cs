using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Bars.EAD.Models
{
    public class EadCfg
    {
        public string Kf { get; set; }
        public int? Mode { get; set; }
    }
}