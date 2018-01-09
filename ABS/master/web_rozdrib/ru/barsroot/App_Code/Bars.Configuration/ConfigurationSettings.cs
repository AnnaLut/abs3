using System;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Web.Configuration;
using System.Xml;
using System.Reflection;
using Bars.Oracle;
using barsroot.core;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Web.Script.Serialization;

namespace Bars.Configuration
{
    public class ModuleSettings
    {
        private static Module_Accounts accounts;
        private static Module_Customers customers;
        private static Module_Documents documents;

        public Module_Accounts Accounts
        {
            get
            {
                if (accounts == null)
                    accounts = new Module_Accounts();
                return accounts;
            }
        }
        public Module_Customers Customers
        {
            get
            {
                if (customers == null)
                    customers = new Module_Customers();
                return customers;
            }
        }
        public Module_Documents Documents
        {
            get
            {
                if (documents == null)
                    documents = new Module_Documents();
                return documents;
            }
        }
        /// <summary>
        /// Регистрация блока js для иницициализации параметров модуля
        /// </summary>
        /// <param name="page"></param>
        public void JsSettingsBlockRegister(System.Web.UI.Page page)
        {
            string script = "var ModuleSettings = {};" + Environment.NewLine;
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            script += "ModuleSettings.Accounts = " + oSerializer.Serialize(this.Accounts) + ";" + Environment.NewLine;
            script += "ModuleSettings.Customers = " + oSerializer.Serialize(this.Customers) + ";" + Environment.NewLine;
            script += "ModuleSettings.Documents = " + oSerializer.Serialize(this.Documents) + ";" + Environment.NewLine;
            page.ClientScript.RegisterClientScriptBlock(page.GetType(), "moduleSettings", script, true);
        }
    }

