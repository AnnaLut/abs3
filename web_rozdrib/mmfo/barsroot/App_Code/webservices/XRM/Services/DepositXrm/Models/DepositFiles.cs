using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    /*формування довідки по депозитному рахунку*/
    public class XRMDepositAccStatus
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;
        public int rnk;
        public int agr_id;
    }
    /*формування виписок в нац. і іноз. валютах по депозитному рахунку*/
    public class XRMDepositExtract
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;
        public String DATFROM;
        public String DATTO;
        public Decimal Param;
        public Decimal National;
    }
}