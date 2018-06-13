using System;
using System.IO;
using System.Data;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using Bars.EAD;
using ibank.core;

/// <summary>
/// MakeFRX сервис формирования и записи договоров в формате фрх 
/// </summary>
namespace Bars.WebServices
{
    public class MakeFRX : BarsWebService
    {
        public WsHeader WsHeaderValue;

        private void AuthenticateUser(String userName, String password)
        {
            // авторизация пользователя по хедеру
            Boolean isAuthenticated = Bars.Application.CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated)
                LoginUserInt(userName, "MakeFRX");
        }

        public static void save_report(Int64? dpt_id, MemoryStream repstream, Int16 flags)
        {
            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd_saverep = con.CreateCommand())
            {
                cmd_saverep.Parameters.Clear();
                cmd_saverep.BindByName = true;
                cmd_saverep.CommandText = @"begin intg_wb.makeblob(:dpt_id, :report, :flags); end;";
                cmd_saverep.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                cmd_saverep.Parameters.Add("report", OracleDbType.Blob, repstream.ToArray(), ParameterDirection.Input);
                cmd_saverep.Parameters.Add("flags", OracleDbType.Decimal, flags, ParameterDirection.Input);
                cmd_saverep.ExecuteNonQuery();
            }
        }
        protected string getDocTemplate(Int16 type_id, Int64? dpt_id, String userName, String password)
        {
            AuthenticateUser(userName, password);
            string Template = String.Empty;

            using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleCommand cmd_findtemplate = con.CreateCommand())
            {
                if (type_id != 99)
                {
                    cmd_findtemplate.CommandText = "select dvc.id_fr id from bars.dpt_deposit d, bars.dpt_vidd_scheme dvc where d.deposit_id = :p_deposit_id and dvc.vidd = d.vidd and dvc.flags = :p_flags";
                    cmd_findtemplate.Parameters.Add("p_deposit_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                    cmd_findtemplate.Parameters.Add("p_flags", OracleDbType.Decimal, type_id, ParameterDirection.Input);

                    using (OracleDataReader rdr_findtemplate = cmd_findtemplate.ExecuteReader())
                    {
                        if (rdr_findtemplate.Read())
                        {
                            Template = Convert.ToString(rdr_findtemplate["id"]);
                        }
                        else
                        {
                            throw new System.Exception(String.Format("Не знайдено шаблон {0} у таблиці dpt_vidd_scheme.id_fr, або шаблон не описано як FastReport", Template));
                        }
                    }
                }
                else if (type_id != 99) Template = "DPT_FINMON_QUESTIONNAIRE";

                return Template;
            }
        }


        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public Decimal? MakeFRX_Blob(Int64? dpt_id, Int64? rnk, Int16 flags, String userName, String password)
        {
            FrxParameters pars = new FrxParameters();
            EadPack ep = new EadPack(new BbConnection());
            Int64? AgrID = dpt_id;
            Int64? AgrUID = null;
            Int64? RNK = rnk;
            String TemplateID;
            decimal? _DocId = null;

            try
            {
                TemplateID = getDocTemplate(flags, dpt_id, userName, password);
                if (_DocId != null) { pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(_DocId.Value.ToString()))); }
                if (rnk.HasValue) { pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, rnk)); }
                if (AgrID.HasValue) { pars.Add(new FrxParameter("p_agr_id", TypeCode.Int64, AgrID)); }
                if (AgrUID.HasValue) { pars.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int32, AgrUID)); }
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    using (var str = new MemoryStream())
                    {
                        FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateID)), pars, null);
                        doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                        save_report(Convert.ToInt64(dpt_id), str, flags);
                    }
                }
                return _DocId;
            }
            finally { DisposeOraConnection(); }
        }
    }
}

