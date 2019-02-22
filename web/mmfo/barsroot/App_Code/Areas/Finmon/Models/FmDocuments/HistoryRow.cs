using System;

namespace Areas.Finmom.Models
{
    public class HistoryRow
    {
        public DateTime? ModDate { get; set; }
        public string ModType { get; set; }
        public string Name { get; set; }
        public long? UserId { get; set; }
        public string UserName { get; set; }
        public string OldValue { get; set; }
    }
}