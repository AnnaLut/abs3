using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.Globalization;
using System.Drawing;
using Bars.Doc;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using Bars.Web.Controls;
using Bars.Application;
using System.Web.UI.HtmlControls;
using System.Windows.Forms;


public partial class credit_fin_nbu_fin_form_pd_fo: Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!String.IsNullOrEmpty(Request["RNK"]))  { RNK_.Value = Convert.ToString(Request["RNK"]);   Tb_rnk.Text = RNK_.Value; }
            if (!String.IsNullOrEmpty(Request["FRM"]))  { ND_.Value = Convert.ToString(Request["FRM"]);    Tb_ref.Text = ND_.Value;}
            if (!String.IsNullOrEmpty(Request["OKPO"])) { OKPO_.Value = Convert.ToString(Request["OKPO"]); Tb_okpo.Text = OKPO_.Value; }
            if (!String.IsNullOrEmpty(Request["DAT"]))  { DAT_.Value = Convert.ToString(Request["DAT"]);  }

            load_form();

            // Наповнимо DropDownList
            try
            {
                InitOraConnection();
                
                //Скоригований клас боржника 
                Dl_clas.DataBind();
                Dl_clas.Items.Insert(0, new ListItem("", null));
                

                //Внутрішній кредитний рейтинг 
                Dl_bkrr.DataBind();
                Dl_bkrr.Items.Insert(0, new ListItem("", ""));
                
                //Кредитна історія
                DL_kredhist.DataBind();
                DL_kredhist.Items.Insert(0, new ListItem("", ""));

                //Зважений коефіцієнт покриття боргу забезпеченням 
                DL_kpz.DataBind();
                DL_kpz.Items.Insert(0, new ListItem("", ""));

            }
            finally
            {
                DisposeOraConnection();
            }



            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            DL_kredhist.SelectedValue = read_nd(ND_.Value, RNK_.Value, "IP1", "60", DAT_.Value);
            DL_kpz.SelectedValue = read_nd(ND_.Value, RNK_.Value, "IP2", "60", DAT_.Value);
            Dl_clas.SelectedValue = read_nd(ND_.Value, RNK_.Value, "CLS", "60", DAT_.Value);
            Cb_zkd.Checked = (read_nd(ND_.Value, RNK_.Value, "ZKD", "60", DAT_.Value) =="1")?(true):(false);
            Cb_zkd_Checked();
            tb_kpz.Text = String.Format("{0:N1}",read_nd_d(ND_.Value, RNK_.Value, "KPZ", "60", DAT_.Value));
            Tb_pd.Text = String.Format("{0:N3}", read_nd_d(ND_.Value, RNK_.Value, "PD", "60", DAT_.Value));

        }






    }

    protected void load_form()
    {

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";


            Decimal rnk = Convert.ToDecimal(RNK_.Value);
            Decimal nd = Convert.ToDecimal(ND_.Value);


            // установка роли
            cmd.ExecuteNonQuery();


            cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.CommandText = @"  select v.cc_id, to_char(v.sdate,'dd/mm/yyyy') sdate, fin_zp.zn_vncrr(rnk, nd) as vncrr
                                  from v_fin_cc_deal v
                                 where v.nd = :nd_ and v.rnk =:rnk_";
            OracleDataReader rdr0 = cmd.ExecuteReader();
            if (rdr0.Read())
            {
               Dl_bkrr.SelectedValue = rdr0["VNCRR"] == DBNull.Value ? (String)null : (String)rdr0["VNCRR"];
               Tb_dat.Text = rdr0["SDATE"] == DBNull.Value ? (String)null : (String)rdr0["SDATE"];
            }

            // -- Автоматизоване визначення показників	 type 3	
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "fin_nbu.get_subpok_fo";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("ND_",  OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.Parameters.Add("DAT_", OracleDbType.Date, Convert.ToDateTime(DAT_.Value, cinfo), ParameterDirection.Input);
            cmd.ExecuteNonQuery();

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected void set_nd_vncrr(string nd_, string rnk_, String txt_)
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("nd_", DB_TYPE.Varchar2, nd_, DIRECTION.Input);
                SetParameters("rnk_", DB_TYPE.Varchar2, rnk_, DIRECTION.Input);
                SetParameters("txt_", DB_TYPE.Varchar2, txt_, DIRECTION.Input);
                SQL_NONQUERY("begin  fin_zp.set_nd_vncrr(:nd_, :rnk_, :txt_);  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    public static String read_nd(String nd_, String rnk_, String kod_, String idf_, String FDAT_)
    {
        String SS_; //  Decimal SS_;
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                if (FDAT_ == null) return null;

                DateTime dat = Convert.ToDateTime(FDAT_, cinfo);

                cmd.Parameters.Add("KOD", OracleDbType.Varchar2, kod_, ParameterDirection.Input);
                cmd.Parameters.Add("IDF", OracleDbType.Varchar2, idf_, ParameterDirection.Input);
                cmd.Parameters.Add("FDAT", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("ND", OracleDbType.Int64, Convert.ToInt64(nd_), ParameterDirection.Input);
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(rnk_), ParameterDirection.Input);
                cmd.CommandText = ("select to_char(fin_nbu.ZN_P_ND(:KOD, :IDF, :FDAT, :ND, :RNK)) as SN from dual");
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    SS_ = rdr["SN"] == DBNull.Value ? (String)null : (String)rdr["SN"];
                    if (SS_ != null)
                    { return Convert.ToString(SS_); }
                    else { return null; }
                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return null;
        }
    }

    public static Decimal read_nd_d(String nd_, String rnk_, String kod_, String idf_, String FDAT_)
    {
        Decimal SS_; //  Decimal SS_;
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                if (FDAT_ == null) return 0;

                DateTime dat = Convert.ToDateTime(FDAT_, cinfo);

                cmd.Parameters.Add("KOD", OracleDbType.Varchar2, kod_, ParameterDirection.Input);
                cmd.Parameters.Add("IDF", OracleDbType.Varchar2, idf_, ParameterDirection.Input);
                cmd.Parameters.Add("FDAT", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("ND", OracleDbType.Int64, Convert.ToInt64(nd_), ParameterDirection.Input);
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(rnk_), ParameterDirection.Input);
                cmd.CommandText = ("select fin_nbu.ZN_P_ND(:KOD, :IDF, :FDAT, :ND, :RNK) as SN from dual");
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    SS_ = rdr["SN"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SN"];
                    if (SS_ != null)
                    { return SS_; }
                    else { return 0; }
                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return 0;
        }
    }


    protected void record_fp_nd(string kod_, String s_, string idf_)
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("kod_", DB_TYPE.Varchar2, kod_, DIRECTION.Input);
                SetParameters("s_", DB_TYPE.Decimal, s_, DIRECTION.Input);
                SetParameters("idf_", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(DAT_.Value, cinfo), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SQL_NONQUERY("begin  fin_nbu.record_fp_ND(:kod_, :s_, :idf_, :dat_, :nd_, :rnk_ );  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void calc_pd()
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";
                Decimal cls_ = Convert.ToDecimal(Dl_clas.SelectedValue);
                ClearParameters();
                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(DAT_.Value, cinfo), DIRECTION.Input);
                SetParameters("cls_", DB_TYPE.Decimal, cls_, DIRECTION.Input);
                SetParameters("vncr_", DB_TYPE.Varchar2, Dl_bkrr.SelectedValue, DIRECTION.Input);
                SQL_NONQUERY("begin  fin_nbu.calc_pd_fl( :rnk_, :nd_,  :dat_, :cls_, :vncr_ );  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void Bt_tofolders_Click(object sender, EventArgs e)
    {
        backToFolders("/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_fl&rnk=" + Convert.ToString(RNK_.Value));
    }

    protected void backToFolders(String p_url)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + p_url + "')", true);
    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
    }
 
    protected void Bt_save_Click(object sender, EventArgs e)
    {

        if (String.IsNullOrEmpty(Dl_clas.SelectedValue))     { ShowError(" Заповніть!!! " + Lb_clas.Text); return; }
        if (String.IsNullOrEmpty(Dl_bkrr.SelectedValue))     {ShowError(" Заповніть!!! " + Lb_VNKR.Text); return;}
        if (String.IsNullOrEmpty(DL_kredhist.SelectedValue)) {ShowError(" Заповніть!!! " + Lb_kredhist.Text); return;}
        if (String.IsNullOrEmpty(DL_kpz.SelectedValue))      { ShowError(" Заповніть!!! " + Lb_kpz.Text); return; }

        record_fp_nd("IP1", DL_kredhist.SelectedValue, "60");
        record_fp_nd("IP2", DL_kpz.SelectedValue, "60");
        record_fp_nd("CLS", Dl_clas.SelectedValue, "60");
        set_nd_vncrr(ND_.Value, RNK_.Value, Dl_bkrr.SelectedValue);
        record_fp_nd("ZKD", (Cb_zkd.Checked)?("1"):("0"), "60");
        // розрахунок PD
            calc_pd();
            Tb_pd.Text = String.Format("{0:N3}", read_nd_d(ND_.Value, RNK_.Value, "PD", "60", DAT_.Value));
            ShowError(" Дані збережено успішно!!! ");
    }

    protected void Cb_zkd_Checked()
    {
        if (Cb_zkd.Checked == true) DL_kpz.Enabled = true;
        else DL_kpz.Enabled = false;
    }

    protected void Cb_zkd_CheckedChanged(object sender, EventArgs e)
    {
        Cb_zkd_Checked(); 
    }
    protected void Dl_SelectedIndexChanged(object sender, EventArgs e)
    {
        Tb_pd.Text = null;
    }
}