namespace BarsWeb.Areas.Crkr.Models
{
    public enum UserType
    {
        Oper,
        Control,
        Back
    }

    public enum TabIndex
    {
        ActDep,
        ActFun,
        ActHer,
        Replen,
        Canceled,
        Benef,
        Document
    }
    public class PaymentsList
    {

        public decimal[] id { get; set; }
        public string Reason { get; set; }

        public TabIndex TabIndex { get; set; }
        public UserType UserType { get; set; }
    }
}
