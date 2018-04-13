using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Oracle;
namespace credit
{

    public class WcsSync : BbPackage
    {
        public WcsSync(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public WcsSync(BbConnection Connection) : base(Connection, AutoCommit.Enabled) { }
        public void CREATE_SYNC_CABID(Decimal? BID_ID_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal, BID_ID_, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_SYNC.CREATE_SYNC_CABID", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
    }
}