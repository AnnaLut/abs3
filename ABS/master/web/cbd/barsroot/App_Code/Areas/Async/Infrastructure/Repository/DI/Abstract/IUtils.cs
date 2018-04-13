using System;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract
{
    public interface IUtils
    {
        OracleDbType TypeCodeToOracleDbType(TypeCode code);
        TypeCode ParamTypeCodeToTypeCode(string code);
        string TypeCodeToParamTypeCode(TypeCode code);
    }
}
