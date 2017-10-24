using System;

namespace BarsWeb.Areas.Crkr.Models
{
    public class ClientProfile
    {
        public decimal? RNK { get; set; }
        public string DBCODE { get; set; }
        public string FullName { get; set; }
        public string INN { get; set; }
        public string Sex { get; set; }
        public DateTime? Birthday { get; set; }
        public string SignResidency { get; set; }
        public string DocumentType { get; set; }
        public string Ser { get; set; }
        public string NumDoc { get; set; }
        public string Organ { get; set; }
        public string EddrId { get; set; }
        public string ActualDate { get; set; }
        public decimal CountryId { get; set; }
        public string Bplace { get; set; }
        public DateTime? IssueDate { get; set; }
        public string PhoneNumber { get; set; }
        public string MobileNumber { get; set; }
        public string DepartmentCode { get; set; }
        public string SourceDownload{ get; set; } //спитати чи обов'язкове!
        public DateTime? RegisterDate { get; set; }
        public string Postindex { get; set; }
        public string Region { get; set; }//область
        public string Area { get; set; }//район
        public string City { get; set; }
        public string Address { get; set; } //вулиця, дім, квартира
        public string Mfo { get; set; }
        public string Nls { get; set; }
        public string Secondary { get; set; }
        public string Okpo { get; set; }
        public decimal IsEdit { get; set; }
        public DateTime? DateVal { get; set; }
        public DateTime? ActualDateTime { get; set; }
        public string StrBirthday { get; set; }
        public string StrIssueDate { get; set; }
        public string StrRegisterDate { get; set; }


        public string ID_SEX { get; set; }
        public string ID_REZID { get; set; }
        public string ID_DOC_TYPE { get; set; }
       
    }
}