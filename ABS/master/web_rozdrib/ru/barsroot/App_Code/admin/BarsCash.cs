using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace ibank.objlayer
{

    public class BarsCash : BbPackage
    {
        public BarsCash(BbConnection Connection) : base(Connection) {}
        public void OPEN_CASH ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("BARS_CASH.OPEN_CASH", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_CASH.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_CASH.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? CURRENT_SHIFT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_CASH.CURRENT_SHIFT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? NEXT_SHIFT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_CASH.NEXT_SHIFT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public DateTime? NEXT_SHIFT_DATE ( Decimal? P_CURRSHIFT,  DateTime? P_OPDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_CURRSHIFT", OracleDbType.Decimal,P_CURRSHIFT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OPDATE", OracleDbType.Date,P_OPDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Date, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_CASH.NEXT_SHIFT_DATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDate res = (OracleDate)ReturnValue;
            return res.IsNull ? (DateTime?)null : res.Value;
        }
        public DateTime? CURRENT_OPDATE ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Date, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_CASH.CURRENT_OPDATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDate res = (OracleDate)ReturnValue;
            return res.IsNull ? (DateTime?)null : res.Value;
        }
    }
}