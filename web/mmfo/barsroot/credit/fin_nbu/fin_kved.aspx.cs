using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Drawing;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.Doc;

public partial class credit_fin_nbu_fin_kved : Bars.BarsPage
{
    
    int row_counter = 0;
    Int64    p_okpo;
    Int64    p_rnk;
    String   p_date;
    


    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterClientScript();

        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
            ViewState.Add("PREV_URL2", Request.UrlReferrer.PathAndQuery);
            
        }

       CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
       cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
       cinfo.DateTimeFormat.DateSeparator = "/";

        if (!IsPostBack)
        {
            p_rnk = Convert.ToInt64(Request["rnk"]); 
            p_okpo = Convert.ToInt64(Request["okpo"]); 
            p_date = Convert.ToString(Request["DAT"]); 


            RNK_.Value = Convert.ToString( p_rnk);
            OKPO_.Value = Convert.ToString( p_okpo );
            tbOKPO.Text = OKPO_.Value;
            DAT_.Value  = p_date;
            DATP_.Value = Convert.ToString(Request["DATP"]); 
         

        }

        if (!IsPostBack)
        {
            FillData();
            try
            {
                InitOraConnection();
                dl_kved.DataSource = SQL_SELECT_dataset("select ved, ved||'-'||name as name from ved where d_close is null and ved not in ('00000','99999','ZZZZZ') order by ved").Tables[0];
                dl_kved.DataTextField = "name";
                dl_kved.DataValueField = "ved";
                //Биндим
                dl_kved.DataBind();
                dl_kved.Items.Insert(0, new ListItem("Виберіть вид економічної діяльності", ""));


                dl_kod.DataSource = SQL_SELECT_dataset("select kod, kod||' - '||name as name from fin_forma2 where fm = 'N' and kod in ('2000','2010','2120') order by kod").Tables[0];
                dl_kod.DataTextField = "name";
                dl_kod.DataValueField = "kod";
                //Биндим
                dl_kod.DataBind();
                dl_kod.Items.Insert(0, new ListItem("Виберіть рядок ф.2", ""));


            }
            finally
            {
                DisposeOraConnection();
            }
        }

        //FillData();

        
    }

    protected void backToFolders(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(DD_ved.SelectedValue))
        {
            ShowError("Не вірно заповнені дані." + ". !!!");
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('/barsroot/credit/fin_nbu/fin_form.aspx?okpo=" + OKPO_.Value + "&frm=2&dat=" + DATP_.Value + "&rnk="+ RNK_.Value + "')", true);
    }

    private void FillData()
    {
        load_form();
        try
        {
            
            InitOraConnection();
            SetRole("WR_DOC_INPUT");

            SetParameters("prnk",  DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            SetParameters("pokpo", DB_TYPE.Int64, Convert.ToInt64(OKPO_.Value) , DIRECTION.Input);
            SetParameters("pdat",  DB_TYPE.Date,  Convert.ToDateTime(DAT_.Value), DIRECTION.Input);
            DataKved.DataSource = SQL_SELECT_dataset(@"select kod, kved, name, volme_sales, to_char(weight,'999990.99')||' %' weight, flag, ord, err from table(fin_nbu.f_fin_kved(:prnk,:pokpo,:pdat))");


            DataKved.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }
       // load_form();
    }

    protected void load_form()
    {

        setCustomerElement();
 
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            DateTime dat =  Convert.ToDateTime(DAT_.Value, cinfo);
            Decimal  rnk = Convert.ToDecimal(RNK_.Value);

            // установка роли
            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("dat", OracleDbType.Date, Convert.ToDateTime(DATP_.Value, cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("OKPO", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.CommandText = @" select c.nmk, c.okpo, f.ved, (select count(1) from fin_kved where okpo = c.okpo and dat = f.fdat and flag = 1) kol, case when (sysdate-datea) < 366 then to_char(:dat,'DD.MM.YYYY') else to_char(trunc(f.fdat,'YYYY') -1,'YYYY') end Year_, case when (sysdate-datea) < 366 then 1 else 0 end tips, to_char(datea) as datea,
                                        (select sum(s)+ fin_nbu.LOGK_read (DAT_ => f.fdat, OKPO_ => f.okpo,  IDF_ => 2,  mode_ => 1) from fin_rnk where okpo = f.okpo and fdat = f.fdat and idf = 2 and kod in ('2000','2010','2120')) s_2000
                                  from fin_customer c 
                                       left join fin_fm f on c.okpo = f.okpo and f.fdat = :dat 
                                 where c.rnk = :rnk";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                LbOrp.Text = "Обсяг реалізованої продукції за " + Convert.ToString(rdr["Year_"]) + " рік";
                
                //новостворені підприемства дані перем за звітний період а не за попередній рік
                if (Convert.ToDecimal(rdr["TIPS"]) == 1) 
                { 
                     DAT_.Value = DATP_.Value;
                     LbOrp.Text = "Обсяг реалізованої продукції на " + Convert.ToString(rdr["Year_"]) + " рік";
                } 

                
                LbNMK.Text = Convert.ToString(rdr["NMK"]);
                Decimal Flag = Convert.ToDecimal(rdr["KOL"]);
                Decimal S_2000 = Convert.ToDecimal(rdr["S_2000"]);


   if (S_2000 == 0)
     {
      try
                    {
                        InitOraConnection();
                        DD_ved.DataSource = SQL_SELECT_dataset("select ved, ved||'-'||name as name from ved where d_close is null and ved not in ('00000','99999','ZZZZZ') order by ved").Tables[0];
                        DD_ved.DataTextField = "name";
                        DD_ved.DataValueField = "ved";
                        //Биндим
                        DD_ved.DataBind();
                        DD_ved.Items.Insert(0, new ListItem("Виберіть вид економічної діяльності", ""));
                    }
                    finally
                    {
                        DisposeOraConnection();
                    }
                    
                   if (!string.IsNullOrEmpty(Convert.ToString(rdr["VED"])))
                    {
                        DD_ved.SelectedValue = Convert.ToString(rdr["VED"]);
                    }
                    else
                    {
                        ShowError("Виберіть вид економічної діяльності " + ". !!!");
                    }

                   BtSave.Visible = true;
     }

     else{



                if (Flag == 0)
                {
                    BtSave.Visible = false;
                    try
                    {
                        InitOraConnection();
                        DD_ved.DataSource = SQL_SELECT_dataset("select ved, ved||'-'||name as name from ved where d_close is null and ved not in ('00000','99999','ZZZZZ') and ved in (select kved from fin_kved where okpo = " + Convert.ToString(rdr["OKPO"]) + " and dat=to_date('" + DAT_.Value + "','dd/mm/yyyy') and flag = 1) order by ved").Tables[0];
                        DD_ved.DataTextField = "name";
                        DD_ved.DataValueField = "ved";
                        //Биндим
                        DD_ved.DataBind();
                        DD_ved.Items.Insert(0, new ListItem("Обсяг реалізованої продукції не відповідає Ф2  за " + Convert.ToString(rdr["Year_"]) + " рік", ""));
                    }
                    finally
                    {
                        DisposeOraConnection();
                    }
                }
                else if (Flag == 1)
                {
                    BtSave.Visible = false;
                    try
                   {
                     InitOraConnection();
                     DD_ved.DataSource = SQL_SELECT_dataset("select ved, ved||'-'||name as name from ved where d_close is null and ved not in ('00000','99999','ZZZZZ') and ved in (select kved from fin_kved where okpo = " + Convert.ToString(rdr["OKPO"]) + " and dat=to_date('" + DAT_.Value + "','dd/mm/yyyy') and flag = 1) order by ved").Tables[0];
                     DD_ved.DataTextField = "name";
                     DD_ved.DataValueField = "ved";
                     //Биндим
                     DD_ved.DataBind();
                    // DD_ved.Items.Insert(0, new ListItem("Виберіть вид економічної діяльності", ""));
                   }
                    finally
                    {
                        DisposeOraConnection();
                    }

                }
                else
                {
                    BtSave.Visible = true;

                    try
                    {
                        InitOraConnection();
                        DD_ved.DataSource = SQL_SELECT_dataset("select ved, ved||'-'||name as name from ved where d_close is null and ved not in ('00000','99999','ZZZZZ') and ved in (select kved from fin_kved where okpo = " + Convert.ToString(rdr["OKPO"]) + " and flag = 1) order by ved").Tables[0];
                        DD_ved.DataTextField = "name";
                        DD_ved.DataValueField = "ved";
                        //Биндим
                        DD_ved.DataBind();
                        DD_ved.Items.Insert(0, new ListItem("Виберіть вид економічної діяльності", ""));
                    }
                    finally
                    {
                        DisposeOraConnection();
                    }

                    if (!string.IsNullOrEmpty(Convert.ToString(rdr["VED"])))
                    {
                        DD_ved.SelectedValue = Convert.ToString(rdr["VED"]);
                    }
                    else
                    {
                        ShowError("Виберіть вид економічної діяльності " + ". !!!");
                    }

                }

     }


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

    protected void bt_Ok_Click(object sender, EventArgs e)
    {

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        if (string.IsNullOrEmpty(dl_kved.SelectedValue))
        {
            ShowError("Не заповнено Код за КВЕД-2010 " + ". !!!");
        }
        else if (string.IsNullOrEmpty(dl_kod.SelectedValue))
        {
            ShowError("Не заповнено Код рядка форми2 " + ". !!!");
        }
        else
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                string l_volme_sales;
                l_volme_sales = tb_sump.Text;
                if (string.IsNullOrEmpty(l_volme_sales)) l_volme_sales = "0";
                decimal volme_sales = decimal.Parse(l_volme_sales.Replace(",", "."));

                cmd.Parameters.Clear();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "fin_nbu.save_volmesales";

                cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(RNK_.Value), ParameterDirection.Input);
                cmd.Parameters.Add("p_okpo", OracleDbType.Int64, Convert.ToInt64(OKPO_.Value), ParameterDirection.Input);
                cmd.Parameters.Add("p_dat", OracleDbType.Date, Convert.ToDateTime(DAT_.Value, cinfo), ParameterDirection.Input);
                cmd.Parameters.Add("p_kod", OracleDbType.Varchar2,  dl_kod.SelectedValue, ParameterDirection.Input);
                cmd.Parameters.Add("p_kved", OracleDbType.Varchar2, dl_kved.SelectedValue, ParameterDirection.Input);
                cmd.Parameters.Add("p_volme_sales", OracleDbType.Decimal, volme_sales, ParameterDirection.Input);
                cmd.ExecuteNonQuery();


            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            FillData();
            pnrekv.Visible = false;
            clear_form();
        }
    }
    
    protected void bt_Cancel_Click(object sender, EventArgs e)
    {
       // FillData();
        pnrekv.Visible = false;
        clear_form();
    }
    
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
            var lastColor;
			function S_A(id, kved_,ss_,kod_, ord_)
			{
			 if(selectedRow != null ) selectedRow.style.backgroundColor = lastColor;
			 lastColor = document.getElementById('r_'+id).style.backgroundColor;
             if(ord_ == 0 ) document.getElementById('r_'+id).style.backgroundColor = '#cce6ff';
             //document.getElementById('r_'+id).style.backgroundColor = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			   document.getElementById('KVED_').value =   kved_;
               document.getElementById('SS_' ).value  =   ss_;
               document.getElementById('FLAG_').value =   ord_;
               document.getElementById('KOD_' ).value =   kod_;
     //          nd = nd1;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }
    
    protected void DataDepository_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        row_counter++;

        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            decimal ord = Convert.ToDecimal(((DataRowView)e.Row.DataItem).Row["ORD"]);
           // decimal flag = Convert.ToDecimal(((DataRowView)e.Row.DataItem).Row["FLAG"]);


            row.Attributes.Add("id", row_id);
            if (ord == 0)
            { 
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                row.Cells[1].Text + "','"  + row.Cells[3].Text + "',\"" +
                row.Cells[0].Text + "\",'" + ord  + "')");
            }
            else
            {
                row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                    "" + "','" + "" + "',\"" +
                    "" + "\",'" + ord + "')");
            }

        
            //if (row.Cells[5].Text == "1")
            if (ord == 0)
            {
                row.ForeColor = Color.Black;
                row.BackColor = Color.FromArgb(240, 240, 245);
            }

            if ( ord == 1)
            {
                row.ForeColor = Color.Black;
                row.BackColor = Color.FromArgb(214, 214, 194);
                row.Font.Bold = true;
            }


            if (ord == 2)
            {
                row.ForeColor = Color.Black;
                row.BackColor = Color.FromArgb(224, 224, 209);
                row.Font.Italic = true;
                row.Font.Bold = true;
            }
            //  Response.Write("-" + row.Cells[10].Text  );

        }
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    if (string.IsNullOrEmpty(HttpUtility.HtmlDecode(e.Row.Cells[1].Text).Trim())
        //       ||
        //       string.IsNullOrEmpty(HttpUtility.HtmlDecode(e.Row.Cells[3].Text).Trim()))
        //    {
        //        e.Row.Cells[6].Enabled = false;
        //        e.Row.Cells[7].Enabled = false;
        //    }
        //}
    }

    protected void Clik_bt_insert(object sender, ImageClickEventArgs e)
    {
        clear_form();
        pnrekv.Visible = true;
        dl_kved.Enabled = true;
        dl_kod.Enabled = true;
 
    }
    
    protected void Clik_bt_edit(object sender, ImageClickEventArgs e)
    {
        if (String.IsNullOrEmpty(KVED_.Value))
        { ShowError("Для редагування необхідно вибрати рядок!!! "); }
        else
        {
            pnrekv.Visible = true;
            dl_kod.SelectedValue = KOD_.Value;
            dl_kod.Enabled = false;
            dl_kved.SelectedValue = KVED_.Value;
            dl_kved.Enabled = false;
            tb_sump.Text = SS_.Value;
        }
    }
    
    protected void Clik_bt_del(object sender, ImageClickEventArgs e)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";
        
        if (String.IsNullOrEmpty(KVED_.Value))
        { ShowError("Для видалення необхідно вибрати рядок!!! "); }
        else
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                cmd.Parameters.Clear();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "fin_nbu.del_volmesales";
                cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(RNK_.Value), ParameterDirection.Input);
                cmd.Parameters.Add("p_okpo", OracleDbType.Int64, Convert.ToInt64(OKPO_.Value), ParameterDirection.Input);
                cmd.Parameters.Add("p_dat", OracleDbType.Date, Convert.ToDateTime(DAT_.Value, cinfo), ParameterDirection.Input);
                cmd.Parameters.Add("p_kved", OracleDbType.Varchar2, KVED_.Value, ParameterDirection.Input);
                cmd.ExecuteNonQuery();


            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            FillData();
            clear_form();
        }
    }
    
    private void clear_form()
    {

        KOD_.Value = null;
        KVED_.Value = null;
        SS_.Value = null;
        FLAG_.Value = null;
        ORD_.Value = null;
            


        dl_kved.SelectedValue = "";
        dl_kod.SelectedValue = "";
        tb_sump.Text = null;


        pnrekv.Visible = false;

    }
    
    private void ShowError(String ErrorText)
    {
        //Response.Write("!" + ErrorText + "!");
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
    }

    protected void Clik_bt_save(object sender, ImageClickEventArgs e)
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        DateTime dat = Convert.ToDateTime(DAT_.Value, cinfo);
        string OKPO = Convert.ToString(OKPO_.Value);
        string KVED = Convert.ToString(DD_ved.SelectedValue);
        if (!string.IsNullOrEmpty(KVED))
        {
        try
        {
             InitOraConnection();
             ClearParameters();
             SetParameters("ved", DB_TYPE.Varchar2,  KVED, DIRECTION.Input);
             SetParameters("dat", DB_TYPE.Date,      dat,  DIRECTION.Input);
             SetParameters("OKPO", DB_TYPE.Varchar2, OKPO, DIRECTION.Input);
             SQL_NONQUERY(" begin UPDATE FIN_FM set ved=:ved where FDAT=:dat and OKPO=:OKPO;  end;");

        }
        finally
        {
            DisposeOraConnection();
        }
        }
    }

    private void get_customerw()
    {

        try
        {
            InitOraConnection();
            ClearParameters();
            SetParameters("p_rnk", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
            SetParameters("p_tag", DB_TYPE.Varchar2, "N_CK", DIRECTION.Input);
            SetParameters("p_zn",  DB_TYPE.Varchar2, (CC_CK.Checked)?("1"):("0"), DIRECTION.Input);
            SetParameters("p_isp", DB_TYPE.Int16, 0, DIRECTION.Input);
            SQL_NONQUERY(" begin kl.setCustomerElement(:p_rnk,:p_tag,:p_zn,:p_isp); commit; end;");

        }
        finally
        {
            DisposeOraConnection();
        }

    }

    private void setCustomerElement()
    {

            String SS_;  
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                 
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(RNK_.Value), ParameterDirection.Input);
                cmd.CommandText = ("select to_char(kl.get_customerw(:RNK, 'N_CK', 0)) as CK from dual");
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    SS_ = rdr["CK"] == DBNull.Value ? (String)null : (String)rdr["CK"];
                    if (SS_ != null)
                    {
                        CC_CK.Checked = (SS_ == "1") ? (true) : (false);
                    }
                    
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

    protected void CC_CK_CheckedChanged(object sender, EventArgs e)
    {
        get_customerw();

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "fin_nbu.determ_kved";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToInt64(RNK_.Value), ParameterDirection.Input);
            cmd.Parameters.Add("p_okpo", OracleDbType.Int64, Convert.ToInt64(OKPO_.Value), ParameterDirection.Input);
            cmd.Parameters.Add("p_dat", OracleDbType.Date, Convert.ToDateTime(DAT_.Value, cinfo), ParameterDirection.Input);
            cmd.ExecuteNonQuery();

        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        load_form();
        FillData();
    }

}