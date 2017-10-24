using System;

namespace Bars.Oracle
{
    public static class NullableTypeHelper
    {
        public static T[] EliminateNullValues<T> (T?[] _source)
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
}