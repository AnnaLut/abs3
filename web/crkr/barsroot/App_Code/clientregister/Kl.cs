using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace clientregister
{
    public class Kl : BbPackage
    {
        public Kl(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) { }
        public Kl(BbConnection Connection) : base(Connection, AutoCommit.Enabled) { }
        public void SETCUSTOMEREXTERN(ref Decimal? P_ID, String P_NAME, Decimal? P_DOCTYPE, String P_DOCSERIAL, String P_DOCNUMBER, DateTime? P_DOCDATE, String P_DOCISSUER, DateTime? P_BIRTHDAY, String P_BIRTHPLACE, String P_SEX, String P_ADR, String P_TEL, String P_EMAIL, Decimal? P_CUSTTYPE, String P_OKPO, Decimal? P_COUNTRY, String P_REGION, String P_FS, String P_VED, String P_SED, String P_ISE, String P_NOTES)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.InputOutput));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2, P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCTYPE", OracleDbType.Decimal, P_DOCTYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCSERIAL", OracleDbType.Varchar2, P_DOCSERIAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCNUMBER", OracleDbType.Varchar2, P_DOCNUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCDATE", OracleDbType.Date, P_DOCDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCISSUER", OracleDbType.Varchar2, P_DOCISSUER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BIRTHDAY", OracleDbType.Date, P_BIRTHDAY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BIRTHPLACE", OracleDbType.Varchar2, P_BIRTHPLACE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SEX", OracleDbType.Varchar2, P_SEX, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ADR", OracleDbType.Varchar2, P_ADR, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEL", OracleDbType.Varchar2, P_TEL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EMAIL", OracleDbType.Varchar2, P_EMAIL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CUSTTYPE", OracleDbType.Decimal, P_CUSTTYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OKPO", OracleDbType.Varchar2, P_OKPO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COUNTRY", OracleDbType.Decimal, P_COUNTRY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REGION", OracleDbType.Varchar2, P_REGION, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FS", OracleDbType.Varchar2, P_FS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VED", OracleDbType.Varchar2, P_VED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SED", OracleDbType.Varchar2, P_SED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ISE", OracleDbType.Varchar2, P_ISE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NOTES", OracleDbType.Varchar2, P_NOTES, ParameterDirection.Input));

            object ReturnValue = null;
            ExecuteNonQuery("kl.setCustomerExtern", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ID = parameters[0].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[0].Value).Value;
        }
        public void SETCUSTOMERREL(Decimal? P_RNK, Decimal? P_RELID, Decimal? P_RELRNK, Decimal? P_RELINTEXT, Decimal? P_VAGA1, Decimal? P_VAGA2, Decimal? P_TYPEID, String P_POSITION, String P_FIRSTNAME, String P_MIDDLENAME, String P_LASTNAME, Decimal? P_DOCUMENTTYPEID, String P_DOCUMENT, String P_TRUSTREGNUM, DateTime? P_TRUSTREGDAT, DateTime? P_BDATE, DateTime? P_EDATE, String P_NOTARYNAME, String P_NOTARYREGION, Decimal? P_SIGNPRIVS, Decimal? P_SIGNID, String P_NAMER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal, P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RELID", OracleDbType.Decimal, P_RELID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RELRNK", OracleDbType.Decimal, P_RELRNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RELINTEXT", OracleDbType.Decimal, P_RELINTEXT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAGA1", OracleDbType.Decimal, P_VAGA1, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAGA2", OracleDbType.Decimal, P_VAGA2, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPEID", OracleDbType.Decimal, P_TYPEID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_POSITION", OracleDbType.Varchar2, P_POSITION, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FIRSTNAME", OracleDbType.Varchar2, P_FIRSTNAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIDDLENAME", OracleDbType.Varchar2, P_MIDDLENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_LASTNAME", OracleDbType.Varchar2, P_LASTNAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCUMENTTYPEID", OracleDbType.Decimal, P_DOCUMENTTYPEID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DOCUMENT", OracleDbType.Varchar2, P_DOCUMENT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TRUSTREGNUM", OracleDbType.Varchar2, P_TRUSTREGNUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TRUSTREGDAT", OracleDbType.Date, P_TRUSTREGDAT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BDATE", OracleDbType.Date, P_BDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EDATE", OracleDbType.Date, P_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NOTARYNAME", OracleDbType.Varchar2, P_NOTARYNAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NOTARYREGION", OracleDbType.Varchar2, P_NOTARYREGION, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SIGNPRIVS", OracleDbType.Decimal, P_SIGNPRIVS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SIGNID", OracleDbType.Decimal, P_SIGNID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMER", OracleDbType.Varchar2, P_NAMER, ParameterDirection.Input));

            object ReturnValue = null;
            ExecuteNonQuery("kl.setCustomerRel", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SETCUSTOMERELEMENT(Decimal? P_RNK, String P_TAG, String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("Rnk_", OracleDbType.Decimal, P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("Tag_", OracleDbType.Varchar2, P_TAG, ParameterDirection.Input));
            parameters.Add(new OracleParameter("Val_", OracleDbType.Varchar2, P_VAL, ParameterDirection.Input));

            object ReturnValue = null;
            ExecuteNonQuery("begin kl.setCustomerElement(:Rnk_, :Tag_, :Val_, user_id); end; ", parameters.ToArray(), CommandType.Text, out ReturnValue);
        }
        public void DELCUSTOMERREL(Decimal? P_RNK, Decimal? P_RELID, Decimal? P_RELRNK, Decimal? P_RELINTEXT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal, P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RELID", OracleDbType.Decimal, P_RELID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RELRNK", OracleDbType.Decimal, P_RELRNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RELINTEXT", OracleDbType.Decimal, P_RELINTEXT, ParameterDirection.Input));

            object ReturnValue = null;
            ExecuteNonQuery("kl.delCustomerRel", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
    }
}