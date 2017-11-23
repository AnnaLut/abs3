using System;

namespace BarsWeb.Areas.AccountRestore.Models
{
    /// <summary>
    /// Account for restore (saldo view)
    /// </summary>
    public class RestoreAccount
    {
        /// <summary>
        /// Internal account number
        /// </summary>
        public Decimal ACC { get; set; }
        /// <summary>
        /// Account number (external)
        /// </summary>
        public String NLS { get; set; }
        /// <summary>
        /// Currency code
        /// </summary>
        public Int16? KV { get; set; }
        /// <summary>
        /// Account name
        /// </summary>
        public String NMS { get; set; }
        /// <summary>
        /// Customer's registration number
        /// </summary>
        public Decimal? RNK { get; set; }
        /// <summary>
        /// Account opening date
        /// </summary>
        public DateTime? DAOS { get; set; }
        /// <summary>
        /// Account closure date
        /// </summary>
        public DateTime DAZS { get; set; }
    }
}
