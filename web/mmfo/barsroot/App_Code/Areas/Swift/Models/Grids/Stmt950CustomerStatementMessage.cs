using System;

namespace Areas.Swift.Models
{
    public class Stmt950CustomerStatementMessage
    {
        public string bic { get; set; }
        public long rnk { get; set; }
        public string dat1 { get; set; }
        public string dat2 { get; set; }
        public int stmt { get; set; }
    }
}
