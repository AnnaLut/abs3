using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class XRMDKBOReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public List<XRMDKBOReqInner> Data;
    }

    public class XRMDKBOReqInner
    {
        public Decimal Ext_id;
        public Decimal RNK;
        public String DealNumber;
        public List<Decimal?> AccList;
        public DateTime? DKBODateFrom;
        public DateTime? DKBODateTo;
    }

    public class XRMDKBORes
    {
        public Decimal TransactionId;
        public List<XRMDKBOResInner> Results;
    }

    public class XRMDKBOResInner
    {
        public Decimal Ext_id;
        public Decimal? DealId;
        public DateTime? StartDate;
        public Int32 ResultCode;
        public String ResultMessage;
        public Decimal Rnk;
    }

    public class XRMQuestionnaireDKBOAttrReq
    {
        public string Code;
        public string Value;
    }

    public class XRMQuestionnaireDKBOReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public string NewDKBOId;
        public XRMQuestionnaireDKBOAttrReq[] Attributes;
    }

    public class XRMQuestionnaireDKBOAttrRes
    {
        public string AttributeCode;
        public string AttributeMessage;
    }

    public class XRMQuestionnaireDKBORes
    {
        public int ResultCode;
        public string ResultMessage;
        public List<XRMQuestionnaireDKBOAttrRes> Answers;
    }
}