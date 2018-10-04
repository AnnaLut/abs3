using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    /// <summary>
    /// Summary description for DuplicatesV2Dto
    /// </summary>
    public class DuplicatesV2Dto : INullable, IOracleCustomType
    {
        public DuplicatesV2Dto()
        {
            Gcif = string.Empty;
            MasterGcif = string.Empty;
        }

        [OracleObjectMappingAttribute("KF")]
        public string Kf { get; set; }

        [OracleObjectMappingAttribute("RNK")]
        public decimal Rnk { get; set; }

        [OracleObjectMappingAttribute("GCIF")]
        public string Gcif { get; set; }

        [OracleObjectMappingAttribute("MASTERGCIF")]
        public string MasterGcif { get; set; }

        public bool IsNull
        {
            get
            {
                return string.IsNullOrEmpty(Kf) && string.IsNullOrEmpty(Gcif) && string.IsNullOrWhiteSpace(MasterGcif);
            }
        }

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            if (Kf != null)
            {
                OracleUdt.SetValue(con, pUdt, "KF", Kf);
            }

            OracleUdt.SetValue(con, pUdt, "RNK", Rnk);

            if (Gcif != null)
            {
                OracleUdt.SetValue(con, pUdt, "GCIF", Gcif);
            }

            if (MasterGcif != null)
            {
                OracleUdt.SetValue(con, pUdt, "MASTERGCIF", MasterGcif);
            }
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            Kf = (string) OracleUdt.GetValue(con, pUdt, "KF");
            Rnk = (long) OracleUdt.GetValue(con, pUdt, "RNK");
            Gcif = (string) OracleUdt.GetValue(con, pUdt, "GCIF");
            MasterGcif = (string) OracleUdt.GetValue(con, pUdt, "MASTERGCIF");
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.R_SLAVE_CLIENT_EBK")]
    public class DuplicatesV2DtoFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject() { return new DuplicatesV2Dto();}
    }

    [OracleCustomTypeMappingAttribute("BARS.T_SLAVE_CLIENT_EBK")]
    public class DuplicatesV2DtoArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new DuplicatesV2Dto[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return null;
        }
    }
}