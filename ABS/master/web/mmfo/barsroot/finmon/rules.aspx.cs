using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;

public partial class rules : Bars.BarsPage
{
    public string RULE_ID
    {
        get
        {
            if (Request["rule_id"] != "") {
                return Request["rule_id"].ToString();
            }

            if (Session["rule_id"] != null) { 
                var tmp =  Session["rule_id"].ToString();
                return tmp;
            }
            else
                return "";
        }
    }

    private void FillData()
    {
        odsRules.DataBind();
        gvRules.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvRules.AutoGenerateCheckBoxColumn = true;
        gvRules.ShowFooter = false;
        gvRules.ShowPageSizeBox = false;

        FillGrid();
    }

    private void FillGrid()
    {

        odsRules.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsRules.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsRules.SelectParameters.Clear();
        odsRules.WhereParameters.Clear();

        String selectCommand = string.Format("SELECT  ID, NAME FROM fm_rules where id in ({0}) order by id", RULE_ID);

        odsRules.SelectCommand = selectCommand;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

}