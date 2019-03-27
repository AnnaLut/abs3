using System;
using System.Collections.Generic;

using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.IO.Ports;

namespace BarsWeb.Areas.Clients.Models
{
    public class Customer
    {
        [DisplayName(@"������������ ���")]
        [Key]
        public decimal? Id { get; set; }

        [DisplayName(@"�����")]
        public string Branch{get;set;}

        [DisplayName(@"����� ��������")]
        public string ContractNumber{get;set;}

        [DisplayName(@"��� �볺���")]
        public decimal? TypeId { get; set; }
        [DisplayName(@"����� ���� �볺���")]
        public string TypeName { get; set; }
        //DaeteOpen
        [DisplayName(@"���� ��������")]
        public DateTime? DateClosed{get;set;}

        [DisplayName(@"���� ���������")]
        public DateTime? DateOpen{get;set;}

        [DisplayName(@"����� (Բ�)")]
        public string Name{get;set;}

        [DisplayName(@"����� (̳��������)")]
        public string NameInternational{get;set;}

        [DisplayName(@"����� (�������)")]
        public string NameShort{get;set;}

        [DisplayName(@"���������������� ���")]
        public string Code {get;set;}
        public string RequestStatus{get;set;}
        public decimal? RequestType { get; set; }

        [DisplayName(@"����� �������������� (�051)")]
        public string Sed{get;set;}

        [DisplayName(@"������ �����")]
        public virtual ICollection<Address> AddressList{get;set;}

        [DisplayName(@"�������� ��������")]
        public virtual ICollection<CustomerDetail> DetailsList { get; set; }

        /// <summary>
        /// ������ ������
        /// </summary>
        //[DisplayName(@"�����")]
        //public string SearchColumn { get; set; }




        public string EditType = "";

        public string ReadOnly = "false";

        public string ReadOnlyMode = "0";

        public string BANKDATE = "";

        public string Par_EN = "";

        public string ADR = "";

        public string fullADRMORE = "";

        public string CODCAGENT = "";

        public string COUNTRY = "";

        public string PRINSIDER = "";

        public string TGR = "";

        public string STMT = "";

        public string SAB = "";

        public string BC = "";

        public string TOBO = "";

        public string PINCODE = "";

        public string RNlPres = "";

        public string C_REG = "";

        public string C_DST = "";

        public string ADM = "";

        public string TAXF = "";

        public string RGADM = "";

        public string RGTAX = "";

        public string DATET = "";

        public string DATEA = "";

        public string NEkPres = "";

        public string ISE = "";

        public string FS = "";

        public string VED = "";

        public string OE = "";

        public string K050 = "";

        public string MFO = "";

        public string ALT_BIC = "";

        public string BIC = "";

        public string RATING = "";

        public string KOD_B = "";

        public string DAT_ND = "";

        public string NUM_ND = "";

        public string RUK = "";

        public string BUH = "";

        public string TELR = "";

        public string TELB = "";

        public string NMKU = "";

        public string fullACCS = "";

        public string E_MAIL = "";

        public string TEL_FAX = "";

        public string SEAL_ID = "";

        public string RCFlPres = "";

        public string PASSP = "";

        public string SER = "";

        public string NUMDOC = "";

        public string ORGAN = "";

        public string PDATE = "";

        public string BDAY = "";

        public string BPLACE = "";

        public string SEX = "";

        public string TELD = "";

        public string TELW = "";

        public string ISP = "";

        public string NOTES = "";

        public string CRISK = "";

        public string MB = "";

        public string ADR_ALT = "";

        public string NOM_DOG = "";

        public string LIM_KASS = "";

        public string LIM = "";

        public string NOMPDV = "";

        public string RNKP = "";

        public string NOTESEC = "";

        public string TrustEE = "";

        public string NRezidCode = "";

        public string DopRekv = "";

        public string DopRekv_SN_LN = "";

        public string DopRekv_SN_FN = "";

        public string DopRekv_SN_MN = "";

        public string DopRekv_SN_4N = "";

        public string DopRekv_MPNO = "";
    }
}