using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;

namespace Bars.W4
{
    public class BarsOw : BbPackage
    {
        public BarsOw(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) { }
        public BarsOw(BbConnection Connection) : base(Connection, AutoCommit.Enabled) { }
        public void W4_SET_FILE_PAYSTATUS(String P_FILENAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2, P_FILENAME, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.W4_SET_FILE_PAYSTATUS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_OIC_FILE(String P_FILETYPE, String P_FILENAME, out Decimal? P_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILETYPE", OracleDbType.Varchar2, P_FILETYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2, P_FILENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.IMPORT_OIC_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ID = parameters[2].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
        }
        public void IMPORT_CNG_FILE(Decimal? P_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.IMPORT_CNG_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_OP_FILE(out Decimal? P_ERR)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ERR", OracleDbType.Decimal, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.IMPORT_OP_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ERR = parameters[0].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[0].Value).Value;
        }
        public void PAY_FILE(Decimal? P_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.PAY_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_PAY_FLAG(String P_FILETYPE, Decimal? P_FILEID, Decimal? P_FILEIDN, Decimal? P_REF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILETYPE", OracleDbType.Varchar2, P_FILETYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal, P_FILEID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILEIDN", OracleDbType.Decimal, P_FILEIDN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal, P_REF, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.SET_PAY_FLAG", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MATCHING_REF(Decimal? P_ID, Decimal? P_IDN, Decimal? P_REF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDN", OracleDbType.Decimal, P_IDN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal, P_REF, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.MATCHING_REF", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PAYMENT_REF(Decimal? P_REF, Decimal? P_DK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal, P_REF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DK", OracleDbType.Decimal, P_DK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.PAYMENT_REF", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DELETE_TRAN(Decimal? P_ID, Decimal? P_IDN)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDN", OracleDbType.Decimal, P_IDN, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.DELETE_TRAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PKKQUE(Decimal? P_REF, Decimal? P_DK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal, P_REF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DK", OracleDbType.Decimal, P_DK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.DEL_PKKQUE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CLIRING(Decimal? P_PAR)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PAR", OracleDbType.Decimal, P_PAR, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.CLIRING", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void FORM_IIC_FILE(out String P_FILENAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.FORM_IIC_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_FILENAME = parameters[0].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[0].Value).Value;
        }
        public void IMPORT_RIIC_FILE(String P_FILENAME, out Decimal? P_ID, out String P_ERR)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2, P_FILENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_ERR", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.IMPORT_RIIC_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ID = parameters[1].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[1].Value).Value;
            P_ERR = parameters[2].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[2].Value).Value;
        }
        public void UNFORM_IIC_DOC(String P_FILENAME, Decimal? P_REF, Decimal? P_DK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2, P_FILENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal, P_REF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DK", OracleDbType.Decimal, P_DK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.UNFORM_IIC_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CHECK_PKCUSTOMER(Decimal? P_PK_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PK_ND", OracleDbType.Decimal, P_PK_ND, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.CHECK_PKCUSTOMER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CHECK_SALARY_OPENCARD(Decimal? P_ID, String P_CARDCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CARDCODE", OracleDbType.Varchar2, P_CARDCODE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.CHECK_SALARY_OPENCARD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_SALARY_FLAGOPEN(Decimal? P_ID, Decimal? P_IDN, Decimal? P_FLAGOPEN)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDN", OracleDbType.Decimal, P_IDN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FLAGOPEN", OracleDbType.Decimal, P_FLAGOPEN, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.SET_SALARY_FLAGOPEN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_SALARY_ACCINSTANT ( Decimal? P_ID,  Decimal? P_IDN,  Decimal? P_ACCINSTANT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDN", OracleDbType.Decimal,P_IDN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACCINSTANT", OracleDbType.Decimal,P_ACCINSTANT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.SET_SALARY_ACCINSTANT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }		
        public void OPEN_CARD(Decimal? P_RNK, String P_CARDCODE, String P_BRANCH, String P_EMBFIRSTNAME, String P_EMBLASTNAME, String P_SECNAME, String P_WORK, String P_OFFICE, DateTime? P_WDATE, Decimal? P_SALARYPROECT, Decimal? P_TERM, out Decimal? P_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal, P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CARDCODE", OracleDbType.Varchar2, P_CARDCODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2, P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EMBFIRSTNAME", OracleDbType.Varchar2, P_EMBFIRSTNAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EMBLASTNAME", OracleDbType.Varchar2, P_EMBLASTNAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SECNAME", OracleDbType.Varchar2, P_SECNAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WORK", OracleDbType.Varchar2, P_WORK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OFFICE", OracleDbType.Varchar2, P_OFFICE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WDATE", OracleDbType.Date, P_WDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SALARYPROECT", OracleDbType.Decimal, P_SALARYPROECT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TERM", OracleDbType.Decimal, P_TERM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Decimal, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.OPEN_CARD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ND = parameters[11].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[11].Value).Value;
        }
        public void ADD_DEAL_TO_CMQUE(Decimal? P_ND, Decimal? P_OPERTYPE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Decimal, P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OPERTYPE", OracleDbType.Decimal, P_OPERTYPE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.ADD_DEAL_TO_CMQUE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_ACCOUNTS_RATE(Decimal? P_PAR)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PAR", OracleDbType.Decimal, P_PAR, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.SET_ACCOUNTS_RATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_SPARAM(String P_MODE, Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MODE", OracleDbType.Varchar2, P_MODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Decimal, P_ACC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.SET_SPARAM", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void FORM_REQUEST(Decimal? P_ID, Decimal? P_OPERTYPE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OPERTYPE", OracleDbType.Decimal, P_OPERTYPE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.FORM_REQUEST", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void W4_IMPORT_SALARY_FILE(String P_FILENAME, String P_FILEBODY, out Decimal? P_FILEID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2, P_FILENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILEBODY", OracleDbType.Clob, P_FILEBODY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.W4_IMPORT_SALARY_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_FILEID = parameters[2].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
        }
        public void W4_CREATE_SALARY_DEAL(Decimal? P_FILEID, Decimal? P_PROECT_ID, String P_CARD_CODE, String P_BRANCH, Decimal? P_ISP, out String P_TICKETNAME, out String P_TICKETBODY)
        {
            this.InitConnection();

            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal, P_FILEID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PROECT_ID", OracleDbType.Decimal, P_PROECT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CARD_CODE", OracleDbType.Varchar2, P_CARD_CODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2, P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ISP", OracleDbType.Decimal, P_ISP, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TICKETNAME", OracleDbType.Varchar2, 100, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TICKETBODY", OracleDbType.Clob, null, ParameterDirection.Output));

            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.W4_CREATE_SALARY_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);

            P_TICKETNAME = parameters[5].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[5].Value).Value;

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
        public void IMPORT_SALARY_FILE(String P_FILENAME, Decimal? P_USERID, out Decimal? P_FILEID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2, P_FILENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_USERID", OracleDbType.Decimal, P_USERID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.IMPORT_SALARY_FILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_FILEID = parameters[2].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
        }
        public void CREATE_SALARY_DEAL(Decimal? P_FILEID, Decimal? P_PROECT_ID, String P_CARD_CODE, String P_BRANCH, Decimal? P_ISP)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal, P_FILEID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PROECT_ID", OracleDbType.Decimal, P_PROECT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CARD_CODE", OracleDbType.Varchar2, P_CARD_CODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2, P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ISP", OracleDbType.Decimal, P_ISP, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.CREATE_SALARY_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void FORM_SALARY_TICKET(Decimal? P_FILEID, Decimal? P_USERID, out String P_TICKETNAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILEID", OracleDbType.Decimal, P_FILEID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_USERID", OracleDbType.Decimal, P_USERID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TICKETNAME", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.FORM_SALARY_TICKET", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_TICKETNAME = parameters[2].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[2].Value).Value;
        }
        public void PK_REOPEN_CARD(String P_CARDCODE, Decimal? P_SALARYPROECT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_CARDCODE", OracleDbType.Varchar2, P_CARDCODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SALARYPROECT", OracleDbType.Decimal, P_SALARYPROECT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.PK_REOPEN_CARD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PK_REPAY_CARD(Decimal? P_PK_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PK_ND", OracleDbType.Decimal, P_PK_ND, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.PK_REPAY_CARD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PK_CLOSE_CARD(Decimal? P_PK_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PK_ND", OracleDbType.Decimal, P_PK_ND, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.PK_CLOSE_CARD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_TRANSIT(Decimal? P_ACC, Decimal? P_DEFNULL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Decimal, P_ACC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEFNULL", OracleDbType.Decimal, P_DEFNULL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.GET_TRANSIT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_TRANSIT(Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Decimal, P_ACC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.GET_TRANSIT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String CHECK_OPENCARD(Decimal? P_RNK, String P_CARDCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal, P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CARDCODE", OracleDbType.Varchar2, P_CARDCODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.CHECK_OPENCARD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? FOUND_CLIENT(String P_OKPO, String P_PASPSER, String P_PASPNUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_OKPO", OracleDbType.Varchar2, P_OKPO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PASPSER", OracleDbType.Varchar2, P_PASPSER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PASPNUM", OracleDbType.Varchar2, P_PASPNUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_OW.FOUND_CLIENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}