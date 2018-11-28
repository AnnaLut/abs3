using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Bills.Infrastructure.OracleCustomTypes
{
    /// <summary>
    /// Классы для работы с пользовательскими типами Oracle
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public abstract class OracleNullableCustomType<T> : INullable
        where T : OracleNullableCustomType<T>, new()
    {
        public bool IsNull { get; protected set; }

        public static T Null
        {
            get { return new T() { IsNull = true }; }
        }
    }

    public class OracleCustomTypeFactory<T> : IOracleCustomTypeFactory
        where T : IOracleCustomType, new()
    {
        public IOracleCustomType CreateObject()
        {
            return new T();
        }
    }

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

        public static implicit operator T[] (OracleNestedTable<T, U> _data)
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

        public T?[] RawValue
        {
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
            get { return Value == null ? 0 : Value.Length; }
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

        public static implicit operator T?[] (OracleValueTypeNestedTable<T, U> _data)
        {
            return _data.RawValue;
        }

        public static implicit operator T[] (OracleValueTypeNestedTable<T, U> _data)
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

    public static class NullableTypeHelper
    {
        public static T[] EliminateNullValues<T>(T?[] _source)
            where T : struct
        {
            if (_source == null)
                return null;

            T[] destination = new T[_source.Length];

            int elementsCount = 0;

            foreach (T? item in _source)
            {
                if (item.HasValue)
                {
                    destination[elementsCount] = item.Value;
                    elementsCount++;
                }
            }

            Array.Resize<T>(ref destination, elementsCount);

            return destination;
        }

        public static T[] EliminateNullValues<T>(T[] _source)
            where T : class
        {
            if (_source == null)
                return null;

            T[] destination = new T[_source.Length];

            int elementsCount = 0;

            foreach (T item in _source)
            {
                if (item != null)
                {
                    destination[elementsCount] = item;
                    elementsCount++;
                }
            }

            Array.Resize<T>(ref destination, elementsCount);

            return destination;
        }

        public static T[] ReplaceNullValues<T>(T?[] _source, T _replacingValue) where T : struct
        {
            if (_source == null)
                return null;

            T[] destination = new T[_source.Length];

            for (int i = 0; i < _source.Length; i++)
            {
                destination[i] = _source[i] ?? _replacingValue;
            }

            return destination;
        }

        public static T[] ReplaceNullValues<T>(T[] _source, T _replacingValue) where T : class
        {
            if (_source == null)
                return null;

            T[] destination = new T[_source.Length];

            for (int i = 0; i < _source.Length; i++)
            {
                destination[i] = _source[i] ?? _replacingValue;
            }

            return destination;
        }

        public static T?[] ConvertToNullableArray<T>(T[] _source)
        where T : struct
        {
            T?[] value = new T?[_source.Length];
            for (int i = 0; i < _source.Length; i++)
            {
                value[i] = _source[i];
            }
            return value;
        }
    }

    [OracleCustomTypeMapping("BILLS.NUMBER_LIST")]
    public class NumberListFactory : OracleValueTypeNestedTableFactory<decimal, NumberList> { }

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
}