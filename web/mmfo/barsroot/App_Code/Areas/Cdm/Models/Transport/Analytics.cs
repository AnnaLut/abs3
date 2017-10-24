using System;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class Analytics : INullable, IOracleCustomType
    {
        [OracleObjectMappingAttribute("QUALITY")]
        public string Quality { get; set; }

        [OracleObjectMappingAttribute("NAME")]
        public string Name { get; set; }

        [OracleObjectMappingAttribute("VALUE")]
        public string Value { get; set; }

        [OracleObjectMappingAttribute("RECOMMENDVALUE")]
        public string RecommendValue { get; set; }

        [OracleObjectMappingAttribute("DESCR")]
        public string Descr { get; set; }

        public bool IsNull
        {
            get
            {
                return (string.IsNullOrEmpty(Quality) && string.IsNullOrEmpty(Name) && string.IsNullOrEmpty(Value) &&
                        string.IsNullOrEmpty(RecommendValue) && string.IsNullOrEmpty(Descr));
            }
        }

        public void FromCustomObject(Oracle.DataAccess.Client.OracleConnection con, System.IntPtr pUdt)
        {

            if (Quality != null)
            {
                OracleUdt.SetValue(con, pUdt, "QUALITY", Quality);
            }

            if (Name != null)
            {
                OracleUdt.SetValue(con, pUdt, "NAME", Name);
            }

            if (Value != null)
            {
                OracleUdt.SetValue(con, pUdt, "VALUE", Value);
            }

            if (RecommendValue != null)
            {
                OracleUdt.SetValue(con, pUdt, "RECOMMENDVALUE", RecommendValue);
            }
            if (Descr != null)
            {
                OracleUdt.SetValue(con, pUdt, "DESCR", Descr);
            }
        }

        public void ToCustomObject(Oracle.DataAccess.Client.OracleConnection con, System.IntPtr pUdt)
        {
            Quality = (string)OracleUdt.GetValue(con, pUdt, "QUALITY");
            Name = (string)OracleUdt.GetValue(con, pUdt, "NAME");
            Value = (string)OracleUdt.GetValue(con, pUdt, "VALUE");
            RecommendValue = (string)OracleUdt.GetValue(con, pUdt, "RECOMMENDVALUE");
            Descr = (string)OracleUdt.GetValue(con, pUdt, "DESCR");
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.R_REC_EBK")]
    public class AnalyticsFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new Analytics();
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.T_REC_EBK")]
    public class PersonArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new Analytics[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return null;
        }

    }

}


