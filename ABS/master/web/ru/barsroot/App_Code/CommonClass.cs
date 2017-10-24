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
/// ����� ����� �������
/// </summary>
public class CommonClass
{
    public CommonClass()
    {}

    /// <summary>
    /// ������������� ������������ � ����� UserMap.config
    /// </summary>
    /// <param name="log_name">�����(��� ������������)</param>
    /// <param name="comment">�����������</param>
    /// <param name="user_blocked">���� ���������� (0 ��� 1)</param>
    public static void SyncUser(String log_name, String comment, String user_blocked)
    {
        XmlDocument doc = ConfigurationSettings.UserMapConfiguration;
        XmlNode section = doc.SelectSingleNode("//userMapSettings");

        /// �� ���� ��� ����� ����������
        bool found_one = false;
        /// ����� � ��� ������������
        XmlNode node;
        /// ���� ������� ������
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
        /// ������ � - ������ ��������, 
        /// ���� ���� - ������� �����
        else
        {
            node = section.ChildNodes[0].Clone();

            foreach (XmlNode t_node in section.ChildNodes)
            {
                if ((t_node.NodeType != XmlNodeType.Comment) &&
                    (log_name.Trim().ToLower() == t_node.Attributes["webuser"].Value.ToLower()))
                {
                    /// ������� ������ �����������
                    t_node.Attributes["blocked"].Value = user_blocked;
                    found_one = true;
                    break;
                }
            }
        }

        /// ���������� ��� ���� 
        /// ���������� ����
        if (!found_one)
        /// ���������� �����
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

