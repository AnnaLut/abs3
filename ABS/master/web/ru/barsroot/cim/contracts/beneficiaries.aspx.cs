using Bars.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cim_contracts_beneficiaries : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsCountries.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }

    protected void gvVCimBeneficiaries_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        fvBeneficiar.ChangeMode(FormViewMode.Edit);
    }
    protected void btSave_Click(object sender, EventArgs e)
    {

    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        fvBeneficiar.ChangeMode(FormViewMode.ReadOnly);
    }
    protected void fvBeneficiar_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.Cancel = true;
        divMsg.InnerText = "";
        gvVCimBeneficiaries.EditIndex = -1;
        string benefId = Convert.ToString(e.Keys[0]);
        string benefName = ((TextBox)fvBeneficiar.FindControl("tbBENEF_NAME")).Text;
        string countyId = ((DropDownList)fvBeneficiar.FindControl("ddCOUNTRY")).SelectedValue;
        string benefAdr = ((TextBox)fvBeneficiar.FindControl("tbAddr")).Text;
        string benefComments = ((TextBox)fvBeneficiar.FindControl("tbComments")).Text;

        try
        {
            InitOraConnection();
            SetParameters("p_benef_id", DB_TYPE.Decimal, benefId, DIRECTION.Input);
            SetParameters("p_benef_name", DB_TYPE.Varchar2, benefName, DIRECTION.Input);
            SetParameters("p_country_id", DB_TYPE.Decimal, countyId, DIRECTION.Input);
            SetParameters("p_adr", DB_TYPE.Varchar2, benefAdr, DIRECTION.Input);
            SetParameters("p_comments", DB_TYPE.Varchar2, benefComments, DIRECTION.Input);

            SQL_PROCEDURE("cim_mgr.update_beneficiary");

            gvVCimBeneficiaries.SelectedIndex = -1;
            gvVCimBeneficiaries.DataBind();
            fvBeneficiar.ChangeMode(FormViewMode.ReadOnly);
            divMsg.InnerText = string.Empty;
        }
        catch (Exception ex)
        {
            divMsg.InnerText = ex.Message;
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btAddNew_Click(object sender, EventArgs e)
    {
        fvBeneficiar.ChangeMode(FormViewMode.Insert);
        gvVCimBeneficiaries.SelectedIndex = -1;
    }
    protected void gvVCimBeneficiaries_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        gvVCimBeneficiaries.EditIndex = -1;
        string benef_id = Convert.ToString(e.Keys[0]);
        string deleteDate = Convert.ToString(e.Keys[1]);
        try
        {
            InitOraConnection();

            SetParameters("benef_id", DB_TYPE.Decimal, benef_id, DIRECTION.Input);
            if (string.IsNullOrEmpty(deleteDate))
                SQL_NONQUERY("update cim_beneficiaries set delete_date=sysdate where benef_id=:benef_id");
            else
                SQL_NONQUERY("update cim_beneficiaries set delete_date=null where benef_id=:benef_id");

            gvVCimBeneficiaries.DataBind();
            divMsg.InnerText = string.Empty;
            fvBeneficiar.ChangeMode(FormViewMode.ReadOnly);
        }
        catch (Exception ex)
        {
            divMsg.InnerText = ex.Message;
        }
        finally
        {
            DisposeOraConnection();
        }

    }
    protected void fvBeneficiar_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Cancel = true;
        divMsg.InnerText = "";
        gvVCimBeneficiaries.EditIndex = -1;
        string benefName = ((TextBox)fvBeneficiar.FindControl("tbBENEF_NAME")).Text;
        string countyId = ((DropDownList)fvBeneficiar.FindControl("ddCOUNTRY")).SelectedValue;
        string benefAdr = ((TextBox)fvBeneficiar.FindControl("tbAddr")).Text;
        string benefComments = ((TextBox)fvBeneficiar.FindControl("tbComments")).Text;

        try
        {
            InitOraConnection();
            SetParameters("p_benef_name", DB_TYPE.Varchar2, benefName, DIRECTION.Input);
            SetParameters("p_country_id", DB_TYPE.Decimal, countyId, DIRECTION.Input);
            SetParameters("p_adr", DB_TYPE.Varchar2, benefAdr, DIRECTION.Input);
            SetParameters("p_comments", DB_TYPE.Varchar2, benefComments, DIRECTION.Input);

            SQL_PROCEDURE("cim_mgr.create_beneficiary");

            gvVCimBeneficiaries.SelectedIndex = -1;
            gvVCimBeneficiaries.DataBind();
            fvBeneficiar.ChangeMode(FormViewMode.ReadOnly);
            divMsg.InnerText = string.Empty;
        }
        catch (Exception ex)
        {
            divMsg.InnerText = ex.Message;
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void gvVCimBeneficiaries_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton imgDel = (ImageButton)e.Row.Cells[1].Controls[1];

            if (e.Row.Cells[7].Text.Replace("&nbsp;", "").Trim().Equals(""))
                imgDel.Attributes["onclick"] = "return confirm('Видалити вказаного бенефіціара?')";
            else
            {
                imgDel.ImageUrl = "/Common/Images/default/16/arrow_left.png";
                imgDel.ToolTip = "Відновити бенефіціара";
                imgDel.Attributes["onclick"] = "return confirm('Відновити видаленого бенефіціара ?')";
            }

        }
    }
}