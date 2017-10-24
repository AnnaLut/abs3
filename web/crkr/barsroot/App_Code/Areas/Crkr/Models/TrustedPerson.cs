namespace BarsWeb.Areas.Crkr.Models
{
    public class TrustedPerson
    {
        public string FIOB { get; set; }
        public string NSC { get; set; }
        public string FULLADDRESSB { get; set; }
        public string ICODB { get; set; }
        public string DOCTYPEB { get; set; }
        public string DOCSERIALB { get; set; }
        public string DOCNUMBERB { get; set; }
        public string DOCORGB { get; set; }
        public string DOCDATEB { get; set; }
        public string CLIENTBDATEB { get; set; }
        public string CLIENTPHONEB { get; set; }

        private readonly string _document = null;
        public string DOCUMENTB
        {
            get
            {
                if (_document == null)
                    return DOCSERIALB + " " + DOCNUMBERB;
                return _document;
            }
        }
    }
}