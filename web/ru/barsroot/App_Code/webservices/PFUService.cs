using System;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
using Bars.Application;
using barsroot.core;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.WebServices
{
    public class InitiateRequestResult
    {
        public int Rq_Id { get; set; }
        public string ErrorCode { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class RequestStateResult
    {
        public string RequestStateData { get; set; }
        public string ErrorCode { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class PFUResponse
    {
        //public 
    }

    /// <summary>
    /// Заглушка веб-сервісу для взаємодії з ПФУ по отриманню реєстрів пенсійних зарахувань
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PFUService : BarsWebService
    {
        public WsHeader WsHeaderValue;

        #region private methods

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
                    String.Format("PayService: авторизация. Хост {0}, пользователь {1}", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
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

        private void LoginUser()
        {

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";

            // авторизация пользователя по хедеру
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated)
                LoginUserInt(userName);
        }

        #endregion

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public InitiateRequestResult InitiateRequest(string RequestBody)
        {
            InitiateRequestResult response = new InitiateRequestResult();
            try
            {
                using (OracleConnection connection = new OracleConnection("Data Source=COBUMMFO_DEV;User Id=pfu;Password=pfu"))
                {
                    connection.Open();

                    OracleCommand command = new OracleCommand("PFU_PKG_TRANSP_CA.a_hlp_ree_apply", connection) {CommandType = CommandType.StoredProcedure};
                    OracleParameter resultParam = new OracleParameter("result", OracleDbType.XmlType) {Direction = ParameterDirection.ReturnValue};
                    command.Parameters.Add(resultParam);
                    command.ExecuteNonQuery();
                    if (resultParam.Value != null)
                    {
                        XmlDocument doc = new XmlDocument();
                        doc.LoadXml(((OracleXmlType)resultParam.Value).Value);

                        XmlNodeList nodes = doc.GetElementsByTagName("rq_id");
                        if (nodes.Count > 0)
                        {
                            response.Rq_Id = Int32.Parse(nodes[0].InnerText);
                        }
                    }

                    connection.Close();
                }
            }
            catch (System.Exception ex)
            {
                response.ErrorCode = "1";
                response.ErrorMessage = ex.Message + "\n" + ex.StackTrace;
            }
            return response;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public RequestStateResult GetRequestState(string RequestBody)
        {
            RequestStateResult response = new RequestStateResult();
            try
            {
                using (OracleConnection connection = new OracleConnection("Data Source=COBUMMFO_DEV;User Id=pfu;Password=pfu"))
                {
                    //connection.Open();

                    OracleCommand command = new OracleCommand("PFU_PKG_TRANSP_CA.a_hlp_ree_apply", connection) { CommandType = CommandType.StoredProcedure };
                    OracleParameter resultParam = new OracleParameter("result", OracleDbType.XmlType) { Direction = ParameterDirection.ReturnValue };
                    command.Parameters.Add(resultParam);
                    command.ExecuteNonQuery();
                    if (resultParam.Value != null)
                    {
                        response.RequestStateData = ((OracleXmlType)resultParam.Value).Value;
                    }

                    connection.Close();
                }
            }
            catch (System.Exception ex)
            {
                response.ErrorCode = "1";
                response.ErrorMessage = ex.Message + "\n" + ex.StackTrace;
            }
            return response;
        }
    }



}
