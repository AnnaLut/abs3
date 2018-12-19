using System;
using System.Web.Services;
using Bars.Classes;
using System.Web.Services.Protocols;
using Dapper;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using barsroot.core;
using Bars.Application;
using System.Web;
using BarsWeb.Areas.Way.Models;
using Oracle.DataAccess.Client;
using System.Data;
using System.Text;

namespace Bars.WebServices
{
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class LoadCoursesService : BarsWebService
    {
        public WsHeader WsHeaderValue;

        public class ResultResponse
        {
            public string message { get; set; }
            public string status { get; set; }
            public string StackTrace { get; set; }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public ResultResponse LoadAllCourses(string UserName, string Password, string PathFrom, string PathTo)
        {
            var result = new ResultResponse { status = "OK", message = "",  StackTrace=""};
            StringBuilder sb = new StringBuilder();
            
            try
            {
                bool isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);

                if (isAuthenticated)
                    LoginUserInt(UserName);

                List<UpdateStatusError> results = new List<UpdateStatusError>();

                IEnumerable<string> fileNames = GetFile(PathFrom);

                if (fileNames.Count() > 0)
                {
                    OracleConnection con = OraConnector.Handler.UserConnection;
                    try
                    {
                        results = ImportCoursesFile(con, fileNames, PathFrom, PathTo);
                        foreach (var res in results)
                        {
                            sb.Append(res.Message);
                            sb.Append("  ");
                        }
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
                }
                else
                {
                    result.status = "Warning";
                    result.message = "No files in directory : " + PathFrom;
                }
            }
            catch (System.Exception ex)
            {
                result.status = "Error";
                result.message = ex.Message;
                result.StackTrace = ex.StackTrace;
            }
            
            result.message = sb.ToString();
            return result;
        }

        private List<UpdateStatusError> ImportCoursesFile(OracleConnection con, IEnumerable<string> fileNames, String pathFrom, String pathaTo)
        {
            List<UpdateStatusError> results = new List<UpdateStatusError>();
            foreach (var fileName in fileNames)
            {
                var Processresult = ImportCoursesInDB(con, pathFrom, fileName);

                results.Add(new UpdateStatusError { FileName = fileName, Message = !string.IsNullOrEmpty(Processresult) && Processresult != "null" ? Processresult : fileName });
                File.Copy(pathFrom + "\\" + fileName, pathaTo + "\\" + fileName, true);
                File.Delete(pathFrom + "\\" + fileName);
            }
            return results;
        }

        private string ImportCoursesInDB(OracleConnection con, string pathfrom, string fileName)
        {
            string InputBuffer = string.Empty;
            String Result = String.Empty;
            pathfrom += pathfrom[pathfrom.Length - 1] == '/' ? "" : "/";

            using (StreamReader sr = new StreamReader(File.Open(String.Format("{0}{1}", pathfrom, fileName), FileMode.Open), Encoding.GetEncoding(1251)))
            {
                InputBuffer = sr.ReadToEnd();  //2.Проверить кодировку кириллици
            }

            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "bars.rates.load_file";
                cmd.Parameters.Add("P_FILENAME", OracleDbType.Varchar2, fileName, ParameterDirection.Input);
                cmd.Parameters.Add("P_FILE_BODY", OracleDbType.Clob, InputBuffer, ParameterDirection.Input);
                cmd.Parameters.Add("P_RETURN", OracleDbType.Varchar2, 4000, Result, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                Result = Convert.ToString(cmd.Parameters["P_RETURN"].Value);
            }                

            return Result;
        }

        private IEnumerable<string> GetFile(String path)
        {
            List<string> files = new List<string>();
            string[] dirs = (Directory.GetFiles(path, "*.*", SearchOption.TopDirectoryOnly)).Where(s => s.EndsWith(".VAL") || s.EndsWith(".BMT") || s.EndsWith(".V01") || s.EndsWith(".V02")).ToArray();
            foreach (string dir in dirs)
            {
                files.Add(dir.Replace(path, "").Replace("\\", ""));
            }
            return files.AsEnumerable();
        }        

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
    }
}
