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



public partial class credit_defolt : Bars.BarsPage
{

    String ErrR = "0";
    String Err_name;


    protected void Page_Load(object sender, EventArgs e)
    {
        
        // Create the ToolTip and associate with the Form container.
        ToolTip toolTip1 = new ToolTip();

        // Set up the delays for the ToolTip.
        toolTip1.AutoPopDelay = 200000;  //Возвращает или задает интервал времени, в течение которого всплывающая подсказка отображается на экране
        toolTip1.InitialDelay = 500;    //Возвращает или задает время, которое проходит до появления подсказки.
        toolTip1.ReshowDelay = 500;
        // Force the ToolTip text to be displayed whether or not the form is active.
        toolTip1.ShowAlways = true;
        toolTip1.ToolTipTitle = "132465798";
        Decimal Set_Papams;


        if (!IsPostBack)
        {

            //RNK_.Value = "6611";
            //ND_.Value  = "9456521";
            if (Request["RNK"] != null) { RNK_.Value = Convert.ToString(Request["RNK"]); }
            if (Request["ND"] != null) { ND_.Value = Convert.ToString(Request["ND"]); }

            //Активуємо першу закладку  Wizard1
            Wizard1.ActiveStepIndex = 0;

            if (ND_.Value == "-1") { Dl_val.Visible = true; Lb_val.Visible = true; }
            else { Dl_val.Visible = false; Lb_val.Visible = false; }

            // Наповнюємо стартові даніна сторінку
            load_form();

            // Автоматизоване визначення чи входить клієнт до групи
            //rnk_group();

            // Розрахунок класу позичальника з інтегрального показника.   //переніс в load_form
            calculation_class();
            //Tb_clas.Text = read_zn_p(Tb_okpo.Text, "CLAS", "6", TB_Dat.Text);


            Set_Papams = read_osbb(RNK_.Value);

            if (Set_Papams == 1)
            {
                tb_vncr.Enabled = true;
                Ib_save_vncrr.Visible = true;
                Ib_vncrr.Visible = false;
            }
            else
            {
                tb_vncr.Enabled = false;
                Ib_save_vncrr.Visible = false;
                Ib_vncrr.Visible = true;
            }
        }

    }

    public static Decimal read_osbb(String rnk_)
    {
        Decimal res_type_; 
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(rnk_), ParameterDirection.Input);
                cmd.CommandText = ("select f_get_osbb_k110_type(:RNK) as RES from dual");
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    res_type_ = rdr["RES"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["RES"];
                    if (res_type_ != null)
                    { return Convert.ToDecimal(res_type_); }
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

    public static Decimal greatest(Decimal par1_, Decimal Par2_ )
    {
        Decimal Par_ = par1_;
        if (Par2_ > Par_) Par_ = Par2_;
        return Par_;
    }

    public static Decimal least(Decimal par1_, Decimal Par2_)
    {
        Decimal Par_ = par1_;
        if (Par2_ < Par_) Par_ = Par2_;
        return Par_;
    }


    public static String read_zn_p(String okpo_, String kod_, String idf_, String FDAT_)
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
                cmd.Parameters.Add("OKPO", OracleDbType.Int64, Convert.ToInt64(okpo_), ParameterDirection.Input);

                cmd.CommandText = ("select to_char(fin_nbu.ZN_P(:KOD, :IDF, :FDAT, :OKPO)) as SN from dual");
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

    /// <summary>
    /// 
    /// </summary>
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
                cmd.CommandText = ("select to_char(fin_nbu.ZN_P_ND(:KOD, :IDF, :FDAT, :ND, :RNK, null)) as SN from dual");
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


    /// <summary>
    /// 
    /// </summary>
    public static String read_nd_hist(String nd_, String rnk_, String kod_, String idf_, String FDAT_)
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
                cmd.CommandText = ("select to_char(fin_nbu.ZN_P_ND_hist(:KOD, :IDF, :FDAT, :ND, :RNK )) as SN from dual");
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
    /// <summary>
    /// 
    /// </summary>
    public static Decimal read_nd_n(String nd_, String rnk_, String kod_, String idf_, String FDAT_)
    {
        Decimal SS_;
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
                    //String SS_;
                    //SS_ = rdr["SN"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SN"];
                    SS_ = rdr["SN"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SN"];
                    if (SS_ != null)
                    { return Convert.ToDecimal(SS_); }
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

        //return "123";
    }

    /// <summary>
    /// 
    /// </summary>
    public static DateTime read_nd_date(String nd_, String rnk_, String kod_, String idf_, String FDAT_)
    {
        DateTime SS_;
        {


            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                if (FDAT_ == null) return Convert.ToDateTime(null);



                DateTime dat = Convert.ToDateTime(FDAT_, cinfo);



                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("KOD", OracleDbType.Varchar2, kod_, ParameterDirection.Input);
                cmd.Parameters.Add("IDF", OracleDbType.Varchar2, idf_, ParameterDirection.Input);
                cmd.Parameters.Add("FDAT", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("ND", OracleDbType.Int64, Convert.ToInt64(nd_), ParameterDirection.Input);
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(rnk_), ParameterDirection.Input);

                cmd.CommandText = ("select fin_nbu.ZN_P_ND_date(:KOD, :IDF, :FDAT, :ND, :RNK) as SN from dual");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {

                    SS_ = rdr["SN"] == DBNull.Value ? (DateTime)Convert.ToDateTime("01/01/1900", cinfo) : (DateTime)rdr["SN"];
                    if (SS_ != null)
                    { return SS_; }
                    else { return SS_; }
                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }


            return Convert.ToDateTime(null);

        }


    }

    /// <summary>
    /// 
    /// </summary>
    public static DateTime read_nd_date_hist(String nd_, String rnk_, String kod_, String idf_, String FDAT_)
    {
        DateTime SS_;
        {


            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                if (FDAT_ == null) return Convert.ToDateTime(null);



                DateTime dat = Convert.ToDateTime(FDAT_, cinfo);



                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("KOD", OracleDbType.Varchar2, kod_, ParameterDirection.Input);
                cmd.Parameters.Add("IDF", OracleDbType.Varchar2, idf_, ParameterDirection.Input);
                cmd.Parameters.Add("FDAT", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("ND", OracleDbType.Int64, Convert.ToInt64(nd_), ParameterDirection.Input);
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(rnk_), ParameterDirection.Input);

                cmd.CommandText = ("select fin_nbu.ZN_P_ND_date_hist(:KOD, :IDF, :FDAT, :ND, :RNK) as SN from dual");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    SS_ = rdr["SN"] == DBNull.Value ? (DateTime)Convert.ToDateTime(null, cinfo) : (DateTime)rdr["SN"];
                    return SS_;
                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }


            return Convert.ToDateTime(null);

        }


    }

    /// <summary>
    ///  fin_nbu.record_fp_nd (KOD_, S_, IDF_)
    /// </summary>
    protected void record_fp_nd(string kod_, Decimal s_, string idf_)
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
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
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

    /// <summary>
    ///  fin_nbu.record_fp_nd (KOD_, S_, IDF_)
    /// </summary>
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
                SetParameters("s_", DB_TYPE.Varchar2, s_, DIRECTION.Input);
                SetParameters("idf_", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
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

    /// <summary>
    ///  record_fp
    /// </summary>
    /// <param name="kod_"></param>
    /// <param name="s_"></param>
    /// <param name="idf_"></param>
    protected void record_fp(string kod_, decimal s_, string idf_)
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
                SetParameters("s_", DB_TYPE.Varchar2, s_, DIRECTION.Input);
                SetParameters("idf_", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
                SetParameters("okpo_", DB_TYPE.Decimal, Convert.ToDecimal(Tb_okpo.Text), DIRECTION.Input);
                SQL_NONQUERY("begin  fin_nbu.record_fp(:kod_, :s_, :idf_, :dat_, :okpo_ );  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void record_fp(string kod_, decimal s_, string idf_, String dat_ )
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
                SetParameters("s_", DB_TYPE.Varchar2, s_, DIRECTION.Input);
                SetParameters("idf_", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(dat_, cinfo), DIRECTION.Input);
                SetParameters("okpo_", DB_TYPE.Decimal, Convert.ToDecimal(Tb_okpo.Text), DIRECTION.Input);
                SQL_NONQUERY("begin  fin_nbu.record_fp(:kod_, :s_, :idf_, :dat_, :okpo_ );  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    ///  fin_nbu.record_fp_nd_date (KOD_, val_date_, IDF_)
    /// </summary>
    protected void record_fp_nd_date(string kod_, DateTime val_date_, string idf_)
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
                SetParameters("val_date_", DB_TYPE.Date, val_date_, DIRECTION.Input);
                SetParameters("idf_", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SQL_NONQUERY("begin  fin_nbu.record_fp_ND_date(:kod_, :val_date_, :idf_, :dat_, :nd_, :rnk_ );  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    ///  розрахунок відповідей  fin_nbu.get_subpok
    /// </summary>
    protected void get_subpok()
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
                SetParameters("zdat_", DB_TYPE.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), DIRECTION.Input);

                SQL_NONQUERY("begin  fin_nbu.get_subpok(:rnk_, :nd_, :dat_, :zdat_);  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    ///  розрахунок відповідей  fin_nbu.get_subpok
    /// </summary>
    protected void get_restr()
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
                SetParameters("zdat_", DB_TYPE.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), DIRECTION.Input);

                SQL_NONQUERY("begin  fin_nbu.get_restr(:rnk_, :nd_, :dat_, :zdat_);  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    ///   Автоматизоване визначення чи входить клієнт до групи
    /// </summary>
    protected void rnk_group()
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
                SetParameters("zdat_", DB_TYPE.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), DIRECTION.Input);
                SetParameters("okpo_", DB_TYPE.Varchar2, Tb_okpo.Text, DIRECTION.Input);

                SQL_NONQUERY("begin  fin_nbu.rnk_group(:rnk_, :nd_, :dat_, :zdat_, :okpo_);  end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    ///  Корегування класу позичальника (Постанова 351)  fin_nbu.adjustment_class
    /// </summary>
    protected void adjustment_class()
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
                SetParameters("zdat_", DB_TYPE.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), DIRECTION.Input);

                SQL_NONQUERY(@"declare
                               l_rnk number := :rnk_; 
                               l_nd number  := :nd_; 
                               l_dat date   := :dat_; 
                               l_zdat date  := :zdat_;
                               begin  
                                   fin_nbu.adjustment_class(l_rnk, l_nd, l_dat, l_zdat);  
                                   fin_nbu.add_findat(l_rnk, l_nd, l_dat);   
                               end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    ///  calculation_class  розрахунок класу позичальника по інтегральному показнику
    /// </summary>
    protected void calculation_class()
    {
        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), DIRECTION.Input);

                SQL_NONQUERY(@"declare
                               l_rnk number := :rnk_;
                               l_dat date   := :dat_;
                               begin  
                                 fin_nbu.calculation_class(l_rnk, l_dat);  
                               end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }


    /// <summary>
    /// Зберігаємо дані гріда Wizard0
    /// </summary>
    protected void save_gr0()
    {


        ErrR = "0";

        if (String.IsNullOrEmpty(tb_vncr.SelectedValue) && Tb_okpo.Text.Length != 12 )
        {
            ErrR = "1";
            Err_name = Err_name + ".  ВНКР  <>  Необхідно провести розрахунок ВНКР!!! ";
        }


        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep0);
        }

     
         

    }

    /// <summary>
    /// Зберігаємо дані гріда Wizard1
    /// </summary>
    protected void save_gr1(String par_, Decimal clas_)
    {
        ErrR = "0";
        int pos = 0;
        Decimal p_clas = clas_;
        foreach (GridViewRow row in GridView_GP.Rows)
        {
            if (row.Cells[1].Controls[1] is DropDownList)
            {
                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
                string NAME_ = Convert.ToString(GridView_GP.DataKeys[pos].Values[2]);
                if (tb1.Text != "-99")
                {
                    Decimal ORD = Convert.ToDecimal(GridView_GP.DataKeys[pos].Values[4]);
                    string  KOD = Convert.ToString(GridView_GP.DataKeys[pos].Values[0]);
                    string  IDF = Convert.ToString(GridView_GP.DataKeys[pos].Values[1]);
                    if (par_ == "1") 
                      { 
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
                        if (ORD >= 6  && ORD <= 9  && Convert.ToDecimal(tb1.Text) == 1) { p_clas = greatest(p_clas, 5); }
                        if (ORD >= 10 && ORD <= 13 && Convert.ToDecimal(tb1.Text) == 1) { p_clas = greatest(p_clas, 8); }
                        if (ORD >= 14 && ORD <= 18 && Convert.ToDecimal(tb1.Text) == 1) { p_clas = greatest(p_clas, 10); }
                        
                      }
                }
                else
                {
                    ErrR = "1";
                    Err_name = Err_name + NAME_ + "      ";
                }
            }
            pos++;
        }

        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
        }

        Tb_cls2.Text = Convert.ToString(p_clas);
        //record_fp_nd("CLS2", Convert.ToString(p_clas), "56");

    }


    /// <summary>
    /// Зберігаємо дані гріда Wizard2
    /// </summary>
    protected void save_gr2()
    {
        //char j = (char)10;
        ErrR = "0";
        int pos = 0;
        foreach (GridViewRow row in GrWiz2.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
                string NAME_ = Convert.ToString(GrWiz2.DataKeys[pos].Values[2]);
                string KOD = Convert.ToString(GrWiz2.DataKeys[pos].Values[0]);
                string IDF = Convert.ToString(GrWiz2.DataKeys[pos].Values[1]);
                if (tb1.Text != "-99")
                {

                    //if (Convert.ToString(GrWiz2.DataKeys[pos].Values[3]) == "0")
                    //{
                        // string KOD = Convert.ToString(GrWiz2.DataKeys[pos].Values[0]);
                        // string IDF = Convert.ToString(GrWiz2.DataKeys[pos].Values[1]);
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
                    //}
                }
                else
                {
                    ErrR = "1";
                    Err_name = Err_name + NAME_ + "      " + KOD + IDF;
                }
            }
            pos++;
        }

        //pos = 0;
        //foreach (GridViewRow row in GrWiz2_kl.Rows)
        //{

        //    if (row.Cells[1].Controls[1] is DropDownList)
        //    {

        //        DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
        //        string NAME_ = Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[2]);
        //        string KOD = Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[0]);
        //        string IDF = Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[1]);
        //        if (tb1.Text != "-99")
        //        {

        //            if (Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[3]) == "0")
        //            {
        //                record_fp(KOD, Convert.ToDecimal(tb1.Text), IDF);
        //                record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
        //            }
        //        }
        //        else
        //        {
        //            ErrR = "1";
        //            Err_name = Err_name + NAME_ + "      " + KOD + IDF;
        //        }
        //    }
        //    pos++;
        //}
        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep2);
        }
    }


