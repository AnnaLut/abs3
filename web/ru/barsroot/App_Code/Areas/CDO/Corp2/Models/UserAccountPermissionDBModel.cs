namespace BarsWeb.Areas.CDO.Corp2.Models
{
    /// <summary>
    /// Summary description for UserAccountPermissionDBModel
    /// </summary>
    public class UserAccountPermissionDBModel
    {
        public string ACTIVE { get; set; }
        public string NUM_ACC { get; set; }
        public int? CORP2_ACC { get; set; }
        public string KF { get; set; }
        public int? KV { get; set; }
        public decimal? USER_ID { get; set; }
        public decimal? CUST_ID { get; set; }
        public string CAN_VIEW { get; set; }
        public string CAN_DEBIT { get; set; }
        public string CAN_VISA { get; set; }
        public int? VISA_ID { get; set; }
        public string SEQUENTIAL_VISA { get; set; }
        public string NAME { get; set; }
        //public int VISA_QUANTITY { get; set; }
    }
}