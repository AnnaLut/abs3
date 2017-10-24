using System;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class swi_reconsilation :Bars.BarsPage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"select 
                                stmt_ref, sender_bic, stmt_trn, stmt_page,
                                loro_accnum, stmt_currcode, stmt_currency,
                                stmt_beg_date, stmt_end_date, stmt_rest_in,
                                stmt_dos stmt_debit_turn, stmt_kos stmt_credit_turn, stmt_rest_out,
                                stmt_detail_count, stmt_nproc_count, stmt_processed,
                                nostro_acccode, nostro_accnum, nostro_accname, 
                                nostro_rest_in, nostro_rest_out, nostro_trn_count
                      from v_sw950_header
                     where stmt_currcode > 0 and stmt_beg_date>=bankdate-10 and stmt_beg_date<= bankdate+10 ";
              
        if (rbAccessed.Checked)
        {
            SelectCommand = SelectCommand + " and stmt_processed=1 ";
        }
        else
        {
            if(rbNoAccessed.Checked)
            {
                SelectCommand = SelectCommand + " and nvl(stmt_processed,0)=0 ";
            }
            else
            {
                SelectCommand = SelectCommand + " and 1=1 ";
            }
            
        }

        SelectCommand = SelectCommand + " order by sender_bic, stmt_currcode, nostro_accnum, stmt_num";

        dsMain.SelectCommand = SelectCommand;




        if (IsPostBack)
        {

          

           dsMainDetail.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
           string SelectCommandDetail = @"select numrow, vdate, debit_sum, credit_sum, 
           processed, swtt, src_swref, their_ref, detail, mt
            from v_sw950_detail where  vdate>=bankdate-10 and vdate<= bankdate+10 and sw950ref='" + Convert.ToString(Session["swref"])+"'";



          dsMainDetail.SelectCommand = SelectCommandDetail;

        }

    }

    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void gvMainDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void gvMainDoc_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    //Наповнення гріда документами виписки МТ950 по кліку на виписку
    protected void gvMain_RowClicked(object sender, Bars.DataComponents.GridViewRowClickedEventArgs args)
    {

        dsMainDetail.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        Session["swref"] = Convert.ToString(args.Row.Cells[0].Text).Replace("&nbsp","null"); 

        Session["nostro_acc"] = Convert.ToString(args.Row.Cells[15].Text).Replace("&nbsp", "null");

        string SelectCommandDetail = @"select numrow, vdate, debit_sum, credit_sum, 
            processed, swtt, src_swref, their_ref, detail, mt
            from v_sw950_detail
        where vdate>=bankdate-10 and vdate<= bankdate+10 and sw950ref= '" + Convert.ToString(Session["swref"])+"'";

        dsMainDetail.SelectCommand = SelectCommandDetail;

        gvMainDetail.DataBind();

    }

    protected void gvMain_DataBound(object sender, EventArgs e)
    {
        gvMainDetail.DataBind();
    }


    //Наповнення третього гріда з схожими документами з АБС по кліку на 2-му гріду(по документу з виписки)
    protected void gvMainDetail_RowClicked(object sender, Bars.DataComponents.GridViewRowClickedEventArgs args)
    {
        dsMainDoc.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
      

        Session["processed"] = Convert.ToString(args.Row.Cells[4].Text);

        Session["numrow"] = Convert.ToString(args.Row.Cells[0].Text);

        Session["TheirRef"] = Convert.ToString(args.Row.Cells[7].Text).Replace("&nbsp", "null");

        string SelectCommandDoc = @"select  ref, fdat, detail, sos, tt, s/100 s
                                          from v_sw950_doc
                                       where fdat>=bankdate-10 and fdat<= bankdate+10  ";

        var debuger = Convert.ToString(Session["nostro_acc"]);

        if (Convert.ToString(Session["nostro_acc"]) != "null;" & Convert.ToString(Session["nostro_acc"])!="null" & (!String.IsNullOrEmpty(Convert.ToString(Session["nostro_acc"]))))
        {
            SelectCommandDoc = SelectCommandDoc + " and acc=" + Convert.ToString(Session["nostro_acc"]).Replace("null","0")+ " and (dk, s) in(select case when nvl(debit_sum,0)=0 then 0 else 1 end dk,  case when nvl(credit_sum,0)=0 then debit_sum else credit_sum end*100 s from v_sw950_detail where numrow=" + Session["numrow"] + " and sw950ref='"+ Session["swref"] + "') ";
        }

        //if(Convert.ToString(Session["TheirRef"]) != "null;" & Convert.ToString(Session["TheirRef"]) != "null" & (!String.IsNullOrEmpty(Convert.ToString(Session["TheirRef"])))&
        //    Convert.ToString(Session["nostro_acc"]) != "null;" & Convert.ToString(Session["nostro_acc"]) != "null" & (!String.IsNullOrEmpty(Convert.ToString(Session["nostro_acc"]))))
        //{
        //    SelectCommandDoc = SelectCommandDoc + " or (th_ref='" + Convert.ToString(Session["TheirRef"]) + "' and acc="+ Convert.ToString(Session["nostro_acc"]).Replace("null", "0") + ")";
        //}

 
        dsMainDoc.SelectCommand = SelectCommandDoc;
        gvMainDoc.DataBind();



    }

    protected void gvMainDetail_DataBound(object sender, EventArgs e)
    {
        gvMainDoc.DataBind();
    }


    //Перечитка верхнього гріда з виписками
    protected void btRefresh_gvMain(object sender, EventArgs e)
    {
        gvMain.DataBind();
        gvMainDetail.DataBind();
        gvMainDoc.DataBind();
    }

    protected void STMT_PROCESSED_Changed(object sender, ImageClickEventArgs e)
    {
        InitOraConnection();
        try
        {
            if (Convert.ToString(Session["swref"])=="null;"|| String.IsNullOrEmpty(Convert.ToString(Session["swref"])))
            {
                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не вибрано рядок виписки!');", true);
            }
            else
            {

                string re = Convert.ToString(Session["swref"]);
            ClearParameters();
            SetParameters("sw_ref", DB_TYPE.Varchar2, re, DIRECTION.Input);
            SetParameters("state", DB_TYPE.Int32, 1, DIRECTION.Input);
            SQL_NONQUERY("begin bars_swift.stmt_set_state(:sw_ref, :state); end;");
            }
        }
        finally
        {
            DisposeOraConnection();
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Процедуру виконано!');", true);
        }
        gvMain.DataBind();
    }

    protected void btAutoLink_Click(object sender, ImageClickEventArgs e)
    {
        InitOraConnection();
        try
        {
            if (Convert.ToString(Session["swref"]) == "null;" || String.IsNullOrEmpty(Convert.ToString(Session["swref"])))
            {
                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не вибрано рядок виписки!');", true);
            }
            else
            {

                string re = Convert.ToString(Session["swref"]);
                ClearParameters();
                SetParameters("sw_ref", DB_TYPE.Varchar2, re, DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.stmt_srcmsg_autolink(:sw_ref); end;");
            }
        }
        finally
        {
            DisposeOraConnection();
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Процедуру виконано!');", true);
        }
        gvMain.DataBind();
    }

    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", "window.showModalDialog('" + URL + "',null,'dialogWidth:700px;');", true);
    }

    //Перегляд документу або SWIFT повідомлення
    protected void btSwtView_Click(object sender, ImageClickEventArgs e)
    {
        InitOraConnection();
        try
        {
            string processed = Convert.ToString(Session["processed"]);

            //Якщо документ привязаний до повідомлення - показуємо документ АБС + закладка SWIFT
            if (processed == "Y")
            {
                          
                    SetParameters("swref", DB_TYPE.Varchar2,Convert.ToString(Session["swref"]), DIRECTION.Input);
                    SQL_Reader_Exec(@"select ref                   
                    from sw_oper where swref=:swref");
                    while (SQL_Reader_Read())
                    {
                        ArrayList reader = SQL_Reader_GetValues();
                        string ref_abs = Convert.ToString(reader[0]);

                      Window_open(String.Format("/barsroot/documentview/default.aspx?ref={0}", ref_abs));

                }

                    SQL_Reader_Close();
               
            }
            //Документа в АБС немає показуємо тільки SWIFT
            if (processed == "N")
            {
                Window_open(String.Format("/barsroot/documentview/view_swift.aspx?swref={0}", Convert.ToString(Session["swref"])));
            }
            if (processed != "Y"& processed!="N")
            {
                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не виділено рядок!');", true);
            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    //Відкріплення SWIFT повідомлення 
    protected void btUnlink_Click(object sender, ImageClickEventArgs e)
    {
        InitOraConnection();
        try
        {
            if (Convert.ToString(Session["swref"]) == "null;" || String.IsNullOrEmpty(Convert.ToString(Session["swref"])) || String.IsNullOrEmpty(Convert.ToString(Session["swref"])) || Convert.ToString(Session["swref"])=="null;")
            {
                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не вибрано рядок!');", true);
            }
            else
            {

                string re = Convert.ToString(Session["swref"]);
                string numrow = Convert.ToString(Session["numrow"]);
                ClearParameters();
                SetParameters("sw_ref", DB_TYPE.Varchar2, re, DIRECTION.Input);
                SetParameters("colN", DB_TYPE.Varchar2, numrow, DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.stmt_srcmsg_unlink(:sw_ref, :colN); end;");
            }
        }
        finally
        {
            DisposeOraConnection();
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Процедуру виконано!');", true);
        }
    }

    //Відкріплення документу АБС
    protected void btUnlinkDoc_Click(object sender, ImageClickEventArgs e)
    {
        InitOraConnection();
        try
        {
            if (Convert.ToString(Session["swref"]) == "null;" || String.IsNullOrEmpty(Convert.ToString(Session["swref"])) || String.IsNullOrEmpty(Convert.ToString(Session["swref"])) || Convert.ToString(Session["swref"]) == "null;")
            {
                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не вибрано рядок!');", true);
            }
            else
            {

                string re = Convert.ToString(Session["swref"]);
                string numrow = Convert.ToString(Session["numrow"]);
                ClearParameters();
                SetParameters("sw_ref", DB_TYPE.Varchar2, re, DIRECTION.Input);
                SetParameters("colN", DB_TYPE.Varchar2, numrow, DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.stmt_document_unlink(:sw_ref, :colN); end;");
            }
        }
        finally
        {
            DisposeOraConnection();
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Процедуру виконано!');", true);
        }
    }

    protected void btViewDOc_Click(object sender, ImageClickEventArgs e)
    {
        if (gvMainDoc.SelectedRows.Count == 0)
        {
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано документ!');", true);
        }
        else
        {
            string reference = Convert.ToString((gvMainDoc.Rows[gvMainDoc.SelectedRows[0]].Cells[1]).Text);

            Window_open(String.Format("/barsroot/documentview/default.aspx?ref={0}", reference));
        }
    }

    //Заквитувати документ
    protected void btLinkDoc_Click(object sender, ImageClickEventArgs e)
    {
        InitOraConnection();
        try
        {
            if (Convert.ToString(Session["swref"]) == "null;" || String.IsNullOrEmpty(Convert.ToString(Session["swref"])) || String.IsNullOrEmpty(Convert.ToString(Session["numrow"])) || Convert.ToString(Session["numrow"]) == "null;" || gvMainDoc.SelectedRows.Count == 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не вибрано рядок!');", true);
            }
            else
            {

                string re = Convert.ToString(Session["swref"]);
                string numrow = Convert.ToString(Session["numrow"]);
                string reference = Convert.ToString((gvMainDoc.Rows[gvMainDoc.SelectedRows[0]].Cells[1]).Text);
                string tt = Convert.ToString((gvMainDoc.Rows[gvMainDoc.SelectedRows[0]].Cells[3]).Text);
                ClearParameters();
                SetParameters("sw_ref", DB_TYPE.Varchar2, re, DIRECTION.Input);
                SetParameters("ref", DB_TYPE.Varchar2, reference, DIRECTION.Input);
                SetParameters("colN", DB_TYPE.Varchar2, numrow, DIRECTION.Input);
                SetParameters("tt", DB_TYPE.Varchar2, tt, DIRECTION.Input);
                SQL_NONQUERY("begin p_reconsilation_kwt(:sw_ref, :ref, :colN, :tt); end;");
            }
        }
        finally
        {
            DisposeOraConnection();
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Процедуру виконано!');", true);
        }
        gvMainDetail.DataBind();
        gvMainDoc.DataBind();
    }

    //Прилінкувати SWIFT повідомлення
    protected void btLinkSwt_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(Session["swref"]) == "null;" || String.IsNullOrEmpty(Convert.ToString(Session["swref"])) || String.IsNullOrEmpty(Convert.ToString(Session["numrow"])) || Convert.ToString(Session["numrow"]) == "null;")
        {
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано документ!');", true);
        }
        else
        {
          
           Window_open(String.Format("/barsroot/swi/reconsilation_link_swt.aspx?stmt_ref={0}&coln={1}", Convert.ToString(Session["swref"]), Convert.ToString(Session["numrow"])));
        }

        Session.Remove("numrow");
    }
    //Обробити повідомлення
    protected void btRun_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(Session["swref"]) == "null;" || String.IsNullOrEmpty(Convert.ToString(Session["swref"])) || String.IsNullOrEmpty(Convert.ToString(Session["numrow"])) || Convert.ToString(Session["numrow"]) == "null;")
        {
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано документ!');", true);
        }
        else
        {

            Window_open(String.Format("/barsroot/swi/reconsilation_tt.aspx?stmt_ref={0}&coln={1}", Convert.ToString(Session["swref"]), Convert.ToString(Session["numrow"])));
        }


        Session.Remove("numrow");

    }
}