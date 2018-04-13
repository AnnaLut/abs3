using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace Bars.W4
{

    public class BarsOwesk : BbPackage
    {
        public BarsOwesk(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public BarsOwesk(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void W4_IMPORT_ESK_FILE ( String P_FILENAME,  String P_FILEBODY, out Decimal? P_FILEID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2,P_FILENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILEBODY", OracleDbType.Clob,P_FILEBODY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal,null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OWESK.W4_IMPORT_ESK_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_FILEID = parameters[2].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
        }
        public void W4_CREATE_ESK_DEAL ( Decimal? P_FILEID,  Decimal? P_PROECT_ID,  String P_CARD_CODE,  String P_BRANCH,  Decimal? P_ISP, out String P_TICKETNAME, out String P_TICKETBODY)
        {
            this.InitConnection();

            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal,P_FILEID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PROECT_ID", OracleDbType.Decimal,P_PROECT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CARD_CODE", OracleDbType.Varchar2,P_CARD_CODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ISP", OracleDbType.Decimal,P_ISP, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TICKETNAME", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TICKETBODY", OracleDbType.Clob,null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OWESK.W4_CREATE_ESK_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_TICKETNAME = parameters[5].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[5].Value).Value;
            //P_TICKETBODY = parameters[6].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleClob)parameters[6].Value).Value;
            if (parameters[6].Status == OracleParameterStatus.NullFetched)
            {
                P_TICKETBODY = String.Empty;
            }
            else
            {
                OracleClob TicketBodyClob = (OracleClob)parameters[6].Value;
                P_TICKETBODY = TicketBodyClob.Value;

                TicketBodyClob.Close();
                TicketBodyClob.Dispose();
            }

            this.CloseConnection();
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OWESK.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OWESK.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
    }
}