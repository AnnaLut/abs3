using Bars;
using Bars.Application;
using Bars.Classes;
using barsroot.core;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using Bars.WebServices.DataExchangeService;
using Oracle.DataAccess.Types;
using System.Xml.Serialization;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System.Text;
using System.IO;
using System.Xml;

namespace Bars.WebServices.CBD
{
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class CBDDataExchangeService : BarsWebService
    {
        # region Конструкторы
        public CBDDataExchangeService()
        {
        }
        # endregion

        # region Публичные свойства
        public WsHeader WsHeaderValue;
        # endregion

        # region Веб-методы
        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public ResultResponse ReciveData(string p_mfo, int p_id, string p_date, string p_clob)
        {
            var result = new ResultResponse { status = -999, message = "", StackTrace = "" };

            // авторизация пользователя по хедеру
            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "TECH_SW";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "35c0576c94cf1846eacb52a4f311b042ec37ef67";

            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, false);
                if (isAuthenticated)
                    LoginUser(userName);

                using (OracleConnection con = OraConnector.Handler.UserConnection)
                {
                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "bars.pkg_sw_compare.recive_data";

                        cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, p_mfo, ParameterDirection.Input);
                        cmd.Parameters.Add("p_id", OracleDbType.Int64, p_id, ParameterDirection.Input);
                        cmd.Parameters.Add("p_date", OracleDbType.Varchar2, p_date, ParameterDirection.Input);
                        cmd.Parameters.Add("p_clob", OracleDbType.Clob, p_clob, ParameterDirection.Input);
                        cmd.Parameters.Add("p_state", OracleDbType.Decimal, result.status, ParameterDirection.Output);
                        cmd.Parameters.Add("p_message", OracleDbType.Varchar2, 4000, result.message, ParameterDirection.Output);
                        cmd.ExecuteNonQuery();

                        result.status = ((OracleDecimal)cmd.Parameters["p_state"].Value).IsNull ? null : (decimal?)(OracleDecimal)cmd.Parameters["p_state"].Value;
                        result.message = Convert.ToString(cmd.Parameters["p_message"].Value);
                    }
                }
            }
            catch (System.Exception e)
            {
                result.message += e.Message;
                result.StackTrace += e.StackTrace;
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public ResultResponseFromRu RequestDataToRU(string UserName, string Password, string p_mfo, string p_date, string p_url)
        {
            var result = new ResultResponseFromRu { id = -999, clob = "", message = "" };

            try
            {
                RuDataExchangeService clientService = new RuDataExchangeService() { Url = p_url };
                result = clientService.ResponseData(p_date, p_mfo, UserName, Password);
            }
            catch (System.Exception ex)
            {
                result.clob = "null";
                result.message += ex.Message;
            }
            return result;
        }
        # endregion
    }
}

namespace Bars.WebServices.RU
{
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class RuDataExchangeService : BarsWebService
    {
        # region Конструкторы
        public RuDataExchangeService()
        {
        }
        #endregion

        #region Публичные свойства
        public WsHeader WsHeaderValue;
        # endregion

        # region Веб-методы
        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public ResultResponse SendData()
        {
            var result = new ResultResponse { status = -999, message = "", StackTrace = "" };
            string bodyText = "";

            try
            {
                using (var bodyStream = new StreamReader(this.Context.Request.InputStream))
                {
                    bodyStream.BaseStream.Seek(0, SeekOrigin.Begin);
                    bodyText = bodyStream.ReadToEnd();
                }

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(bodyText);

                int id = Convert.ToInt32(xmlDoc.GetElementsByTagName("p_id")[0].InnerText);
                string mfo = xmlDoc.GetElementsByTagName("p_mfo")[0].InnerText;
                //DateTime date = Convert.ToDateTime(xmlDoc.GetElementsByTagName("p_date")[0].InnerText);
                string date = xmlDoc.GetElementsByTagName("p_date")[0].InnerText;
                string clob = xmlDoc.GetElementsByTagName("buffer")[0].InnerText;
                string url = xmlDoc.GetElementsByTagName("p_url")[0].InnerText;

                CBDDataExchangeService clientCBDService = new CBDDataExchangeService() { Url = url };
                // uncomment after changes
                result = clientCBDService.ReciveData(mfo, id, date, clob);
            }
            catch (System.Exception ex)
            {
                result.message += ex.Message;
                result.StackTrace += ex.StackTrace;
            }
            return result;
        }

        /// <summary>
        /// Этот метод вызывает сервис на стороне ЦБД (CBDServie - To - RuServicee)
        /// Метод RU сервиса, в котором вызывается процедура response_data
        /// </summary>
        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public ResultResponseFromRu ResponseData(string p_date, string p_mfo, string user, string pass)
        {
            var result = new ResultResponseFromRu { id = -999, clob = "", message = "" };

            // авторизация пользователя по хедеру
            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : user;
            String password = WsHeaderValue != null ? WsHeaderValue.Password : pass;

            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, false);
                if (isAuthenticated) LoginUser(userName);

                using (OracleConnection con = OraConnector.Handler.UserConnection)
                {
                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "bars.pkg_sw_compare.response_data";

                        cmd.Parameters.Add("p_date", OracleDbType.Varchar2, p_date, ParameterDirection.Input);
                        cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, p_mfo, ParameterDirection.Input);
                        cmd.Parameters.Add("p_id", OracleDbType.Decimal, result.id, ParameterDirection.Output);
                        cmd.Parameters.Add("p_clob", OracleDbType.Clob, result.clob, ParameterDirection.Output);
                        cmd.Parameters.Add("p_message", OracleDbType.Varchar2, result.message, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        result.id = ((OracleDecimal)cmd.Parameters["p_id"].Value).IsNull ? -999 : (decimal?)(OracleDecimal)cmd.Parameters["p_id"].Value;
                        result.clob = ((OracleClob)cmd.Parameters["p_clob"].Value).IsNull ? "null" : Convert.ToString(((OracleClob)cmd.Parameters["p_clob"].Value).Value);
                        result.message = Convert.ToString(cmd.Parameters["p_message"].Value);
                    }
                }
            }
            catch (System.Exception e)
            {
                result.clob = "null";
                result.message += e.Message;
            }
            return result;
        }
        #endregion
    }
}