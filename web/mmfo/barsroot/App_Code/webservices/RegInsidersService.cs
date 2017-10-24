using System;
using System.Web.Services;
using System.Data;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Web.Services.Protocols;
using System.Xml;
using Oracle.DataAccess.Types;
using Dapper;
using BarsWeb.Areas.TechWorks.Infrastructure;
using System.IO;
using BarsWeb.Areas.TechWorks.Models;
using System.Collections.Generic;
using System.Linq;
using barsroot.core;
using Bars.Application;
using System.Web;

namespace Bars.WebServices
{
    public class InsiderFile
    {
        public String filesfolder { get; set; }
        public String filefullname { get; set; }
        public String filename { get; set; }
    }
    public class ReqStatus
    {
        public string Status { get; set; }
        public string Message { get; set; }
    }

    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class RegInsidersService : BarsWebService
    {
        public WsHeader WsHeaderValue;
        public string mask = "RI*.xml";
        private const string ERRORSTATUS = "ERROR";
        private const string OKSTATUS = "OK";

        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public ReqStatus ScanFolder(string UserName, string Password, string Branch)
        {
            try
            {
                bool isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);

                if (isAuthenticated)
                    LoginUserInt(UserName);
                if (Branch != null)
                    SetBranch(Branch);

                var result = new ReqStatus();
                result.Message = "Файли відсутні.";
                result.Status = OKSTATUS;
                FileManager filemanager = new FileManager();
                InsiderFile file = new InsiderFile();

                try
                {
                    file = this.GetPath();
                }
                catch (System.Exception ex)
                {
                    result.Message = ex.Message + "  authorization required";
                    result.Status = ERRORSTATUS;
                    return result;
                }

                if (!Directory.Exists(file.filesfolder))
                {
                    result.Message = "Вказаний шлях не знайдено, або відсутній доступ. (помилка при зчитуванні файлів) " + file.filesfolder;
                    result.Status = ERRORSTATUS;
                    return result;
                }

                List<InsiderFile> Files = new List<InsiderFile>();
                try
                {
                    Files = GetFile(file.filesfolder);
                }
                catch (UnauthorizedAccessException)
                {
                    return new ReqStatus() { Message = "Відсутній доступ до каталогу " + file.filesfolder, Status = ERRORSTATUS };
                }

                for (int i = 0; i < Files.Count; i++)
                {
                    result.Message = "Файли знайдено";
                    Stream data = this.GetStream(Files[i].filefullname);
                    try
                    {
                        filemanager.FileProcess(Files[i].filename, data);
                        this.Backup(Files[i]);
                    }
                    catch (UnauthorizedAccessException ex) { return new ReqStatus() { Message = "Помилка під час запису файлів. " + ex.Message, Status = ERRORSTATUS }; }
                    catch (System.Exception ex) { return new ReqStatus() { Message = ex.Message, Status = ERRORSTATUS }; }
                }
                return result;
            }
            catch (System.Exception ex) { return new ReqStatus() { Status = ERRORSTATUS, Message = ex.Message }; }
        }

        #region service methods

        private List<InsiderFile> GetFile(String path)
        {
            List<InsiderFile> files = new List<InsiderFile>();
            InsiderFile f = new InsiderFile();

            string[] dirs = Directory.GetFiles(path, mask);
            foreach (string dir in dirs)
            {
                f.filefullname = dir;
                f.filesfolder = path;
                f.filename = dir.Replace(path, "").Replace("\\", "");
                files.Add(f);
            }
            return files;
        }
        private InsiderFile GetPath()
        {
            //var fileManager = new FileManager();
            InsiderFile file = new InsiderFile();

            try
            {
                string sqls = @"select branch_attribute_utl.get_value('RIXML_PATH_IN') as pathout from dual";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    file.filesfolder = connection.Query<string>(sqls).SingleOrDefault();
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
        private Stream GetStream(String file)
        {
            try
            {
                Stream stream = new MemoryStream(File.ReadAllBytes(file));
                return stream;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
        //private void DeleteInsiderFile(String file)
        //{
        //    String path = file;

        //    if (System.IO.File.Exists(path))
        //    {
        //        try
        //        {
        //            System.IO.File.Delete(path);
        //        }
        //        catch (System.IO.IOException e)
        //        {
        //            throw;
        //        }
        //    }
        //}
        private void Backup(InsiderFile file)
        {
            string pathto = "";

            try
            {
                string sql = @"select branch_attribute_utl.get_value('RIXML_PATH_ARC') as pathout from dual";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    pathto = connection.Query<string>(sql).SingleOrDefault();
                }

                if (!Directory.Exists(pathto)) throw new System.Exception("Вказаний шлях не знайдено, або відсутній доступ (помилка при запису файлів). " + pathto);

                if (File.Exists(pathto + "\\" + file.filename))
                {
                    File.Delete(pathto + "\\" + file.filename);
                }

                this.MoveFile(file.filefullname, pathto + "\\" + file.filename);
            }
            catch (System.Exception ex) { throw; }
            finally
            {
                DisposeOraConnection();
            }
        }
        private void MoveFile(string pathfrom, string pathto)
        {
            string sourceFile = pathfrom;
            string destinationFile = pathto;

            System.IO.File.Move(sourceFile, destinationFile);
        }
        #endregion

        #region private methods
        private void LoginUserInt(string userName)
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

        private void SetBranch(String branch)
        {
            try
            {
                InitOraConnection();
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_branch", DB_TYPE.Varchar2, branch, DIRECTION.Input);
                SQL_PROCEDURE("bars.bc.go");

                ClearParameters();
                SetParameters("p_info", DB_TYPE.Varchar2, String.Format("Установлен branch = ", branch), DIRECTION.Input);
                SQL_PROCEDURE("bars_audit.info");
            }
            finally
            {
                DisposeOraConnection();
            }

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
