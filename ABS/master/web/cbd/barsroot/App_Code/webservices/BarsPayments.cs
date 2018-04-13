using System;
using Bars.Classes;
using System.Collections;
using Bars.Exception;
using Bars.Configuration;
using System.IO;
using barsroot.core;
using System.Web;
using System.Security;
using System.Data;
using Bars.Application;
using System.Web.Services;
using System.Xml;
using System.Xml.Schema;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.WebServices
{
    /// <summary>
    /// Сервисы для обработки запросов из внешних задач
    /// </summary>

    [WebService(Namespace = "http://bars.webservices/BarsPayments")]
    public class BarsPayments : WebService
    {
        public BarsPayments()
        {
        }

        // Validation Error Count
        static int ErrorsCount = 0;

        // Validation Error Message
        static string ErrorMessage = "";

        public static void ValidationHandler(object sender,
                                             ValidationEventArgs args)
        {
            ErrorMessage = ErrorMessage + args.Message + "\r\n";
            ErrorsCount++;
        }


        [WebMethod(EnableSession = true)]
        public XmlDocument ImportXml(string login, string xmlData, bool debug)
        {
            XmlDocument xmlResult = new XmlDocument();
            XmlText errorText = null;
            // Declaration
            XmlDeclaration xmlDeclaration = xmlResult.CreateXmlDeclaration("1.0", "utf-8", null);
            // Create the root element
            XmlElement element = xmlResult.CreateElement("BarsPaymentsResult");
            xmlResult.InsertBefore(xmlDeclaration, xmlResult.DocumentElement);
            xmlResult.AppendChild(element);

            XmlNode node = xmlResult.CreateNode(XmlNodeType.Attribute, "Login", "");
            node.Value = login;
            element.Attributes.SetNamedItem(node);

            node = xmlResult.CreateNode(XmlNodeType.Attribute, "Date", "");
            node.Value = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
            element.Attributes.SetNamedItem(node);

            XmlNode nodeStatus = xmlResult.CreateNode(XmlNodeType.Attribute, "Status", "");
            try
            {
                string packName = string.Empty;
                // Валидация xml данных
                if (true)
                {
                    string xsdFile = Server.MapPath("~/App_Data/BarsPayment_Import.xsd");
                    if (!File.Exists(xsdFile))
                        throw new BarsException("Не знайдено файлу схеми " + xsdFile);

                    XmlDocument doc = new XmlDocument();
                    doc.LoadXml(xmlData);

                    XmlNodeReader nodeReader = new XmlNodeReader(doc);
                    XmlReaderSettings settings = new XmlReaderSettings();
                    settings.ValidationType = ValidationType.Schema;

                    settings.Schemas.Add("http://www.unity-bars.com.ua/iBank", xsdFile);
                    settings.ValidationEventHandler += new ValidationEventHandler(ValidationHandler);

                    using (XmlReader reader = XmlReader.Create(nodeReader, settings))
                    {
                        while (reader.Read()) ;
                        reader.Close();
                    }

                    if (ErrorsCount > 0)
                    {
                        throw new BarsException(ErrorMessage);
                    }
                }

                // login
                // Обновляем информацию об пользователе
                UserMap userMap = ConfigurationSettings.RefreshUserInfo(login);
                if (ConfigurationSettings.UserMapSettings[login] == null)
                    throw new BarsException("Користувача з іменем " + login + " не знайдено. Зверніться до адміністратора.");

                CustomIdentity userIdentity = new CustomIdentity(login, 1, true, false, login, "", "");
                CustomPrincipal principal = new CustomPrincipal(userIdentity, new ArrayList());
                Context.User = principal;
                Session["userIdentity"] = userIdentity;
                string outResult = string.Empty;

                // connect
                OracleConnection con = OraConnector.Handler.UserConnection;
                try
                {
                    OracleCommand cmd = con.CreateCommand();
                    cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
                    cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, HttpContext.Current.Request.UserHostAddress, ParameterDirection.Input);
                    cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "bars.bars_login.login_user";

                    cmd.ExecuteNonQuery();
                    Session["UserLoggedIn"] = true;


                    cmd.Parameters.Clear();
                    cmd.CommandText = "bars_xmlklb_imp.make_import";
                    cmd.Parameters.Add("p_indoc", OracleDbType.Clob, xmlData, ParameterDirection.Input);
                    cmd.Parameters.Add("p_packname", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                    cmd.Parameters.Add("p_outdoc", OracleDbType.Clob, "" , ParameterDirection.InputOutput);

                    cmd.ExecuteNonQuery();

                    OracleClob clob = (OracleClob)cmd.Parameters["p_outdoc"].Value;

                    if (!clob.IsNull)
                        outResult = clob.Value;

                    packName = Convert.ToString(cmd.Parameters["p_packname"].Value);

                    cmd.Dispose();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }

                nodeStatus.Value = "OK";
                element.Attributes.SetNamedItem(nodeStatus);

                XmlElement parentNode = xmlResult.CreateElement("OutData");
                xmlResult.DocumentElement.PrependChild(parentNode);

                node = xmlResult.CreateNode(XmlNodeType.Attribute, "PackName", "");
                node.Value = packName;
                parentNode.Attributes.SetNamedItem(node);

                XmlText DataText = xmlResult.CreateTextNode(outResult);
                parentNode.AppendChild(DataText);
            }
            catch (System.Exception ex)
            {
                nodeStatus.Value = "Error";
                element.Attributes.SetNamedItem(nodeStatus);

                if (debug)
                {                                    	
                    element = xmlResult.CreateElement("ErrorStack");
                    errorText = xmlResult.CreateTextNode(ex.StackTrace);
                    element.AppendChild(errorText);
                    xmlResult.DocumentElement.PrependChild(element);
                }

                element = xmlResult.CreateElement("ErrorData");
                errorText = xmlResult.CreateTextNode(ex.Message);
                element.AppendChild(errorText);
                xmlResult.DocumentElement.PrependChild(element);
            }
            finally
            {

            }
            return xmlResult;
        }

    }
}

