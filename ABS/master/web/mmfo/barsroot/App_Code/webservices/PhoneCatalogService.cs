using System;
using System.Web.Services;
using Bars.Classes;
using System.Web.Services.Protocols;
using Dapper;
using BarsWeb.Areas.TechWorks.Infrastructure;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using barsroot.core;
using Bars.Application;
using System.Web;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Way.Models;

namespace Bars.WebServices
{
    public class PhoneFile
    {
        public String filesfolder { get; set; }
        public String filefullname { get; set; }
        public String filename { get; set; }
    }

    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PhoneCatalogService : BarsWebService
    {
        public WsHeader WsHeaderValue;
        public String mask = "CN*.xml";

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public string ScanFolder(string UserName, string Password)
        {
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);

            if (isAuthenticated)
                LoginUserInt(UserName);

            string TextResult = "";
            List<UpdateStatusDb> results = new List<UpdateStatusDb>();
            String pathfrom =  this.GetPathFrom();//@"C://temp//ri//in";
            String pathto = this.GetPathTo();//@"C://temp//ri//arc";
            IEnumerable<string> fileNames = GetFile(pathfrom);
            try
            {
                results = this.ProcessPhoneFile(fileNames, pathfrom, pathto);
                foreach (var res in results)
                {
                    TextResult = TextResult + res.Message;
                }
            }
            catch (System.Exception ex)
            {
                var result = new UpdateStatusDb();
                result.Message = ex.Message;
                result.Status = "Failed";
                results.Add(result);
                return "error";
            }
            return TextResult;
        }

        #region service methods
        private List<UpdateStatusDb> ProcessPhoneFile(IEnumerable<string> fileNames, String pathin, String patharc)
        {
            WayRepository _repository = new WayRepository();
            var result = new UpdateStatusDb();
            result.Status = "OK";
            List<UpdateStatusDb> results = new List<UpdateStatusDb>();
            result.Message = "Files are not found.";
            foreach (var fileName in fileNames)
            {
                result.Message = "Proccesed.   ";
                byte[] fileData = new byte[0];
                var file = File.OpenRead(Path.Combine(pathin, fileName));
                var binaryReader = new BinaryReader(file);

                try
                {
                    var Rrocessresult = _repository.ImporPhonetFile(fileName, binaryReader.ReadBytes((int)file.Length));
                    file.Close();
                    file.Dispose();
                    if (Rrocessresult.FileId != null)
                    {
                        result.FileId = Rrocessresult.FileId;
                        result.Message = Rrocessresult.Message;
                        result.Status = "ERROR";
                        results.Add(result);
                    }
                    else
                    {
                        if (File.Exists(patharc + "\\" + fileName))
                        {
                            File.Delete(patharc + "\\" + fileName);
                        }
                        MoveFile(pathin + "\\" + fileName, patharc + "\\" + fileName);
                    }
                }
                catch (System.Exception ex)
                {
                    throw;
                }
            }
            return results;
        }

        private IEnumerable<string> GetFile(String path)
        {
            List<string> files =new List<string>();
            PhoneFile f = new PhoneFile();
            string[] dirs = Directory.GetFiles(path, mask);
            foreach (string dir in dirs)
            {
                files.Add(dir.Replace(path, "").Replace("\\", ""));
            }
            return files.AsEnumerable();
        }
        private void MoveFile(String pathfrom, String pathto)
        {
            string sourceFile = pathfrom;
            string destinationFile = pathto;
            if (File.Exists(destinationFile))
            {
                File.Delete(destinationFile);
            }
            System.IO.File.Move(sourceFile, destinationFile);
        }
        private String GetPathFrom()
        {
            var fileManager = new FileManager();
            String file = "";

            try
            {
                string sqls = @"select branch_attribute_utl.get_value('WAY4_AUTO_TEL_CHANGE_INDIR') as pathfrom from dual";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    file = connection.Query<string>(sqls).SingleOrDefault();
                }
                return file;
            }
            catch (System.Exception ex)
            {
                throw;
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        private String GetPathTo()
        {
            var fileManager = new FileManager();
            String file = "";

            try
            {
                string sqls = @"select branch_attribute_utl.get_value('WAY4_AUTO_TEL_CHANGE_ARCDIR') as pathto from dual";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    file = connection.Query<string>(sqls).SingleOrDefault();
                }
                return file;
            }
            catch (System.Exception ex)
            {
                throw;
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        #endregion

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
    }
}
