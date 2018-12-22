using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LoginModel
/// </summary>
namespace Bars.CommonModels.ExternUtilsModels
{
    [Serializable]
    public class LoginModel
    {
        public LoginModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public string SessionId { get; set; }
        public string UserId { get; set; }

        public string HostName { get; set; }
        public string Appname { get; set; }
        public  string ConnectionString { get; set; }
    }
} 
