using System; 
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections.Generic;

namespace Bars.Oracle
{
    public abstract class OracleNestedTable<T, U> : OracleNullableCustomType<U>, IOracleCustomType
        where T : class
        where U : OracleNestedTable<T, U>, new()
    {
        [OracleArrayMapping]
        public T[] Value { get; set; }

        public OracleUdtStatus[] StatusArray { get; set; }

        public int Length
        {
            get
            {
                return Value == null ? 0 : Value.Length;
            }
        }

        public void FromCustomObject(OracleConnection _connection, IntPtr _udtPointer)
        {
            OracleUdt.SetValue(_connection, _udtPointer, 0, Value, null);
        }

        public void ToCustomObject(OracleConnection _connection, IntPtr _udtPointer)
        {
            object objectStatusArray;
            Value = (T[])OracleUdt.GetValue(_connection, _udtPointer, 0, out objectStatusArray);
            StatusArray = (OracleUdtStatus[])objectStatusArray;
        }

        public static U FromObject(object _data)
        {
            if (_data is OracleNestedTable<T, U>)
                return (U)_data;

            if (_data is T[])
                return (U)(T[])_data;

            if (_data is List<T>)
                return (U)(List<T>)_data;

            throw new InvalidCastException();
        }

        public static implicit operator T[](OracleNestedTable<T, U> _data)
        {
            return _data.Value;
        }

        public static implicit operator List<T>(OracleNestedTable<T, U> _data)
        {
            return new List<T>(_data.Value);
        }

        public static explicit operator OracleNestedTable<T, U>(T[] _data)
        {
            return new U() { Value = _data };
        }

        public static explicit operator OracleNestedTable<T, U>(List<T> _data)
        {
            T[] data = new T[_data.Count];
            _data.CopyTo(data);
            return new U() { Value = data };
        }
    }

    public abstract class OracleValueTypeNestedTable<T, U> : OracleNullableCustomType<U>, IOracleCustomType
        where T : struct
        where U : OracleValueTypeNestedTable<T, U>, new()
    {
        [OracleArrayMapping]
        private T?[] rawValue;
        private T[] value;

        public T?[] RawValue {
            get { return rawValue; }
            set
            {
                rawValue = value;
                this.value = null;
            }
        }

        public T[] Value
        {
            get
            {
                if (value == null)
                    value = NullableTypeHelper.EliminateNullValues<T>(rawValue);

                return value;
            }
            set
            {
                rawValue = NullableTypeHelper.ConvertToNullableArray<T>(value);
                this.value = value;
            }
        }

        public OracleUdtStatus[] StatusArray { get; set; }

        public int Length
        {
            get { return Value == null ? 0 : Value.Length;  }
        }

        public int RawLength
        {
            get { return RawValue == null ? 0 : RawValue.Length; }
        }

        public void FromCustomObject(OracleConnection _connection, IntPtr _udtPointer)
        {
            OracleUdt.SetValue(_connection, _udtPointer, 0, RawValue, null);
        }

        public void ToCustomObject(OracleConnection _connection, IntPtr _udtPointer)
        {
            object objectStatusArray;
            RawValue = (T?[])OracleUdt.GetValue(_connection, _udtPointer, 0, out objectStatusArray);
            StatusArray = (OracleUdtStatus[])objectStatusArray;
        }

        public static U FromObject(object _data)
        {
            if (_data is OracleValueTypeNestedTable<T, U>)
                return (U)_data;

            if (_data is T[])
                return (U)(T[])_data;

            if (_data is T?[])
                return (U)(T?[])_data;

            if (_data is List<T>)
                return (U)(List<T>)_data;

            if (_data is List<T?>)
                return (U)(List<T?>)_data;

            throw new InvalidCastException();
        }

        public static implicit operator T?[](OracleValueTypeNestedTable<T, U> _data)
        {
            return _data.RawValue;
        }

        public static implicit operator T[](OracleValueTypeNestedTable<T, U> _data)
        {
            return _data.Value;
        }

        public static implicit operator List<T>(OracleValueTypeNestedTable<T, U> _data)
        {
            return new List<T>(_data.Value);
        }

        public static implicit operator List<T?>(OracleValueTypeNestedTable<T, U> _data)
        {
            return new List<T?>(_data.RawValue);
        }

        public static explicit operator OracleValueTypeNestedTable<T, U>(T[] _data)
        {
            return new U() { Value = _data };
        }

        public static explicit operator OracleValueTypeNestedTable<T, U>(T?[] _data)
        {
            return new U() { RawValue = _data };
        }

        public static explicit operator OracleValueTypeNestedTable<T, U>(List<T> _data)
        {
            T[] data = new T[_data.Count];
            _data.CopyTo(data);
            return new U() { Value = data };
        }

        public static explicit operator OracleValueTypeNestedTable<T, U>(List<T?> _data)
        {
            T?[] data = new T?[_data.Count];
            _data.CopyTo(data);
            return new U() { RawValue = data };
        }
    }

