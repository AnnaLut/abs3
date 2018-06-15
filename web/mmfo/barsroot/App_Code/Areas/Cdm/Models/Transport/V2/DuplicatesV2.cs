using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Xml.Serialization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    // A custom class mapping to an Oracle user defined type.
    // Provided all required implementations by ODP.NET developer guide to represent the Oracle UDT as custom type.
    // The custom class must implement IOracleCustomType and INullable interfaces.
    // Note: Any Oracle UDT name must be uppercase.
    [DataContract]
    public class DuplicatesV2 : IOracleCustomType, INullable
    {
        // Код РУ (код МФО)
        [XmlAttribute("kf")]
        [DataMember(IsRequired = true)]
        [Required]
        [OracleObjectMapping("KF")]
        public string Kf { get; set; }


        // Реєстраційний номер
        [XmlAttribute("rnk")]
        [DataMember(IsRequired = true)]
        [Required]
        [OracleObjectMapping("RNK")]
        public long Rnk { get; set; }

        // Ідентифікатор майстер-запису
        [XmlAttribute("gcif")]
        [OracleObjectMapping("GCIF")]
        public string Gcif { get; set; }
        public bool ShouldSerializeGcif()
        {
            return !string.IsNullOrEmpty(Gcif);
        }

        // Ідентифікатор майстер-запису майстер-картки
        [XmlAttribute("masterGcif")]
        [OracleObjectMapping("MASTERGCIF")]
        public string MasterGcif { get; set; }
        public bool ShouldSerializeMasterGcif()
        {
            return !string.IsNullOrEmpty(MasterGcif);
        }

        // Implementation of interface IOracleCustomType method FromCustomObject.
        // Set Oracle object attribute values from .NET custom type object.
        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, "KF", Kf);
            OracleUdt.SetValue(con, pUdt, "RNK", Rnk);
            if (null != Gcif) OracleUdt.SetValue(con, pUdt, "GCIF", Gcif);
            if (null != MasterGcif) OracleUdt.SetValue(con, pUdt, "MASTERGCIF", MasterGcif);
        }

        // Implementation of interface IOracleCustomType method ToCustomObject.
        // Set .NET custom type object members from Oracle object attributes.
        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            Kf = (string)OracleUdt.GetValue(con, pUdt, "KF");
            Rnk = (long)OracleUdt.GetValue(con, pUdt, "RNK");
            Gcif = (string)OracleUdt.GetValue(con, pUdt, "GCIF");
            MasterGcif = (string)OracleUdt.GetValue(con, pUdt, "MASTERGCIF");
        }

        // A property of interface INullable. Indicate whether the custom type object is null.
        public bool IsNull
        {
            get { return string.IsNullOrWhiteSpace(Kf); }
        }
    }

    [OracleCustomTypeMapping("BARS.R_SLAVE_CLIENT_EBK")]
    public class DuplicatesV2Factory : IOracleCustomTypeFactory
    {
        // Implementation of interface IOracleCustomTypeFactory method CreateObject.
        // Return a new .NET custom type object representing an Oracle UDT object.
        public IOracleCustomType CreateObject()
        {
            return new DuplicatesV2();
        }
    }


    [OracleCustomTypeMapping("BARS.T_SLAVE_CLIENT_EBK")]
    public class DuplicatesV2ListFactory : IOracleArrayTypeFactory
    {
        // Implementation of interface IOracleArrayTypeFactory method CreateArray to return a new array.
        public Array CreateArray(int numElems)
        {
            return new DuplicatesV2[numElems];
        }

        // Implementation of interface IOracleArrayTypeFactory method CreateStatusArray to return a new OracleUdtStatus array.
        public Array CreateStatusArray(int numElems)
        {
            //return null;
            return new OracleUdtStatus[numElems];
        }
    }
}