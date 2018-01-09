using System;
using System.Reflection;

namespace BarsWeb.Areas.Kernel.Models
{
    public class BarsUpdateInfo
    {
        public string Name { get; set; }
        public string Hash { get; set; }
        public string Log { get; set; }
        public string ModuleName { get; set; }
        public DateTime Date { get; set; }
        public string HostName { get; set; }
        public string UserName { get; set; }
        public string Version { get; set; }
    }
}