    public class NumberList : OracleValueTypeNestedTable<decimal, NumberList>
    {
        public decimal[] ReplaceNullValues(decimal _replacingValue)
        {
            return NullableTypeHelper.ReplaceNullValues(RawValue, _replacingValue);
        }
    }

    public class StringList : OracleNestedTable<string, StringList> { }

    public class DateList : OracleValueTypeNestedTable<DateTime, DateList>
    {
        public DateTime[] ReplaceNullValues(DateTime _replacingValue)
        {
            return NullableTypeHelper.ReplaceNullValues(RawValue, _replacingValue);
        }
    }

    public class BlobList : OracleNestedTable<byte[], BlobList> { }

    public class OraDictionaryItem : OracleNullableCustomType<OraDictionaryItem>, IOracleCustomType
    {
        [OracleObjectMappingAttribute("KEY")]
        public string Key { get; set; }

        [OracleObjectMappingAttribute("VALUE")]
        public string Value { get; set; }

        public virtual void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, "KEY", this.Key);
            OracleUdt.SetValue(con, pUdt, "VALUE", this.Value);
        }

        public virtual void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            Key = (string)OracleUdt.GetValue(con, pUdt, "KEY");
            Value = (string)OracleUdt.GetValue(con, pUdt, "VALUE");
        }
    }

    public class OraDictionary : OracleNestedTable<OraDictionaryItem, OraDictionary>
    {
        public OraDictionaryItem[] EliminateNullValues()
        {
            return NullableTypeHelper.EliminateNullValues(Value);
        }

        public OraDictionaryItem[] ReplaceNullValues(OraDictionaryItem _replacingValue)
        {
            return NullableTypeHelper.ReplaceNullValues(Value, _replacingValue);
        }
    }

    public class OracleNestedTableFactory<T, U> : IOracleArrayTypeFactory, IOracleCustomTypeFactory
        where T : class
        where U : OracleNestedTable<T, U>, new()
    {
        public Array CreateArray(int _elementsCount)
        {
            return new T[_elementsCount];
        }

        public Array CreateStatusArray(int _elementsCount)
        {
            return new OracleUdtStatus[_elementsCount];
        }

        public IOracleCustomType CreateObject()
        {
            return new U();
        }
    }

    public class OracleValueTypeNestedTableFactory<T, U> : IOracleArrayTypeFactory, IOracleCustomTypeFactory
        where T : struct
        where U : OracleValueTypeNestedTable<T, U>, new()
    {
        public Array CreateArray(int _elementsCount)
        {
            return new T?[_elementsCount];
        }

        public Array CreateStatusArray(int _elementsCount)
        {
            return new OracleUdtStatus[_elementsCount];
        }

        public IOracleCustomType CreateObject()
        {
            return new U();
        }
    }

    [OracleCustomTypeMapping("BARS.NUMBER_LIST")]
    public class NumberListFactory : OracleValueTypeNestedTableFactory<decimal, NumberList> { }

    [OracleCustomTypeMapping("BARS.STRING_LIST")]
    public class StringListFactory : OracleNestedTableFactory<string, StringList> { }

    [OracleCustomTypeMapping("BARS.VARCHAR2_LIST")]
    public class Varchar2ListFactory : OracleNestedTableFactory<string, StringList> { }

    [OracleCustomTypeMapping("BARS.CLOB_LIST")]
    public class ClobListFactory : OracleNestedTableFactory<string, StringList> { }

    [OracleCustomTypeMapping("BARS.DATE_LIST")]
    public class DateListFactory : OracleValueTypeNestedTableFactory<DateTime, DateList> { }

    [OracleCustomTypeMapping("BARS.BLOB_LIST")]
    public class BlobListFactory : OracleNestedTableFactory<byte[], BlobList> { }

    [OracleCustomTypeMapping("BARS.T_DICTIONARY")]
    public class OraDictionaryFactory : OracleNestedTableFactory<OraDictionaryItem, OraDictionary> { }

    [OracleCustomTypeMapping("BARS.T_DICTIONARY_ITEM")]
    public class OraDictionaryItemFactory : OracleCustomTypeFactory<OraDictionaryItem> { }
}