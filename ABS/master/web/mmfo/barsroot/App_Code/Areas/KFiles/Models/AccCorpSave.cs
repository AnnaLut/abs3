using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;

namespace BarsWeb.Areas.KFiles.Models
{
    public class AccCorpSave : IOracleCustomType
    {
        [OracleObjectMapping("RNK")]
        public decimal RNK { get; set; }

        [OracleObjectMapping("USE_INVP")]
        public string USE_INVP { get; set; }

        [OracleObjectMapping("TRKK")]
        public string TRKK_KOD { get; set; }

        [OracleObjectMapping("INST_KOD")]
        public string INST_KOD { get; set; }

        [OracleObjectMapping("ALT_CORP_COD")]
        public string ALT_CORP_COD { get; set; }

        [OracleObjectMapping("ACC")]
        public decimal ACC { get; set; }

        [OracleObjectMapping("DAOS")]
        public DateTime DAOS { get; set; }

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, "RNK", RNK);
            OracleUdt.SetValue(con, pUdt, "USE_INVP", USE_INVP);
            OracleUdt.SetValue(con, pUdt, "TRKK", TRKK_KOD);
            OracleUdt.SetValue(con, pUdt, "INST_KOD", INST_KOD);
            OracleUdt.SetValue(con, pUdt, "ALT_CORP_COD", ALT_CORP_COD);
            OracleUdt.SetValue(con, pUdt, "ACC", ACC);
            OracleUdt.SetValue(con, pUdt, "DAOS", DAOS);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            RNK = (decimal)OracleUdt.GetValue(con, pUdt, "RNK");
            USE_INVP = (string)OracleUdt.GetValue(con, pUdt, "USE_INVP");
            TRKK_KOD = (string)OracleUdt.GetValue(con, pUdt, "TRKK");
            INST_KOD = (string)OracleUdt.GetValue(con, pUdt, "INST_KOD");
            ALT_CORP_COD = (string)OracleUdt.GetValue(con, pUdt, "ALT_CORP_COD");
            ACC = (decimal)OracleUdt.GetValue(con, pUdt, "ACC");
            DAOS = (DateTime)OracleUdt.GetValue(con, pUdt, "DAOS");
        }
    }

    [OracleCustomTypeMapping("BARS.T_ACC_CORP_PARAMS_REC")]
    public class AccCorpFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new AccCorpSave();
        }
    }

    [OracleCustomTypeMapping("BARS.T_ACC_CORP_PARAMS")]
    public class FilterInfoListFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new AccCorpSave[numElems];

        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }
    }
}


