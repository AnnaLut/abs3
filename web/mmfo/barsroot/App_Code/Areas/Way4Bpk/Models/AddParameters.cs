using System;
using System.Collections.Generic;


namespace Areas.Way4Bpk.Models
{
    public class AddParameters
    {
        public long ND { get; set; }
        public List<AddParameter> Params { get; set; }
}

    public class AddParameter
    {
        public string Tag { get; set; }
        public string Value { get; set; }
    }

    public class AddParamVal
    {
        public string Tag { get; set; }
        public string ID { get; set; }
        public string NAME { get; set; }
    }
}