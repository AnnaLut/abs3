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

public partial class admin_operateuserdata : Bars.BarsPage
{
    /// <summary>
    /// Тукущий юзер
    /// </summary>
    ClassUser oCurUser;

    // ====================================================

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["oCurUser"] == null)
        {
            int nUserId = Convert.ToInt32(Request.Params.Get("uid"));

            oCurUser = new ClassUser(nUserId);
            Session["oCurUser"] = oCurUser;
        }
        else
        {
            oCurUser = (ClassUser)Session["oCurUser"];
        }

        string sPswd = (edPassword.Attributes["value"] != null) ? (edPassword.Attributes["value"]) : ("");
        if (sPswd == "" && edPassword.Text.Trim() != "") sPswd = edPassword.Text.Trim();
        edPassword.Attributes.Add("value", sPswd);

        string sPswdCfm = (edPasswordConfirm.Attributes["value"] != null) ? (edPasswordConfirm.Attributes["value"]) : ("");
        if (sPswdCfm == "" && edPasswordConfirm.Text.Trim() != "") sPswdCfm = edPasswordConfirm.Text.Trim();
        edPasswordConfirm.Attributes.Add("value", sPswdCfm);
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        // Заполнение формы
        if (!IsPostBack)
        {
            edFIO.Text = oCurUser.sFIO;
            edLogin.Text = oCurUser.sLogin;
            edTabN.Text = oCurUser.sTabN;

            if (!oCurUser.bIsNewUser)
            {
                edLogin.Enabled = false;
                edPassword.Enabled = false;
                edPasswordConfirm.Enabled = false;

                edPassword.Attributes["value"] = "qwerty";
                edPasswordConfirm.Attributes["value"] = "qwerty";
            }
            else
            {
                edLogin.Enabled = true;
                edPassword.Enabled = true;
                edPasswordConfirm.Enabled = true;
            }

            oCurUser.FillUserTypes(ddlUserType);
            oCurUser.FillDeps(ddlDep);
        }

        lbxGrantedARMs.DataSource = oCurUser.licGrantedARMs;
        lbxGrantedARMs.DataBind();
        ddlAvailableARMs.DataSource = oCurUser.licAvailableARMs;
        ddlAvailableARMs.DataBind();

        lbxGrantedFiles.DataSource = oCurUser.licGrantedFiles;
        lbxGrantedFiles.DataBind();
        ddlAvailableFiles.DataSource = oCurUser.licAvailableFiles;
        ddlAvailableFiles.DataBind();

        lbxGrantedDocs.DataSource = oCurUser.licGrantedDocs;
        lbxGrantedDocs.DataBind();
        ddlAvailableDocs.DataSource = oCurUser.licAvailableDocs;
        ddlAvailableDocs.DataBind();
    }
    protected void imgARMAdd_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlAvailableARMs.SelectedIndex >= 0)
            oCurUser.AddARM(ddlAvailableARMs.SelectedValue);
    }
    protected void imgARMDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (lbxGrantedARMs.SelectedIndex >= 0)
            oCurUser.DeleteARM(lbxGrantedARMs.SelectedValue);
    }
    protected void imgFileAdd_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlAvailableFiles.SelectedIndex >= 0)
            oCurUser.AddFile(Convert.ToInt32(ddlAvailableFiles.SelectedValue));
    }
    protected void imgFileDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (lbxGrantedFiles.SelectedIndex >= 0)
            oCurUser.DeleteFile(Convert.ToInt32(lbxGrantedFiles.SelectedValue));
    }
    protected void imgDocAdd_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlAvailableDocs.SelectedIndex >= 0)
            oCurUser.AddDoc(Convert.ToInt32(ddlAvailableDocs.SelectedValue));
    }
    protected void imgDocDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (lbxGrantedDocs.SelectedIndex >= 0)
            oCurUser.DeleteDoc(Convert.ToInt32(lbxGrantedDocs.SelectedValue));
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        // перетягиваем данные в класс
        /*try
        {*/
        /*if (edPassword.Enabled == false)
        {
            edPassword.Text = "qwerty";
            edPasswordConfirm.Text = "qwerty";
        }*/

        oCurUser.sFIO = edFIO.Text;
        oCurUser.sLogin = edLogin.Text;
        oCurUser.sTabN = edTabN.Text;
        oCurUser.sPassword = edPassword.Attributes["value"];
        oCurUser.sPasswordConfirm = edPasswordConfirm.Attributes["value"];
        oCurUser.nType = Convert.ToDecimal(ddlUserType.SelectedValue);
        oCurUser.sDep = ddlDep.SelectedValue;

        oCurUser.Save();
        /*}
         catch
         {
             //!!!! обработать возможные ошибки
         }*/
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("operateusers.aspx");
    }
}
