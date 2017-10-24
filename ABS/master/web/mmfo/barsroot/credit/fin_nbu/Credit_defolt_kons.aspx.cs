using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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

public partial class credit_fin_nbu_Credit_drfolt_kons : Bars.BarsPage
{
    String ErrR = "0";
    String Err_name;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
             if (Request["RNK"] != null) { RNK_.Value = Convert.ToString(Request["RNK"]); }
             if (Request["ND"] != null)  { ND_.Value = Convert.ToString(Request["ND"]);   }
             load_form();
            // здійснити розрахунок автиоматичних питань
             get_subpok_kons();
             FillData_Wizar2();
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
            String p_Okpo;


            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();

            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.CommandText = @"  select c.nmk nmkk, to_char(C.datea,'dd/mm/yyyy') datea, c.okpo,
                                         (select to_char(nvl(max(fdat), trunc(gl.bd,'Q') ),'dd/mm/yyyy') from fin_fm where okpo = c.okpo and fdat < gl.bd) dat 
                                  from  fin_customer c
                                 where  rnk =:rnk_";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                Tb_nmk.Text = (String)rdr["NMKK"];
                p_Okpo = (String)rdr["OKPO"];
                Tb_okpo.Text = p_Okpo; //.Substring(4, 8);
                OKPO_.Value = (String)rdr["OKPO"];
                TB_Date_open.Text = rdr["DATEA"] == DBNull.Value ? (String)null : (String)rdr["DATEA"];
                TB_Dat.Text = rdr["DAT"] == DBNull.Value ? (String)null : (String)rdr["DAT"];

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

    protected void get_subpok_kons()
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


            // -- Автоматизоване визначення показників	 type 3	
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "fin_nbu.get_subpok_kons";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.Parameters.Add("DAT_", OracleDbType.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), ParameterDirection.Input);
            cmd.ExecuteNonQuery();

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected void adjustment_class_kons()
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


            // -- Автоматизоване визначення показників	 type 3	
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "fin_nbu.adjustment_class_kons";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("RNK_", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmd.Parameters.Add("ND_", OracleDbType.Decimal, nd, ParameterDirection.Input);
            cmd.Parameters.Add("DAT_", OracleDbType.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), ParameterDirection.Input);
            cmd.ExecuteNonQuery();

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }



    private void FillData_Wizar2()
    {

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            InitOraConnection();
            SetRole("WR_DOC_INPUT");



            ClearParameters();
            SetParameters("fdat", DB_TYPE.Date, Convert.ToDateTime(TB_Dat.Text, cinfo), DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Int64, Convert.ToInt64(ND_.Value), DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Int64, Convert.ToInt64(RNK_.Value), DIRECTION.Input);
            GrWiz2_kl.DataSource = SQL_SELECT_dataset(@"select q.*,   nvl(fin_OBU.ZN_P_ND(KOD, IDF, :FDAT, :ND, :RNK),-99) s,
                                                                 'select -99 as val, null as name from dual union all select val, name as name from FIN_QUESTION_REPLY where kod='''||KOD||''' and idf = '||IDF  l_sql
                                                          from  FIN_QUESTION q
                                                           where  q.idf = 59 
                                                           ORDER BY ord");
            GrWiz2_kl.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }

        Tb_Kzdv.Text = String.Format("{0:N2}", read_nd_n(ND_.Value, RNK_.Value, "KZDV", "59", TB_Dat.Text));   //Чиста кредитна заборгованість до чистої виручки від реалізації 
        Tb_Kzde.Text = String.Format("{0:N2}", read_nd_n(ND_.Value, RNK_.Value, "KZDE", "59", TB_Dat.Text));   //Чиста кредитна заборгованість до значення EBITDA

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

    protected void save_gr2()
    {
        
        ErrR = "0";
        int pos = 0;

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
            return;
        }


        Pn2.Visible = true;
        adjustment_class_kons();
        Tb_clas.Text = read_zn_p(OKPO_.Value, "CLAS", "6", TB_Dat.Text);
        Tb_cls.Text  = Convert.ToString(read_nd_n(ND_.Value, RNK_.Value, "CLS", "59", TB_Dat.Text));   

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
                SetParameters("dat_", DB_TYPE.Date, Convert.ToDateTime(TB_Dat.Text , cinfo), DIRECTION.Input);
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

    protected void Bt_run_Click(object sender, EventArgs e)
    {
         save_gr2();
    }

    protected void backToFolders(String p_url)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + p_url + "')", true);
    }

    protected void BtI_Cardkl_Click(object sender, EventArgs e)
    {
        backToFolders("/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl&rnk=" + Convert.ToString(Request["RNK2"]));
    }

}