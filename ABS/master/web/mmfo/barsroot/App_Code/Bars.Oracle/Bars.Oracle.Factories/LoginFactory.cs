using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Bars.CommonModels;
using Bars.CommonModels.ExternUtilsModels;
/// <summary>
/// Summary description for LoginFactory
/// </summary>
namespace Bars.Oracle.Factories
{
    using barsroot.core;

    using Bars.Configuration;

    public class LoginFactory
    {
        private LoginModel loginModel;

        private UserMap userMap;
        public LoginFactory()
        {

        }
        public LoginModel GetloginModel
        {
            get
            {
                return loginModel;
            }
        }

        public LoginModel CreateLoginModel
        {
            get
            {
                userMap = Bars.Configuration.ConfigurationSettings.GetCurrentUserInfo;
                loginModel = new LoginModel
                                 {
                                     SessionId = HttpContext.Current.Session.SessionID,
                                     UserId = userMap.user_id,
                                     Appname = HttpContext.Current.Request.Url.Segments[1].Replace("/", ""),
                                     ConnectionString = GetAppConnection,
                                     HostName = HttpContext.Current.Request.UserHostName
                                 };
                return loginModel;
            }
        }

    public string GetAppConnection
    {
        get
        {
            return System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppConnectionString"].ToString();
        }
    }
        public LoginModel GetLoginModelOrCreate
        {
            get
            {
                if (loginModel == null)
                    return CreateLoginModel;
                return loginModel;
            }
        }

        public  LoginModel GetLoginModel
        {
            get { return loginModel; }
        }

    }
}