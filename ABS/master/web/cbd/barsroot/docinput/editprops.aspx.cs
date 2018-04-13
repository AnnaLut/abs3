using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars;
using Bars.Classes;
using Bars.Logger;

public partial class docinput_editprops : BarsPage
{
    protected override void OnPreInit(EventArgs e)
    {
        FillData();
        base.OnPreInit(e);
    }

    private void FillData()
    {
        sdsProps.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsDocs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        string reqFilterCondition = Convert.ToString(Session["cim.ReqFilterCondition"]);
        sdsProps.SelectCommand =
            @"SELECT r.tag TAG, f.name NAME, NVL(ww.value,'') VALUE, decode(f.browser,null,0,1) REL, ww.ref REF
                                      FROM oper o, op_rules r, op_field f, 
                                            ( SELECT ff.tag, NVL(w.value,'') value, ref
                                                FROM operw w, op_field ff 
                                               WHERE w.ref(+) = :REF
                                                 AND w.tag(+) = ff.tag and nvl(ff.nomodify,0)=0 ) ww 
                                      WHERE o.ref = :REF
                                        AND o.branch LIKE SYS_CONTEXT ('bars_context','user_branch_mask')
                                        AND o.tt  = r.tt and nvl(r.used4input,0) = 1
                                        AND r.tag = f.tag " + ((!string.IsNullOrEmpty(reqFilterCondition) && Request["ref"] != null) ? ("and " + reqFilterCondition) : ("")) +
                    
                                        "AND r.tag = ww.tag order by decode(trim(r.tag), 'N', null, 'n', null, r.tag) nulls first";

        string sql =
            "select o.ref, o.tt, o.userid, o.nlsa, o.s, v1.lcv lcv_a, o.vdat, o.s2, v2.lcv lcv_b ,o.mfob, o.nlsb, o.dk, o.sk, o.datd from oper o, tabval$global v1, tabval$global v2 where o.kv=v1.kv AND o.kv2=v2.kv and o.branch LIKE SYS_CONTEXT ('bars_context','user_branch_mask') and pdat >= :pdat {0}";

        string panelTitle = "Перегляд документів {0}починаючи з дати {1}";

        string pDat = Convert.ToString(Session["editprops_date"]);
        if (string.IsNullOrEmpty(pDat))
            pDat = DateTime.Now.AddDays(-10).ToString("dd/MM/yyyy");

        sdsDocs.SelectParameters.Add("pdat", DbType.Date, pDat);

        string refDoc = Convert.ToString(Session["editprops_ref"]);
        if (!string.IsNullOrEmpty(refDoc) && IsPostBack)
            sql += " and o.ref=" + refDoc;

        if (Request["mode"] == "0")
        {
            trDateFilter.Visible = true;
            sdsDocs.SelectCommand = string.Format(sql, "", pDat);
            panelTitle = string.Format(panelTitle, "", pDat);
        }
        else if (Request["mode"] == "1")
        {
            trDateFilter.Visible = true;
            sdsDocs.SelectCommand = string.Format(sql, " and o.userid=bars.user_id ", pDat);
            panelTitle = string.Format(panelTitle, "користувача ", pDat);
        }
        else if (Request["mode"] == "2")
        {
            sdsDocs.SelectCommand = string.Format(sql, " and o.vdat=bankdate ", pDat);
            panelTitle = "Перегляд документів за сьогодні";
        }
        else if (Request["ref"] != null)
        {
            sdsDocs.SelectCommand = string.Format(sql, " and o.ref=" + Request["ref"], pDat);
            panelTitle = "Перегляд документу ref=" + Request["ref"];
        }
        else
        {
            throw new ArgumentException("Невірні вхідні параметри");
        }
        pnDocuments.GroupingText = panelTitle;

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            deStartDate.Date = DateTime.Now.AddDays(-10);
            Session["editprops_date"] = deStartDate.Date.ToString("dd/MM/yyyy");
            Session.Remove("editprops_ref");
        }

    }
    protected void gvProps_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        e.Cancel = true;
        gvProps.EditIndex = -1;
        try
        {
            InitOraConnection();
            string refDoc = Convert.ToString(gvDocs.SelectedValue);
            string newValue = Convert.ToString(e.NewValues["VALUE"]);
            string oldValue = Convert.ToString(e.OldValues["VALUE"]);
            string tag = Convert.ToString(e.Keys[1]);
            // Update or delete
            if (e.Keys[0] != DBNull.Value)
            {
                //delete
                if (string.IsNullOrEmpty(newValue))
                {
                    SetParameters("ref", DB_TYPE.Decimal, e.Keys[0], DIRECTION.Input);
                    SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                    SQL_NONQUERY("delete from operw where ref=:ref and tag=:tag");
                }
                // update
                else
                {
                    SetParameters("value", DB_TYPE.Varchar2, newValue, DIRECTION.Input);
                    SetParameters("ref", DB_TYPE.Decimal, e.Keys[0], DIRECTION.Input);
                    SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                    SQL_NONQUERY("update operw set value=:value where ref=:ref and tag=:tag");
                }
            }
            // Insert
            else
            {
                SetParameters("ref", DB_TYPE.Decimal, refDoc, DIRECTION.Input);
                SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                SetParameters("value", DB_TYPE.Varchar2, newValue, DIRECTION.Input);
                SQL_NONQUERY("insert into operw (ref, tag, value)  values (:ref, :tag, :value)");
            }

            ArrayList reader = SQL_reader("select id, fio from staff$base where id=user_id");
            DBLogger.Info(
                "Изменение доп. реквизита [" + e.OldValues["NAME"] + "(TAG=" + tag.Trim() + ")] в документе ref=" +
                Request["ref"] + " пользователем [" + reader[1] + "(ID=" + reader[0] + ")],\n старое значение :" +
                oldValue + "\n новое значение  :" + newValue, "DOCINPUT");
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void gvProps_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            Control ctrl = e.Row.Cells[2].Controls[1];
            if (ctrl is TextBox)
                hEditBoxId.Value = ctrl.ClientID;
        }
    }

    protected void gvDocs_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            gvProps.DataBind();
            pnProps.GroupingText = "Реквізити документу ref=" + Convert.ToString(e.CommandArgument);
        }
    }

    protected void OnClick(object sender, EventArgs e)
    {
        Session["editprops_date"] = deStartDate.Date.ToString("dd/MM/yyyy");
        Session["editprops_ref"] = tbRef.Text;
        FillData();
        gvDocs.DataBind();
    }

    protected void gvDocs_OnPreRender(object sender, EventArgs e)
    {
        bool flag = gvDocs.Rows.Count == 0;
        gvDocs.Visible = !flag;
        pnProps.Visible = !flag;
        pnEmptyData.Visible = flag;
    }
}