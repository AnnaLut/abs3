using System;
using System.Collections;
using System.Web.UI.WebControls;
using System.Xml;
using Bars;
using barsroot.core;
using Bars.Configuration;

namespace BarsWeb.Admin
{
    public partial class AdminUsers : BarsPage
    {
        private static bool _sortDesc = false;
        private static bool _sortDBUser = false;
        public class Sorting : IComparer
        {

            public Sorting(bool sortDesc)
            {
                _sortDesc = sortDesc;
            }

            int IComparer.Compare(Object x, Object y)
            {
                if (_sortDesc)
                    return ((new CaseInsensitiveComparer()).Compare(y, x));
                else
                    return ((new CaseInsensitiveComparer()).Compare(x, y));
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) FillData();
            ddType.Items[0].Text = spDBUser.Text;
            ddType.Items[1].Text = spWebUser.Text;
        }

        public void FillData()
        {
            ArrayList staffList = new ArrayList();
            try
            {
                InitOraConnection();
                SetRole("basic_info");
                string query = "select logname from staff";
                if (!string.IsNullOrEmpty(tbFilter.Text) && ddType.SelectedValue == "0")
                    query += " where logname like '" + tbFilter.Text.Replace("*", "%").Replace("?", "_").ToUpper() + "'";
                SQL_Reader_Exec(query);
                while (SQL_Reader_Read())
                {
                    staffList.Add(SQL_Reader_GetValues()[0].ToString().ToLower());
                }
                SQL_Reader_Close();
            }
            finally
            {
                DisposeOraConnection();
            }
            NbuAuth.Value = ConfigurationSettings.AppSettings.Get("CustomAuthentication.AuthNbu");
            btUpdate.Attributes["onclick"] = "javascript:if (Validate(this.form))";
            Hashtable tab = ConfigurationSettings.UserMapSettings;
            Hashtable tabDBUser = new Hashtable();
            ArrayList list = new ArrayList(tab.Keys);

            list.Sort(new Sorting(_sortDesc));
            Table tbl = new Table();
            tbl.CellPadding = 0;
            tbl.CellSpacing = 0;
            tbl.Attributes["border"] = "1";
            TableCell cell = null;
            int count = 0;
            bool bFilter = (!string.IsNullOrEmpty(tbFilter.Text) && ddType.SelectedValue == "1");
            foreach (string key in list)
            {
                UserMap map = (UserMap)tab[key];
                if (string.IsNullOrEmpty(map.webuser)) continue;
                if (map.dbuser != null)
                    if (!staffList.Contains(map.dbuser.ToLower()))
                        continue;
                if (bFilter && !map.webuser.ToLower().StartsWith(tbFilter.Text.ToLower().Replace("*", "")))
                    continue;

                TableRow row = new TableRow();
                row.ID = "r_" + count;
                row.Attributes["onclick"] = "sR(this)";
                row.Attributes["err"] = map.errormode;
                row.Attributes["pswa"] = map.adminpass;
                row.Attributes["pswu"] = map.webpass;
                row.Attributes["comm"] = map.comm;
                row.Attributes["block"] = map.blocked;
                row.CssClass = "rs";

                cell = new TableCell();
                cell.ID = "c_web_" + count;
                cell.Text = map.webuser;
                if (map.blocked == "1")
                    cell.CssClass = "cwb";
                else
                    cell.CssClass = "cw";
                row.Cells.Add(cell);

                cell = new TableCell();
                cell.ID = "c_db_" + count;
                cell.Text = map.dbuser;
                cell.CssClass = "cd";
                row.Cells.Add(cell);

                tbl.Controls.Add(row);
                count++;
            }
            mapUsers.Controls.Add(tbl);
        }

        private void UpdateUserXml(string webuser)
        {
            bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "Off") ? (false) : (true);
            XmlDocument doc = ConfigurationSettings.UserMapConfiguration;

            XmlNode section = doc.SelectSingleNode("//userMapSettings");
            string userPass = string.Empty;
            string adminPass = string.Empty;
            if (secEnabled)
            {
                adminPass = adminpass.Value;
                if (string.IsNullOrEmpty(adminPass))
                    userPass = webpass.Value;
            }
            else
            {
                userPass = adminpass.Value;
                if (string.IsNullOrEmpty(userPass))
                    userPass = webpass.Value;
            }
            // Обновление
            if (ConfigurationSettings.UserMapSettings[webuser] != null)
            {
                XmlNode node = doc.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
                if (node != null)
                {
                    node.Attributes["dbuser"].Value = dbuser.Text.Trim();
                    node.Attributes["errormode"].Value = errormode.Text.Trim();
                    node.Attributes["adminpass"].Value = adminPass;
                    node.Attributes["webpass"].Value = userPass;
                    node.Attributes["comm"].Value = comm.Text.Trim();
                    node.Attributes["blocked"].Value = hStatus.Value;
                    node.Attributes["attemps"].Value = "0";
                }
            }
            // Вставка
            else
            {
                XmlNode node = section.ChildNodes[0].Clone();
                node.Attributes["webuser"].Value = webuser;
                node.Attributes["dbuser"].Value = dbuser.Text.Trim();
                node.Attributes["errormode"].Value = errormode.Text.Trim();
                node.Attributes["adminpass"].Value = adminPass;
                node.Attributes["webpass"].Value = userPass;
                node.Attributes["comm"].Value = comm.Text.Trim();
                node.Attributes["blocked"].Value = "0";
                node.Attributes["attemps"].Value = "0";
                node.Attributes["chgdate"].Value = "";
                section.AppendChild(node);
            }
            ConfigurationSettings.SaveXmlConfiguration(doc, 2);
        }

