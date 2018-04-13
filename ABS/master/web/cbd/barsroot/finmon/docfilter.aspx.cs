using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;
using Bars.UserControls;
using Bars.Oracle;
using Bars.Classes;
using System.Web.Services;


public partial class finmon_docfilter : Bars.BarsPage
{
    private void FillData()
    {
        odsRules.DataBind();
        gvRules.DataBind();
    }

    protected void Init()
    {
        if (!String.IsNullOrEmpty(Session["Finmon_Rules"] as string))
        {
            tbRules.Value = Session["Finmon_Rules"].ToString();

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        gvRules.AutoGenerateCheckBoxColumn = true;
        gvRules.ShowFooter = false;
        gvRules.ShowPageSizeBox = false;

        if (!IsPostBack)
        {
            if (null != Session["FinmonDat1"] && null != Session["FinmonDat1"])
            {
                diDat1.SelectedDate = Convert.ToDateTime(Session["FinmonDat1"].ToString().Substring(0, 10).Replace("/", "."));
                diDat2.SelectedDate = Convert.ToDateTime(Session["FinmonDat2"].ToString().Substring(0, 10).Replace("/", "."));
            }
            else
            {
                getbdate();
            }
        }

        FillGrid();
        Init();
    }

    private void FillGrid()
    {

        odsRules.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsRules.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsRules.SelectParameters.Clear();
        odsRules.WhereParameters.Clear();

        String selectCommand = "SELECT  ID, NAME FROM fm_rules order by id";

        odsRules.SelectCommand = selectCommand;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void getbdate()
    {
        string yestr;
        InitOraConnection();
        try
        {
            yestr = SQL_SELECT_list("select to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd/mm/yyyy') from dual");

            string count = SQL_SELECT_list("SELECT count(*) FROM fm_rules");
            int length = count.Length;

            RulesCount.Value = count.Substring(0, length - 1);

            diDat1.SelectedDate = Convert.ToDateTime(yestr.Substring(0, 10));
            diDat2.SelectedDate = Convert.ToDateTime(yestr.Substring(0, 10));

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void btSearch_Click(object sender, EventArgs e)
    {
        string p_rules = null;
        string p_status = null;
        int count = 0;
        foreach (int row in gvRules.GetSelectedIndices())
        {
            p_rules += gvRules.DataKeys[row]["ID"].ToString() + ",";
            p_status += gvRules.DataKeys[row]["NAME"].ToString();
            count += 1;
        }
        Session["FinminReload"] = "1";
        Session["Finmon_Rules"] = p_rules;

        if (count == 0)
        {
            Session["FinmonSelectedStatus"] = "Період відбору документів з " + diDat1.SelectedDate.ToString().Substring(0, 10).Replace("/", ".") + " по " + diDat2.SelectedDate.ToString().Substring(0, 10).Replace("/", ".");
        }
        else if (count == 1)
        {
            Session["FinmonSelectedStatus"] = "Період відбору документів з " + diDat1.SelectedDate.ToString().Substring(0, 10).Replace("/", ".") + " по " + diDat2.SelectedDate.ToString().Substring(0, 10).Replace("/", ".") + " та правило " + p_status;
        }
        else
        {
            int x = p_rules.Length;
            Session["FinmonSelectedStatus"] = "Період відбору документів з " + diDat1.SelectedDate.ToString().Substring(0, 10).Replace("/", ".") + " по " + diDat2.SelectedDate.ToString().Substring(0, 10).Replace("/", ".") + " та правила ФМ " + p_rules.Substring(0, x - 1);
        }


        if (null != p_rules)
        {
            InitOraConnection();

            try
            {
                ClearParameters();
                SetParameters("p_dat1", DB_TYPE.Date, diDat1.SelectedDate, DIRECTION.Input);
                SetParameters("p_dat2", DB_TYPE.Date, diDat2.SelectedDate, DIRECTION.Input);
                SetParameters("p_rules", DB_TYPE.Varchar2, p_rules, DIRECTION.Input);
                SQL_NONQUERY("begin p_fm_checkrules(:p_dat1 ,:p_dat2,:p_rules); end;");
            }

            finally
            {
                DisposeOraConnection();
            }
            Session["selectParam"] = 1;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "close", " window.close('this');", true);
        }
        else
        {
            Session["selectParam"] = "0";
        }
        Session["FinmonDat1"] = diDat1.SelectedDate;
        Session["FinmonDat2"] = diDat2.SelectedDate;
    }

}