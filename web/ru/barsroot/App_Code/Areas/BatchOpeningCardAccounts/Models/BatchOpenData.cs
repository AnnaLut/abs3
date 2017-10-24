using System;

namespace Areas.BatchOpeningCardAccounts.Models
{
    public class BatchOpenData
    {
        public decimal ID { get; set; }
        public decimal IDN { get; set; }
        public string OKPO { get; set; }
        public string FIRST_NAME { get; set; }
        public string LAST_NAME { get; set; }
        public string MIDDLE_NAME { get; set; }
        public decimal? TYPE_DOC { get; set; }
        public string PASPSERIES { get; set; }
        public string PASPNUM { get; set; }
        public string PASPISSUER { get; set; }
        public DateTime? PASPDATE { get; set; }
        public DateTime? BDAY { get; set; }
        public string COUNTRY { get; set; }
        public string RESIDENT { get; set; }
        public string GENDER { get; set; }
        public string PHONE_HOME { get; set; }
        public string PHONE_MOB { get; set; }
        public string EMAIL { get; set; }
        public string ENG_FIRST_NAME { get; set; }
        public string ENG_LAST_NAME { get; set; }
        public string MNAME { get; set; }
        public string ADDR1_CITYNAME { get; set; }
        public string ADDR1_PCODE { get; set; }
        public string ADDR1_DOMAIN { get; set; }
        public string ADDR1_REGION { get; set; }
        public string ADDR1_STREET { get; set; }
        public long? ADDR1_STREETTYPE { get; set; }
        public string ADDR1_STREETNAME { get; set; }
        public string ADDR1_BUD { get; set; }
        public decimal? REGION_ID1 { get; set; }
        public decimal? AREA_ID1 { get; set; }
        public decimal? SETTLEMENT_ID1 { get; set; }
        public decimal? STREET_ID1 { get; set; }
        public decimal? HOUSE_ID1 { get; set; }
        public string ADDR2_CITYNAME { get; set; }
        public string ADDR2_PCODE { get; set; }
        public string ADDR2_DOMAIN { get; set; }
        public string ADDR2_REGION { get; set; }
        public string ADDR2_STREET { get; set; }
        public long? ADDR2_STREETTYPE { get; set; }
        public string ADDR2_STREETNAME { get; set; }
        public string ADDR2_BUD { get; set; }
        public decimal? REGION_ID2 { get; set; }
        public decimal? AREA_ID2 { get; set; }
        public decimal? SETTLEMENT_ID2 { get; set; }
        public decimal? STREET_ID2 { get; set; }
        public decimal? HOUSE_ID2 { get; set; }
        public string WORK { get; set; }
        public string OFFICE { get; set; }
        public DateTime? DATE_W { get; set; }
        public string OKPO_W { get; set; }
        public string PERS_CAT { get; set; }
        public long? AVER_SUM { get; set; }
        public string TABN { get; set; }
        public string STR_ERR { get; set; }
        public decimal? RNK { get; set; }
        public decimal? ND { get; set; }
        public short? FLAG_OPEN { get; set; }
        public decimal? ACC_INSTANT { get; set; }
        public string KK_SECRET_WORD { get; set; }
        public short? KK_REGTYPE { get; set; }
        public long? KK_CITYAREAID { get; set; }
        public long? KK_STREETTYPEID { get; set; }
        public string KK_STREETNAME { get; set; }
        public string KK_APARTMENT { get; set; }
        public string KK_POSTCODE { get; set; }
        public decimal? MAX_TERM { get; set; }
        public DateTime? PASP_END_DATE { get; set; }
        public string PASP_EDDRID_ID { get; set; }
        public string KF { get; set; }

    }
}