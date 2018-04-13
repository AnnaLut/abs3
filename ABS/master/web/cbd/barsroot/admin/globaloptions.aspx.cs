using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Configuration;
using System.Xml;

namespace BarsWeb.Admin
{
    public partial class GlobalOptions : Bars.BarsPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                FillData();   
        }
        private void FillData()
        {
            tbPswLength.Text = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.MinLength"];
            tbPswExp.Text = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.Expiration"];
            tbSeqLength.Text = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.MaxSeq"];
            tbPswAttempts.Text = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Password.Attempts"];
            tbCookieTime.Text = Bars.Configuration.ConfigurationSettings.AppSettings["CustomAuthentication.Session.Expiration"];
        }

        private void UpdateXml()
        {
            XmlDocument doc = Bars.Configuration.ConfigurationSettings.ConfigurationDocument;
            XmlNode section = doc.SelectSingleNode("//appSettings//add[attribute::key='CustomAuthentication.Password.MinLength']");
			if(section.Attributes.Count == 0) return;
			section.Attributes["value"].Value = tbPswLength.Text;

            section = doc.SelectSingleNode("//appSettings//add[attribute::key='CustomAuthentication.Password.Expiration']");
            if (section.Attributes.Count == 0) return;
            section.Attributes["value"].Value = tbPswExp.Text;

            section = doc.SelectSingleNode("//appSettings//add[attribute::key='CustomAuthentication.Password.MaxSeq']");
            if (section.Attributes.Count == 0) return;
            section.Attributes["value"].Value = tbSeqLength.Text;

            section = doc.SelectSingleNode("//appSettings//add[attribute::key='CustomAuthentication.Password.Attempts']");
            if (section.Attributes.Count == 0) return;
            section.Attributes["value"].Value = tbPswAttempts.Text;

            section = doc.SelectSingleNode("//appSettings//add[attribute::key='CustomAuthentication.Session.Expiration']");
            if (section.Attributes.Count == 0) return;
            section.Attributes["value"].Value = tbCookieTime.Text;

            Bars.Configuration.ConfigurationSettings.SaveXmlConfiguration(doc, 1);
            AppDomain.CurrentDomain.SetData("appSettings", null);
        }

        protected void btSave_Click(object sender, EventArgs e)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ConfigInDB"] == "On")
                UpdateDB();
            else
                UpdateXml();
            Bars.Configuration.ConfigurationSettings.RefreshBarsConfig();
            FillData(); 
        }

        private void UpdateDB()
        {
            InitOraConnection();
            try
            {
                SetRole("WR_ADMIN");

                SetParameters("type_name", DB_TYPE.Varchar2, "appSettings", DIRECTION.Input);
                SetParameters("key", DB_TYPE.Varchar2, "CustomAuthentication.Password.MinLength", DIRECTION.Input);
                SetParameters("val", DB_TYPE.Varchar2, tbPswLength.Text, DIRECTION.Input);
                SQL_PROCEDURE("bars.web_utl_adm.set_configparam");

                ClearParameters();
                SetParameters("type_name", DB_TYPE.Varchar2, "appSettings", DIRECTION.Input);
                SetParameters("key", DB_TYPE.Varchar2, "CustomAuthentication.Password.Expiration", DIRECTION.Input);
                SetParameters("val", DB_TYPE.Varchar2, tbPswExp.Text, DIRECTION.Input);
                SQL_PROCEDURE("bars.web_utl_adm.set_configparam");

                ClearParameters();
                SetParameters("type_name", DB_TYPE.Varchar2, "appSettings", DIRECTION.Input);
                SetParameters("key", DB_TYPE.Varchar2, "CustomAuthentication.Password.MaxSeq", DIRECTION.Input);
                SetParameters("val", DB_TYPE.Varchar2, tbSeqLength.Text, DIRECTION.Input);
                SQL_PROCEDURE("bars.web_utl_adm.set_configparam");

                ClearParameters();
                SetParameters("type_name", DB_TYPE.Varchar2, "appSettings", DIRECTION.Input);
                SetParameters("key", DB_TYPE.Varchar2, "CustomAuthentication.Password.Attempts", DIRECTION.Input);
                SetParameters("val", DB_TYPE.Varchar2, tbPswAttempts.Text, DIRECTION.Input);
                SQL_PROCEDURE("bars.web_utl_adm.set_configparam");

                ClearParameters();
                SetParameters("type_name", DB_TYPE.Varchar2, "appSettings", DIRECTION.Input);
                SetParameters("key", DB_TYPE.Varchar2, "CustomAuthentication.Session.Expiration", DIRECTION.Input);
                SetParameters("val", DB_TYPE.Varchar2, tbCookieTime.Text, DIRECTION.Input);
                SQL_PROCEDURE("bars.web_utl_adm.set_configparam");
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        protected void btRefresh_Click(object sender, EventArgs e)
        {
            Bars.Configuration.ConfigurationSettings.RefreshBarsConfig();
            FillData(); 
        }
        protected void btGC_Click(object sender, EventArgs e)
        {
            GC.Collect();
            GC.WaitForPendingFinalizers();
            GC.Collect();
        }
}
}
