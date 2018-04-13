using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
namespace BarsWeb.Areas.Escr.Infrastructure.OraTypeConverter
{
    /// <summary>
    /// Summary description for NumberList
    /// </summary>
    public class NumberList : IOracleCustomType, INullable
    {
        [OracleArrayMapping()]
        public decimal[] Value { get; set; }

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, 0, Value, null);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            object objectStatusArray;
            Value = (decimal[])OracleUdt.GetValue(con, pUdt, 0, out objectStatusArray);
            StatusArray = (OracleUdtStatus[])objectStatusArray;
        }

        public OracleUdtStatus[] StatusArray { get; set; }

        public bool IsNull { get; private set; }

        public static NumberList Null
        {
            get { return new NumberList() { IsNull = true }; }
        }

        public static implicit operator decimal[](NumberList numberList)
        {
            return numberList.Value;
        }

        public static implicit operator NumberList(decimal[] numberList)
        {
            return new NumberList() { Value = numberList };
        }
    }

    [OracleCustomTypeMapping("BARS.NUMBER_LIST")]
    public class UDTNumberListFactory : IOracleCustomTypeFactory, IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new decimal[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }

        public IOracleCustomType CreateObject()
        {
            return new NumberList();
        }
    }
}