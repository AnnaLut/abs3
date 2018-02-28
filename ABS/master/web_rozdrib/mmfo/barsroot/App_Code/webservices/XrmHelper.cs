using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices
{
    public static class XrmHelper
    {
        public static DateTime? GmtToLocal(DateTime? dateTime)
        {
            if (dateTime.HasValue && dateTime != null)
            {
                TimeZoneInfo tz = TimeZoneInfo.Local;
                DateTime _dateTime = dateTime.Value;
                return TimeZoneInfo.ConvertTimeFromUtc(_dateTime, tz);
            }
            else { return null; }
        }
    }
    public static class OracleHelper
    {
        public static string GetString(OracleDataReader _reader, int _fieldId)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetString(_fieldId);
        }

        public static string GetIntString(OracleDataReader _reader, int _fieldId)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetInt32(_fieldId).ToString();
        }

        public static string GetDateTimeString(OracleDataReader _reader, int _fieldId, string _dateFormat)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetDateTime(_fieldId).ToString(_dateFormat);
        }

        public static string GetDecimalString(OracleDataReader _reader, int _fieldId, string _decimalFormat)
        {
            return _reader.IsDBNull(_fieldId) ? null : _reader.GetDecimal(_fieldId).ToString(_decimalFormat);
        }
        public static Decimal? GetDecimal(OracleDataReader _reader, int _fieldId)
        {
            return _reader.IsDBNull(_fieldId) ? null : (Decimal?)_reader.GetDecimal(_fieldId);
        }
        private static OracleParameter GetParameter(OracleCommand _command, string _parameterName)
        {
            OracleParameter parameter = _command.Parameters[_parameterName];
            if (parameter == null) throw new KeyNotFoundException(String.Format("Parameter with name '{0}' not found", _parameterName));
            return parameter;
        }

        public static string GetParameterString(OracleCommand _command, string _parameterName)
        {
            OracleString oracleString = (OracleString)GetParameter(_command, _parameterName).Value;
            return oracleString == null ? null : oracleString.Value;
        }

        public static int? GetParameterInt(OracleCommand _command, string _parameterName)
        {
            OracleDecimal oracleDecimal = (OracleDecimal)GetParameter(_command, _parameterName).Value;
            return oracleDecimal.IsNull ? null : (int?)oracleDecimal.Value;
        }

        public static decimal? GetParameterDecimal(OracleCommand _command, string _parameterName)
        {
            OracleDecimal oracleDecimal = (OracleDecimal)GetParameter(_command, _parameterName).Value;
            return oracleDecimal.IsNull ? null : (decimal?)oracleDecimal.Value;
        }
    }
}