using System;

namespace Areas.PRVN.Models
{
    public class SrrCostRow
    {
        public decimal ID_CALC_SET { get; set; }
        public string UNIQUE_BARS_IS { get; set; }
        public string ID_BRANCH { get; set; }
        public string ID_CURRENCY { get; set; }
        public decimal FV_CCY { get; set; }
        public string CLIENT_NAME { get; set; }
        public string COMM { get; set; }

        public string RNK_CLIENT { get; set; }
    }

    public class InsertRowResult : SrrCostRow
    {
        public InsertRowResult(SrrCostRow val)
        {
            this.ID_CALC_SET = val.ID_CALC_SET;
            this.ID_BRANCH = val.ID_BRANCH;
            this.ID_CURRENCY = val.ID_CURRENCY;
            this.UNIQUE_BARS_IS = val.UNIQUE_BARS_IS;
            this.CLIENT_NAME = val.CLIENT_NAME;
            this.RNK_CLIENT = val.RNK_CLIENT;

            this.COMM = val.COMM;
            this.FV_CCY = val.FV_CCY;

            this.ErrorText = string.Empty;
        }

        public InsertRowResult()
        {
            this.ErrorText = string.Empty;
        }

        public string ErrorText { get; set; }
    }
}
