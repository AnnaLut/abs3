using Oracle.DataAccess.Client;
using System;
using System.Security.Cryptography;
using System.Text;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Начало сессии взаимодействия с ЕА
    /// </summary>
    public struct StartSession
    {
        public String UserLogin;
        public String UserFio;
        public String UserPassword;
        public String EAServiceUrl;

        public static StartSession GetInstance(OracleConnection con, String kf)
        {
            StartSession res = new StartSession();

            String EadParLogin = "ead.User_Login" + kf;
            String EadParUserFio = "ead.User_Fio" + kf;
            String EadParUserPassword = "ead.User_Password" + kf;
            String EAdServiceUrl = "ead.ServiceUrl" + kf;

            string msg = String.Format("EadParLogin= {0}, EadParUserFio= {1}, EadParUserPassword= {2} ", EadParLogin, EadParUserFio, EadParUserPassword);
            EadSyncHelper.DbLoggerInfo(con, msg);

            res.UserLogin = Configuration.ConfigurationSettings.AppSettings[EadParLogin];
            res.UserFio = Configuration.ConfigurationSettings.AppSettings[EadParUserFio];
            res.EAServiceUrl = Configuration.ConfigurationSettings.AppSettings[EAdServiceUrl];

            String PasswordClear = Configuration.ConfigurationSettings.AppSettings[EadParUserPassword];
            using (MD5 MD5Hash = MD5.Create())
            {
                String PasswordHash = GetMd5Hash(MD5Hash, PasswordClear);
                res.UserPassword = PasswordHash;
            }

            return res;
        }
        public static String GetMd5Hash(MD5 md5Hash, String input)
        {
            Byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));

            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
                sBuilder.Append(data[i].ToString("x2"));

            return sBuilder.ToString();
        }
    }
}