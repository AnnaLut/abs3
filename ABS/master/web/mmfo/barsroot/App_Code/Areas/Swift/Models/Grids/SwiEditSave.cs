using System;
using System.Collections.Generic;

namespace Areas.Swift.Models
{
    public class SwiEditSave
    {
        public List<SwiEditMsg> data { get; set; }
        public decimal swref { get; set; }        
        public int mt { get; set; }
    }
}
