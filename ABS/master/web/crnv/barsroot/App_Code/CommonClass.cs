using System;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Configuration;
using System.Xml;

/// <summary>
/// Класс общих функций
/// </summary>
public class CommonClass
{
    public CommonClass()
    {}

    /// <summary>
    /// Синхронизация пользователя в файле UserMap.config
    /// </summary>
    /// <param name="log_name">логин(имя пользователя)</param>
    /// <param name="comment">комментарий</param>
    /// <param name="user_blocked">флаг блокировки (0 или 1)</param>
    public static void SyncUser(String log_name, String comment, String user_blocked)
    {
        XmlDocument doc = ConfigurationSettings.UserMapConfiguration;
        XmlNode section = doc.SelectSingleNode("//userMapSettings");

        /// Чи існує вже такий користувач
        bool found_one = false;
        /// Рядок з цим користувачем
        XmlNode node;
        /// Немає жодного запису
        if (section.ChildNodes.Count == 0)
        {
            node = doc.CreateNode(XmlNodeType.Element, "map", doc.NamespaceURI);
            XmlAttribute webuser = doc.CreateAttribute("webuser");
            node.Attributes.Append(webuser);
            XmlAttribute dbuser = doc.CreateAttribute("dbuser");
            node.Attributes.Append(dbuser);
            XmlAttribute errormode = doc.CreateAttribute("errormode");
            node.Attributes.Append(errormode);
            XmlAttribute webpass = doc.CreateAttribute("webpass");
            node.Attributes.Append(webpass);
            XmlAttribute adminpass = doc.CreateAttribute("adminpass");
            node.Attributes.Append(adminpass);
            XmlAttribute comm = doc.CreateAttribute("comm");
            node.Attributes.Append(comm);
            XmlAttribute blocked = doc.CreateAttribute("blocked");
            node.Attributes.Append(blocked);
            XmlAttribute attemps = doc.CreateAttribute("attemps");
            node.Attributes.Append(attemps);
            XmlAttribute chgdate = doc.CreateAttribute("chgdate");
            node.Attributes.Append(chgdate);
        }
        /// Записи є - шукаємо потрібний, 
        /// якщо немає - створємо новий
        else
        {
            node = section.ChildNodes[0].Clone();

            foreach (XmlNode t_node in section.ChildNodes)
            {
                if ((t_node.NodeType != XmlNodeType.Comment) &&
                    (log_name.Trim().ToLower() == t_node.Attributes["webuser"].Value.ToLower()))
                {
                    /// Знайшли такого користувача
                    t_node.Attributes["blocked"].Value = user_blocked;
                    found_one = true;
                    break;
                }
            }
        }

        /// Користувач вже існує 
        /// обновляємо його
        if (!found_one)
        /// Користувач новий
        {
            node.Attributes["webuser"].Value = log_name.Trim().ToLower();
            node.Attributes["dbuser"].Value = log_name.Trim().ToUpper();
            node.Attributes["errormode"].Value = "0";
            node.Attributes["adminpass"].Value = ConfigurationSettings.AppSettings.Get("CustomAuthentication.InitPassword.Hash");
            node.Attributes["webpass"].Value = "";
            node.Attributes["comm"].Value = comment;
            node.Attributes["blocked"].Value = user_blocked;
            node.Attributes["attemps"].Value = "0";
            node.Attributes["chgdate"].Value = "";

            section.AppendChild(node);
        }

        ConfigurationSettings.SaveXmlConfiguration(doc, 2);
    }
}

