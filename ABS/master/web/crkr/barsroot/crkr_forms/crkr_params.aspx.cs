using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Linq;
using Bars.Classes;
using Bars.CRKR;
using ibank.core;

public partial class crkr_params : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            populateDdlParTypes();
            Calendar1.Visible = false;
           
            Session["SELECT_PARAM_TYPE"] = null;
            Session["SELECT_PARAM"] = null;
            Session["SELECT_DATE"] = null;
            Session["SELECT_STATUS"] = null;

            if ("2" == Request["type_id"] || "1" == Request["type_id"])
            {
                setState(Request["type_id"].ToString(), Request["param"].ToString(), Request["dat"].ToString(), Request["status"].ToString());
            }
            else
            {
                populateDdlParams(1);
            }
        }
        gvParams.DataBind();
    }

    protected void SetSesion()
    {
        Session["SELECT_PARAM_TYPE"] = ddlParTypes.SelectedValue;
        Session["SELECT_PARAM"] = ddlParams.SelectedValue;

        if (deOnDate.Text == "")
            Session["SELECT_DATE"] = DateTime.MinValue.ToShortDateString();
        else
            Session["SELECT_DATE"] = deOnDate.Text;

        Session["SELECT_STATUS"] = ddlIsEnable.SelectedValue;
    }

    protected void setState(string type_id, string param, string dat, string status)
    {
        populateDdlParams(Convert.ToDecimal(type_id));
        ddlParTypes.SelectedValue = type_id;
        ddlParams.SelectedValue = param;
        deOnDate.Text = dat;
        ddlIsEnable.SelectedValue = status;
    }

    protected void btFind_Click(object sender, EventArgs e)
    {
        SetSesion();

    }

    protected void populateDdlParTypes()
    {
        IList<CompenParamTypesRecord> res = null;

        BbConnection connection = new BbConnection();
        connection.InitConnection();
        try
        {
            CompenParamTypes table = new CompenParamTypes(connection);
            res = table.Select();
        }
        finally
        {
            connection.CloseConnection();
        }

        ddlParTypes.Items.Clear();

        foreach (CompenParamTypesRecord item in res)
        {
            ListItem l = new ListItem();

            l.Text = item.DISCRIPTION;
            l.Value = item.ID.ToString();
            ddlParTypes.Items.Add(l);
        }
    }

    protected void populateDdlParams(decimal type_id)
    {
        IList<CompenParamsRecord> res = null;

        BbConnection connection = new BbConnection();
        connection.InitConnection();
        try
        {
            CompenParams table = new CompenParams(connection);
            table.Filter.TYPE.Equal(type_id);
            res = table.Select();
        }
        finally
        {
            connection.CloseConnection();
        }

        ddlParams.Items.Clear();

        int indx = 0;
        foreach (CompenParamsRecord item in res)
        {
            ListItem l = new ListItem();

            if (indx == 0)
            {
                ListItem n = new ListItem();
                n.Text = "";
                n.Value = "";
                ddlParams.Items.Add(n);
            }

            indx += 1;

            l.Text = item.DISCRIPTION;
            l.Value = item.PAR.ToString();
            ddlParams.Items.Add(l);
        }
    }

    protected void ddlParTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetSesion();
        if (ddlParTypes.SelectedValue == "1")
        {
            lbGvTitle.Text = "Ліміти";
        }

        if (ddlParTypes.SelectedValue == "2")
        {
            lbGvTitle.Text = "Параметри";
        }

        populateDdlParams(Convert.ToDecimal(ddlParTypes.SelectedValue));
    }

    protected void gvParams_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void odsParams_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["TYPE"] = ddlParTypes.SelectedValue;
        e.InputParameters["PAR"] = ddlParams.SelectedValue;
        e.InputParameters["DAT"] = deOnDate.Text;
        e.InputParameters["STATUS"] = ddlIsEnable.SelectedValue.ToString();
    }
    protected void tbAdd_Click(object sender, EventArgs e)
    {
        SetSesion();
        Response.Redirect("/barsroot/crkr_forms/add_or_edit_params.aspx?id=0", true);

    }
    protected void btEdit_Click(object sender, EventArgs e)
    {
        SetSesion();
        decimal id = 0;
        decimal? is_enable = null;

        if (gvParams.SelectedRows.Count != 0)
        {
            if (Convert.ToString(gvParams.DataKeys[gvParams.SelectedRows[0]].Value) != null)
            {

                if (gvParams.DataKeys[gvParams.SelectedRows[0]]["ID"].ToString().Length > 0)
                {
                    id = Convert.ToDecimal(gvParams.DataKeys[gvParams.SelectedRows[0]]["ID"]);
                    is_enable = Convert.ToDecimal(gvParams.DataKeys[gvParams.SelectedRows[0]]["IS_ENABLE"]);
                }

                if (is_enable == 1)
                {

                    Server.Transfer("/barsroot/crkr_forms/add_or_edit_params.aspx?id=" + id, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Ліміт не діє, додайте новий ліміт');", true);
                }
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "editParam('" + id + "');", true);
                //  ScriptManager.RegisterStartupScript(this, this.GetType(), "open", " window.open('/barsroot/crkr_forms/add_or_edit_params.aspx?id=" + id +"');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }

    protected void ShowCalendar_Click(object sender, EventArgs e)
    {
        Calendar1.Visible = (Calendar1.Visible == true ) ? false : true;
    }



    protected void ClearDate_Click(object sender, EventArgs e)
    {
        deOnDate.Text = "";
        Calendar1.SelectedDate = DateTime.Today;
    }
    protected void DateChange(object sender, EventArgs e)
    {
        deOnDate.Text = Calendar1.SelectedDate.ToShortDateString();
        Calendar1.Visible = false;
    }
}