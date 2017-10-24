using System;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Implementation
{
    public class Utils : IUtils
    {
        public OracleDbType TypeCodeToOracleDbType(TypeCode code)
        {
            switch (code)
            {
                case TypeCode.Char:
                case TypeCode.String:
                    return OracleDbType.Varchar2;
                case TypeCode.Decimal:
                case TypeCode.Double:
                case TypeCode.Int16:
                case TypeCode.Int32:
                case TypeCode.Int64:
                case TypeCode.UInt16:
                case TypeCode.UInt32:
                case TypeCode.UInt64:
                case TypeCode.Boolean:
                    return OracleDbType.Decimal;
                case TypeCode.DateTime:
                    return OracleDbType.Date;
                default:
                    return OracleDbType.Varchar2;
            }
        }

        public TypeCode ParamTypeCodeToTypeCode(string code)
        {
            code = code.Trim().ToUpper();
            switch (code)
            {
                case "DATE":
                    return TypeCode.DateTime;
                case "NUMBER":
                    return TypeCode.Decimal;
                case "VARCHAR2":
                    return TypeCode.String;
                default:
                    return TypeCode.String;
            }
        }

        public string TypeCodeToParamTypeCode(TypeCode code)
        {
            switch (code)
            {
                case TypeCode.DateTime:
                    return "DATE";
                case TypeCode.Decimal:
                    return "NUMBER";
                case TypeCode.String:
                    return "VARCHAR2";
                default:
                    return "VARCHAR2";
            }
        }
    }
}