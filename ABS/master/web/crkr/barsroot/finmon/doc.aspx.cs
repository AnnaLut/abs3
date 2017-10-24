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

public partial class finmon_doc : Bars.BarsPage
{
    string Ref = null;
    string ID = null;
    decimal? otm;

    private void FillData()
    {
        odsFmDocs.DataBind();
        gvFmDocs.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string yestr;
            InitOraConnection();
            try
            {
                yestr = SQL_SELECT_list("select to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd/mm/yyyy') from dual");

            }
            finally
            {
                DisposeOraConnection();
            }
            
            lbDat.Text = "Період відбору документів з " + yestr.ToString().Substring(0, 10).Replace("/", ".") + " по " + yestr.ToString().Substring(0, 10).Replace("/", ".");


            if (null != Session["selectParam".ToString()])
            {
                string ppp = Session["selectParam"].ToString();

                Session["selectParam"] = "0";
            }
            Session["FinmonDat1"] = null;
            Session["FinmonDat1"] = null;
            Session["FinmonStatuses"] = "0";
            Session["FinmonBlockedDocs"] = "0";

            FillGrid();
            FillData();
        }

        if ("1" == Session["FinminReload"])
        {
            FillData();

            Session["FinminReload"] = "0";
        }

        FillGrid();
    }

    private void FillGrid()
    {
        decimal? selectParam;
        string selectCommand = null;
        string dat1 = "01.01.1500";
        string dat2 = "01.01.1500";
        if (null != Session["FinmonDat1"])
        {
            dat1 = Session["FinmonDat1"].ToString().Substring(0, 10).Replace("/", ".");
        }
        if (null != Session["FinmonDat2"])
        {
            dat2 = Session["FinmonDat2"].ToString().Substring(0, 10).Replace("/", ".");
        }
        selectParam = Convert.ToDecimal(Session["selectParam"]);

        odsFmDocs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        odsFmDocs.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        odsFmDocs.SelectParameters.Clear();
        odsFmDocs.WhereParameters.Clear();


        string status = "";
        if ("0" != Session["FinmonStatuses"].ToString())
        {
            int c = Session["FinmonStatuses"].ToString().Length;
            if (c > 1)
            {
                status = " Статус документів " + Session["FinmonStatuses"].ToString().Substring(0, c - 1).Replace("'", "");
            }
            else
            {
                status = "";
            }
                lbStatus.Text = status;
        }
        else
        {
            lbStatus.Text = "";
        }

        if (selectParam == 1)
        {
            if (dat1 != "01.01.1500")
            {

                tblDat.Visible = true;
                lbDat.Text = Session["FinmonSelectedStatus"].ToString();

            }
            selectCommand = @"select o.id,
                                   o.ref,
                                   o.tt,
                                   o.nd,
                                   to_char(o.datd,'dd.mm.yyyy') datd,
                                   o.nlsa,
                                   o.s/100 s,
                                   o.lcv,
                                   o.mfoa,
                                   o.dk,
                                   o.nlsb,
                                   o.s2/100 s2,
                                   o.lcv2,
                                   o.mfob,
                                   to_char(o.vdat,'dd.mm.yyyy') vdat,
                                   o.nazn,
                                   o.status,
                                   decode(o.otm,0,null,o.otm) otm,
                                   o.tobo,
                                   o.opr_vid2,
                                   o.opr_vid3,
                                   o.fio,
                                   to_char(o.in_date,'dd.mm.yyyy hh:mi:ss') in_date,
                                   o.comments,
                                   t.rules,
                                   s.name status_name,
                                   o.nmka,
                                   o.nmkb
                                 from v_finmon_que_oper o, 
                                   tmp_fm_checkrules t,
                                   finmon_que_status s
                                 where o.ref = t.ref
                                   and t.id = bars.user_id()
                                   and o.status = s.status(+)                
                                 ";
        }

        if (selectParam == 0)
        {
            if (dat1 != "01.01.1500")
            {

                tblDat.Visible = true;
                lbDat.Text = Session["FinmonSelectedStatus"].ToString();

            }
            selectCommand = @"select o.id,
                                   o.ref,
                                   o.tt,
                                   o.nd,
                                   to_char(o.datd,'dd.mm.yyyy') datd,
                                   o.nlsa,
                                   o.s/100 s,
                                   o.lcv,
                                   o.mfoa,
                                   o.dk,
                                   o.nlsb,
                                   o.s2/100 s2,
                                   o.lcv2,
                                   o.mfob,
                                   to_char(o.vdat,'dd.mm.yyyy') vdat,
                                   o.nazn,
                                   o.status,
                                   decode(o.otm,0,null,o.otm) otm,
                                   o.tobo,
                                   o.opr_vid2,
                                   o.opr_vid3,
                                   o.fio,
                                   to_char(o.in_date,'dd.mm.yyyy hh:mi:ss') in_date,
                                   o.comments,
                                   null rules,
                                   s.name status_name,
                                   o.nmka,
                                   o.nmkb
                          from v_finmon_que_oper o, 
                            finmon_que_status s
                           where o.vdat between to_date(decode('" + dat1 + "','01.01.1500',to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd.mm.yyyy'),'" + dat1 + "'),'dd.mm.yy') and to_date(decode('" + dat2 + "','01.01.1500',to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd.mm.yyyy'),'" + dat2 + "'),'dd.mm.yy')";
        }

        string p_status = Session["FinmonStatuses"].ToString(); 

        if ("0" != p_status)
        {
            int x = Session["FinmonStatuses"].ToString().Length;

            string statuses = Session["FinmonStatuses"].ToString().Remove(x - 1);
            
            selectCommand += " and o.status = s.status and o.status in (" + statuses + ")";
        }
        else
        {
            selectCommand += " and o.status = s.status(+)";
        }

        string p_block = Session["FinmonBlockedDocs"].ToString(); 
        if ("0" != p_block)
        {
            selectCommand += " and ( to_number(o.otm) != 0) ";
        }

        odsFmDocs.SelectCommand = selectCommand;
    }


    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "STATUS").ToString() == "T")
            {
                e.Row.Cells[3].Attributes.Add("style", "color:DarkGreen;");
            }

            if (DataBinder.Eval(e.Row.DataItem, "STATUS").ToString() == "I")
            {
                e.Row.Cells[3].Attributes.Add("style", "color:Blue;");
            }

            if (DataBinder.Eval(e.Row.DataItem, "STATUS").ToString() == "S")
            {
                e.Row.Cells[3].Attributes.Add("style", "color:DarkBlue;");
            }
            if (DataBinder.Eval(e.Row.DataItem, "STATUS").ToString() == "R")
            {
                e.Row.Cells[3].Attributes.Add("style", "color:DarkRed;");
            }
            if (DataBinder.Eval(e.Row.DataItem, "STATUS").ToString() == "B")
            {
                e.Row.Cells[3].Attributes.Add("style", "color:DarkGray;");
            }
            if (DataBinder.Eval(e.Row.DataItem, "STATUS").ToString() == "D")
            {
                e.Row.Cells[3].Attributes.Add("style", "color:DarkGray;");
            }
            if (DataBinder.Eval(e.Row.DataItem, "OTM").ToString().Length > 0)
            {
                e.Row.Attributes.Add("style", "background-color:DarkGray;");
            }

        }
    }

    protected void btOpen_Click(object sender, EventArgs e)
    {
        if (gvFmDocs.SelectedRows.Count != 0)
        {

            string Ref = Convert.ToString(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]].Value);
            var md = "window.showModalDialog('/barsroot/documentview/default.aspx?ref=" + Ref + "','document','dialogwidth=800px,dialogheight=650px');";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "document", md, true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }

    }
    protected void btSetStatus_Click(object sender, EventArgs e)
    {
        string p_ref = "";
        int p_count = 0;

        foreach (int row in gvFmDocs.GetSelectedIndices())
        {
            if (String.IsNullOrEmpty(gvFmDocs.DataKeys[row]["STATUS"].ToString()))
            {
                p_count = p_count + 1;
                p_ref += gvFmDocs.DataKeys[row]["REF"].ToString() + "-";
            }
        }

        if (p_count > 0)
        {
            string p_par = p_count + ":" + p_ref;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "statusOpen('" + p_count + ":" + p_ref + "');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка або всі відмічені документи мають статус ``Повідомлено``');", true);
        }
    }

    protected void btSetParams_Click(object sender, EventArgs e)
    {
        if (gvFmDocs.SelectedRows.Count != 0)
        {
            if (Convert.ToString(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]].Value) != null)
            {

                Ref = gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["REF"].ToString();
                ID = gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["ID"].ToString();
                var rnd = DateTime.Now;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "paramsOpen('" + Ref + "','" + ID + "','" + rnd + "');", true);

            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }

    protected void tbRefTerorists_Click(object sender, EventArgs e)
    {
        if (gvFmDocs.SelectedRows.Count != 0)
        {
            if (Convert.ToString(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]].Value) != null)
            {

                if (gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["OTM"].ToString().Length > 0)
                {
                    otm = Convert.ToDecimal(gvFmDocs.DataKeys[gvFmDocs.SelectedRows[0]]["OTM"]);
                }
                else
                {
                    otm = 0;
                }

                if (otm != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "RefTeroristsOpen('" + otm + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "alert('Немає даних для відображення.');", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодного радка');", true);
        }
    }


    protected void ibtRulesFilter_Click(object sender, EventArgs e)
    {
        var rnd = DateTime.Now;

        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "filterOpen('" + rnd + "');", true);

    }
    protected void ibStatusFilter_Click(object sender, EventArgs e)
    {
        var rnd = DateTime.Now;

        ScriptManager.RegisterStartupScript(this, this.GetType(), "document", "filterStatusOpen('" + rnd + "');", true);

    }
}
