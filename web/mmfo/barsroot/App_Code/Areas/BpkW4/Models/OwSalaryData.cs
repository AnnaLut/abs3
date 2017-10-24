using System;

namespace BarsWeb.Areas.BpkW4.Models
{
    public class OwSalaryData
    {
        public Decimal? ID { get; set; }
        public Decimal? IDN { get; set; }
        public Decimal? ND { get; set; }
        public Decimal? RNK { get; set; }
        public String NLS { get; set; }
        public String OKPO { get; set; }
        public String FIRST_NAME { get; set; }
        public String LAST_NAME { get; set; }
        public String MIDDLE_NAME { get; set; }
        public Decimal? TYPE_DOC { get; set; }
        public String PASPSERIES { get; set; }
        public String PASPNUM { get; set; }
        public String PASPISSUER { get; set; }
        public DateTime? PASPDATE { get; set; }
        public DateTime? BDAY { get; set; }
        public String COUNTRY { get; set; }
        public String RESIDENT { get; set; }
        public String GENDER { get; set; }
        public String PHONE_HOME { get; set; }
        public String PHONE_MOB { get; set; }
        public String EMAIL { get; set; }
        public String ENG_FIRST_NAME { get; set; }
        public String ENG_LAST_NAME { get; set; }
        public String MNAME { get; set; }
        public String ADDR1_CITYNAME { get; set; }
        public String ADDR1_PCODE { get; set; }
        public String ADDR1_DOMAIN { get; set; }
        public String ADDR1_REGION { get; set; }
        public String ADDR1_STREET { get; set; }
        public String ADDR2_CITYNAME { get; set; }
        public String ADDR2_PCODE { get; set; }
        public String ADDR2_DOMAIN { get; set; }
        public String ADDR2_REGION { get; set; }
        public String ADDR2_STREET { get; set; }
        public String WORK { get; set; }
        public String OFFICE { get; set; }
        public DateTime? DATE_W { get; set; }
        public String OKPO_W { get; set; }
        public String PERS_CAT { get; set; }
        public Decimal? AVER_SUM { get; set; }
        public String TABN { get; set; }
        public String STR_ERR { get; set; }
        public Decimal? FLAG_OPEN { get; set; }

        public String FullName
        {
            get { return LAST_NAME + " " + FIRST_NAME + " " + MIDDLE_NAME; }
        }

        public String PasspNum
        {
            get { return PASPSERIES + " " + PASPNUM; }
        }

        public String FullAddress
        {
            get { return ADDR1_CITYNAME + "; " + ADDR1_STREET; }
        }
    }
}