using System;
using System.IO;
using System.Data;
using Bars.Classes;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Globalization;
using Bars.UserControls;
using Bars.Oracle;



public partial class vip : Bars.BarsPage
{
    public override void VerifyRenderingInServerForm(Control control) { }
    protected OracleConnection con;
    private void FillData()
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        if (this.DesignMode == true)
        {
            this.EnsureChildControls();
        }
        this.Page.RegisterRequiresControlState(this);
    }

    //Населення грида
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsVipNew.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsKvipNew.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        String SelectCommand = @"SELECT DISTINCT d.rnk
										 ,d.NMK 
										 ,a.BRANCH 
										 ,d.customer_segment_financial
										 ,d.customer_segment_activity
										 ,d.customer_segment_products_amnt
										 ,d.rlvip
										 ,d.fio_manager
										 ,d.phone_manager
										 ,d.mail_manager
										 ,d.account_manager
								  FROM bars.V_VIP_DEAL d
									,bars.accounts   a
								 WHERE d.RNK = a.rnk
								   AND a.branch LIKE sys_context('bars_context'
												,'user_branch_mask') ";
        SelectCommand += " and upper(d.nmk) like  upper('%" + tbNMK.Text + "%') ";
        SelectCommand += " and d.rnk  like '%" + tbRNK.Text + "%' ";
        //if (rbAll.Checked)
        //{
        //    SelectCommand += " and kvip like '%'";
        //}

        //if (rbFin.Checked)
        //{
        //    SelectCommand += " and kvip = '1'";
        //}
        //if (rbSoc.Checked)
        //{
        //    SelectCommand += " and kvip = '2'";
        //}
        //if (rbPravl.Checked)
        //{
        //    SelectCommand += " and kvip = '3'";
        //}

        dsMain.SelectCommand = SelectCommand;
        //bt_new.Visible = true;
        pnNew.Visible = false;
        //  gvMain.AutoGenerateCheckBoxColumn = true;
    }

    //Перечитати дани
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        dsMain.DataBind();
        gvMain.DataBind();
    }

    // Для коректного відображення алертiв
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    //Для открытия в новом окне
    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", " window.open('" + URL + "');", true);
    }




    //Розкраска грида
    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
    }



    protected void bt_save_Click(object sender, EventArgs e)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            int pos = 0;
         
                foreach (GridViewRow row in gvMain.Rows)
                {
                    string MFO = Convert.ToString(gvMain.DataKeys[pos].Values[0]).Substring(1,6);
                    string RNK = Convert.ToString(gvMain.DataKeys[pos].Values[1]);
                    TextBoxString tbFIOMANAGER = ((TextBoxString)row.Cells[8].Controls[1]);
                    TextBox tbPHONEMANAGER = ((TextBox)row.Cells[9].Controls[1]);
                    TextBox tbMAILMANAGER = ((TextBox)row.Cells[10].Controls[1]);
                    TextBoxRefer tbACCOUNTMANAGER = ((TextBoxRefer)row.Cells[7].Controls[1]);

               
                

                ClearParameters();
                    SetParameters("P_MFO", DB_TYPE.Varchar2, MFO, DIRECTION.Input);
                    SetParameters("P_RNK", DB_TYPE.Varchar2, RNK, DIRECTION.Input);
                    SetParameters("P_VIP", DB_TYPE.Varchar2, "", DIRECTION.Input);
                    SetParameters("P_KVIP", DB_TYPE.Varchar2, "", DIRECTION.Input);
                    SetParameters("P_RETURN", DB_TYPE.Varchar2, 4000, DIRECTION.Output);
                    SetParameters("p_COMMENTS", DB_TYPE.Varchar2, "", DIRECTION.Input);
                    SetParameters("p_FIOMANAGER", DB_TYPE.Varchar2, tbFIOMANAGER.Value, DIRECTION.Input);
                    SetParameters("p_PHONEMANAGER", DB_TYPE.Varchar2, tbPHONEMANAGER.Text, DIRECTION.Input);
                    SetParameters("p_MAILMANAGER", DB_TYPE.Varchar2, tbMAILMANAGER.Text, DIRECTION.Input);
                    SetParameters("p_ACCOUNTMANAGER", DB_TYPE.Int32, tbACCOUNTMANAGER.Value, DIRECTION.Input);



                    SQL_NONQUERY(@" begin  load_vip_web(:P_MFO, :P_RNK, :P_VIP, :P_KVIP, null, null,
                                                        :P_RETURN, 
									                    :p_COMMENTS,
                                                        :p_FIOMANAGER,
                                                        :p_PHONEMANAGER,
                                                        :p_MAILMANAGER,
                                                        :p_ACCOUNTMANAGER);
                                                  end;");

                    pos++;
                }


            FillData();
        }
        finally
        {
            DisposeOraConnection();
        }

        gvMain.Visible = true;
        pnInfo.Visible = true;

        //bt_new.Visible = true;

        //bt_cancel.Visible = false;

        pnNew.Visible = false;
        chBox.Checked = false;
    }

    protected void btDel_Click(object sender, ImageClickEventArgs e)
    {

        ShowError("RNK:");
    }
    protected void gvMain_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DEL_ROW")
        {
            InitOraConnection();
            try
            {
                string[] pars = e.CommandArgument.ToString().Split(new char[] { ',' });
                String MFO = pars[0];
                String RNK = pars[1];

                ClearParameters();
                SetParameters("MFO", DB_TYPE.Varchar2, MFO, DIRECTION.Input);
                SetParameters("RNK", DB_TYPE.Varchar2, RNK, DIRECTION.Input);
                SetParameters("RNK2", DB_TYPE.Varchar2, RNK, DIRECTION.Input);
                SQL_NONQUERY(@"begin 
                                    delete from vip_flags where mfo=:MFO and rnk=:RNK; 
                                    update customerw set value='0' where rnk=:RNK2 and tag='VIP_K';
                                    end;");

                gvMain.DataBind();

            }
            finally
            {

                DisposeOraConnection();
            }
        }
    }
    //protected void bt_new_Click(object sender, EventArgs e)
    //{
    //    gvMain.Visible = false;
    //    pnInfo.Visible = false;

    //    bt_new.Visible = false;
    //    bt_Export.Visible = false;

    //    bt_cancel.Visible = true;

    //    pnNew.Visible = true;
    //    chBox.Checked = true;
    //}
    //protected void bt_cancelEdit_Click(object sender, EventArgs e)
    //{
    //    gvMain.Visible = true;
    //    pnInfo.Visible = true;

    //    bt_new.Visible = true;
    //    bt_Export.Visible = true;

    //    bt_cancel.Visible = false;

    //    pnNew.Visible = false;
    //    chBox.Checked = false;
    //}
    protected void bt_Export_Click(object sender, EventArgs e)
    {
        LiteralControl lc = new LiteralControl();
        gvExport.Visible = true;
        gvExport.DataSourceID = "dsMain";
        gvExport.DataBind();

        string attachment = "attachment; filename=vip.xls";
        Response.ClearContent();
        Response.BufferOutput = true;
        Response.AddHeader("content-disposition", attachment);
        Response.Charset = "utf-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.ContentType = "application/vnd.ms-excel";
        Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");

        StringWriter swrt = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(swrt);
        lc.RenderControl(htw);

        gvExport.RenderControl(htw);
        Response.Write(swrt.ToString());
        Response.Flush();
        Response.End();
        gvExport.Visible = false;
    }

}

