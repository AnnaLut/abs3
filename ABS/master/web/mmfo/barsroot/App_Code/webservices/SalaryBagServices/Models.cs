
namespace Bars.SalaryBagSrv.Models
{
    public class Result
    {
        public Result()
        {
            status = "OK";
            message = "";
        }

        public string status;
        public string message;
    }

    public class UrlModel
    {
        public string mfo { get; set; }
        public string url { get; set; }
    }

    public class CorpAddIfoResult : Result
    {
        public CorpAddIfoResult()
        {
            data = new CorpInfoModel();
        }
        public CorpInfoModel data { get; set; }
    }

    public class OpenCardsResult : Result
    {
        public byte[] OutBlob { get; set; }
    }

    public class CorpInfoModel
    {
        public CorpInfoModel()
        {
            Debt = null;
            CommissionSum = null;
            Premial = null;
        }

        public decimal? Debt { get; set; }
        public decimal? CommissionSum { get; set; }
        public decimal? Premial { get; set; }
    }
}