    public class Module_Accounts
    {
        public bool EnhanceCheck
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Accounts.EnhanceCheck"] == "1";
            }
        }
        public bool CheckSpecParams
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Accounts.CheckSpecParams"] == "1";
            }
        }

        public bool EnhanceCloseCheck
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Accounts.EnhanceCloseCheck"] == "1";
            }
        }
        public bool DisableEditBlkType
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Accounts.DisableEditBlkType"] == "1";
            }
        }
    }
    public class Module_Customers
    {
        public bool EnhanceCheck
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Customers.EnhanceCheck"] == "1";
            }
        }
    }

    public class Module_Documents
    {
        public bool EnhancePrint
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Documents.EnhancePrint"] == "1";
            }
        }
        /// <summary>
        /// Флаг - при зміна (bars_cash.current_shift) >=3 брати дату валютування - наступну банківську 
        /// </summary>
        public bool ShiftValueDate
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Documents.ShiftValueDate"] == "1";
            }
        }

        public bool EnhanceSwiftCheck
        {
            get
            {
                return ConfigurationSettings.AppSettings["Module.Documents.EnhanceSwiftCheck"] == "1";
            }
        }
    }

    /// <summary>
    /// Библиотека для доступа к общему файлу конфигурации.
    /// </summary>
    public sealed class ConfigurationSettings
    {
        static Hashtable _watchers = new Hashtable();

        private ConfigurationSettings()
        {
        }
        # region Работа с файлом конфигурации Bars.config
        //---------------------------------------------------------------------------------------
        //---------------------------------BARS--------------------------------------------------
        //---------------------------------------------------------------------------------------
        /// <summary>
        /// Путь к файлу конфигурации
        /// </summary>
        public static string AppPathConfig
        {
            get { return System.Web.HttpContext.Current.Server.MapPath("//Common/Configuration") + "//Bars.config"; }
        }
        /// <summary>
        /// Путь к файлу конфигурации закодированому
        /// </summary>
        public static string AppPathConfigEncode
        {
            get { return System.Web.HttpContext.Current.Server.MapPath("//Common/Configuration") + "//Bars.encoded"; }
        }
        /// <summary>
        /// Доступ к колекции атрибутов в секции "appSettings" в файле конфигурации.
        /// </summary>
        /// <remarks></remarks>
        public static NameValueCollection AppSettings
        {
            get
            {
                NameValueCollection appSettings = (NameValueCollection)
                    AppDomain.CurrentDomain.GetData("appSettings");

                if (appSettings == null)
                {
                    if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
                    {
                        appSettings = getBarsConfigFromDB("appSettings");
                        if (appSettings.Count == 0)
                        {
                            throw new Bars.Exception.BarsException("Не заполнена таблица конфиругационных параметров web_barsconfig.");
                        }
                    }
                    else
                    {
                        appSettings = getBarsConfigFromXml("appSettings");
                    }
                    AppDomain.CurrentDomain.SetData("appSettings", appSettings);
                }
                return appSettings;
            }
        }
        /// <summary>
        /// Обновить глобальные настройки
        /// </summary>
        public static void RefreshBarsConfig()
        {
            NameValueCollection appSettings = new NameValueCollection();
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                appSettings = getBarsConfigFromDB("appSettings");
            }
            else
            {
                appSettings = getBarsConfigFromXml("appSettings");
            }
            AppDomain.CurrentDomain.SetData("appSettings", appSettings);
        }
        
        /// <summary>
        /// Доступ к колекции атрибутов в произвольной секции sectionName в файле конфигурации.
        /// </summary>
        /// <param name="sectionName">Имя секции</param>
        /// <returns></returns>
        public static NameValueCollection CustomSettings(string sectionName)
        {
            NameValueCollection customSettings = (NameValueCollection)
                    AppDomain.CurrentDomain.GetData(sectionName);

            if (customSettings == null)
            {
                if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
                {
                    customSettings = getBarsConfigFromDB(sectionName);
                }
                else
                {
                    customSettings = getBarsConfigFromXml(sectionName);
                }
                AppDomain.CurrentDomain.SetData(sectionName, customSettings);
            }
            return customSettings;
        }
        private static NameValueCollection getBarsConfigFromDB(string sectionName)
        {
            NameValueCollection appSettings = new NameValueCollection();
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.Parameters.Add("typename", OracleDbType.Varchar2, sectionName, System.Data.ParameterDirection.Input);
                cmd.CommandText = "select c.key,c.val from bars.web_barsconfig c, bars.web_barsconfig_grouptypes g where c.grouptype=g.id and g.type_name=:typename";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string key = Convert.ToString(reader.GetValue(0));
                    string val = Convert.ToString(reader.GetValue(1));
                    if (System.Configuration.ConfigurationSettings.AppSettings[key] != null)
                        val = Convert.ToString(System.Configuration.ConfigurationSettings.AppSettings[key]);
                    appSettings.Add(key, val);
                }
                reader.Close();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return appSettings;
        }

        private static NameValueCollection getBarsConfigFromXml(string sectionName)
        {
            NameValueCollection appSettings = new NameValueCollection();
            XmlDocument document = ConfigurationDocument;
            XmlNode section = document.SelectSingleNode("//" + sectionName);
            foreach (XmlNode node in section.ChildNodes)
            {
                if (node.NodeType != XmlNodeType.Comment && node.Attributes.Count >= 2)
                    appSettings.Add(node.Attributes["key"].Value, node.Attributes["value"].Value);
            }
            return appSettings;
        }

        /// <summary>
        /// Возвращает файл конфигурации в виде XmlDocument.
        /// </summary>
        /// <remarks></remarks>
        public static XmlDocument ConfigurationDocument
        {
            get
            {
                XmlDocument doc = new XmlDocument();
                string xml = string.Empty;

                if (System.IO.File.Exists(AppPathConfigEncode))
                {
                    StreamReader reader = new StreamReader(AppPathConfigEncode);
                    string xmlEncoded = reader.ReadToEnd();
                    xml = Bars.Application.CustomEncryption.Decrypt(xmlEncoded);
                    doc.LoadXml(xml);
                    AddMonitor(AppPathConfigEncode);
                    reader.Close();
                }
                else
                {
                    StreamReader reader = new StreamReader(AppPathConfig);
                    xml = reader.ReadToEnd();
                    doc.LoadXml(xml);
                    AddMonitor(AppPathConfig);
                    reader.Close();
                }
                return doc;
            }
        }
        /// <summary>
        /// Добавляет мониторинг за изменениями файла конфигурации
        /// </summary>
        private static void AddMonitor(string file)
        {
            AppDomain.CurrentDomain.DomainUnload += new EventHandler(OnUnload);
            if (!_watchers.ContainsKey(file))
            {
                FileSystemWatcher watcher = new FileSystemWatcher();
                watcher.Path = Path.GetDirectoryName(file);
                watcher.Filter = "*" + Path.GetExtension(file);
                watcher.NotifyFilter = NotifyFilters.LastAccess | NotifyFilters.LastWrite | NotifyFilters.FileName | NotifyFilters.DirectoryName;
                watcher.Changed += new FileSystemEventHandler(OnChanged);
                watcher.EnableRaisingEvents = true;

                if (!_watchers.ContainsKey(file)) _watchers.Add(file, watcher);
            }
        }

        /// <summary>
        /// Выгрузка данных при изменении файла конфигурации.
        /// </summary>
        private static void OnChanged(object sender, FileSystemEventArgs e)
        {
            AppDomain.CurrentDomain.SetData("appSettings", null);
            AppDomain.CurrentDomain.SetData("OracleConnectClass", null);
            AppDomain.CurrentDomain.SetData("userMapSettings", null);
            AppDomain.CurrentDomain.SetData("traceSettings", null);
        }

        /// <summary>
        /// Удаляет мониторинг.
        /// </summary>
        private static void OnUnload(object sender, EventArgs e)
        {
            string file = AppPathConfig;
            if (_watchers.ContainsKey(file))
            {
                FileSystemWatcher watcher = (FileSystemWatcher)_watchers[file];
                watcher.Dispose();
                _watchers.Remove(file);
            }
        }
        # endregion

        # region Работа с файлом конфигурации UserMap.config
        //---------------------------------------------------------------------------------------
        //---------------------------------USERMAP-----------------------------------------------
        //---------------------------------------------------------------------------------------
        /// <summary>
        /// Путь к файлу соответствия пользователей
        /// </summary>
        public static string UserMapConfig
        {
            get { return System.Web.HttpContext.Current.Server.MapPath("//Common/Configuration") + "//UserMap.config"; }
            //get { return ""; }
        }
        /// <summary>
        /// Путь к файлу соответствия пользователей закодированый
        /// </summary>
        public static string UserMapConfigEncode
        {
            get { return System.Web.HttpContext.Current.Server.MapPath("//Common/Configuration") + "//UserMap.encoded"; }
        }

        /// <summary>
        /// Доступ к колекции атрибутов в файле конфигурации UserMap.config.
        /// </summary>
        /// <remarks></remarks>
        public static Hashtable UserMapSettings
        {
            get
            {
                Hashtable usersInfo = (Hashtable)
                    AppDomain.CurrentDomain.GetData("userMapSettings");

                if (usersInfo == null)
                {
                    if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
                    {
                        usersInfo = getUserMapFromDB();
                    }
                    else
                    {
                        usersInfo = getUserMapFromXml();
                    }

                    AppDomain.CurrentDomain.SetData("userMapSettings", usersInfo);
                }
                return usersInfo;
            }
            set
            {
                AppDomain.CurrentDomain.SetData("userMapSettings", value);
            }
        }
        /// <summary>
        /// Вычитка из базы всех пользователей в hashtable
        /// </summary>
        /// <returns></returns>
        private static Hashtable getUserMapFromDB()
        {
            Hashtable userMap = new Hashtable();
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = "select webuser,dbuser,errmode,webpass,adminpass,comm,chgdate,blocked,attempts,user_id,shared_user,log_level,change_date, bank_date from bars.v_web_usermap";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    UserMap umap = new UserMap();
                    umap.webuser = Convert.ToString(reader.GetValue(0));
                    umap.dbuser = Convert.ToString(reader.GetValue(1));
                    umap.errormode = Convert.ToString(reader.GetValue(2));
                    umap.webpass = Convert.ToString(reader.GetValue(3));
                    umap.adminpass = Convert.ToString(reader.GetValue(4));
                    umap.comm = Convert.ToString(reader.GetValue(5));
                    umap.chgdate = Convert.ToString(reader.GetValue(6));
                    umap.blocked = Convert.ToString(reader.GetValue(7));
                    umap.attemps = Convert.ToString(reader.GetValue(8));
                    umap.user_id = Convert.ToString(reader.GetValue(9));
                    umap.shared_user = Convert.ToString(reader.GetValue(10));
                    umap.log_level = Convert.ToString(reader.GetValue(11));
                    umap.change_date = Convert.ToString(reader.GetValue(12));
                    umap.bank_date = reader.GetDateTime(13);

                    userMap.Add(umap.webuser, umap);
                }
                reader.Close();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return userMap;
        }
        /// <summary>
        /// Обновляем информацию об текущем пользователе
        /// </summary>
        /// <param name="webuser">логин пользователя</param>
        /// <returns></returns>
        private static UserMap getUserInfoFromDB(string webuser)
        {
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            UserMap umap = new UserMap();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.Parameters.Add("webuser", OracleDbType.Varchar2, webuser.ToLower(), System.Data.ParameterDirection.Input);
                cmd.CommandText = "select webuser,dbuser,errmode,webpass,adminpass,comm,chgdate,blocked,attempts,user_id,shared_user,log_level,change_date, bank_date from bars.v_web_usermap where lower(webuser)=:webuser";
                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    umap.webuser = Convert.ToString(reader.GetValue(0));
                    umap.dbuser = Convert.ToString(reader.GetValue(1));
                    umap.errormode = Convert.ToString(reader.GetValue(2));
                    umap.webpass = Convert.ToString(reader.GetValue(3));
                    umap.adminpass = Convert.ToString(reader.GetValue(4));
                    umap.comm = Convert.ToString(reader.GetValue(5));
                    umap.chgdate = Convert.ToString(reader.GetValue(6));
                    umap.blocked = Convert.ToString(reader.GetValue(7));
                    umap.attemps = Convert.ToString(reader.GetValue(8));
                    umap.user_id = Convert.ToString(reader.GetValue(9));
                    umap.shared_user = Convert.ToString(reader.GetValue(10));
                    umap.log_level = Convert.ToString(reader.GetValue(11));
                    umap.change_date = Convert.ToString(reader.GetValue(12));
                    umap.bank_date = reader.GetDateTime(13);
                }
                reader.Close();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return umap;
        }
        private static UserMap getUserInfoFromXml(string webuser)
        {
            UserMap umap = new UserMap();
            XmlDocument document = UserMapConfiguration;
            XmlNode section = document.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
            if (section != null)
            {
                umap.webuser = section.Attributes["webpass"].Value;
                umap.dbuser = section.Attributes["dbuser"].Value;
                umap.errormode = section.Attributes["errormode"].Value;
                umap.webpass = section.Attributes["webpass"].Value;
                umap.adminpass = section.Attributes["adminpass"].Value;
                umap.comm = section.Attributes["comm"].Value;
                umap.chgdate = section.Attributes["chgdate"].Value;
                umap.blocked = section.Attributes["blocked"].Value;
                umap.attemps = section.Attributes["attemps"].Value;
            }
            return umap;
        }

        public static string getUserNameFromCertificate(HttpClientCertificate cert)
        {
            // Если если есть серитфикат, то берем его имя
            if (cert.IsPresent && cert.IsValid)
            {
                string certName = cert.Get("SubjectCN").ToLower();
                string certNumber = cert.SerialNumber.Replace("-", "");
                return certName;
            }
            else
            {
                throw new Bars.Exception.BarsException("Клиентский сертификат отсутствует или просрочен. Обратитесь к администратору.");
            }
        }

        private static Hashtable getUserMapFromXml()
        {
            XmlDocument document = UserMapConfiguration;
            XmlNode section = document.SelectSingleNode("//userMapSettings");
            Hashtable userMap = new Hashtable();
            foreach (XmlNode node in section.ChildNodes)
            {
                if (node.NodeType != XmlNodeType.Comment)
                {
                    UserMap map = new UserMap();
                    map.webuser = node.Attributes["webuser"].Value.ToLower();
                    map.dbuser = node.Attributes["dbuser"].Value;
                    map.errormode = node.Attributes["errormode"].Value;
                    map.webpass = node.Attributes["webpass"].Value;
                    map.comm = node.Attributes["comm"].Value;
                    map.adminpass = node.Attributes["adminpass"].Value;
                    map.chgdate = node.Attributes["chgdate"].Value;
                    map.blocked = node.Attributes["blocked"].Value;
                    map.attemps = node.Attributes["attemps"].Value;
                    if (userMap.Contains(map.webuser))
                        userMap[map.webuser] = map;
                    else
                        userMap.Add(map.webuser, map);
                }
            }
            return userMap;
        }
        /// <summary>
        /// Обновить информацию о текущем пользователе
        /// </summary>
        /// <param name="webuser"></param>
        public static UserMap RefreshUserInfo(string webuser)
        {
            UserMap map;
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                map = getUserInfoFromDB(webuser);
                if (!string.IsNullOrEmpty(map.webuser))
                    UserMapSettings[webuser] = map;
            }
            else
            {
                map = getUserInfoFromXml(webuser);
                if (!string.IsNullOrEmpty(map.webuser))
                    UserMapSettings[webuser] = map;
            }
            return map;
        }
        /// <summary>
        /// Перечитать информацию об пользователях
        /// </summary>
        public static void RefreshUserMap()
        {
            Hashtable usersInfo = new Hashtable();
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                usersInfo = getUserMapFromDB();
            }
            else
            {
                usersInfo = getUserMapFromXml();
            }

            AppDomain.CurrentDomain.SetData("userMapSettings", usersInfo);
        }

        /// <summary>
        /// Возвращает файл конфигурации в виде XmlDocument.
        /// </summary>
        /// <remarks></remarks>
        public static XmlDocument UserMapConfiguration
        {
            get
            {
                XmlDocument doc = new XmlDocument();
                string xml = string.Empty;
                if (File.Exists(UserMapConfigEncode))
                {
                    StreamReader reader = new StreamReader(UserMapConfigEncode, System.Text.Encoding.UTF8);
                    string xmlEncoded = reader.ReadToEnd();
                    xml = Bars.Application.CustomEncryption.Decrypt(xmlEncoded);
                    doc.LoadXml(xml);
                    AddMonitor(UserMapConfigEncode);
                    reader.Close();
                }
                else if (File.Exists(UserMapConfig))
                {
                    StreamReader reader = new StreamReader(UserMapConfig, System.Text.Encoding.UTF8);
                    xml = reader.ReadToEnd();
                    doc.LoadXml(xml);
                    AddMonitor(UserMapConfig);
                    reader.Close();
                }
                else
                    throw new System.Exception("Не знайдено файл конфігурації UserMap.config");
                return doc;
            }
        }

        /// <summary>
        /// Данные о пользователе в виде структуры UserMap
        /// </summary>
        /// <param name="webuser">логин пользователя</param>
        /// <returns></returns>
        public static UserMap GetUserInfo(string webuser)
        {
            webuser = webuser.ToLower();
            object map = UserMapSettings[webuser];
            if (null != map)
                return (UserMap)UserMapSettings[webuser];
            else
                return new UserMap();
        }

        /// <summary>
        /// Данные о текущем пользователе (в виде структуры UserMap)
        /// </summary>
        public static UserMap GetCurrentUserInfo
        {
            get
            {
                string userName = System.Web.HttpContext.Current.User.Identity.Name.ToLower();
                object map = UserMapSettings[userName];
                if (null != map)
                    return (UserMap)UserMapSettings[userName];
                else
                    return new UserMap();
            }
        }

        /// <summary>
        /// Изменить пароль пользователя
        /// </summary>
        /// <param name="webuser">логин пользователя</param>
        /// <param name="newPswSHA1">хеш нового пароля</param>
        /// <returns></returns>
        public static bool ChangePassword(string webuser, string newPswSHA1)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                WebUtl_changePassword(webuser, newPswSHA1);
            }
            else
            {
                if (UserMapSettings[webuser] == null)
                    return false;
                UserMap map = (UserMap)UserMapSettings[webuser];
                XmlDocument doc = UserMapConfiguration;
                XmlNode section = doc.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
                if (section.Attributes.Count == 0)
                    return false;
                section.Attributes["webpass"].Value = newPswSHA1;
                SaveXmlConfiguration(doc, 2);
            }
            RefreshUserInfo(webuser);
            return true;
        }

        /// <summary>
        /// Изменить дату последнего изменения пароля на текущюю дату сервера
        /// </summary>
        /// <param name="webuser">логин пользователя</param>
        /// <returns></returns>
        public static bool ChangeDataLastChangePsw(string webuser)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                WebUtl_setUserChangedate(webuser);
            }
            else
            {
                XmlDocument doc = UserMapConfiguration;
                XmlNode section = doc.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
                if (section.Attributes.Count == 0)
                    return false;
                section.Attributes["chgdate"].Value = DateTime.Now.ToString("dd/MM/yyyy");
                SaveXmlConfiguration(doc, 2);
            }
            RefreshUserInfo(webuser);
            return true;
        }

        /// <summary>
        /// Добавить количество попыток неправильного ввода пароля 
        /// </summary>
        /// <param name="webuser">логин пользователя</param>
        /// <param name="val">количество попыток</param>
        /// <returns></returns>
        public static bool AddAtempt(string webuser)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                WebUtl_addUserAtempt(webuser);
            }
            else
            {
                XmlDocument doc = UserMapConfiguration;
                XmlNode section = doc.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
                if (section.Attributes.Count == 0)
                    return false;
                int val = Convert.ToInt32(section.Attributes["attemps"].Value);
                section.Attributes["attemps"].Value = Convert.ToString(val + 1);
                SaveXmlConfiguration(doc, 2);
            }
            RefreshUserInfo(webuser);
            return true;
        }

        public static bool ClearAtempt(string webuser)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                WebUtl_cleraUserAtempt(webuser);
            }
            else
            {
                XmlDocument doc = UserMapConfiguration;
                XmlNode section = doc.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
                if (section.Attributes.Count == 0)
                    return false;
                section.Attributes["attemps"].Value = "0";
                SaveXmlConfiguration(doc, 2);
            }
            RefreshUserInfo(webuser);
            return true;
        }

        /// <summary>
        /// Заблокировать пользователя
        /// </summary>
        /// <param name="webuser">логин пользователя</param>
        /// <returns></returns>
        public static bool BlockUser(string webuser)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                WebUtl_blockUser(webuser);
            }
            else
            {
                XmlDocument doc = UserMapConfiguration;
                XmlNode section = doc.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
                if (section.Attributes.Count == 0)
                    return false;
                section.Attributes["blocked"].Value = "1";
                SaveXmlConfiguration(doc, 2);
            }
            RefreshUserInfo(webuser);
            return true;
        }

        public static void SaveXmlConfiguration(XmlDocument doc, byte type)
        {
            //Bars.config
            string encodeXml = string.Empty;
            if (type == 1)
            {
                if (File.Exists(AppPathConfigEncode))
                {
                    encodeXml = Bars.Application.CustomEncryption.Encrypt(doc.OuterXml);
                    StreamWriter writer = new StreamWriter(AppPathConfigEncode, false, System.Text.Encoding.UTF8);
                    writer.Write(encodeXml);
                    writer.Close();
                }
                else
                {
                    doc.Save(AppPathConfig);
                }
                AppDomain.CurrentDomain.SetData("appSettings", null);
            }
            else if (type == 2)
            {
                if (File.Exists(UserMapConfigEncode))
                {
                    encodeXml = Bars.Application.CustomEncryption.Encrypt(doc.OuterXml);
                    StreamWriter writer = new StreamWriter(UserMapConfigEncode, false, System.Text.Encoding.UTF8);
                    writer.Write(encodeXml);
                    writer.Close();
                }
                else
                {
                    doc.Save(UserMapConfig);
                }
                AppDomain.CurrentDomain.SetData("userMapSettings", null);
            }
        }

        # endregion

        # region Функции для работы с базой
        /// <summary>
        /// Строка соединения для webtech
        /// </summary>
        /// <returns></returns>
        public static string GetTechConnectionString()
        {
            //return System.Configuration.ConfigurationManager.AppSettings["ConnectStringForConfig"];
            return WebConfigurationManager.ConnectionStrings[BarsWeb.Infrastructure.Constants.AppConnectionStringName].ConnectionString;
        }

        /// <summary>
        /// Проверка доступности базы
        /// </summary>
        /// <returns></returns>
        public static bool CheckDatabase()
        {
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            try
            {
                con.Open();
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = "select sysdate from dual";
                cmd.ExecuteScalar();
                cmd.Dispose();
                return true;
            }
            catch { return false; }
            finally
            {
                if (con.State != System.Data.ConnectionState.Closed)
                    con.Close();
                con.Dispose();
            }
        }
        private static void WebUtl_changePassword(string webuser, string pswhash)
        {
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("p_webuser", OracleDbType.Varchar2, webuser, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_pswhash", OracleDbType.Varchar2, pswhash, System.Data.ParameterDirection.Input);
                cmd.CommandText = "bars.web_utl.change_password";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        private static void WebUtl_setUserChangedate(string webuser)
        {
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("p_webuser", OracleDbType.Varchar2, webuser, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_dt", OracleDbType.Date, DateTime.Now, System.Data.ParameterDirection.Input);
                cmd.CommandText = "bars.web_utl.set_user_changedate";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
        private static void WebUtl_addUserAtempt(string webuser)
        {
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("p_webuser", OracleDbType.Varchar2, webuser, System.Data.ParameterDirection.Input);
                cmd.CommandText = "bars.web_utl.add_user_atempt";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        private static void WebUtl_cleraUserAtempt(string webuser)
        {
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("p_webuser", OracleDbType.Varchar2, webuser, System.Data.ParameterDirection.Input);
                cmd.CommandText = "bars.web_utl.clear_user_atempt";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        private static void WebUtl_blockUser(string webuser)
        {
            OracleConnection con = new OracleConnection(GetTechConnectionString());
            con.Open();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("p_webuser", OracleDbType.Varchar2, webuser, System.Data.ParameterDirection.Input);
                cmd.CommandText = "bars.web_utl.blockUser";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
        # endregion
    }

}
