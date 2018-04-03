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
using Bars.Classes;

public partial class ussr_PouredInTOBO : Bars.BarsPage
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        sdsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsChilds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void gvMain_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected override void OnPreRender(EventArgs e)
    {
        bool bShowAdd = (gvMain.SelectedValue != null);

        trAddTitle.Visible = bShowAdd;
        trAdd.Visible = bShowAdd;

        // =================
        sdsChilds.SelectCommand = "select * from ussr_pouredintobo where branch_parent = '" + (gvMain.SelectedValue != null ? gvMain.SelectedValue.ToString() : "") + "'";
    }

    protected void btAdd_Click(object sender, EventArgs e)
    {
        string sNum = edNum.Text.Trim();
        string sName = edName.Text.Trim();
        string sParentBranch = gvMain.SelectedValue.ToString();

        bool bHasErr = false;
        string sErrText = "";

        InitOraConnection();
        try
        {
            SetRole("WR_USSR_TECH");

            ClearParameters();
            SetParameters("sNum", DB_TYPE.Varchar2, sNum, DIRECTION.Input);
            if (Convert.ToInt32(SQL_SELECT_scalar("select count(*) from alegrob where num = :sNum")) > 0)
            {
                bHasErr = true;
                sErrText += "Вказаний Ідентифікатор вже міститься у довідніку Alegrob. ";
            }
            if (Convert.ToInt32(SQL_SELECT_scalar("select count(*) from ussr_pouredintobo where num = :sNum")) > 0)
            {
                bHasErr = true;
                sErrText += "Вказаний Ідентифікатор вже було додано. ";
            }
            
            /* Доработать!!!!!
            if (Convert.ToInt32(SQL_SELECT_scalar("select count(*) from alegrob where mod_num = f_mod_num2(:sNum)")))
            {
                bHasErr = true;
                sErrText = "Вказаний Ідентифікатор вже міститься у довідніку Alegrob. \n";
            }
            if (Convert.ToInt32(SQL_SELECT_scalar("select count(*) from ussr_pouredintobo where num = :sNum")))
            {
                bHasErr = true;
                sErrText = "Вказаний Ідентифікатор вже було додано. \n";
            }*/

            if (!bHasErr)
            {
                ClearParameters();
                SetParameters("sNum", DB_TYPE.Varchar2, sNum, DIRECTION.Input);
                SetParameters("sName", DB_TYPE.Varchar2, sName, DIRECTION.Input);
                SetParameters("sParentBranch", DB_TYPE.Varchar2, sParentBranch, DIRECTION.Input);
                SQL_NONQUERY("insert into ussr_pouredintobo (num, name, branch_parent) values (:sNum, :sName, :sParentBranch)");
            }
        }
        finally
        {
            DisposeOraConnection();
        }

        if (bHasErr)
        {
            Response.Write("<script>alert('" + sErrText + "');</script>");
            edName.Text = "";
            edNum.Text = "";
        }
    }
}
