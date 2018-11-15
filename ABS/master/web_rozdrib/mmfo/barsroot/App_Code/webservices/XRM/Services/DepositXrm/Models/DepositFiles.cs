using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    /*формування довідки по депозитному рахунку*/
    public class AccStatusRequest
    {
        public string Kf;
        public int Rnk;
        public int AgrId;
    }
    /*формування виписок в нац. і іноз. валютах по депозитному рахунку*/
    public class ExtractFileRequest
    {
        public string Kf;
        public string DateFrom;
        public string DateTo;
        public decimal Param;
        public decimal National;
    }
}