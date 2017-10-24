using System;
using System.Xml.Serialization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class GroupQuality : INullable, IOracleCustomType
    {
        [OracleObjectMappingAttribute("QUALITY")]
        [XmlAttribute("quality")]
        public decimal Quality { get; set; }

        [OracleObjectMappingAttribute("NAME")]
        [XmlAttribute("name")]
        public string Name { get; set; }

        public bool IsNull
        {
            get
            {
                return (Quality == null && string.IsNullOrEmpty(Name));
            }
        }

        public void FromCustomObject(OracleConnection con, System.IntPtr pUdt)
        {
            if (Quality != null)
            {
                OracleUdt.SetValue(con, pUdt, "QUALITY", Quality);
            }

            if (Name != null)
            {
                OracleUdt.SetValue(con, pUdt, "NAME", Name);
            }
        }

        public void ToCustomObject(OracleConnection con, System.IntPtr pUdt)
        {
            Quality = (decimal)OracleUdt.GetValue(con, pUdt, "QUALITY");
            Name = (string)OracleUdt.GetValue(con, pUdt, "NAME");
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.R_REC_QLT_GRP")]
    public class QtGroupFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new GroupQuality();
        }
    }

    [OracleCustomTypeMappingAttribute("BARS.T_REC_QLT_GRP")]
    public class QtGroupArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new GroupQuality[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return null;
        }

    }
}