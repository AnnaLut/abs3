using System;

namespace Areas.AccpReportDocs.Models
{
    public class ACCPDOCS
    {
        public String OKPO_ORG { get; set; }
        public Decimal TYPEPL { get; set; }
        public Decimal REF { get; set; }
        public String BRANCH { get; set; }
        public DateTime FDAT { get; set; }
        public String NLSA { get; set; }
        public String NLSB { get; set; }
        public String MFOA { get; set; }
        public String MFOB { get; set; }
        public String NAM_A { get; set; }
        public String NAM_B { get; set; }
        public String ID_A { get; set; }
        public String ID_B { get; set; }
        public Decimal S { get; set; }
        public Decimal S_FEE { get; set; }
        public Decimal ORDER_FEE { get; set; }
        public Decimal AMOUNT_FEE { get; set; }
        public String NAZN { get; set; }
        public Decimal CHECK_ON { get; set; }
    }
}
