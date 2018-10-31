using System;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class EbkSlaveClient : INullable, IOracleCustomType
    {
        [OracleObjectMappingAttribute("KF")]
        public string Kf { get; set; }
        [OracleObjectMappingAttribute("RNK")]
        public decimal? Rnk { get; set; }

        public bool IsNull
        {
            get { return Rnk == null && string.IsNullOrEmpty(Kf); }
        }

        public void FromCustomObject(Oracle.DataAccess.Client.OracleConnection con, System.IntPtr pUdt)
        {
            if (Rnk != null)
            {
                OracleUdt.SetValue(con, pUdt, "RNK", Rnk);
            }

            if (Kf != null)
            {
                OracleUdt.SetValue(con, pUdt, "KF", Kf);
            }
        }

        public void ToCustomObject(Oracle.DataAccess.Client.OracleConnection con, System.IntPtr pUdt)
        {
            Kf = (string)OracleUdt.GetValue(con, pUdt, "KF");
            Rnk = (decimal?)OracleUdt.GetValue(con, pUdt, "RNK");
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.R_SLAVE_CLIENT_EBK_V1")]
    public class SlaveClientFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new EbkSlaveClient();
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.T_SLAVE_CLIENT_EBK_V1")]
    public class SlaveClientArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new EbkSlaveClient[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return null;
        }

    }
}