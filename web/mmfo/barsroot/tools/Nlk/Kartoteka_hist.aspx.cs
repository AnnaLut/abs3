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
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Globalization;
using System.Drawing;
using System.Collections.Generic;
using Oracle.DataAccess.Types;
using System.Threading;
using Bars.UserControls;

public partial class tools_Nlk_Kartoteka_hist : Bars.BarsPage
{
    protected OracleConnection con;
    int row_counter = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        dsgrid_nlk.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        RegisterClientScript();

        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
            ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
        }
        if (!IsPostBack)
        {
            ACC_.Value = Convert.ToString(Request["ACC"]);
            REF1_.Value = Convert.ToString(Request["REF1"]);


            rekv_ref();
            FillGrid();
        }
    }

    //protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    //{
    //    if (sourceControl.GetType().Name == "BarsGridViewEx" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
    //    { FillGrid(); rekv_ref(); }

    //    base.RaisePostBackEvent(sourceControl, eventArgument);

    //}

    private void rekv_ref()
    {
        Decimal SS_;
        String Nazn_;
        String datd_;
        Decimal Szal;
        Decimal Skar;

             OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                 cmd.Parameters.Add("ref", OracleDbType.Decimal, Convert.ToDecimal(REF1_.Value), ParameterDirection.Input);

                cmd.CommandText = (@"  select ref, to_char(datd,'dd/mm/yyyy') datd, s/100 ss, amount/100 amount, (select sum(s/100) from nlk_ref_hist h, oper oo where oo.ref = h.ref2 and ref1 = n.ref1 and oo.sos >= 0 ) skar, nazn 
                                        from oper o, nlk_ref n 
                                       where ref = :ref
                                         and n.ref1 = o.ref");
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    SS_ = rdr["SS"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SS"];
                    Szal = rdr["AMOUNT"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["AMOUNT"];
                    Skar = rdr["SKAR"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SKAR"];
                    datd_ = rdr["DATD"] == DBNull.Value ? (String)null : (String)rdr["DATD"];
                    Nazn_ = rdr["NAZN"] == DBNull.Value ? (String)null : (String)rdr["NAZN"];
                    Lbrefl.Text = REF1_.Value;
                    Lbdatdl.Text = datd_;
                    Lbnaznl.Text = Nazn_;
                    Lbsuml.Text = String.Format("{0:N2}",SS_);
                    Lbamoul.Text = String.Format("{0:N2}", Szal);
                    Lbkarl.Text = String.Format("{0:N2}", Skar);
                }
                 rdr.Close();
                 rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            
    }
    private void FillGrid()
    {


        dsgrid_nlk.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsgrid_nlk.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
        dsgrid_nlk.SelectParameters.Clear();
        dsgrid_nlk.WhereParameters.Clear();

        String selectCommand = "SELECT o.sos, o.datd, o.ref ref2, o.nlsb, o.s/100 as s, o.Nazn, o.userid, S.FIO  "
                            + "  from nlk_ref_hist h, oper o, staff s  "
                            +"  where ref2 = o.ref "
                            +"    and o.sos>=-10 "
                            +"    and o.userid = s.id";

        if (!String.IsNullOrEmpty(ACC_.Value))
        {
            selectCommand += " and acc = :acc ";
            dsgrid_nlk.SelectParameters.Add("acc", TypeCode.Decimal, ACC_.Value);
        }

        if (!String.IsNullOrEmpty(REF1_.Value))
        {
            selectCommand += " and ref1 = :ref1 ";
            dsgrid_nlk.SelectParameters.Add("ref1", TypeCode.Decimal, REF1_.Value);
        }
       

        selectCommand += " order by o.datd ";

        dsgrid_nlk.SelectCommand = selectCommand;
        grid_nlk.DataBind();


    }

    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
            var lastColor;
			function S_A(id,nd,rnk,cus, prod)
			{
			 if(selectedRow != null) selectedRow.style.backgroundColor = lastColor;
			 lastColor = document.getElementById('r_'+id).style.backgroundColor;
             document.getElementById('r_'+id).style.backgroundColor = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('REF2_').value = nd;
             document.getElementById('REF2_').value = rnk;
             document.getElementById('REF2_').value = cus;
             document.getElementById('REF2_').value = prod;
     //          nd = nd1;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }

    protected void gridCCPortf_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                row.Cells[0].Text + "','" + row.Cells[0].Text + "',\"" +
                row.Cells[0].Text + "\",'" + row.Cells[0].Text + "')");

            if (Convert.ToString(row.Cells[5].Text) == "1")
            {
                row.ForeColor = Color.Green;
            }

            if (Convert.ToDecimal(row.Cells[5].Text) < 0)
            {
                row.ForeColor = Color.Red;
            }
         }
    }

    protected void Insert_Click(object sender, EventArgs e)
    {
        Pn_Ins.Visible = true;
        Tb_ref.Text = "";
    }
    protected void Btok_Click(object sender, EventArgs e)
    {
        if ( String.IsNullOrEmpty(Tb_ref.Text) )
        { ShowError("Вкажіть референс документа!!!"); return; }
        else
        { nlk_add(Convert.ToDecimal(ACC_.Value), Convert.ToDecimal(REF1_.Value), Convert.ToDecimal(Tb_ref.Text)); }


        Pn_Ins.Visible = false;
        Tb_ref.Text = "";

        FillGrid();
        rekv_ref();
    }
    protected void btcan_Click(object sender, EventArgs e)
    {
        Pn_Ins.Visible = false;
        Tb_ref.Text = "";
    }
    protected void backToFolders(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
    }
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }
    protected void Clik_bt_del(object sender, ImageClickEventArgs e)
    {

        if (String.IsNullOrEmpty(REF2_.Value))
        { ShowError("Виберіть референс який необхідно відвязати!"); }
        else { nlk_del(Convert.ToDecimal(ACC_.Value), Convert.ToDecimal(REF1_.Value), Convert.ToDecimal(REF2_.Value)); }
        REF2_.Value = "";
        FillGrid();
        rekv_ref();
    }
    protected void Clik_bt_refr(object sender, ImageClickEventArgs e)
    {
        nlk_contr( Convert.ToDecimal(ACC_.Value), Convert.ToDecimal(REF1_.Value) );
        rekv_ref();
    }
    protected void nlk_del(decimal p_acc, decimal p_ref1, decimal p_ref2)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            // установка роли
            cmd.ExecuteNonQuery();


            // -- Автоматизоване визначення показників	 type 3	
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "pack_nlk.nlk_del";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_acc_",  OracleDbType.Decimal, p_acc, ParameterDirection.Input);
            cmd.Parameters.Add("p_ref1_", OracleDbType.Decimal, p_ref1, ParameterDirection.Input);
            cmd.Parameters.Add("p_ref2_", OracleDbType.Decimal, p_ref2, ParameterDirection.Input);
            cmd.ExecuteNonQuery();

        }
        finally
        {
            con.Close();
            con.Dispose();
        }

    }

    protected void nlk_contr(decimal p_acc, decimal p_ref1)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            // установка роли
            cmd.ExecuteNonQuery();


            // -- Автоматизоване визначення показників	 type 3	
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "pack_nlk.nlk_contr";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_acc_", OracleDbType.Decimal, p_acc, ParameterDirection.Input);
            cmd.Parameters.Add("p_ref1_", OracleDbType.Decimal, p_ref1, ParameterDirection.Input);
            cmd.ExecuteNonQuery();

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }


    protected void nlk_add(decimal p_acc, decimal p_ref1, decimal p_ref2)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        Decimal? ErrCode;
        String ErrMessage;
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            // установка роли
            cmd.ExecuteNonQuery();


            // -- Автоматизоване визначення показників	 type 3	
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "pack_nlk.nlk_add";
            cmd.Parameters.Clear();
            
            cmd.Parameters.Add("ref_" , OracleDbType.Decimal, p_ref1, ParameterDirection.Input);
            cmd.Parameters.Add("refx_", OracleDbType.Decimal, p_ref2, ParameterDirection.Input);
            cmd.Parameters.Add("acc_" , OracleDbType.Decimal, p_acc, ParameterDirection.Input);
            cmd.Parameters.Add("ERR_Message", OracleDbType.Varchar2,4000, null, ParameterDirection.Output);
            cmd.Parameters.Add("ERR_Code", OracleDbType.Decimal, null, ParameterDirection.Output);
            cmd.ExecuteNonQuery();


            ErrCode = ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).Value;
            ErrMessage = ((OracleString)cmd.Parameters["ERR_Message"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["ERR_Message"].Value).Value;

                // анализируем результат
                    if (ErrCode.HasValue)
                    { ShowError(ErrMessage); }

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    public static String read_oper(String p_ref_)
    {
        String REFFF_;

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
        {

            cmd.Parameters.Add("ref", OracleDbType.Varchar2, p_ref_, ParameterDirection.Input);

            cmd.CommandText = (@"  select to_char(ref) ref from oper where ref = :ref");
            OracleDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read())
            {
                REFFF_ = rdr["REF"] == DBNull.Value ? (String)null : (String)rdr["REF"];
                return REFFF_;
            }
            else
            { return null; }
            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

    }

    protected void Clik_bt_docs(object sender, ImageClickEventArgs e)
    {
        String REF_ = read_oper(Tb_ref.Text);
        
       
          if (String.IsNullOrEmpty(REF_))
          {
              ShowError("Документ не знайдено!!!");
          }
          else
          {
              ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.showModalDialog('/barsroot/documentview/default.aspx?ref=" + REF_ + "', 'aaaa', 'dialogwidth=1050Px; dialogheight=770Px;  resizable=no;scrollbars=yes;status=yes;" + "')", true);
          }
    }
}