        private void DeleteUserXml(string webuser)
        {
            XmlDocument doc = ConfigurationSettings.UserMapConfiguration;
            XmlNode section = doc.SelectSingleNode("//userMapSettings");
            XmlNode userSection = doc.SelectSingleNode("//userMapSettings//map[attribute::webuser='" + webuser + "']");
            if (userSection.Attributes.Count > 0)
            {
                section.RemoveChild(userSection);
            }
            ConfigurationSettings.SaveXmlConfiguration(doc, 2);
        }

        private void DeleteUserDB(string webuser)
        {
            InitOraConnection();
            try
            {
                SetRole("WR_ADMIN");
                SetParameters("webuser", DB_TYPE.Varchar2, webuser, DIRECTION.Input);

                SQL_PROCEDURE("bars.web_utl_adm.drop_webuser");
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        private void UpdateUserDB(string webuser)
        {
            bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "Off") ? (false) : (true);
            InitOraConnection();
            try
            {
                string userPass = string.Empty;
                string adminPass = string.Empty;
                if (secEnabled)
                {
                    adminPass = adminpass.Value;
                    if (string.IsNullOrEmpty(adminPass))
                        userPass = webpass.Value;
                }
                else
                {
                    userPass = adminpass.Value;
                    if (string.IsNullOrEmpty(userPass))
                        userPass = webpass.Value;
                }

                SetRole("WR_ADMIN");
                SetParameters("webuser", DB_TYPE.Varchar2, webuser, DIRECTION.Input);
                SetParameters("dbuser", DB_TYPE.Varchar2, dbuser.Text, DIRECTION.Input);
                SetParameters("webpass", DB_TYPE.Varchar2, userPass, DIRECTION.Input);
                SetParameters("blocked", DB_TYPE.Varchar2, hStatus.Value, DIRECTION.Input);
                SetParameters("errmode", DB_TYPE.Varchar2, errormode.Text, DIRECTION.Input);
                SetParameters("adminpass", DB_TYPE.Varchar2, adminPass, DIRECTION.Input);
                SetParameters("comm", DB_TYPE.Varchar2, comm.Text, DIRECTION.Input);

                SQL_PROCEDURE("bars.web_utl_adm.set_webuser");
            }
            finally
            {
                DisposeOraConnection();
            }
            ConfigurationSettings.RefreshUserInfo(webuser);
        }

        protected void btDelete_Click(object sender, EventArgs e)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                DeleteUserDB(webuser.Text.Trim().ToLower());
            }
            else
            {
                DeleteUserXml(webuser.Text.Trim().ToLower());
            }
            webuser.Text = string.Empty;
            dbuser.Text = string.Empty;
            errormode.Text = string.Empty;
            adminpass.Value = string.Empty;
            comm.Text = string.Empty;
            ConfigurationSettings.RefreshUserMap();
            FillData();
        }

        protected void btUpdate_ServerClick(object sender, EventArgs e)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                UpdateUserDB(webuser.Text.Trim().ToLower());
            }
            else
            {
                UpdateUserXml(webuser.Text.Trim().ToLower());
            }
            FillData();
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {

        }
        #endregion

        protected void btBlock_Click(object sender, EventArgs e)
        {
            hStatus.Value = (hStatus.Value == "0") ? ("1") : ("0");
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
            {
                
                UpdateUserDB(webuser.Text.Trim().ToLower());
            }
            else
            {
                UpdateUserXml(webuser.Text.Trim().ToLower());
            }
            FillData();
        }
        protected void spWebUser_Click(object sender, EventArgs e)
        {
            _sortDesc = !_sortDesc;
            _sortDBUser = false;
            FillData();
        }
       
        protected void btFilter_Click(object sender, EventArgs e)
        {
            FillData();
        }
        
        protected void btRefresh_Click(object sender, EventArgs e)
        {
            ConfigurationSettings.RefreshUserMap();
            FillData();
        }
}
}
