using System;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class KievCardImported
    {
        public decimal Idn { get; set; }
        public string Okpo { get; set; }
        public string First_Name { get; set; }
        public string Middle_Name { get; set; }
        public string Last_Name { get; set; }
        public DateTime BDay { get; set; }
        public string Phone_Mob {get; set;}
        public string PaspSeries { get; set; }
        public string PaspNum { get; set; }
        public string PaspIssuer { get; set; }
        public string Work { get; set; }
        public decimal? KK_Regtype {get; set;}
        public decimal? KK_CityAreaId {get; set;}
        public decimal? KK_StreetTypeId {get;set;}
        public string KK_StreetName {get;set;}
        public string KK_Apartment {get;set;}
        public string KK_Postcode { get; set; }
        public string Addr1_Cityname { get; set; }
        public string Addr1_Street { get; set; }
        public string Str_Err { get; set; }

        public string FullName
        {
            get { return Last_Name + " " + First_Name + " " + Middle_Name; }
        }

        public string FullDocNumber
        {
            get { return PaspSeries + " " + PaspNum; }
        }

        public string FullAddress
        {
            get { return Addr1_Cityname + "; " + Addr1_Street; }
        }
    }
}
