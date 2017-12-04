using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;

namespace BarsWeb.Areas.PfuSync.SyncModels
{
    public class PensAccQueue : INullable, IOracleCustomType
    {

        [OracleObjectMappingAttribute("ACC")]
        public decimal ACC { get; set; }
        [OracleObjectMappingAttribute("BRANCH")]
        public string BRANCH { get; set; }
        [OracleObjectMappingAttribute("DAOS")]
        public DateTime? DAOS { get; set; }
        [OracleObjectMappingAttribute("DAPP")]
        public DateTime? DAPP { get; set; }
        [OracleObjectMappingAttribute("DAZS")]
        public DateTime? DAZS { get; set; }
        [OracleObjectMappingAttribute("KF")]
        public string KF { get; set; }
        [OracleObjectMappingAttribute("KV")]
        public Int32 KV { get; set; }
        [OracleObjectMappingAttribute("LAST_CHGDATE")]
        public DateTime? LAST_CHGDATE { get; set; }
        [OracleObjectMappingAttribute("LAST_IDUPD")]
        public decimal? LAST_IDUPD { get; set; }
        [OracleObjectMappingAttribute("NLS")]
        public string NLS { get; set; }
        [OracleObjectMappingAttribute("OB22")]
        public string OB22 { get; set; }
        [OracleObjectMappingAttribute("RNK")]
        public decimal RNK { get; set; }
        //[OracleObjectMappingAttribute("SET_DATE_SYNC")]
        //public DateTime? SET_DATE_SYNC { get; set; }
        //[OracleObjectMappingAttribute("STATE_SYNC")]
        //public Int32? STATE_SYNC { get; set; }

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
            OracleUdt.SetValue(con, pUdt, "ACC", ACC);
            OracleUdt.SetValue(con, pUdt, "BRANCH", BRANCH);
            OracleUdt.SetValue(con, pUdt, "DAOS", DAOS);
            OracleUdt.SetValue(con, pUdt, "DAPP", DAPP);
            OracleUdt.SetValue(con, pUdt, "DAZS", DAZS);
            OracleUdt.SetValue(con, pUdt, "KF", KF);
            OracleUdt.SetValue(con, pUdt, "KV", KV);
            OracleUdt.SetValue(con, pUdt, "LAST_CHGDATE", LAST_CHGDATE);
            OracleUdt.SetValue(con, pUdt, "LAST_IDUPD", LAST_IDUPD);
            OracleUdt.SetValue(con, pUdt, "NLS", NLS);
            OracleUdt.SetValue(con, pUdt, "OB22", OB22);
            OracleUdt.SetValue(con, pUdt, "RNK", RNK);
            //OracleUdt.SetValue(con, pUdt, "SET_DATE_SYNC", SET_DATE_SYNC);
            //OracleUdt.SetValue(con, pUdt, "STATE_SYNC", STATE_SYNC);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            ACC = (decimal)OracleUdt.GetValue(con, pUdt, "ACC");
            BRANCH = (string)OracleUdt.GetValue(con, pUdt, "BRANCH");
            DAOS = (DateTime?)OracleUdt.GetValue(con, pUdt, "DAOS");
            DAPP = (DateTime?)OracleUdt.GetValue(con, pUdt, "DAPP");
            DAZS = (DateTime?)OracleUdt.GetValue(con, pUdt, "DAZS");
            KF = (string)OracleUdt.GetValue(con, pUdt, "KF");
            KV = (Int32)OracleUdt.GetValue(con, pUdt, "KV");
            LAST_CHGDATE = (DateTime?)OracleUdt.GetValue(con, pUdt, "LAST_CHGDATE");
            LAST_IDUPD = (decimal?)OracleUdt.GetValue(con, pUdt, "LAST_IDUPD");
            NLS = (string)OracleUdt.GetValue(con, pUdt, "NLS");
            OB22 = (string)OracleUdt.GetValue(con, pUdt, "OB22");
            RNK = (decimal)OracleUdt.GetValue(con, pUdt, "RNK");
            //SET_DATE_SYNC = (DateTime?)OracleUdt.GetValue(con, pUdt, "SET_DATE_SYNC");
            //STATE_SYNC = (Int32)OracleUdt.GetValue(con, pUdt, "STATE_SYNC");
        }
    }

    //Oracle type mapping class
    //single obj
    [OracleCustomTypeMappingAttribute("BARS.R_PFU_PENSACC")]
    public class PensAccQueueFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new PensAccQueue();
        }
    }

    //array of obj's
    [OracleCustomTypeMappingAttribute("BARS.T_PFU_PENSACC")]
    public class PensAccQueueArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new PensAccQueue[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }

    }
}