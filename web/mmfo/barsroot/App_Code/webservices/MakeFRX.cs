using System;
using System.IO;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;
using Bars.EAD;
using ibank.core;
using Bars.Application;
using barsroot.core;



/// <summary>
/// MakeFRX сервис формирования и записи договоров в формате фрх 
/// </summary>
/// 
namespace Bars.WebServices
{
    public class MakeFRX : BarsWebService
    {

        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;
        private void LoginUserInt(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");

                ClearParameters();
                SetParameters("p_info", DB_TYPE.Varchar2,
                    String.Format("makeFRX: авторизация. Хост {0}, пользователь {1}", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
                    DIRECTION.Input);
                SQL_PROCEDURE("bars_audit.info");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }

        private void LoginUser(String userName, String password)
        {
            // авторизация пользователя по хедеру
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated)
                LoginUserInt(userName);
        }
        public static void save_report(Int64? dpt_id, MemoryStream repstream, Int16 flags)
        {
            using(OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
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
            LoginUser(userName, password);
            string Template = String.Empty;
            using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                if (type_id != 99)
                {

                    using (OracleCommand cmd_findtemplate = con.CreateCommand())
                    {
                        cmd_findtemplate.CommandText =
                            "select dvc.id_fr id from bars.dpt_deposit d, bars.dpt_vidd_scheme dvc where d.deposit_id = :p_deposit_id and dvc.vidd = d.vidd and dvc.flags = :p_flags";
                        cmd_findtemplate.Parameters.Add("p_deposit_id", OracleDbType.Decimal, dpt_id,
                            ParameterDirection.Input);
                        cmd_findtemplate.Parameters.Add("p_flags", OracleDbType.Decimal, type_id,
                            ParameterDirection.Input);

                        using (OracleDataReader rdr_findtemplate = cmd_findtemplate.ExecuteReader())
                        {
                            if (rdr_findtemplate.Read())
                            {
                                Template = Convert.ToString(rdr_findtemplate["id"]);
                            }
                            else
                            {
                                throw new System.Exception(String.Format(
                                    "Не знайдено шаблон {0} у таблиці dpt_vidd_scheme.id_fr, або шаблон не описано як FastReport",
                                    Template));
                            }
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
                if (_DocId != null){pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(_DocId.Value.ToString())));}
                if (rnk.HasValue){pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, rnk));}
                if (AgrID.HasValue){pars.Add(new FrxParameter("p_agr_id", TypeCode.Int64, AgrID));}
                if (AgrUID.HasValue){pars.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int32, AgrUID));}
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
    
    