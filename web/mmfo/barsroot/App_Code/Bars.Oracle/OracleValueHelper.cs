using System;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.Oracle
{
    // Just for information
    //  byte                => OracleDbType.Byte
    //  byte[]              => OracleDbType.Raw
    //  char                => OracleDbType.Varchar2
    //  char[]              => OracleDbType.Varchar2
    //  DateTime            => OracleDbType.TimeStamp
    //  short               => OracleDbType.Int16
    //  int                 => OracleDbType.Int32
    //  long                => OracleDbType.Int64
    //  float               => OracleDbType.Single
    //  double              => OracleDbType.Double
    //  Decimal             => OracleDbType.Decimal
    //  string              => OracleDbType.Varchar2
    //  TimeSpan            => OracleDbType.IntervalDS
    //  OracleBFile         => OracleDbType.BFile
    //  OracleBinary        => OracleDbType.Raw
    //  OracleBlob          => OracleDbType.Blob
    //  OracleClob          => OracleDbType.Clob
    //  OracleDate          => OracleDbType.Date
    //  OracleDecimal       => OracleDbType.Decimal
    //  OracleIntervalDS    => OracleDbType.IntervalDS
    //  OracleIntervalYM    => OracleDbType.IntervalYM
    //  OracleRefCursor     => OracleDbType.RefCursor
    //  OracleString        => OracleDbType.Varchar2
    //  OracleTimeStamp     => OracleDbType.TimeStamp
    //  OracleTimeStampLTZ  => OracleDbType.TimeStampLTZ
    //  OracleTimeStampTZ   => OracleDbType.TimeStampTZ
    //  OracleXmlType       => OracleDbType.XmlType
    //  OracleRef           => OracleDbType.Ref
    //  bool                => OracleDbType.Boolean

    public static class OracleValueHelper
    {
        public static Decimal? GetDecimalNullableValue(OracleDecimal _oracleDecimal)
        {
            return _oracleDecimal.IsNull ? null : (Decimal?)_oracleDecimal.Value;
        }

        public static Int32? GetInt32NullableValue(OracleDecimal _oracleDecimal)
        {
            return _oracleDecimal.IsNull ? null : (Int32?)_oracleDecimal.Value;
        }

        public static Int64? GetInt64NullabeValue(OracleDecimal _oracleDecimal)
        {
            return _oracleDecimal.IsNull ? null : (Int64?)_oracleDecimal.Value;
        }

        public static DateTime? GetDateTimeNullableValue(OracleDate _oracleDate)
        {
            return _oracleDate.IsNull ? null : (DateTime?)_oracleDate.Value;
        }

        public static DateTime? GetDateTimeNullableValue(OracleTimeStamp _oracleTimestamp)
        {
            return _oracleTimestamp.IsNull ? null : (DateTime?)_oracleTimestamp.Value;
        }

        public static DateTime? GetDateTimeNullableValue(OracleTimeStampLTZ _oracleTimestamp)
        {
            return _oracleTimestamp.IsNull ? null : (DateTime?)_oracleTimestamp.Value;
        }

        public static DateTime? GetDateTimeNullableValue(OracleTimeStampTZ _oracleTimestamp)
        {
            return _oracleTimestamp.IsNull ? null : (DateTime?)_oracleTimestamp.Value;
        }

        public static Decimal GetDecimal(OracleDecimal _oracleDecimal, Decimal _nullSubstitution = default(Decimal))
        {
            return _oracleDecimal.IsNull ? _nullSubstitution : _oracleDecimal.Value;
        }

        public static Int32 GetInt32(OracleDecimal _oracleDecimal, Int32 _nullSubstitution = default(Int32))
        {
            return _oracleDecimal.IsNull ? _nullSubstitution : (Int32)_oracleDecimal.Value;
        }

        public static Int64 GetInt64(OracleDecimal _oracleDecimal, Int64 _nullSubstitution = default(Int64))
        {
            return _oracleDecimal.IsNull ? _nullSubstitution : (Int64)_oracleDecimal.Value;
        }

        public static String GetString(OracleString _oracleString)
        {
            return _oracleString.IsNull ? null : _oracleString.Value;
        }

        public static String GetString(OracleClob _oracleClob)
        {
            return _oracleClob.IsNull ? null : _oracleClob.Value;
        }

        public static DateTime GetDateTime(OracleDate _oracleDate, DateTime _nullSubstitution = default(DateTime))
        {
            return _oracleDate.IsNull ? _nullSubstitution : _oracleDate.Value;
        }

        public static DateTime GetDateTime(OracleTimeStamp _oracleTimeStamp, DateTime _nullSubstitution = default(DateTime))
        {
            return _oracleTimeStamp.IsNull ? _nullSubstitution : _oracleTimeStamp.Value;
        }

        public static DateTime GetDateTime(OracleTimeStampLTZ _oracleDate, DateTime _nullSubstitution = default(DateTime))
        {
            return _oracleDate.IsNull ? _nullSubstitution : _oracleDate.Value;
        }

        public static DateTime GetDateTime(OracleTimeStampTZ _oracleDate, DateTime _nullSubstitution = default(DateTime))
        {
            return _oracleDate.IsNull ? _nullSubstitution : _oracleDate.Value;
        }

        public static Byte[] GetBytes(OracleBlob _oracleBlob)
        {
            return _oracleBlob.IsNull ? null : _oracleBlob.Value;
        }

        private static OracleParameter GetParameter(OracleCommand _command, string _parameterName)
        {
            OracleParameter parameter = _command.Parameters[_parameterName];
            if (parameter == null)
                throw new KeyNotFoundException(String.Format("Parameter with name '{0}' not found", _parameterName));

            return parameter;
        }

        public static T GetParameterValue<T>(OracleCommand _command, string _parameterName)
        {
            return (T)GetParameter(_command, _parameterName).Value;
        }

        public static Decimal? GetDecimalNullableValue(OracleCommand _command, string _parameterName)
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDecimal)
                return GetDecimalNullableValue((OracleDecimal)oracleParameter.Value);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(Decimal?)));
        }

        public static Int32? GetInt32NullableValue(OracleCommand _command, string _parameterName)
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDecimal)
                return GetInt32NullableValue((OracleDecimal)oracleParameter.Value);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(Int32?)));
        }

        public static Int64? GetInt64NullableValue(OracleCommand _command, string _parameterName)
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDecimal)
                return GetInt64NullabeValue((OracleDecimal)oracleParameter.Value);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(Int64?)));
        }

        public static DateTime? GetDateTimeNullableValue(OracleCommand _command, string _parameterName)
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDate)
                return GetDateTimeNullableValue((OracleDate)oracleParameter.Value);
            if (oracleParameter.Value is OracleTimeStamp)
                return GetDateTimeNullableValue((OracleTimeStamp)oracleParameter.Value);
            if (oracleParameter.Value is OracleTimeStampLTZ)
                return GetDateTimeNullableValue((OracleTimeStampLTZ)oracleParameter.Value);
            if (oracleParameter.Value is OracleTimeStampTZ)
                return GetDateTimeNullableValue((OracleTimeStampTZ)oracleParameter.Value);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(DateTime?)));
        }

        public static String GetString(OracleCommand _command, string _parameterName)
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleString)
                return GetString((OracleString)oracleParameter.Value);
            if (oracleParameter.Value is OracleClob)
                return GetString((OracleClob)oracleParameter.Value);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(String)));
        }

        public static Decimal GetDecimal(OracleCommand _command, string _parameterName, Decimal _nullSubstitution = default(Decimal))
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDecimal)
                return GetDecimal((OracleDecimal)oracleParameter.Value, _nullSubstitution);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(Decimal[])));
        }

        public static Int32 GetInt32(OracleCommand _command, string _parameterName, Int32 _nullSubstitution = default(Int32))
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDecimal)
                return GetInt32((OracleDecimal)oracleParameter.Value, _nullSubstitution);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(Int32[])));
        }

        public static Int64 GetInt64(OracleCommand _command, string _parameterName, Int64 _nullSubstitution = default(Int64))
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDecimal)
                return GetInt64((OracleDecimal)oracleParameter.Value, _nullSubstitution);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(Int64[])));
        }

        public static DateTime GetDateTime(OracleCommand _command, string _parameterName, DateTime _nullSubstitution = default(DateTime))
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleDate)
                return GetDateTime((OracleDate)oracleParameter.Value, _nullSubstitution);
            if (oracleParameter.Value is OracleTimeStamp)
                return GetDateTime((OracleTimeStamp)oracleParameter.Value, _nullSubstitution);
            if (oracleParameter.Value is OracleTimeStampLTZ)
                return GetDateTime((OracleTimeStampLTZ)oracleParameter.Value, _nullSubstitution);
            if (oracleParameter.Value is OracleTimeStampTZ)
                return GetDateTime((OracleTimeStampTZ)oracleParameter.Value, _nullSubstitution);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType()));
        }

        public static Byte[] GetBytes(OracleCommand _command, string _parameterName)
        {
            OracleParameter oracleParameter = GetParameter(_command, _parameterName);

            if (oracleParameter.Value is OracleBlob)
                return GetBytes((OracleBlob)oracleParameter.Value);

            throw new InvalidCastException(String.Format("Unable to convert parameter {0} from type {1} to {2}", _parameterName, oracleParameter.Value.GetType(), typeof(Byte[])));
        }
    }
}