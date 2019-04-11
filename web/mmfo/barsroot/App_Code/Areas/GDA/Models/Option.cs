using System;
using System.Collections.Generic;

namespace Areas.GDA.Models
{
    public class Option
    {
        public List<Xml2CSharp.CONDITION> Conditions { get; set; }
        public string ValidFrom { get; set; }
        public string ValidThough { get; set; }
        public string IsActive { get; set; }
        public string  UserId { get; set; }
        public string SysTime { get; set; }
        public string Id { get; set; }
        public string OptionDescription { get; set; }

    }
}