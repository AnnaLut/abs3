using System;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Crkr.Infrastructure.OraTypeConverter
{
    /// <summary>
    /// StringList type convertor
    /// </summary>
    public class StringList : IOracleCustomType, INullable
    {
        [OracleArrayMapping()]
        public string[] Value { get; set; }

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, 0, Value, null);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            object objectStatusArray;
            Value = (string[])OracleUdt.GetValue(con, pUdt, 0, out objectStatusArray);
            StatusArray = (OracleUdtStatus[])objectStatusArray;
        }

        public OracleUdtStatus[] StatusArray { get; set; }

        public bool IsNull { get; private set; }

        public static StringList Null
        {
            get { return new StringList() { IsNull = true }; }
        }

        public static implicit operator string[](StringList stringList)
        {
            return stringList.Value;
        }

        public static implicit operator StringList(string[] stringList)
        {
            return new StringList() { Value = stringList };
        }
    }

    [OracleCustomTypeMapping("BARS.STRING_LIST")]
    public class UDTStringListFactory : IOracleCustomTypeFactory, IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new string[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems]; ;
        }

        public IOracleCustomType CreateObject()
        {
            return new StringList();
        }
    }
}