using System.Collections.Generic;

namespace BarsWeb.Areas.Crkr.Models
{
    public class ResultPay
    {
        public ResultPay(IEnumerable<PayRegister> listOfDepos, string info)
        {
            ListOfDepos = listOfDepos;
            Info = info;
        }

        public ResultPay(IEnumerable<PayRegister> listOfDepos, decimal? amount, decimal? count)
        {
            ListOfDepos = listOfDepos;
            Amount = amount;
            Count = count;
        }
        
        public IEnumerable<PayRegister> ListOfDepos { get; set; }
        public decimal? Amount { get; set; }
        public decimal? Count { get; set; }
        public string Info { get; set; }
    }
}