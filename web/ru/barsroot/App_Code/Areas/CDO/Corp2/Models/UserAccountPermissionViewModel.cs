namespace BarsWeb.Areas.CDO.Corp2.Models
{
    /// <summary>
    /// Summary description for Corp2AccUser
    /// </summary>
    public class UserAccountPermissionViewModel
    {
        private long id;
        public long Id
        {
            get
            {
                if(id == 0) id = NUM_ACC.GetHashCode() ^ (KV == null ? 0 : KV.GetHashCode()) ^ (KF == null ? 0 : KF.GetHashCode()) ^ (USER_ID == null ? 0 : (long)USER_ID);
                return id;
            }
        }
        public bool CAN_WORK { get; set; }
        public string NUM_ACC { get; set; }
        public int? CORP2_ACC { get; set; }
        public string KF { get; set; }
        public int? KV { get; set; }
        public decimal? USER_ID { get; set; }
        public decimal? CUST_ID { get; set; }
        public bool CAN_VIEW { get; set; }
        public bool CAN_DEBIT { get; set; }
        public bool CAN_VISA { get; set; }
        public int? VISA_ID { get; set; }
        public bool SEQUENTIAL_VISA { get; set; }
        public string NAME { get; set; }
        //public int VISA_QUANTITY { get; set; }
    }
}