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
        // A private member indicating whether this object is null.
        private bool _objectIsNull;

        // The OracleObjectMapping attribute is required to map .NET custom type member to Oracle object attribute.
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
            get { return _objectIsNull; }
        }

        // Static null property is required to return a null UDT.
        public static DuplicatesV2 Null
        {
            get
            {
                var obj = new DuplicatesV2 { _objectIsNull = true };
                return obj;
            }
        }
    }

    // A custom type factory class is required to create an instance of a custom type representing an Oracle object type.
    // The custom type factory class must implement IOralceCustomTypeFactory class.
    // The OracleCustomTypeMapping attribute is required to indicate the Oracle UDT for this factory class.
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

    // A custom class mapping to an Oracle collection type.
    public class DuplicatesV2List : IOracleCustomType, INullable
    {
        // The OracleArrayMapping attribute is required to map .NET class member to Oracle collection type.
        [OracleArrayMapping()]
        public DuplicatesV2[] ObjDuplicatesV2s;

        // A private member indicating whether this object is null.
        private bool _objectIsNull;

        // Implementation of interface IOracleCustomType method FromCustomObject.
        // Set Oracle collection value from .NET custom type member with OracleArrayMapping attribute.
        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, 0, ObjDuplicatesV2s);
        }

        // Implementation of interface IOracleCustomType method ToCustomObject.
        // Set .NET custom type member with OracleArrayMapping attribute from Oracle collection value.
        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            ObjDuplicatesV2s = (DuplicatesV2[])OracleUdt.GetValue(con, pUdt, 0);
        }

        // A property of interface INullable. Indicate whether the custom type object is null.
        public bool IsNull
        {
            get { return _objectIsNull; }
        }

        // Static null property is required to return a null UDT.
        public static DuplicatesV2List Null
        {
            get
            {
                var obj = new DuplicatesV2List { _objectIsNull = true };
                return obj;
            }
        }
    }

    // A custom type factory class is required to crate an instance of a custom type representing an Oracle collection type.
    // The custom type factory class must implement IOralceCustomTypeFactory and IOracleArrayTypeFactory class.
    // The OracleCustomTypeMapping attribute is required to indicate the Oracle UDT for this factory class.
    [OracleCustomTypeMapping("BARS.T_SLAVE_CLIENT_EBK")]
    public class DuplicatesV2ListFactory : IOracleCustomTypeFactory, IOracleArrayTypeFactory
    {
        // Implementation of interface IOracleCustomTypeFactory method CreateObject.
        // Return a new .NET custom type object representing an Oracle UDT collection object.
        public IOracleCustomType CreateObject()
        {
            return new DuplicatesV2List();
        }

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