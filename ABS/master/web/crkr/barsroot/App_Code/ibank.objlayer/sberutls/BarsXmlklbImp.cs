using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace ibank.objlayer
{

    public class BarsXmlklbImp : BbPackage
    {
        public BarsXmlklbImp(BbConnection Connection) : base(Connection) {}
        public void MAKE_IMPORT ( String P_INDOC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_INDOC", OracleDbType.Clob,P_INDOC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.MAKE_IMPORT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_DOC_CNT ( String P_PACKNAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PACKNAME", OracleDbType.Varchar2,P_PACKNAME, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.IMPORT_DOC_CNT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_RESULTS ( String P_FILENAME,  DateTime? P_DAT, out Decimal? P_FILECNT, out Decimal? P_FILESUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FILENAME", OracleDbType.Varchar2,P_FILENAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DAT", OracleDbType.Date,P_DAT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FILECNT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_FILESUM", OracleDbType.Decimal,null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.IMPORT_RESULTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_FILECNT = parameters[2].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
            P_FILESUM = parameters[3].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[3].Value).Value;
        }
        public void VALIDATE_DOC ( Decimal? P_IMPREF, out String P_ERRCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ERRCODE", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.VALIDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ERRCODE = parameters[1].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[1].Value).Value;
        }
        public void PAY_DOC ( Decimal? P_IMPREF, out String P_ERRCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ERRCODE", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.PAY_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ERRCODE = parameters[1].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[1].Value).Value;
        }
        public void DELETE_DOC ( Decimal? P_IMPREF, out String P_ERRCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ERRCODE", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.DELETE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ERRCODE = parameters[1].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[1].Value).Value;
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB,  String P_NLSB,  String P_IDB,  String P_NAMB,  String P_NAZN,  Decimal? P_S,  Decimal? P_SK,  Decimal? P_KV)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSB", OracleDbType.Varchar2,P_NLSB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDB", OracleDbType.Varchar2,P_IDB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMB", OracleDbType.Varchar2,P_NAMB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2,P_NAZN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_S", OracleDbType.Decimal,P_S, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SK", OracleDbType.Decimal,P_SK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KV", OracleDbType.Decimal,P_KV, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB,  String P_NLSB,  String P_IDB,  String P_NAMB,  String P_NAZN,  Decimal? P_S,  Decimal? P_SK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSB", OracleDbType.Varchar2,P_NLSB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDB", OracleDbType.Varchar2,P_IDB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMB", OracleDbType.Varchar2,P_NAMB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2,P_NAZN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_S", OracleDbType.Decimal,P_S, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SK", OracleDbType.Decimal,P_SK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB,  String P_NLSB,  String P_IDB,  String P_NAMB,  String P_NAZN,  Decimal? P_S)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSB", OracleDbType.Varchar2,P_NLSB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDB", OracleDbType.Varchar2,P_IDB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMB", OracleDbType.Varchar2,P_NAMB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2,P_NAZN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_S", OracleDbType.Decimal,P_S, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB,  String P_NLSB,  String P_IDB,  String P_NAMB,  String P_NAZN)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSB", OracleDbType.Varchar2,P_NLSB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDB", OracleDbType.Varchar2,P_IDB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMB", OracleDbType.Varchar2,P_NAMB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2,P_NAZN, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB,  String P_NLSB,  String P_IDB,  String P_NAMB)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSB", OracleDbType.Varchar2,P_NLSB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDB", OracleDbType.Varchar2,P_IDB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMB", OracleDbType.Varchar2,P_NAMB, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB,  String P_NLSB,  String P_IDB)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSB", OracleDbType.Varchar2,P_NLSB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDB", OracleDbType.Varchar2,P_IDB, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB,  String P_NLSB)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSB", OracleDbType.Varchar2,P_NLSB, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA,  String P_MFOB)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOB", OracleDbType.Varchar2,P_MFOB, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA,  String P_NAMA)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAMA", OracleDbType.Varchar2,P_NAMA, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA,  String P_IDA)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IDA", OracleDbType.Varchar2,P_IDA, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA,  String P_NLSA)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DOC ( Decimal? P_IMPREF,  String P_MFOA)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IMPREF", OracleDbType.Decimal,P_IMPREF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFOA", OracleDbType.Varchar2,P_MFOA, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("BARS_XMLKLB_IMP.UPDATE_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
    }
}