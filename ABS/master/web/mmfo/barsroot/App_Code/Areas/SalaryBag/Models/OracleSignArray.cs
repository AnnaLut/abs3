using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;

namespace Areas.SalaryBag.Models
{
    public class OracleSignArrayItem : IOracleCustomType
    {
        [OracleObjectMapping("ID")]
        public int id { get; set; }

        [OracleObjectMapping("KEY_ID")]
        public string SubjectSN { get; set; }

        [OracleObjectMapping("SIGN")]
        public string Sign { get; set; }

        [OracleObjectMapping("DOC_BUFFER")]
        public string buffer { get; set; }

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, "ID", id);
            OracleUdt.SetValue(con, pUdt, "KEY_ID", SubjectSN);
            OracleUdt.SetValue(con, pUdt, "SIGN", Sign);
            OracleUdt.SetValue(con, pUdt, "DOC_BUFFER", buffer);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            id = (int)OracleUdt.GetValue(con, pUdt, "ID");
            SubjectSN = (string)OracleUdt.GetValue(con, pUdt, "KEY_ID");
            Sign = (string)OracleUdt.GetValue(con, pUdt, "SIGN");
            buffer = (string)OracleUdt.GetValue(con, pUdt, "DOC_BUFFER");
        }
    }

    [OracleCustomTypeMapping("BARS.T_SIGN_DOC_REC")]
    public class SignArrayItemFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new OracleSignArrayItem();
        }
    }

    [OracleCustomTypeMapping("BARS.T_SIGN_DOC_SET")]
    public class FilterInfoListFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new OracleSignArrayItem[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }
    }
}