    /// <summary>
    /// Зберігаємо дані гріда Wizard3
    /// </summary>
    protected void save_gr3()
    {
        //Response.Write("save_gr3");
        //char j = (char)10;
        ErrR = "0";
        int pos = 0;
        String RK1_ = "0";

        foreach (GridViewRow row in GrWiz3.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);

                if (tb1.Text == "1" || tb1.Text == "11") RK1_ = "1";

                string NAME_ = Convert.ToString(GrWiz3.DataKeys[pos].Values[2]);
                if (tb1.Text != "-99")
                {

                    if (Convert.ToString(GrWiz3.DataKeys[pos].Values[3]) == "0")
                    {
                        string KOD = Convert.ToString(GrWiz3.DataKeys[pos].Values[0]);
                        string IDF = Convert.ToString(GrWiz3.DataKeys[pos].Values[1]);
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
                    }

                }
                else
                {
                    ErrR = "1";
                    Err_name = Err_name + NAME_ + "      ";
                }
            }
            pos++;
        }

        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep3);
        }

        record_fp_nd_date("PD8D", Convert.ToDateTime(tb_PD8_d.Value), "53");
        record_fp_nd("RK1", RK1_, "56");
        Tb_ZDN1_TextChanged(null, null);
    }

    /// <summary>
    /// Зберігаємо дані гріда Wizard4
    /// </summary>
    protected void save_gr4()
    {
        //Response.Write("save_gr4");
        //char j = (char)10;
        ErrR = "0";
        int pos = 0;
        String RK2_ = "0";

        if (String.IsNullOrEmpty(Tb_kres.Text))
        {
            ErrR = "1";
            Err_name = " Не заповнено поле " + Lb_Kres.Text;
            ShowError(Err_name);
            return;
        }

        if (Convert.ToDecimal(Tb_kres.Text) > 0 & String.IsNullOrEmpty(Tb_Klres.Text))
        {
            ErrR = "1";
            Err_name = " Не заповнено поле " + Lb_klres.Text;
            ShowError(Err_name);
            return;
        }
        if (Convert.ToDecimal(Tb_kres.Text) > 0 & String.IsNullOrEmpty(Tb_kdpres.Text))
        {
            ErrR = "1";
            Err_name = " Не заповнено поле " + Lb_kdpres.Text;
            ShowError(Err_name);
            return;
        }


        foreach (GridViewRow row in GrWiz4.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);

                if (tb1.Text == "1") RK2_ = "1";

                string NAME_ = Convert.ToString(GrWiz4.DataKeys[pos].Values[2]);
                if (tb1.Text != "-99")
                {

                    if (Convert.ToString(GrWiz4.DataKeys[pos].Values[3]) == "0")
                    {
                        string KOD = Convert.ToString(GrWiz4.DataKeys[pos].Values[0]);
                        string IDF = Convert.ToString(GrWiz4.DataKeys[pos].Values[1]);
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);

                        if (
                            Convert.ToDecimal(Tb_kres.Text) > 0 &
                            Convert.ToString(tb1.Text) == "1" &
                            KOD == "VD2")
                        {
                            if (Convert.ToDecimal(Tb_Klres.Text) >= 8 || Convert.ToDecimal(Tb_kdpres.Text) > 30)
                            { }
                            else
                            {
                                ErrR = "1";
                                Err_name = NAME_ + " не може приймати значення Так ";
                                ShowError(Err_name);
                                return;
                            }
                        }
                        if (
                            Convert.ToDecimal(Tb_kres.Text) == 0 &
                            Convert.ToString(tb1.Text) == "1" &
                            KOD == "VD2")
                        {
                            ErrR = "1";
                            Err_name = NAME_ + " не може приймати значення Так ";
                            ShowError(Err_name);
                            return;
                        }

                    }

                }
                else
                {
                    ErrR = "1";
                    Err_name = Err_name + NAME_ + "      ";
                }
            }
            pos++;
        }

        if (String.IsNullOrEmpty(Dd_VD0.SelectedValue))
            {
                ErrR = "1";
                Err_name = Err_name + "Наявність судження Банку про відстутність умовних ознак визнання дефолту боржника " + "      ";
            }

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        if (!String.IsNullOrEmpty(Tb_VDN1.Text) & (Convert.ToString(Tb_VDD1.Value, cinfo) == "01/01/0001" || String.IsNullOrEmpty(Convert.ToString(Tb_VDD1.Value, cinfo))))
        {
            ErrR = "1";
            Err_name = Err_name + "Дата Рішення колегіального органу  " + "      ";
        }

        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep3);
        }


        if (!String.IsNullOrEmpty(Tb_VDN1.Text) & !String.IsNullOrEmpty(Convert.ToString(Tb_VDD1.Value, cinfo)))  { RK2_ = "0"; }



        record_fp_nd("RK2", RK2_, "56");

        record_fp_nd("VD0", Dd_VD0.SelectedValue, "56");
        record_fp_nd("VDN1", Tb_VDN1.Text, "56");
        record_fp_nd_date("VDD1", Convert.ToDateTime(Tb_VDD1.Value) , "56");

        //З моменту усунення подій на підставі яких було визнано дефолт минуло щонайменше 180 днів
        elimination_events();
        

    }

    /// <summary>
    /// Зберігаємо дані гріда Wizard5
    /// </summary>
    protected void save_gr5()
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";
        ErrR = "0";

        if ( String.IsNullOrEmpty(Dd_zd6.SelectedValue ))
        {
            ErrR = "1";
            Err_name = Err_name + "Відбулась фінансова реструктуризація  " + "      ";
        }

        

        if (Dd_zd6.SelectedValue == "1")
        {   //Відбулась фінансова реструктуризація  - Yes
            if ((Convert.ToString(Tb_dzd6.Value, cinfo) == "01/01/1901 00:00:00" || String.IsNullOrEmpty(Convert.ToString(Tb_dzd6.Value, cinfo))))
            {
                ErrR = "1";
                Err_name = Err_name + "Дата фінансової реструктуризації " + "      ";
            }

            if (String.IsNullOrEmpty(Dd_zd8.SelectedValue))
            {
                ErrR = "1";
                Err_name = Err_name + "Запроваджено процедуру фінансової реструктуризації ?  " + "      ";
            }

            if (String.IsNullOrEmpty(Dd_zd7.SelectedValue))
            {
                ErrR = "1";
                Err_name = Err_name + "Зняти дефолт?  " + "      ";
            }

            
            if (Dd_zd7.SelectedValue == "1")
            {
                if (String.IsNullOrEmpty(Convert.ToString(tb_dzd7.Value, cinfo)) || (Convert.ToString(tb_dzd7.Value, cinfo) == "01/01/1901 00:00:00"))
                {
                    ErrR = "1";
                    Err_name = Err_name + "Рішення колегіального органу дата " + "      ";
                }

                if (String.IsNullOrEmpty(Tb_nzd7.Text))
                {
                    ErrR = "1";
                    Err_name = Err_name + "Рішення колегіального органу № " + "      ";
                }

            }
            else
            {

            }


            if (ErrR == "1")
            {
                ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
                Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep3);
            }


            if (Dd_zd7.SelectedValue == "1")
            { record_fp_nd("RK3", "1", "56"); }  // знімаємо   дефолт
            else
            { record_fp_nd("RK3", "0", "56"); }  // не знімаємо дефолт

            record_fp_nd("ZD1", null, "55");
            record_fp_nd("ZD2", null, "55");
            record_fp_nd("ZD3", null, "55");
            record_fp_nd("ZDN1", null, "57");


        }
        else 
        {
            save_gr5_defolt();
        }

        record_fp_nd("ZD6", Dd_zd6.SelectedValue, "55");
        record_fp_nd("ZD7", Dd_zd7.SelectedValue, "55");

        record_fp_nd_date("DZD6", Convert.ToDateTime(tb_dzd7.Value), "55");
        record_fp_nd("NZD7", Tb_nzd7.Text, "55");
        record_fp_nd_date("DZD7", Convert.ToDateTime(tb_dzd7.Value), "55");
        record_fp_nd("ZD8", Dd_zd8.SelectedValue, "55");


        FillData_Wizar6();

    }
    /// <summary>
    /// 
    /// </summary>
    protected void save_gr5_defolt()
    {
        ErrR = "0";
        int pos = 0;
        String RK3_ = "1";

        foreach (GridViewRow row in GrWiz5.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);

                if (tb1.Text == "0") RK3_ = "0";

                string NAME_ = Convert.ToString(GrWiz5.DataKeys[pos].Values[2]);
                if (tb1.Text != "-99")
                {

                    if (Convert.ToString(GrWiz5.DataKeys[pos].Values[3]) == "0")
                    {
                        string KOD = Convert.ToString(GrWiz5.DataKeys[pos].Values[0]);
                        string IDF = Convert.ToString(GrWiz5.DataKeys[pos].Values[1]);
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
                    }

                }
                else
                {
                    ErrR = "1";
                    Err_name = Err_name + NAME_ + "      ";
                }
            }
            pos++;
        }


        if (String.IsNullOrEmpty(Dl_ZD3.SelectedValue))
        {
            ErrR = "1";
            Err_name = Err_name + "Банк має документально підтверджене обґрунтоване судження, що Контрагент, попри наявні фінансові труднощі, спроможний обслуговувати борг  " + "      ";
        }
        else
        {
            if (Dl_ZD3.SelectedValue == "0") RK3_ = "0";
        }

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        if (String.IsNullOrEmpty(dl_ZD4.SelectedValue))
        {
            ErrR = "1";
            Err_name = Err_name + "З моменту усунення події/подій, на підставі якої/яких було визнано дефолт божника, минуло щонайменше 180 днів   " + "      ";
        }
        else
        {
            if (!String.IsNullOrEmpty(Tb_ZDN1.Text) & (Convert.ToString(Tb_ZDD1.Value, cinfo) == "01/01/1900 00:00:00" || String.IsNullOrEmpty(Convert.ToString(Tb_ZDD1.Value, cinfo))))
            {
                ErrR = "1";
                Err_name = Err_name + "Дата рішення колегіального органу " + "      ";

            }
        }



        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep3);
        }

        //Тобто, якщо за параметром «Наявність ознак для визнання події дефолту» стоїть відмітка «ТАК», та за всіма параметрами, наведеними у цьому пункті стоїть відмітка «ТАК», 
        //то параметру «Припинення визнання дефолту» присвоюється відмітка «ТАК». У всіх інших випадках – «НІ».

        //Параметр «Припинення визнання дефолту» не може набути значення «ТАК», якщо параметру «Подія дефолту настала» присвоєно значення «ТАК».


        if (read_nd(ND_.Value, RNK_.Value, "RK2", "56", Dl_Zdat.SelectedValue) == "1" && RK3_ == "1")
        {
            if (read_nd(ND_.Value, RNK_.Value, "RK1", "56", Dl_Zdat.SelectedValue) == "1")
            { record_fp_nd("RK3", "0", "56"); }
            else
            { record_fp_nd("RK3", "1", "56"); }
        }
        else
        {
            record_fp_nd("RK3", "0", "56");
        }


        record_fp_nd("ZD3", Dl_ZD3.SelectedValue, "55");
        record_fp_nd("ZDN1", Tb_ZDN1.Text, "57");
        record_fp_nd_date("ZDD1", Convert.ToDateTime(Tb_ZDD1.Value), "57");
    }
    /// <summary>
    /// Зберігаємо дані гріда Wizard5
    /// </summary>
    protected void save_gr6()
    {
        //Response.Write("save_gr6");
        ErrR = "0";
        int pos = 0;

        foreach (GridViewRow row in GrWiz6.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
                string NAME_ = Convert.ToString(GrWiz6.DataKeys[pos].Values[2]);
                string KOD = Convert.ToString(GrWiz6.DataKeys[pos].Values[0]);
                string IDF = Convert.ToString(GrWiz6.DataKeys[pos].Values[1]);
                if (tb1.Text != "-99")
                {
                        record_fp(KOD, Convert.ToDecimal(tb1.Text), IDF);
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
                }
                else
                {
                    ErrR = "1";
                    Err_name = Err_name + NAME_ + "      " + KOD + IDF;
                }
            }
            pos++;
        }
        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep2);
        }


       
        FillData_Wizar7();
    }

    /// <summary>
    /// Стартова вичитка даних по угоді та клієнту
    /// </summary>
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
            cmd.CommandText = @"  select v.cc_id, to_char(v.sdate) sdate
                                  from v_fin_cc_deal v
                                 where v.nd = :nd_ and v.rnk =:rnk_";
            OracleDataReader rdr0 = cmd.ExecuteReader();
            if (rdr0.Read())
            {
                Tb_NumU.Text = rdr0["CC_ID"] == DBNull.Value ? (String)null : (String)rdr0["CC_ID"];
                Tb_DatU.Text = rdr0["SDATE"] == DBNull.Value ? (String)null : (String)rdr0["SDATE"];
                Lb3.Text = rdr0["CC_ID"] == DBNull.Value ? (String)null : (String)rdr0["CC_ID"];
                Lb4.Text = rdr0["SDATE"] == DBNull.Value ? (String)null : (String)rdr0["SDATE"];
            }


            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            //cmd.Parameters.Add("ND_",  OracleDbType.Decimal, nd , ParameterDirection.Input);
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.CommandText = @"  select c.nmk nmkk, to_char(C.datea,'dd/mm/yyyy') datea, c.okpo,
                                         to_char(gl.bd,'dd/mm/yyyy') zp_dat, 
                                         (select to_char(nvl(max(fdat), trunc(gl.bd,'Q') ),'dd/mm/yyyy') from fin_fm where okpo = c.okpo and fdat < gl.bd) dat 
                                  from  fin_customer c
                                 where  rnk =:rnk_";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                Tb_nmk.Text = (String)rdr["NMKK"];   Lb1.Text=(String)rdr["NMKK"];
                Tb_okpo.Text = (String)rdr["OKPO"];  Lb2.Text = (String)rdr["OKPO"];
                TB_Date_open.Text = rdr["DATEA"] == DBNull.Value ? (String)null : (String)rdr["DATEA"];
                TB_Dat.Text = rdr["DAT"] == DBNull.Value ? (String)null : (String)rdr["DAT"];

                if (!IsPostBack)
                {
                    try
                    {
                        InitOraConnection();
                        String l_sql_dat = "select to_char(dat,'dd/mm/yyyy') dat from (select  add_months(trunc(to_date('" + (String)rdr["ZP_DAT"] + "','dd/mm/yyyy'),'mm'),num-2) dat from conductor where 3 >= num) where dat >= to_date('" + (String)rdr["ZP_DAT"] + "','dd/mm/yyyy')-10 order by 1 ";
                        Dl_Zdat.DataSource = SQL_SELECT_dataset(l_sql_dat).Tables[0];
                        Dl_Zdat.DataTextField = "dat";
                        Dl_Zdat.DataValueField = "dat";
                       // Dl_Zdat.DataTextFormatString = " {0:dd/MM/yyyy} ";
                        Dl_Zdat.DataBind();

                        Dl_Zdat.SelectedValue = (String)rdr["ZP_DAT"];


                    }
                    finally
                    {
                        DisposeOraConnection();
                    }

                }



            }

            // VNKR вичитуємо для звітного періода

            DateTime dat = Convert.ToDateTime(TB_Dat.Text, cinfo);

            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            cmd.Parameters.Add("DAT_", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.CommandText = @" Select nvl( fin_obu.GET_VNKR ( DAT_ =>  :DAT_,
                                                                RNK_ =>  :RNK_,
                                                                ND_  =>  :ND_),
                                             fin_zp.zn_vncrr(:rnk_, :nd_) )  vnkrr 
                                           from dual";
            OracleDataReader rdr2 = cmd.ExecuteReader();

            if (rdr2.Read())
            {
                tb_vncr.SelectedValue = rdr2["VNKRR"] == DBNull.Value ? (String)null : (String)rdr2["VNKRR"];
                if (String.IsNullOrEmpty(tb_vncr.SelectedValue))
                {
                    Ib_vncrr.Visible = true;
                    Sp2.Visible = true;
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



        // Автоматизоване визначення чи входить клієнт до групи
        rnk_group();

        // Наповнимо DropDownList
        try
        {
            InitOraConnection();
            Dl_NgrK.DataBind();
            Dl_NgrP.DataBind();

            

            Dl_GK1_1.DataBind();
            Dl_GK1_1.Items.Insert(0, new ListItem("", ""));

            Dl_GK1_2.DataBind();
            Dl_GK1_2.Items.Insert(0, new ListItem("", ""));

            Dl_GK2.DataBind();
            Dl_GK2.Items.Insert(0, new ListItem("", ""));

            Dl_GK2_2.DataBind();
            Dl_GK2_2.Items.Insert(0, new ListItem("", ""));

            //Dl_NgrK.Items.Insert(0, new ListItem("", ""));
            Dd_NKZV.DataBind();
            Dd_NKZV.Items.Insert(0, new ListItem("", ""));


            Dl_GK3.DataBind();
            Dl_GK3.Items.Insert(0, new ListItem("", ""));

            Dl_GK4.DataBind();
            Dl_GK4.Items.Insert(0, new ListItem("", ""));

            Dl_GK5.DataBind();
            Dl_GK5.Items.Insert(0, new ListItem("", ""));


            Dl_GP1.DataBind();
            Dl_GP1.Items.Insert(0, new ListItem("", ""));

            Dl_GP2.DataBind();
            Dl_GP2.Items.Insert(0, new ListItem("", ""));

            Dl_GP3.DataBind();
            Dl_GP3.Items.Insert(0, new ListItem("", ""));

            Dl_GP4.DataBind();
            Dl_GP4.Items.Insert(0, new ListItem("", ""));

            Dl_GP5.DataBind();
            Dl_GP5.Items.Insert(0, new ListItem("", ""));

            Dd_VD0.DataBind();
            Dd_VD0.Items.Insert(0, new ListItem("", ""));

            Dl_ZD3.DataBind();
            Dl_ZD3.Items.Insert(0, new ListItem("", ""));

            dl_ZD4.DataBind();
            dl_ZD4.Items.Insert(0, new ListItem("", ""));


            Dd_zd6.DataBind();
            Dd_zd6.Items.Insert(0, new ListItem("", ""));

            Dd_zd7.DataBind();
            Dd_zd7.Items.Insert(0, new ListItem("", ""));

            Dd_zd8.DataBind();
            Dd_zd8.Items.Insert(0, new ListItem("", ""));

            Dl_val.DataBind();
            Dl_tzvd.DataBind();

            tb_vncr.DataBind();

            //Dl_inv.DataBind();
            //Dl_etp.DataBind();
            //Dl_etp.Items.Insert(0, new ListItem("", ""));

            //Dl_tzvd.Items.Insert(0, new ListItem("", ""));


            Dd_RK1.DataBind();
            Dd_RK1.Items.Insert(0, new ListItem("", ""));
            Dd_RK2.DataBind();
            Dd_RK2.Items.Insert(0, new ListItem("", ""));
            Dd_RK3.DataBind();
            Dd_RK3.Items.Insert(0, new ListItem("", ""));

            

        }
        finally
        {
            DisposeOraConnection();
        }


        // Розрахунок класу позичальника з інтегрального показника.
        //calculation_class();
        Tb_clas.Text = read_zn_p(Tb_okpo.Text, "CLAS", "6", TB_Dat.Text);


        // Розрахунок відповідей по замовчуванню
        //get_subpok();


        // Насиляємо гриди
        //wizard0
        Dl_NgrK.SelectedValue = read_nd(ND_.Value, RNK_.Value, "NGRK", "51", Dl_Zdat.SelectedValue);
        Dl_NgrP.SelectedValue = read_nd(ND_.Value, RNK_.Value, "NGRP", "51", Dl_Zdat.SelectedValue);

         
        Dl_GK2.SelectedValue = read_nd(ND_.Value, RNK_.Value, "GK2", "51", Dl_Zdat.SelectedValue);

        Selected_DlNgrk();
        Selected_DlNkzv();
        

        get_restr();
        Tb_kres.Text = read_nd(ND_.Value, RNK_.Value, "KRES", "51", Dl_Zdat.SelectedValue);
        tb_dpres.Value = read_nd_date(ND_.Value, RNK_.Value, "DRES", "51", Dl_Zdat.SelectedValue);
        Tb_Klres.Text = read_nd(ND_.Value, RNK_.Value, "CRES", "51", Dl_Zdat.SelectedValue);
        Tb_kdpres.Text = read_nd(ND_.Value, RNK_.Value, "PRES", "51", Dl_Zdat.SelectedValue);

        try {Dl_tzvd.SelectedValue = read_zn_p(Tb_okpo.Text, "TZVT", "6", TB_Dat.Text);} catch (Exception) { } 
        
        //Dl_inv.SelectedValue = read_zn_p(Tb_okpo.Text, "INV", "32", TB_Dat.Text);
        //Dl_etp.SelectedValue = read_zn_p(Tb_okpo.Text, "ETP", "32", TB_Dat.Text);

        Dd_zd6.SelectedValue = read_nd(ND_.Value, RNK_.Value, "ZD6", "55", Dl_Zdat.SelectedValue);
        Dd_zd7.SelectedValue = read_nd(ND_.Value, RNK_.Value, "ZD7", "55", Dl_Zdat.SelectedValue);
        Dd_zd8.SelectedValue = read_nd(ND_.Value, RNK_.Value, "ZD8", "55", Dl_Zdat.SelectedValue);
        Dd_zd6_SelectedIndexChanged(null, null);
        Dd_zd7_SelectedIndexChanged(null, null);

        FillData_Wizar1();
        Dl_GP_SelectedIndexChanged(null, null);

        //wizard2
        //FillData_Wizar2();

        //wizard3
        //FillData_Wizar3();

        //wizard4
        FillData_Wizar4();

        //wizard5
        FillData_Wizar5();

        //wizard6
        // FillData_Wizar6();


        // валідація полів по кнопці кількість ретсруктуризацій
        Tb_kres_Changed();

    }

    /// <summary>
    /// Wizard1 Grid населення даними
    /// </summary>
    private void FillData_Wizar1()
    {
        Selected_Dl_Ngrp(null, null);
        

        //Dl_GP1.SelectedValue = read_nd(ND_.Value, RNK_.Value, "GP1", "51", Dl_Zdat.SelectedValue);
        Dl_GP2.SelectedValue = read_nd(ND_.Value, RNK_.Value, "GP2", "51", Dl_Zdat.SelectedValue);
        Dl_GP3.SelectedValue = read_nd(ND_.Value, RNK_.Value, "GP3", "51", Dl_Zdat.SelectedValue);
        Dl_GP4.SelectedValue = read_nd(ND_.Value, RNK_.Value, "GP4", "51", Dl_Zdat.SelectedValue);
        //Dl_GP5.SelectedValue = read_nd(ND_.Value, RNK_.Value, "GP5", "51", Dl_Zdat.SelectedValue);
        Dl_GP_SelectedIndexChanged(null, null);
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            SetRole("WR_DOC_INPUT");


            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GridView_GP.DataSource = SQL_SELECT_dataset(@"select q.kod, q.idf, q.pob, q.descript, q.ord||'.  '||q.name name, nvl(to_char(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK)),0) s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql, ord
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 51 and kod like 'GP%' and substr(kod,3,2) > 5
                                                           ORDER BY ord");


            GridView_GP.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }

    }

    /// <summary>
    /// Wizard2 Grid населення даними
    /// </summary>
    private void FillData_Wizar2()
    {

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            SetRole("WR_DOC_INPUT");


            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
           // SetParameters("nd_", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
           // SetParameters("rnk_", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
           // SetParameters("zDAT_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            GrWiz2.DataSource = SQL_SELECT_dataset(@"select q.*, case  when kod = 'KIKK' then 0 else nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) end  s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                                 --,(select count(1) from fin_question_reply where kod = q.kod and idf = q.idf) tip
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 52 or (kod in ('INV','TIP') and idf = 32) --or (kod = 'KP61' and idf = 5 and fin_nbu.CC_val( :ND_ , :RNK_, :zDAT_,'351') = 1)
                                                           ORDER BY ord");


            //try { GrWiz2.DataBind(); } catch (Exception) { }  
            GrWiz2.DataBind();

//            ClearParameters();
//            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
//            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
//            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
//            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
//            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
//            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
//            GrWiz2_kl.DataSource = SQL_SELECT_dataset(@"select q.*,  case when nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) = 0 then -99 else nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) end s,
//            
//                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
//                                                          from  FIN_QUESTION q
//                                                           where  q.idf = 50 
//                                                           ORDER BY ord");


//            //try { GrWiz2.DataBind(); } catch (Exception) { }  
//            GrWiz2_kl.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }

        Tb_Kzdv.Text = String.Format("{0:N2}", read_nd_n(ND_.Value, RNK_.Value, "KZDV", "52", Dl_Zdat.SelectedValue));   //Чиста кредитна заборгованість до чистої виручки від реалізації 
        Tb_Kzde.Text = String.Format("{0:N2}", read_nd_n(ND_.Value, RNK_.Value, "KZDE", "52", Dl_Zdat.SelectedValue));   //Чиста кредитна заборгованість до значення EBITDA
        Tb_SRKA.Text = String.Format("{0:N2}%", read_nd_n(ND_.Value, RNK_.Value, "SRKA", "52", Dl_Zdat.SelectedValue));   //Сформований резерв в % до заборгованості

    }

    /// <summary>
    /// Wizard3 Grid населення даними
    /// </summary>
    private void FillData_Wizar3()
    {

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            SetRole("WR_DOC_INPUT");


            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GrWiz3.DataSource = SQL_SELECT_dataset(@"select q.kod, q.idf, q.pob, q.descript, q.ord||'.  '||q.name name, nvl(to_char(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK)),0) s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                                 --,(select count(1) from fin_question_reply where kod = q.kod and idf = q.idf) tip
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 53 
                                                           ORDER BY ord");


            GrWiz3.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }

    }

    /// <summary>
    /// Wizard4 Grid населення даними
    /// </summary>
    private void FillData_Wizar4()
    {

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            SetRole("WR_DOC_INPUT");


            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GrWiz4.DataSource = SQL_SELECT_dataset(@"select q.kod, q.idf, q.pob, q.descript, q.ord||' - '||q.name name, nvl(to_char(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK)),0) s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                                 --,(select count(1) from fin_question_reply where kod = q.kod and idf = q.idf) tip
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 54 
                                                           ORDER BY ord");


            GrWiz4.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }

        //Tb_kres.Text = read_nd(ND_.Value, RNK_.Value, "KRES", "54", Dl_Zdat.SelectedValue);   //Кількість реструктуризацій Не вірно вказано 
    }

    /// <summary>
    /// Wizard5 Grid населення даними
    /// </summary>
    private void FillData_Wizar5()
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            SetRole("WR_DOC_INPUT");


            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GrWiz5.DataSource = SQL_SELECT_dataset(@"select q.kod, q.idf, q.pob, q.descript, q.ord||' - '||q.name name, nvl(to_char(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK)),1) s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                                 --,(select count(1) from fin_question_reply where kod = q.kod and idf = q.idf) tip
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 55  and kod  in ( 'ZD1','ZD2')
                                                           ORDER BY ord");


            GrWiz5.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }

    }

    /// <summary>
    /// Wizard6 Grid населення даними
    /// </summary>
    private void FillData_Wizar6()
    {

        Int16 L_teo;


        if (Convert.ToDecimal(Tb_Kzdv.Text) > 5 / 2 ||  Convert.ToDecimal(Tb_Kzde.Text ) > 5  ||  Convert.ToDecimal(Tb_Kzde.Text ) <= 0 ) 
        {
            L_teo = 3;
        }
        else
        {
            L_teo = 1;
        }

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            SetRole("WR_DOC_INPUT");

            ClearParameters();
            SetParameters("INV", DB_TYPE.Int64, Convert.ToInt64(read_nd(ND_.Value, RNK_.Value, "INV", "32", Dl_Zdat.SelectedValue)), DIRECTION.Input);
            SetParameters("INV", DB_TYPE.Int64, Convert.ToInt64(read_nd(ND_.Value, RNK_.Value, "INV", "32", Dl_Zdat.SelectedValue)), DIRECTION.Input);
            SetParameters("TEO", DB_TYPE.Int64, L_teo, DIRECTION.Input);
            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GrWiz6.DataSource = SQL_SELECT_dataset(@"select q.name, q.ord, q.kod, q.idf, 
                                                            case when kod = 'IP5' and :INV = 1 then 1 else pob end pob, 
                                                            q.descript, 
                                                            case when kod = 'IP5' and :INV = 1                                  then :TEO
                                                                 when nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) = 0  then -99 
                                                                                                                                else nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) end s,
                                                           'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                                      from  FIN_QUESTION q
                                                                       where  q.idf = 50 
                                                                       ORDER BY ord");


            //try { GrWiz2.DataBind(); } catch (Exception) { }  
            //            GrWiz2_kl.DataBind();
            GrWiz6.DataBind();
        }
        finally
        {
            DisposeOraConnection();
        }

    }

    /// <summary>
    /// Wizard6 Grid населення даними
    /// </summary>
    private void FillData_Wizar7()
    {


        Dd_RK1.SelectedValue = read_nd(ND_.Value, RNK_.Value, "RK1", "56", Dl_Zdat.SelectedValue);
        Dd_RK2.SelectedValue = read_nd(ND_.Value, RNK_.Value, "RK2", "56", Dl_Zdat.SelectedValue);
        Dd_RK3.SelectedValue = read_nd(ND_.Value, RNK_.Value, "RK3", "56", Dl_Zdat.SelectedValue);
       

    }

    /// <summary>
    /// Виконання дій при натисканні кнопки Next(Наступна)
    /// </summary>
    protected void BtNext(object sender, WizardNavigationEventArgs e)
    {
        // Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep0);
        // Wizard1.MoveTo(this.WizardStep0);
        //e.Cancel = true;
        //return;

        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep0))
        {
            Tb_kres_Changed();
            ShowError_null(Tb_kres.Text, "Не заповнено питання " +  Lb_Kres.Text );
            if (Tb_kres.Text !="0")
            {
                if (String.IsNullOrEmpty(Tb_Klres.Text))
                {
                    ErrR = "1";
                    ShowError(" Не заповнено показник:   " + Lb_klres.Text);
                }

                if (String.IsNullOrEmpty(Tb_kdpres.Text))
                {
                    ErrR = "1";
                    ShowError(" Не заповнено показник:   " + Lb_kdpres.Text);
                }
            }


            if (ErrR == "1")
            {
                e.Cancel = true;
            }

            record_fp_nd("KRES", Tb_kres.Text, "51");
            record_fp_nd_date("DRES", Convert.ToDateTime(tb_dpres.Value), "51");
            record_fp_nd("CRES", Tb_Klres.Text, "51");
            record_fp_nd("PRES", Tb_kdpres.Text, "51");
            record_fp("TZVT", Convert.ToDecimal(Dl_tzvd.SelectedValue), "6", TB_Dat.Text);
            record_fp_nd_date("ZVTP", Convert.ToDateTime(TB_Dat.Text, cinfo), "51");
            if (ND_.Value == "-1") record_fp_nd("VAL", Dl_val.SelectedValue, "30");

            save_gr0();

            // Розрахунок відповідей по замовчуванню
            get_subpok();
            FillData_Wizar2();
            FillData_Wizar3();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }

            Tb_kres_Changed();


        }

        // **********  Належність до груп та їх вплив на контрагента  *****************************
        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep1))
        {

            //Відсутність консолідованої звітності  
            if (Pn_K0.Visible)
            {
                ShowError_null(Tb_rko0n.Text, "Не заповнено питання " + Lb_rko0n.Text);
                ShowError_null(Convert.ToString(Tb_rko0d.Value, cinfo), "Не заповнено дату рішення  колегіального органу ");
                ShowError_null(Dl_GK2.SelectedValue, "Не заповнено питання " +  Lb_GK2.Text);
            }


            //Клас контрагента нижчий за клас групи під спільним контролем 
            if (Pn_K1.Visible)
            {
                ShowError_null(Dl_GK1_1.SelectedValue, "Не заповнено питання Наявність судження банку");

                if (Pn_K1_1.Visible)
                {
                    ShowError_null(Tb_rko1n.Text, "Не заповнено питання " + Lb_rko1n.Text);
                    ShowError_null(Convert.ToString(Tb_rko1d.Value, cinfo), "Не заповнено дату рішення  колегіального органу ");
                    ShowError_null(Dl_GK3.SelectedValue, "Не заповнено питання " + Lb_GK3.Text);
                    ShowError_null(Dl_GK4.SelectedValue, "Не заповнено питання " + Lb_GK4.Text);
                    ShowError_null(Dl_GK5.SelectedValue, "Не заповнено питання " + Lb_GK5.Text);
                    if (Dl_GK3.SelectedValue == "1" && Dl_GK4.SelectedValue == "1" && Dl_GK5.SelectedValue == "1")
                    { ShowError_null(Tb_clas_plus.Text, "Не заповнено питання " + Lb_clas_plus.Text); }
                }
            }

            // Клас контрагента вищий за клас групи під спільним контролем
            if (Pn_K2.Visible)
            {
                ShowError_null(Dl_GK1_2.SelectedValue, "Не заповнено питання Наявність судження банку");

                if (Pn_K2_1.Visible)
                {
                    ShowError_null(Tb_rko2n.Text, "Не заповнено питання " + Lb_rko2n.Text);
                    ShowError_null(Convert.ToString(Tb_rko2d.Value, cinfo), "Не заповнено дату рішення  колегіального органу ");
                    ShowError_null(Dl_GK2_2.SelectedValue, "Не заповнено питання " + Lb_GK2_2.Text);
                }
            }



            // Якщо помилки далі не пускаєм
            if (ErrR == "1")
            {
                e.Cancel = true;
                return;
            } 

            // фіксуємо відповіді. та клас.
            //...
            Tb_clas.Text = read_zn_p(Tb_okpo.Text, "CLAS", "6", TB_Dat.Text);
            // якщо наявна звітність записуємо в базу
            if (!Pn_K0.Visible && !Pn_K1.Visible)
            {
                record_fp_nd("CLS1", Convert.ToDecimal(Tb_clas.Text), "56");
            }
            //Відсутність консолідованої звітності 
            if (Pn_K0.Visible)
            {
                record_fp_nd("XXXX", 0, "51");
                record_fp_nd("RKN0", Tb_rko0n.Text, "51");
                record_fp_nd_date("RKD0", Convert.ToDateTime( Tb_rko0d.Value), "51");
                record_fp_nd("GK20", Dl_GK2.SelectedValue, "51");
                // зберегти клас на який зкорегували  CLS1    Convert.ToDecimal(Tb_clas.Text) - Convert.ToDecimal(Tb_Gr_Klas.Text) 
                if (Dl_GK2.SelectedValue == "1")
                { record_fp_nd("CLS1", (Convert.ToDecimal(Tb_clas.Text) + 1), "56"); }
                else 
                { record_fp_nd("CLS1", Convert.ToDecimal(Tb_clas.Text), "56");  }
            }
            //Клас контрагента нижчий за клас групи під спільним контролем 
            if (Pn_K1.Visible)
            {
                record_fp_nd("XXXX", 1, "51");
                record_fp_nd("GK11", Dl_GK1_1.SelectedValue, "51");

                if (Dl_GK1_1.SelectedValue == "1")
                {
                    record_fp_nd("RKN1", Tb_rko0n.Text, "51");
                    record_fp_nd_date("RKD1", Convert.ToDateTime(Tb_rko0d.Value), "51");
                    record_fp_nd("GK3", Dl_GK3.SelectedValue, "51");
                    record_fp_nd("GK4", Dl_GK4.SelectedValue, "51");
                    record_fp_nd("GK5", Dl_GK5.SelectedValue, "51");

                    if (Dl_GK3.SelectedValue == "1" && Dl_GK4.SelectedValue == "1" && Dl_GK5.SelectedValue == "1")
                    {  
                        record_fp_nd("CLS+", Convert.ToDecimal(Tb_clas_plus.Text), "51");
                        record_fp_nd("CLS1", (Convert.ToDecimal(Tb_clas.Text) - Convert.ToDecimal(Tb_clas_plus.Text)), "56"); 
                    }
                    else
                    { 
                        record_fp_nd("CLS1", Convert.ToDecimal(Tb_clas.Text), "56"); 
                    }
                }
                else
                { // відстуне суудження банку клас К = клас К
                    record_fp_nd("CLS1", Convert.ToDecimal(Tb_clas.Text), "56");
                }
            }
            // Клас контрагента вищий за клас групи під спільним контролем
            if (Pn_K2.Visible)
            {
                record_fp_nd("XXXX", 2, "51");
                record_fp_nd("GK12", Dl_GK1_2.SelectedValue, "51");

                if (Dl_GK1_2.SelectedValue == "1")
                {
                    record_fp_nd("RKN2", Tb_rko2n.Text, "51");
                    record_fp_nd_date("RKD2", Convert.ToDateTime(Tb_rko2d.Value), "51");
                    record_fp_nd("GK22", Dl_GK2_2.SelectedValue, "51");
                    if (Dl_GK2_2.SelectedValue == "1")
                    {    // Вплив групи Так - 1
                        record_fp_nd("CLS1", (Convert.ToDecimal(Tb_Gr_Klas.Text)), "56"); 
                    }
                    else
                    {   // Вплив групи Ні - 0
                        record_fp_nd("CLS1", (Convert.ToDecimal(Tb_Gr_Klas.Text) - 1), "56"); 
                    }
                }
                else
                {
                    record_fp_nd("CLS1", (Convert.ToDecimal(Tb_Gr_Klas.Text)), "56"); 
                }
            }

            record_fp_nd("NGRK", (Dl_NgrK.SelectedValue), "51");
            Tb_cls1.Text = read_nd(ND_.Value, RNK_.Value, "CLS1", "56", Dl_Zdat.SelectedValue); 

            String l_clas;
            if (Dl_NgrK.SelectedValue == "1")
            {
                record_fp_nd("NKZV", (Dd_NKZV.SelectedValue), "51");
                l_clas = Tb_cls1.Text;
            }
            else
            {
                l_clas = Tb_clas.Text;
            }

        
        // *************   група пов'язаних контрагентів  контроль

            if (Dl_NgrP.SelectedValue == "1")
            {
                ShowError_null(Dl_GP1.SelectedValue, "Не заповнено питання " + Lb_GP1.Text);
                ShowError_null(Dl_GP2.SelectedValue, "Не заповнено питання " + Lb_GP2.Text);
                ShowError_null(Dl_GP3.SelectedValue, "Не заповнено питання " + Lb_GP3.Text);
                ShowError_null(Dl_GP4.SelectedValue, "Не заповнено питання " + Lb_GP4.Text);


               if (    Dl_GP1.SelectedValue == "0" && Dl_GP2.SelectedValue == "0" && Dl_GP3.SelectedValue == "0" && Dl_GP4.SelectedValue == "0")
                     { 
                        ShowError_null(Dl_GP5.SelectedValue, "Не заповнено питання " + Lb_GP5.Text);
                        if (Dl_GP5.SelectedValue == "0")
                            {// перевірка грід на заповнення
                             save_gr1("0", Convert.ToDecimal(l_clas));
                            }
                     }
            }
            // Якщо помилки далі не пускаєм
            if (ErrR == "1")
            {
                e.Cancel = true;
                return;
            } 

        // ****************Повязані контрагенти зберігаємо
            record_fp_nd("NGRP", Dl_NgrP.SelectedValue, "51");

            if (Dl_NgrP.SelectedValue == "1")
            {
                record_fp_nd("GP1", Dl_GP1.SelectedValue, "51");
                record_fp_nd("GP2", Dl_GP2.SelectedValue, "51");
                record_fp_nd("GP3", Dl_GP3.SelectedValue, "51");
                record_fp_nd("GP4", Dl_GP4.SelectedValue, "51");
                Tb_cls2.Text = l_clas; 

                if (Dl_GP1.SelectedValue == "0" && Dl_GP2.SelectedValue == "0" && Dl_GP3.SelectedValue == "0" && Dl_GP4.SelectedValue == "0")
                {
                    record_fp_nd("GP5", Dl_GP5.SelectedValue, "51");
                    if (Dl_GP5.SelectedValue == "0")
                    {// save грід на заповнення
                        save_gr1("1", Convert.ToDecimal(l_clas));
                    }
                    else
                    {
                        //Response.Write("greatest(Convert.ToDecimal(l_clas) + 1, 7)=" + Convert.ToString(greatest(Convert.ToDecimal(l_clas) + 1, 7)));
                        //Response.Write("Convert.ToString(least(greatest(Convert.ToDecimal(l_clas) + 1, 7),10))=" + Convert.ToString(least(greatest(Convert.ToDecimal(l_clas) + 1, 7), 10))); 

                        if (Convert.ToDecimal(l_clas) < 7)
                        { Tb_cls2.Text = Convert.ToString(Convert.ToDecimal(l_clas) + 1); }
                        else
                        { Tb_cls2.Text =  l_clas; }
                        
                    }
                }

                
            }
            else
            {
                Tb_cls2.Text = null;
            }

            record_fp_nd("CLS2", Tb_cls2.Text, "56");
            
         
        // **************************************************
        }



        // Ознаки кредитного ризику 
        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep2))
        {
            save_gr2();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }

        }

        // Подія дефолту настала 
        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep3))
        {
            save_gr3();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }
        }



        //Ознаки припинення дефолту 
        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep5))
        {
            save_gr5();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }

        }

        //Ознаки припинення дефолту 
        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep6))
        {
            save_gr6();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }

        }

        //Ознаки визнання дефолту 
        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep4))
        {
            save_gr4();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }


            if (read_nd_hist(ND_.Value,RNK_.Value,"RK1",  "56", Dl_Zdat.SelectedValue) == "1" 
                 || read_nd_hist(ND_.Value,RNK_.Value,"RK2",  "56", Dl_Zdat.SelectedValue) == "1"
                 || Convert.ToDecimal(read_nd_hist(ND_.Value, RNK_.Value, "KKDP", "56", Dl_Zdat.SelectedValue)) >= 90)
            {
                //Response.Write("WizardStep5");
                Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep5); ;
                Pn_Wizar5.Enabled = true;
                Pn_Wizar5_2.Enabled = true;
            }
            else
            {
                //Response.Write("WizardStep6");
                Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep6); ;
                Pn_Wizar5.Enabled = false;
                Pn_Wizar5_2.Enabled = false;
                //Dd_RK3.Visible = false;
                record_fp_nd("RK3", null, "56");
                Dl_ZD3.SelectedValue = "0";
                //save_gr5();
                record_fp_nd("ZD1", null, "55");
                record_fp_nd("ZD2", null, "55");
                record_fp_nd("ZD3", null, "55");
                FillData_Wizar6();
                //Response.Write("WizardStep6_2");
            }
 
        }

    }


    /// <summary>
    ///  Виконання дій при натисканні кнопки BtPrevious(Попередня)
    /// </summary>
    protected void BtPrevious(object sender, WizardNavigationEventArgs e)
    {
   
        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep7))
        {
            clas_run.Visible  = false;
            BtI_Print.Visible = false;
        }
    }

    /// <summary>
    /// Подія на зміну DropDownList  Dl_NgrK
    /// </summary>
    protected void Selected_Dl_Ngrk(object sender, EventArgs e)
    {
        Selected_DlNgrk();
    }

    /// <summary>
    /// Подія на зміну DropDownList  Dl_Ngrp
    /// </summary>
    protected void Selected_Dl_Ngrp(object sender, EventArgs e)
    {
        if (Dl_NgrP.SelectedValue == "0" || String.IsNullOrEmpty(Dl_NgrP.SelectedValue))
        {
            Pn_povk.Visible = false;
            Lb_cls2.Visible = false;
            Tb_cls2.Visible = false;
        }
        else
        {
            Pn_povk.Visible = true;
            Lb_cls2.Visible = true;
            Tb_cls2.Visible = true;
            Dl_GP_SelectedIndexChanged(null, null); 
        } 
    }

    protected void Selected_Dl_Nkzv(object sender, EventArgs e)
    {
        Selected_DlNkzv();
        Dl_GK1_1SelectedIndexChanged(sender, e);
        Dl_GK1_2SelectedIndexChanged(sender, e);




    }

    /// <summary>
    /// Подія на зміну DropDownList  Dl_NgrK
    /// </summary>
    protected void Selected_DlNgrk()
    {
        if (Dl_NgrK.SelectedValue == "0" || String.IsNullOrEmpty(Dl_NgrK.SelectedValue))
        {
            Pn_kons.Visible = false;
            Tb_NumGrp.Visible = false;
            Lb_NumGrp.Visible = false;
            Tb_Gr_Klas.Visible = false;
            Lb_Gr_Klas.Visible = false;
            Lb_NKZV.Visible = false;
            Dd_NKZV.Visible = false;
            Tb_NumGrp.Text = null;
            Tb_Gr_Klas.Text = null;
            Bt_grp.Visible = false;
            s1.Visible = false;
            Lb_cls1.Visible = false;
            Tb_cls1.Visible = false;

            Dl_GP1.SelectedValue= "0";
            Dl_GP1.Enabled = false;

        }
        else
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (DateTime.Today < Convert.ToDateTime("01/01/2018", cinfo)) Dl_NgrK.Enabled = true; 
            Pn_kons.Visible = true;
            Tb_NumGrp.Visible = true;
            Lb_NumGrp.Visible = true;
            Tb_Gr_Klas.Visible = true;
            Lb_Gr_Klas.Visible = true;
            Lb_NKZV.Visible = true;
            Dd_NKZV.Visible = true;
            Bt_grp.Visible = true;
            s1.Visible = true;
            Tb_NumGrp.Text = read_nd(ND_.Value, RNK_.Value, "NUMG", "51", Dl_Zdat.SelectedValue);//.PadLeft(10,'0');
            Tb_Gr_Klas.Text = read_nd(ND_.Value, RNK_.Value, "GRKL", "51", Dl_Zdat.SelectedValue);
            Dd_NKZV.SelectedValue = read_nd(ND_.Value, RNK_.Value, "NKZV", "51", Dl_Zdat.SelectedValue);
            Lb_cls1.Visible = true;
            Tb_cls1.Visible = true;


            if (Dd_NKZV.SelectedValue == "1")
            { Dl_GP1.SelectedValue = "1"; }
            else
            { Dl_GP1.SelectedValue = "0"; }
             Dl_GP1.Enabled = false;
 
        }


        // насиляємо дані збережені

        // консолідованої звітності No
        Tb_rko0n.Text = read_nd_hist(ND_.Value, RNK_.Value, "RKN0", "51", Dl_Zdat.SelectedValue);
        Tb_rko0d.Value = read_nd_date_hist(ND_.Value, RNK_.Value, "RKD0", "51", Dl_Zdat.SelectedValue);
        Dl_GK2.SelectedValue = read_nd_hist(ND_.Value, RNK_.Value, "GK20", "51", Dl_Zdat.SelectedValue);

        // "Клас контрагента нижчий за клас групи під спільним контролем
        Dl_GK1_1.SelectedValue = read_nd_hist(ND_.Value, RNK_.Value, "GK11", "51", Dl_Zdat.SelectedValue);
        Tb_rko1n.Text = read_nd_hist(ND_.Value, RNK_.Value, "RKN1", "51", Dl_Zdat.SelectedValue);
        Tb_rko1d.Value = read_nd_date_hist(ND_.Value, RNK_.Value, "RKD1", "51", Dl_Zdat.SelectedValue);

        Dl_GK3.SelectedValue = read_nd_hist(ND_.Value, RNK_.Value, "GK3", "51", Dl_Zdat.SelectedValue);
        Dl_GK4.SelectedValue = read_nd_hist(ND_.Value, RNK_.Value, "GK4", "51", Dl_Zdat.SelectedValue);
        Dl_GK5.SelectedValue = read_nd_hist(ND_.Value, RNK_.Value, "GK5", "51", Dl_Zdat.SelectedValue);
        Tb_clas_plus.Text = read_nd_hist(ND_.Value, RNK_.Value, "CLS+", "51", Dl_Zdat.SelectedValue);

        // Клас контрагента вищий за клас групи під спільним контролем
        Dl_GK1_2.SelectedValue = read_nd_hist(ND_.Value, RNK_.Value, "GK12", "51", Dl_Zdat.SelectedValue);
        Tb_rko2n.Text          = read_nd_hist(ND_.Value, RNK_.Value, "RKN2", "51", Dl_Zdat.SelectedValue);
        Tb_rko2d.Value         = read_nd_date_hist(ND_.Value, RNK_.Value, "RKD2", "51", Dl_Zdat.SelectedValue);
        Dl_GK2_2.SelectedValue = read_nd_hist(ND_.Value, RNK_.Value, "GK22", "51", Dl_Zdat.SelectedValue);
        

    }

    protected void Selected_DlNkzv()
    {
        if (String.IsNullOrEmpty(Dd_NKZV.SelectedValue) )
        {
            Pn_K0.Visible = false;
            Pn_K1.Visible = false;
            Pn_K2.Visible = false;
        }
        else if (Dd_NKZV.SelectedValue == "0")  // відсутня консолідована звітність
        {
            Pn_K0.Visible = true;
            Pn_K1.Visible = false;
            Pn_K2.Visible = false;
        }
        else        // наявна консолідована звітність 
        {

            Pn_K0.Visible = false; 
          try{
              // клас контрагента вищий(кращий) за клас групи
            if (Convert.ToDecimal(Tb_Gr_Klas.Text) < Convert.ToDecimal(Tb_clas.Text))
            { 
                Pn_K1.Visible = true;
                Pn_K2.Visible = false; 
            }
            else if (Convert.ToDecimal(Tb_Gr_Klas.Text) > Convert.ToDecimal(Tb_clas.Text))   // клас контрагента гірший за клас групи
            {
                Pn_K1.Visible = false; 
                Pn_K2.Visible = true;
            }
            else
            {
                Pn_K1.Visible = false;
                Pn_K2.Visible = false;
            }
          }
          catch (Exception)
          {
              Pn_K1.Visible = false;
              Pn_K2.Visible = false;
          } 

        }

        if (Dd_NKZV.SelectedValue == "1")
        { Dl_GP1.SelectedValue = "1"; }
        else
        { Dl_GP1.SelectedValue = "0"; }
        

        Dl_GK1_1SelectedIndexChanged(null, null);
        Dl_GK1_2SelectedIndexChanged(null, null);

    }

    /// <summary>
    /// send_error   ПРО ПОМИЛКУ
    /// </summary>
    /// <param name="ErrorText"></param>
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    private void ShowError_null(String parnull, String ErrorText)
    {
        if (String.IsNullOrEmpty(parnull) || parnull =="01/01/1901 00:00:00")
        {
            ErrR = "1";  
            ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
        }
    }

    protected void Tb_kres_TextChanged(object sender, EventArgs e)
    {
        Tb_kres_Changed();
    }

    /// <summary>
    /// валідація блоку  "Реструктуризація повязана з наявністю фінансових трудностей"
    /// </summary>
    protected void Tb_kres_Changed()
    {
        if (Tb_kres.Text == "0" || String.IsNullOrEmpty(Tb_kres.Text))
        {
            Lb_dpres.Visible = false;
            tb_dpres.Visible = false;
            tb_dpres.Value = null;

            Lb_klres.Visible = false;
            Tb_Klres.Visible = false;
            Tb_Klres.Text = null;

            Lb_kdpres.Visible = false;
            Tb_kdpres.Visible = false;
            Tb_kdpres.Text = null;

            // Розрахунок відповідей по замовчуванню
            //get_subpok();

            //wizard4
            FillData_Wizar2();
            FillData_Wizar4();

        }
        else
        {
            Lb_dpres.Visible = true;
            tb_dpres.Visible = true;

            Lb_klres.Visible = true;
            Tb_Klres.Visible = true;

            Lb_kdpres.Visible = true;
            Tb_kdpres.Visible = true;

            // Розрахунок відповідей по замовчуванню
            //get_subpok();

            //wizard4
            FillData_Wizar2();
            FillData_Wizar4();

        }
    }

    protected void Dl_Zdat_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        load_form();
    }

    protected void backToFolders(String p_url)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + p_url + "')", true);
    }


    protected void BtI_Cardkl_Click(object sender, EventArgs e)
    {
        backToFolders("/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl&rnk=" + Convert.ToString(RNK_.Value));
    }

    protected void BtI_Clic_Vnkr(object sender, EventArgs e)
    {
        backToFolders("/barsroot/credit/fin_nbu/fin_form_obu.aspx?okpo=" + Tb_okpo.Text + "&rnk=" + Convert.ToString(RNK_.Value) + "&frm=" + Convert.ToString(ND_.Value) + "&dat=" + TB_Dat.Text);
    }
    protected void Bt_Clic_set_Vnkr(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();
            {
                ClearParameters();


                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("vnkr", DB_TYPE.Varchar2, tb_vncr.SelectedValue, DIRECTION.Input);

                SQL_NONQUERY(@"begin  
                                cck_app.Set_ND_TXT(:nd_ ,'VNCRR' , :vnkr);                                
                               end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Значення ВКР - " + tb_vncr.SelectedValue + " втановлено на договір " + ND_.Value + "');" , true);
    }
    protected void BtI_Clic_Print(object sender, EventArgs e)
    {
        backToFolders("/barsroot/credit/fin_nbu/Print_fin.aspx?frt=fin_obu_CGD_Pot_351&rnk=" + Convert.ToString(RNK_.Value) + "&ND=" + Convert.ToString(ND_.Value) +
                           "&fdat=" + TB_Dat.Text + "&zdat=" + Convert.ToString(Dl_Zdat.SelectedValue).Substring(0, 10));
       


    }
    protected void BtI_Clic_Grp(object sender, EventArgs e)
    {
        backToFolders("/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kontr&rnk=" + Convert.ToString(Tb_NumGrp.Text) + "&rnk2=" + Convert.ToString(RNK_.Value));
        //ShowError("Сторінка в розробці...");
    }

    protected void Dl_GK1_1SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Dl_GK1_1.SelectedValue == "1")
        { Pn_K1_1.Visible = true; }
        else
        { Pn_K1_1.Visible = false; }

        Dl_GK_SelectedIndexChanged(sender, e);

    }


    protected void Dl_GK_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Dl_GK3.SelectedValue == "1" && Dl_GK4.SelectedValue == "1" && Dl_GK5.SelectedValue == "1")  // відобразити на скільки скоригувати клас
        {   Lb_clas_plus.Visible = true; 
            Tb_clas_plus.Visible = true;
            Tb_clas_plus.Text = null;
            String l_clas="0";

            try {
            l_clas = Convert.ToString(  (Convert.ToDecimal(Tb_clas.Text) - Convert.ToDecimal(Tb_Gr_Klas.Text) ) );
            }
            catch (Exception) { } 


            RangeValidator_clas_plus.MaximumValue = l_clas;
            RangeValidator_clas_plus.ErrorMessage = "Допустиме значення від 0 до "+l_clas;
        }   
        else
        { Lb_clas_plus.Visible = false; Tb_clas_plus.Visible = false; }
    }


    protected void Dl_GK1_2SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Dl_GK1_2.SelectedValue == "1")
        { Pn_K2_1.Visible = true; }
        else
        { Pn_K2_1.Visible = false; }

    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Dl_GP_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (    Dl_GP1.SelectedValue == "0" && Dl_GP2.SelectedValue == "0" && Dl_GP3.SelectedValue == "0" && Dl_GP4.SelectedValue == "0")
             { 
                Lb_GP5.Visible = true; Dl_GP5.Visible = true;
                if (Dl_GP5.SelectedValue == "0" && !String.IsNullOrEmpty(Dl_GP5.SelectedValue))
                    { Pn_GP.Visible = true; }
                   else
                    { Pn_GP.Visible = false;  }                    
              
             }
        else { Lb_GP5.Visible = false; Dl_GP5.Visible = false; Pn_GP.Visible = false;}

    }

    //protected void Test_Tb_Gr_Klas(object sender, EventArgs e)
    //{
    //    Selected_DlNkzv();
    //backToFolders("/barsroot/credit/fin_nbu/Print_fin.aspx?frt=fin_obu_CGD_Pot_351&rnk=" + Convert.ToString(Lb_rnk2.Text) + "&ND=" + Convert.ToString(Lb_nd2.Text) +
    //                   "&fdat=" + Convert.ToString(gvMain.SelectedDataKey[3], cinfo).Substring(0, 10) + "&zdat=" + Convert.ToString(gvMain.SelectedDataKey[2], cinfo).Substring(0, 10));
    //}


    protected void GrWiz3_SelectedIndexChanged(object sender, EventArgs e)
    {
        int pos = 0;
        foreach (GridViewRow row in GrWiz3.Rows)
        {
            if (row.Cells[1].Controls[1] is DropDownList)
            {
                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
                if (tb1.Text != "-99" & Convert.ToString(GrWiz3.DataKeys[pos].Values[0]) == "PD8")
                {
                    if (tb1.Text == "1")   {Pn_Wizar3_2.Visible = true; }
                                      else { Pn_Wizar3_2.Visible = false; tb_PD8_d.Value = null; }
                }
            }
            pos++;
        }
    }




    protected void Dd_VD0_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Dd_VD0.SelectedValue == "1")
        {
            Lb_VDN1.Visible = true;
            Lb_VDD1.Visible = true;
            Tb_VDN1.Visible = true;
            Tb_VDD1.Visible = true;
        }
        else 
        {
            Lb_VDN1.Visible = false;
            Lb_VDD1.Visible = false;
            Tb_VDN1.Visible = false; Tb_VDN1.Text = null;
            Tb_VDD1.Visible = false; Tb_VDD1.Value = null;
        }
    }


    protected void Tb_ZDN1_TextChanged(object sender, EventArgs e)
    {
        //Response.Write("Test="+d1.Value);
        if  ( (!String.IsNullOrEmpty(Tb_ZDN1.Text)  & read_nd_hist(ND_.Value,RNK_.Value,"RK1",  "56", Dl_Zdat.SelectedValue) == "1" )
               || read_nd_hist(ND_.Value, RNK_.Value, "RK1", "56", Dl_Zdat.SelectedValue) == "0")
        { Dl_ZD3.SelectedValue = "1"; }
        else
        {
        Dl_ZD3.SelectedValue = "0";}

    }

    protected void Bt_save_Click(object sender, EventArgs e)
    {
        adjustment_class();

        Tb_clas.Text = read_zn_p(Tb_okpo.Text, "CLAS", "6", TB_Dat.Text);
        Tb_cls.Text  = read_nd(ND_.Value, RNK_.Value, "CLS", "56", Dl_Zdat.SelectedValue);
        Tb_clsb.Text = read_nd(ND_.Value, RNK_.Value, "CLSP", "56", Dl_Zdat.SelectedValue);
        //--??
        Tb_cls1.Text = read_nd(ND_.Value, RNK_.Value, "CLS1", "56", Dl_Zdat.SelectedValue);
        Tb_cls2.Text = read_nd(ND_.Value, RNK_.Value, "CLS2", "56", Dl_Zdat.SelectedValue);


        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
        {

            Decimal SS_;

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            DateTime dat = Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo);

            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("RNK", OracleDbType.Decimal, Convert.ToInt64(RNK_.Value), ParameterDirection.Input);
            cmd.Parameters.Add("ND", OracleDbType.Decimal, Convert.ToInt64(ND_.Value), ParameterDirection.Input);
            cmd.Parameters.Add("DAT", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("clas", OracleDbType.Varchar2, Tb_clsb.Text, ParameterDirection.Input);
            cmd.Parameters.Add("vnkr", OracleDbType.Varchar2, tb_vncr.SelectedValue, ParameterDirection.Input);
            cmd.CommandText = (@"select   fin_nbu.get_pd (  p_rnk   =>  :rnk,
                                                            p_nd    =>  :nd,
                                                            p_dat   =>  :dat,  
                                                            p_clas  =>  :clas,
                                                            p_vncr  =>  :vnkr,
                                                            p_idf   => 50  
                                                            ) PD from dual");

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {

                SS_ = rdr["PD"] == DBNull.Value ? (Decimal)Convert.ToDecimal(null) : (Decimal)rdr["PD"];
                Tb_PD.Text = String.Format("{0:N3}", SS_);

                record_fp_nd("PD", SS_, "56");

            }
            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }



        clas_run.Visible = true;
        BtI_Print.Visible = true;
    }

    /// <summary>
    /// З моменту усунення подій на підставі яких було визнано дефолт минуло щонайменше 180 днів
    /// </summary>
    protected void elimination_events()
    {

        try
        {
            InitOraConnection();
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                ClearParameters();

                SetParameters("rnk_", DB_TYPE.Decimal, Convert.ToDecimal(RNK_.Value), DIRECTION.Input);
                SetParameters("nd_", DB_TYPE.Decimal, Convert.ToDecimal(ND_.Value), DIRECTION.Input);
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);

                SQL_NONQUERY(@"begin  
                                   fin_nbu.elimination_events(:rnk_, :nd_, :dat_, '53,54', 55);
                               end;");

            }

        }
        finally
        {
            DisposeOraConnection();
        }

        if (read_nd(ND_.Value, RNK_.Value, "ZD5", "55", Dl_Zdat.SelectedValue) == "1")
        {
            p_events.Visible = true;
            dl_ZD4.SelectedValue = read_nd(ND_.Value, RNK_.Value, "ZD4", "55", Dl_Zdat.SelectedValue);

            if (dl_ZD4.SelectedValue == "1")
            { 
                Pn_Wizar5_2.Visible = true;
                Dl_ZD3.SelectedValue = read_nd(ND_.Value, RNK_.Value, "ZD3", "55", Dl_Zdat.SelectedValue);
                Tb_ZDN1.Text = read_nd(ND_.Value, RNK_.Value, "ZDN1", "57", Dl_Zdat.SelectedValue);
                Tb_ZDD1.Value = read_nd_date(ND_.Value, RNK_.Value, "ZDD1", "57", Dl_Zdat.SelectedValue);


            }
            else { Pn_Wizar5_2.Visible = false;
            Dl_ZD3.SelectedValue = "0";
            Tb_ZDN1.Text = null;
            Tb_ZDD1.Value = null;
            }

        }
        else
        {
            p_events.Visible = false;
            Pn_Wizar5_2.Visible = false;
        }

    }


    protected void Dd_zd6_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Dd_zd6.SelectedValue == "1")
        {   //Відбулась фінансова реструктуризація  - Yes
            Lb_dzd6.Visible = true;
            Tb_dzd6.Visible = true;
            Tb_dzd6.Value = read_nd_date_hist(ND_.Value, RNK_.Value, "DZD6", "55", Dl_Zdat.SelectedValue); 
            Lb_zd7.Visible = true;
            Dd_zd7.Visible = true;

            Lb_zd8.Visible = true;
            Dd_zd8.Visible = true;
            Im_zd8.Visible = true;

            Dd_zd7_SelectedIndexChanged(null, null);
            w5_p2.Visible = false;
        }
        else
        {  // Відбулась фінансова реструктуризація  = No
            Lb_dzd6.Visible = false;
            Tb_dzd6.Visible = false;

            Tb_dzd6.Value = null;
            Dd_zd7.SelectedValue = null;
            Tb_nzd7.Text = null;
            tb_dzd7.Value = null;
            Lb_zd7.Visible = false;
            Dd_zd7.Visible = false;

            Lb_zd8.Visible = false;
            Dd_zd8.Visible = false;
            Dd_zd8.SelectedValue = null;
            Im_zd8.Visible = false;

            Dd_zd7_SelectedIndexChanged(null, null);
            w5_p2.Visible = true;
        }
    }

    protected void Dd_zd7_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Dd_zd7.SelectedValue == "1")
        {
            Lb_nzd7.Visible = true;
            Tb_nzd7.Visible = true;
            Lb_dzd7.Visible = true;
            tb_dzd7.Visible = true;

            Tb_nzd7.Text  = read_nd(ND_.Value, RNK_.Value, "NZD7", "55", Dl_Zdat.SelectedValue);
            tb_dzd7.Value = read_nd_date_hist(ND_.Value, RNK_.Value, "DZD7", "55", Dl_Zdat.SelectedValue); ;

        }
        else
        {
            Lb_nzd7.Visible = false;
            Tb_nzd7.Visible = false;
            Lb_dzd7.Visible = false;
            tb_dzd7.Visible = false;
        }
    }

    protected void dl_ZD4_SelectedIndexChanged(object sender, EventArgs e)
    {

            if (dl_ZD4.SelectedValue == "1")
            {
                Pn_Wizar5_2.Visible = true;
                Dl_ZD3.SelectedValue = read_nd(ND_.Value, RNK_.Value, "ZD3", "55", Dl_Zdat.SelectedValue);
                Tb_ZDN1.Text = read_nd(ND_.Value, RNK_.Value, "ZDN1", "57", Dl_Zdat.SelectedValue);
                Tb_ZDD1.Value = read_nd_date(ND_.Value, RNK_.Value, "ZDD1", "57", Dl_Zdat.SelectedValue);


            }
            else
            {
                Pn_Wizar5_2.Visible = false;
                Dl_ZD3.SelectedValue = "0";
                Tb_ZDN1.Text = null;
                Tb_ZDD1.Value = null;
            }


    }
}
