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



public partial class credit_defolt_bud : Bars.BarsPage
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



        if (!IsPostBack)
        {

            //RNK_.Value = "6611";
            //ND_.Value  = "9456521";
            if (Request["RNK"] != null) { RNK_.Value = Convert.ToString(Request["RNK"]); }
            if (Request["ND"] != null) { ND_.Value = Convert.ToString(Request["ND"]); }

            //Активуємо першу закладку  Wizard1
            Wizard1.ActiveStepIndex = 0;


            // Наповнюємо стартові даніна сторінку
            load_form();

            // Розрахунок класу позичальника з інтегрального показника.   //переніс в load_form
            //calculation_class();
            //Tb_clas.Text = read_zn_p(Tb_okpo.Text, "CLAS", "6", TB_Dat.Text);
        }

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

                    SS_ = rdr["SN"] == DBNull.Value ? (DateTime)Convert.ToDateTime(null) : (DateTime)rdr["SN"];
                    if (SS_ != null)
                    { return Convert.ToDateTime(SS_); }
                    else { return Convert.ToDateTime(null); }
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

                SQL_NONQUERY("begin  fin_nbu.get_subpok_bud(:rnk_, :nd_, :dat_);  end;");

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

                SQL_NONQUERY(@"declare
                               l_rnk number := :rnk_; 
                               l_nd number  := :nd_; 
                               l_dat date   := :dat_; 
                               begin  
                                   fin_nbu.adjustment_class_bud(l_rnk, l_nd, l_dat);  
                                   --fin_nbu.add_findat(l_rnk, l_nd, l_dat);   
                               end;");

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
    /// Зберігаємо дані гріда Wizard0
    /// </summary>
    protected void save_gr0()
    {


        ErrR = "0";

        if (String.IsNullOrEmpty(tb_vncr.SelectedValue))
        {
            ErrR = "1";
            Err_name = Err_name + ". Внутрішній кредитний рейтинг !!! ";
        }

        if (String.IsNullOrEmpty( Dl_clas.SelectedValue ))
        {
            ErrR = "1";
            Err_name = Err_name + ". Клас боржника  !!! ";
        }

        if (String.IsNullOrEmpty(Dl_inv.SelectedValue))
        {
            ErrR = "1";
            Err_name = Err_name + ". Пов’язаний із фінансуванням інвестиційних проектів контрагентів Банку   !!! ";
        }

        if (String.IsNullOrEmpty(Dl_ksr.SelectedValue))
        {
            ErrR = "1";
            Err_name = Err_name + ". Контрагент створений шляхом реорганізації   !!! ";
        }


        if (String.IsNullOrEmpty(Tb_kres.Text))
        {
            ErrR = "1";
            Err_name = Err_name + ". Кількість реструктуризацій по угоді    !!! ";
        }

        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            return;
            //Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep0);
        }


        record_fp_nd("CLAS", Convert.ToDecimal(Dl_clas.SelectedValue), "71");
        record_fp_nd("INV",  Convert.ToDecimal(Dl_inv.SelectedValue), "71");
        record_fp_nd("KSR",  Convert.ToDecimal(Dl_ksr.SelectedValue), "71");
        record_fp_nd("KRES", Convert.ToDecimal(Tb_kres.Text), "71");
        set_nd_vncrr(ND_.Value,RNK_.Value, tb_vncr.SelectedValue );
        get_subpok();
        //wizard2
        FillData_Wizar2();

        //wizard3
        FillData_Wizar3();
        
        //wizard4
        FillData_Wizar4();

        //wizard5
        FillData_Wizar5();




    }

    /// <summary>
    /// Зберігаємо дані гріда Wizard2
    /// </summary>
    protected void save_gr2()
    {
        //char j = (char)10;
        ErrR = "0";
        int pos = 0;
        String RK1_ = "0";
        foreach (GridViewRow row in GrWiz2.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
                string NAME_ = Convert.ToString(GrWiz2.DataKeys[pos].Values[2]);
                string KOD = Convert.ToString(GrWiz2.DataKeys[pos].Values[0]);
                string IDF = Convert.ToString(GrWiz2.DataKeys[pos].Values[1]);

                if (tb1.Text == "1") RK1_ = "1";

                if (tb1.Text != "-99")
                {

                    if (Convert.ToString(GrWiz2.DataKeys[pos].Values[3]) == "0")
                    {
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
                    }
                }
                else
                {
                    ErrR = "1";
                    Err_name = Err_name + NAME_ + "      " + KOD + IDF;
                }
            }
            pos++;
        }

        pos = 0;
        foreach (GridViewRow row in GrWiz2_kl.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
                string NAME_ = Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[2]);
                string KOD = Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[0]);
                string IDF = Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[1]);
                if (tb1.Text != "-99")
                {

                    if (Convert.ToString(GrWiz2_kl.DataKeys[pos].Values[3]) == "0")
                    {
                        record_fp_nd(KOD, Convert.ToDecimal(tb1.Text), IDF);
                    }
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

        record_fp_nd("RK0", RK1_, "76");
        Dd_RK0.SelectedValue = RK1_;


    }


    /// <summary>
    /// Зберігаємо дані гріда Wizard3
    /// </summary>
    protected void save_gr3()
    {
        //char j = (char)10;
        ErrR = "0";
        int pos = 0;
        String RK1_ = "0";

        foreach (GridViewRow row in GrWiz3.Rows)
        {

            if (row.Cells[1].Controls[1] is DropDownList)
            {

                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);

                if (tb1.Text == "1") RK1_ = "1";

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

        record_fp_nd("RK1", RK1_, "76");
        Dd_RK1.SelectedValue = RK1_;
        //Response.Write(RK1_);
        Tb_ZDN1_TextChanged(null,null);

    }


    /// <summary>
    /// Зберігаємо дані гріда Wizard4
    /// </summary>
    protected void save_gr4()
    {
        //char j = (char)10;
        ErrR = "0";
        int pos = 0;
        String RK2_ = "0";

        

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

  //      if (ErrR == "1")
  //      {
  //          ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
  //          Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep3);
  //      }



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
            Err_name = Err_name + " Дата Рішення колегіального органу  " + "      ";
        }

        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep3);
        }


        if (!String.IsNullOrEmpty(Tb_VDN1.Text) & !String.IsNullOrEmpty(Convert.ToString(Tb_VDD1.Value, cinfo))) { RK2_ = "0"; }



        record_fp_nd("RK2", RK2_, "76");
        Dd_RK2.SelectedValue = RK2_;
        record_fp_nd("VD0", Dd_VD0.SelectedValue, "74");
        record_fp_nd("VDN1", Tb_VDN1.Text, "74");
        record_fp_nd_date("VDD1", Convert.ToDateTime(Tb_VDD1.Value), "74");

       // record_fp_nd("RK2", RK2_, "76");
       // Dd_RK2.SelectedValue = RK2_;

        



        
    }


    /// <summary>
    /// Зберігаємо дані гріда Wizard5
    /// </summary>
    protected void save_gr5()
    {
        //char j = (char)10;
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


        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        if (!String.IsNullOrEmpty(Tb_ZDN1.Text) & (Convert.ToString(Tb_ZDD1.Value, cinfo) == "01/01/0001" || String.IsNullOrEmpty(Convert.ToString(Tb_ZDD1.Value, cinfo))))
        {
            ErrR = "1";
            Err_name = Err_name + "Дата рішення колегіального органу " + "      ";

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

        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep3);
        }


        
       // Response.Write(RK3_);
        //Тобто, якщо за параметром «Наявність ознак для визнання події дефолту» стоїть відмітка «ТАК», та за всіма параметрами, наведеними у цьому пункті стоїть відмітка «ТАК», 
        //то параметру «Припинення визнання дефолту» присвоюється відмітка «ТАК». У всіх інших випадках – «НІ».

        //Параметр «Припинення визнання дефолту» не може набути значення «ТАК», якщо параметру «Подія дефолту настала» присвоєно значення «ТАК».


        if (Dd_RK2.SelectedValue == "1" && RK3_ == "1")
        {
            if (Dd_RK1.SelectedValue == "1")
            { Dd_RK3.SelectedValue = "0";}
            else
            { Dd_RK3.SelectedValue = "1"; }
        }
        else
        {
            Dd_RK3.SelectedValue = "0";  
        }
        record_fp_nd("ZD3", Dd_RK3.SelectedValue, "75");

        record_fp_nd("ZDN1", Tb_ZDN1.Text, "75");
        record_fp_nd_date("ZDD1", Convert.ToDateTime(Tb_ZDD1.Value), "75");

        //     if ( RK3_ == "0") { Dd_RK3.SelectedValue = "0"; Dd_RK3.Enabled = false; }
        //else if ( Dd_RK1.SelectedValue == "0" && Dd_RK2.SelectedValue == "0") { Dd_RK3.SelectedValue = "0"; Dd_RK3.Enabled = false; }
        //     else if ((Dd_RK1.SelectedValue == "0" && Dd_RK2.SelectedValue == "1") && Cb_RK22.Checked == true) { Dd_RK3.SelectedValue = "0"; Dd_RK3.Enabled = false;  }
        //     else if ((Dd_RK1.SelectedValue == "1" || Dd_RK2.SelectedValue == "1") && Cb_RK22.Checked == false) { Dd_RK3.SelectedValue = ""; Dd_RK3.Enabled = true; }

        //if (RK3_ == "0") { Dd_RK3.SelectedValue = "0"; Dd_RK3.Enabled = false; }
        //else if (Dd_RK1.SelectedValue == "0" && Dd_RK2.SelectedValue == "0") { Dd_RK3.SelectedValue = "0"; Dd_RK3.Enabled = false; }
        //else if ((Dd_RK1.SelectedValue == "0" && Dd_RK2.SelectedValue == "1")) { Dd_RK3.SelectedValue = "0"; Dd_RK3.Enabled = false; }
        //else if ((Dd_RK1.SelectedValue == "1" || Dd_RK2.SelectedValue == "1")) { Dd_RK3.SelectedValue = ""; Dd_RK3.Enabled = true; }

        record_fp_nd("RK3", Dd_RK3.SelectedValue, "76");
        Pn_clas.Visible = false;
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
                                         to_char(round(gl.bd,'MM'),'dd/mm/yyyy') zp_dat
                                  from  fin_customer c
                                 where  rnk =:rnk_";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                Tb_nmk.Text = (String)rdr["NMKK"];  Lb1.Text = (String)rdr["NMKK"];
                Tb_okpo.Text = (String)rdr["OKPO"]; Lb2.Text = (String)rdr["OKPO"];
                TB_Date_open.Text = rdr["DATEA"] == DBNull.Value ? (String)null : (String)rdr["DATEA"];
                

                if (!IsPostBack)
                {
                    try
                    {
                        InitOraConnection();
                        String l_sql_dat = "select to_char(add_months(trunc(to_date('" + (String)rdr["ZP_DAT"] + "','dd/mm/yyyy'),'mm'),num-2),'DD/MM/YYYY') dat from conductor where 3 >= num order by num ";
                        Dl_Zdat.DataSource = SQL_SELECT_dataset(l_sql_dat).Tables[0];
                        Dl_Zdat.DataTextField = "dat";
                        Dl_Zdat.DataValueField = "dat";
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

            DateTime dat = Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo);

            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            //cmd.Parameters.Add("DAT_", OracleDbType.Date, dat, ParameterDirection.Input);
            //cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            //cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.CommandText = @" Select   fin_zp.zn_vncrr(:rnk_, :nd_)   vnkrr 
                                           from dual";
            OracleDataReader rdr2 = cmd.ExecuteReader();

            if (rdr2.Read())
            {
                tb_vncr.SelectedValue = rdr2["VNKRR"] == DBNull.Value ? (String)null : (String)rdr2["VNKRR"];
            }

            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        // Наповнимо DropDownList
        try
        {
            InitOraConnection();

            Dl_clas.DataBind();
            Dl_clas.Items.Insert(0, new ListItem("", ""));

            tb_vncr.DataBind();
            tb_vncr.Items.Insert(0, new ListItem("", ""));

            Dl_inv.DataBind();
            Dl_inv.Items.Insert(0, new ListItem("", ""));


            Dl_ksr.DataBind();
            Dl_ksr.Items.Insert(0, new ListItem("", ""));



            Dd_RK0.DataBind();
            Dd_RK0.Items.Insert(0, new ListItem("", ""));
            Dd_RK1.DataBind();
            Dd_RK1.Items.Insert(0, new ListItem("", ""));
            Dd_RK2.DataBind();
            Dd_RK2.Items.Insert(0, new ListItem("", ""));
            Dd_RK3.DataBind();
            Dd_RK3.Items.Insert(0, new ListItem("", ""));
            Dd_RK4.DataBind();
            Dd_RK4.Items.Insert(0, new ListItem("", ""));


            Dd_VD0.DataBind();
            Dd_VD0.Items.Insert(0, new ListItem("", ""));

            Dl_ZD3.DataBind();
            Dl_ZD3.Items.Insert(0, new ListItem("", ""));

        }
        finally
        {
            DisposeOraConnection();
        }



         Dl_clas.SelectedValue  = read_nd(ND_.Value, RNK_.Value, "CLAS", "71", Dl_Zdat.SelectedValue);
         Dl_inv.SelectedValue   = read_nd(ND_.Value, RNK_.Value, "INV", "71", Dl_Zdat.SelectedValue);
         Dl_ksr.SelectedValue   = read_nd(ND_.Value, RNK_.Value, "KSR", "71", Dl_Zdat.SelectedValue);
         Tb_kres.Text = read_nd(ND_.Value, RNK_.Value, "KRES", "71", Dl_Zdat.SelectedValue);

         //Dd_RK4.SelectedValue = read_nd(ND_.Value, RNK_.Value, "RK4", "76", Dl_Zdat.SelectedValue);
         Dd_RK4.SelectedValue = "0";
         Dd_RK4.Enabled = false; 
         //Cb_RK22.Checked = true;


        // Розрахунок відповідей по замовчуванню
        // get_subpok();


        // Насиляємо гриди
        //wizard0

        //wizard2
        //FillData_Wizar2();

        //wizard3
        //FillData_Wizar3();

        //wizard4
        //FillData_Wizar4();

        //wizard5
        //FillData_Wizar5();

        //wizard6
        //FillData_Wizar6();

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


           // SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
           // SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
           // SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GrWiz2.DataSource = SQL_SELECT_dataset(@"select q.*, case when kod = 'KR5'  then 0 else nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) end  s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                                 --,(select count(1) from fin_question_reply where kod = q.kod and idf = q.idf) tip
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 72
                                                           ORDER BY ord");
            GrWiz2.DataBind();

            ClearParameters();
            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(Dl_Zdat.SelectedValue, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GrWiz2_kl.DataSource = SQL_SELECT_dataset(@"select q.*,  case when nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) = 0 then -99 else nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) end s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 70 
                                                           ORDER BY ord");


            //try { GrWiz2.DataBind(); } catch (Exception) { }  
            GrWiz2_kl.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }


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
                                                           where  q.idf = 73 
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
                                                           where  q.idf = 74 
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
                                                           where  q.idf = 75  and kod != 'ZD3'
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
    private void save_gr6()
    {

        ErrR = "0";

        if (String.IsNullOrEmpty(Dd_RK3.SelectedValue))
        {
            ErrR = "1";
            Err_name = Err_name + ". Ознака припинення визнання дефолту боржника  !!! ";
        }

        if (String.IsNullOrEmpty(Dd_RK4.SelectedValue))
        {
            ErrR = "1";
            Err_name = Err_name + ". Інформація про належність боржника до класу 5  !!! ";
        }


        if (ErrR == "1")
        {
            ShowError(" Не заповнено показник:   " + Err_name.ToUpper());
            return;
        }
        


        record_fp_nd("RK3", Dd_RK3.SelectedValue, "76");
        record_fp_nd("RK4", Dd_RK4.SelectedValue, "76");

        //if (Cb_RK22.Checked)
        //{ record_fp_nd("RK22", "1", "76"); }
        //else { record_fp_nd("RK22", "0", "76"); }



        adjustment_class(); 

        Tb_cls.Text = read_nd(ND_.Value, RNK_.Value, "CLS", "70", Dl_Zdat.SelectedValue);
        Tb_PD.Text = String.Format("{0:N3}", read_nd_n(ND_.Value, RNK_.Value, "PD", "76", Dl_Zdat.SelectedValue));
        //Tb_clsb.Text = read_nd(ND_.Value, RNK_.Value, "CLSP", "70", Dl_Zdat.SelectedValue);
        Pn_clas.Visible = true;

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

        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep0))
        {



            save_gr0();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }

        }

        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep2))
        {
            save_gr2();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }

        }

        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep3))
        {
            save_gr3();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }

        }


        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep5))
        {
            save_gr5();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }
        }


        if (Wizard1.ActiveStepIndex == Wizard1.WizardSteps.IndexOf(this.WizardStep4))
        {
            save_gr4();
            if (ErrR == "1")
            {
                e.Cancel = true;
            }


            if  (read_nd(ND_.Value, RNK_.Value, "RK1", "76", Dl_Zdat.SelectedValue) == "1"
                || read_nd(ND_.Value, RNK_.Value, "RK2", "76", Dl_Zdat.SelectedValue) == "1"
                || Convert.ToDecimal(read_nd(ND_.Value, RNK_.Value, "KKDP", "76", Dl_Zdat.SelectedValue)) >= 90) 
            {
                Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep5); ;
                Pn_Wizar5.Enabled = true;
                Pn_Wizar5_2.Enabled = true;
            }
            else
            {
                Wizard1.ActiveStepIndex = Wizard1.WizardSteps.IndexOf(this.WizardStep6); ;
                Pn_Wizar5.Enabled = false;
                Pn_Wizar5_2.Enabled = false;
                Dl_ZD3.SelectedValue = "0";
                save_gr5();
            }


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

    /// <summary>
    /// send_error   ПРО ПОМИЛКУ
    /// </summary>
    /// <param name="ErrorText"></param>
    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n", "").Replace("\r", "") + "');", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
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
        backToFolders("/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_bd&rnk=" + Convert.ToString(RNK_.Value));
    }

    protected void Tb_ZDN1_TextChanged(object sender, EventArgs e)
    {
        if ((!String.IsNullOrEmpty(Tb_ZDN1.Text) & Dd_RK1.SelectedValue == "1")       || Dd_RK1.SelectedValue == "0")
        { Dl_ZD3.SelectedValue = "1"; }
        else
        {
            Dl_ZD3.SelectedValue = "0";
        }
         
    }

    //protected void Cb_RK22_CheckedChanged(object sender, EventArgs e)
    //{
    //    save_gr5();
    //    Pn_clas.Visible = false;
    //}

    protected void GrWiz3_SelectedIndexChanged(object sender, EventArgs e)
    {
        int pos = 0;
        foreach (GridViewRow row in GrWiz3.Rows)
        {
            if (row.Cells[1].Controls[1] is DropDownList)
            {
                DropDownList tb1 = ((DropDownList)row.Cells[1].Controls[1]);
                if (tb1.Text != "-99" & Convert.ToString(GrWiz3.DataKeys[pos].Values[0]) == "BO6")
                {
                    if (tb1.Text == "1") { Pn_Wizar3_2.Visible = true; }
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

    protected void Bt_save_Click(object sender, EventArgs e)
    {

        save_gr6();
        
    }
}