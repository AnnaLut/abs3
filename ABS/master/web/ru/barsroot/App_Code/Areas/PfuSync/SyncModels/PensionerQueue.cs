using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;

namespace BarsWeb.Areas.PfuSync.SyncModels
{
    public class PensionerQueue : INullable, IOracleCustomType
    {
        [OracleObjectMappingAttribute("ADR")]
        public string ADR { get; set; }
        [OracleObjectMappingAttribute("BDAY")]
        public DateTime? BDAY { get; set; }
        [OracleObjectMappingAttribute("BPLACE")]
        public string BPLACE { get; set; }
        [OracleObjectMappingAttribute("BRANCH")]
        public string BRANCH { get; set; }
        [OracleObjectMappingAttribute("CELLPHONE")]
        public string CELLPHONE { get; set; }
        [OracleObjectMappingAttribute("DATE_OFF")]
        public DateTime? DATE_OFF { get; set; }
        [OracleObjectMappingAttribute("DATE_ON")]
        public DateTime? DATE_ON { get; set; }
        [OracleObjectMappingAttribute("KF")]
        public string KF { get; set; }
        [OracleObjectMappingAttribute("LAST_CHGDATE")]
        public DateTime? LAST_CHGDATE { get; set; }
        [OracleObjectMappingAttribute("LAST_IDUPD")]
        public decimal? LAST_IDUPD { get; set; }
        [OracleObjectMappingAttribute("NMK")]
        public string NMK { get; set; }
        [OracleObjectMappingAttribute("NUMDOC")]
        public string NUMDOC { get; set; }
        [OracleObjectMappingAttribute("OKPO")]
        public string OKPO { get; set; }
        [OracleObjectMappingAttribute("ORGAN")]
        public string ORGAN { get; set; }
        [OracleObjectMappingAttribute("PASSP")]
        public Int32 PASSP { get; set; }
        [OracleObjectMappingAttribute("PDATE")]
        public DateTime? PDATE { get; set; }
        [OracleObjectMappingAttribute("RNK")]
        public decimal RNK { get; set; }
        [OracleObjectMappingAttribute("SER")]
        public string SER { get; set; }
        [JsonIgnore]
        public bool IsNull
        {
            get
            {
                return false;
            }
        }
        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, "ADR", ADR);
            OracleUdt.SetValue(con, pUdt, "BDAY", BDAY);
            OracleUdt.SetValue(con, pUdt, "BPLACE", BPLACE);
            OracleUdt.SetValue(con, pUdt, "BRANCH", BRANCH);
            OracleUdt.SetValue(con, pUdt, "CELLPHONE", CELLPHONE);
            OracleUdt.SetValue(con, pUdt, "DATE_OFF", DATE_OFF);
            OracleUdt.SetValue(con, pUdt, "DATE_ON", DATE_ON);
            OracleUdt.SetValue(con, pUdt, "KF", KF);
            OracleUdt.SetValue(con, pUdt, "LAST_CHGDATE", LAST_CHGDATE);
            OracleUdt.SetValue(con, pUdt, "LAST_IDUPD", LAST_IDUPD);
            OracleUdt.SetValue(con, pUdt, "NMK", NMK);
            OracleUdt.SetValue(con, pUdt, "NUMDOC", NUMDOC);
            OracleUdt.SetValue(con, pUdt, "OKPO", OKPO);
            OracleUdt.SetValue(con, pUdt, "ORGAN", ORGAN);
            OracleUdt.SetValue(con, pUdt, "PASSP", PASSP);
            OracleUdt.SetValue(con, pUdt, "PDATE", PDATE);
            OracleUdt.SetValue(con, pUdt, "RNK", RNK);
            OracleUdt.SetValue(con, pUdt, "SER", SER);
        }
        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            BDAY = (DateTime)OracleUdt.GetValue(con, pUdt, "BDAY");
            BPLACE = (string)OracleUdt.GetValue(con, pUdt, "BPLACE");
            BRANCH = (string)OracleUdt.GetValue(con, pUdt, "BRANCH");
            CELLPHONE = (string)OracleUdt.GetValue(con, pUdt, "CELLPHONE");
            DATE_OFF = (DateTime?)OracleUdt.GetValue(con, pUdt, "DATE_OFF");
            DATE_ON = (DateTime?)OracleUdt.GetValue(con, pUdt, "DATE_ON");
            KF = (string)OracleUdt.GetValue(con, pUdt, "KF");
            LAST_CHGDATE = (DateTime?)OracleUdt.GetValue(con, pUdt, "LAST_CHGDATE");
            LAST_IDUPD = (decimal?)OracleUdt.GetValue(con, pUdt, "LAST_IDUPD");
            NMK = (string)OracleUdt.GetValue(con, pUdt, "NMK");
            NUMDOC = (string)OracleUdt.GetValue(con, pUdt, "NUMDOC");
            OKPO = (string)OracleUdt.GetValue(con, pUdt, "OKPO");
            ORGAN = (string)OracleUdt.GetValue(con, pUdt, "ORGAN");
            PASSP = (Int32)OracleUdt.GetValue(con, pUdt, "PASSP");
            PDATE = (DateTime?)OracleUdt.GetValue(con, pUdt, "PDATE");
            RNK = (decimal)OracleUdt.GetValue(con, pUdt, "RNK");
            SER = (string)OracleUdt.GetValue(con, pUdt, "SER");
        }
    }

    //Oracle type mapping class
    //single obj
    [OracleCustomTypeMappingAttribute("BARS.R_PFU_PENSIONER")]
    public class PensionerQueueFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new PensionerQueue();
        }
    }

    //array of obj's
    [OracleCustomTypeMappingAttribute("BARS.T_PFU_PENSIONER")]
    public class PensionerQueueArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new PensionerQueue[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }

    }
}