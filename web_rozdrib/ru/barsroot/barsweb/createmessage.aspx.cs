using System;
using System.Data;
using System.Collections;
using System.Web;
using barsroot.core;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Configuration;
using System.Messaging;

public partial class barsweb_createmessage : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ActiveUsers"] == null)
            Session["ActiveUsers"] = initUsersList();
        listUsers.Items.AddRange((ListItem[])Session["ActiveUsers"]);

        cbAll.Attributes["onclick"] = "selectAll()";
        btSend.Attributes["onclick"] = "return validateForm();";
    }

    private ListItem[] initUsersList()
    {
        ArrayList staffList = new ArrayList();
        try
        {
            InitOraConnection();
            SetRole("basic_info");
            SQL_Reader_Exec("select logname from staff where tobo like decode(tobopack.gettobo,0,'%',tobopack.gettobo)");
            while (SQL_Reader_Read())
            {
                staffList.Add(SQL_Reader_GetValues()[0].ToString().ToLower().Trim());
            }
            SQL_Reader_Close();
            Hashtable usersInfo = ConfigurationSettings.UserMapSettings;
            ArrayList activeList = new ArrayList();
            foreach (string key in usersInfo.Keys)
            {
                UserMap map = (UserMap)usersInfo[key];
                string dbUser = map.dbuser.ToUpper();
                if (!staffList.Contains(map.dbuser.ToLower()))
                    continue;
                ListItem li = new ListItem(dbUser + "(" + map.comm + ")", dbUser);
                li.Attributes["onclick"] = "addUser(this,'" + dbUser + "')";
                activeList.Add(li);
            }
            ListItem[] res = new ListItem[activeList.Count];
            int i = 0;
            foreach (ListItem item in activeList)
                res[i++] = item;
            return res;
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btSend_Click(object sender, EventArgs e)
    {
        Message msg = new Message();
        msg.Body = tbMessage.Text;
        msg.Label = Context.User.Identity.Name;
        double span = Convert.ToDouble(tbLifeTime.Text);
        TimeSpan lifeTime = TimeSpan.MinValue;
        switch(ddTerm.SelectedValue)
        {
            case "0": lifeTime = TimeSpan.FromMinutes(span); break;
            case "1": lifeTime = TimeSpan.FromHours(span); break;
            case "2": lifeTime = TimeSpan.FromDays(span); break;
            case "3": lifeTime = TimeSpan.FromDays(span*30); break;
            default: lifeTime = TimeSpan.MaxValue; break;
        }
        msg.TimeToBeReceived = lifeTime;
        BarsMessaging.CreateMessage(tbUsers.Text, msg, cbAdmin.Checked);
    }
}
