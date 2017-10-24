﻿using System;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class EbkDupeClient : INullable, IOracleCustomType
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

    [OracleCustomTypeMappingAttribute("BARS.R_DUPLICATE_EBK")]
    public class DupeClientFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new EbkDupeClient();
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.T_DUPLICATE_EBK")]
    public class DupeClientArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new EbkDupeClient[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return null;
        }
    }
}