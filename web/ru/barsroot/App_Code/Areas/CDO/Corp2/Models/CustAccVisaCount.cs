namespace BarsWeb.Areas.CDO.Corp2.Models
{
    public class CustAccVisaCount
    {
        public decimal Id
        {
            get
            {
                return ACC_ID ^ VISA_ID;
            }
        }
        public int ACC_ID { get; set; }
        public int CORP2_ACC_ID { get; set; }
        public int VISA_ID { get; set; }
        public int Old_VISA_ID { get; set; }
        public int? COUNT { get; set; }
    }
}