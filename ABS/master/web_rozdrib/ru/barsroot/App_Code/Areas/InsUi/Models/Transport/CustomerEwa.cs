using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class CustomerEwa
    {
        public string code { get; set; }
        public bool dontHaveCode { get; set; }
        public string name { get; set; }
        public string nameLast { get; set; }
        public string nameFirst { get; set; }
        public string nameMiddle { get; set; }
        public string address { get; set; }
        public string phone { get; set; }
        public string birthDate { get; set; }
        public DocumentEwa document { get; set; }
        public bool legal { get; set; }
    }
}