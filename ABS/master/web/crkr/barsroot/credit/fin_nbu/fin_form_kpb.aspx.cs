using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Drawing;
//using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using Bars.Web.Controls;
using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls.WebParts;

public partial class credit_fin_form_kpb : Bars.BarsPage
{
    //# region Приватные свойства
    //private String _ShowbtPOK = "ShowbtPOK({0}, '{1}', '{2}', '{3}', '{4}'); return false;";
  
    /*
     *    Request["custype"] :
     *                     null -   Юридичні особи
     *                        2 -   Юридичні особи
     *                        3 -   Фізичні  особи
     *                        4 -   Бюджетні особи
     *    
     */


    //    protected OracleConnection con;
    String PAR_BANKYPE;
    String ErrR = "0";  
    private void FillData()
    {
        try
        {
            InitOraConnection();

            //Обязательно биндим

            //ОКПО клиента
            tbOKPO.DataBind();

            //Номер форми 
            tbFrm.DataBind();

            // Переводим в формат дати
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);


            // Дата(присваиваем сегодняшнюю дату)
            //tbFDat.Value= DateTime.Now;

            ClearParameters();

            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);

            if (Request["custype"] == null || Request["custype"] == "2")
            { SetParameters("idf", DB_TYPE.Varchar2, "7", DIRECTION.Input); }
            else if ( Request["custype"] == "3")
            {
                SetParameters("idf", DB_TYPE.Varchar2, "20", DIRECTION.Input);
            }
            else if (Request["custype"] == "4")
            {
                SetParameters("idf", DB_TYPE.Varchar2, "23", DIRECTION.Input);
            }

            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Varchar2, tbRNK.Text, DIRECTION.Input);

            if (Request["custype"] == null || Request["custype"] == "2")
            {
                SetParameters("idf", DB_TYPE.Varchar2, "7", DIRECTION.Input);
                SetParameters("idf", DB_TYPE.Varchar2, "7", DIRECTION.Input);
            }
            else if (Request["custype"] == "3")
            {
                SetParameters("idf", DB_TYPE.Varchar2, "20", DIRECTION.Input);
                SetParameters("idf", DB_TYPE.Varchar2, "20", DIRECTION.Input);
            }
            else if (Request["custype"] == "4")
            {
                SetParameters("idf", DB_TYPE.Varchar2, "23", DIRECTION.Input);
                SetParameters("idf", DB_TYPE.Varchar2, "23", DIRECTION.Input);
            }


            gvMain.DataSource = SQL_SELECT_dataset(@"select :dat as fdat, :nd as nd, q.KOD, q.ord, q.IDF, q.NAME, nvl(r.s, -99) as s, nvl(pob,0) as pob
                                                          from  FIN_QUESTION q, 
                                                                (select * from fin_nd rr where fdat = to_date(decode(:idf, 0, :dat,  fdat)) and nd = :nd and rnk = :rnk and exists (select 1 from fin_question_reply where kod= rr.kod and val = rr.s AND IDF = :idf)) r
                                                           where r.kod(+) = q.kod
                                                              and r.idf(+) = q.idf
                                                              and q.idf = :idf
                                                           ORDER BY 2, 4");
            //gvMain.DataSource = SQL_SELECT_dataset(@"select * from test_o");




            gvMain.DataBind();



        }
        finally
        {
            DisposeOraConnection();
        }
    }

    //  Опредиляю банк по DPT_BANK_TYPE 
    //  Якщо СБЕР то показую (Внутрішній кредитний рейтинг)
    private void GetGlobalData()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {



//            String PAR_BANKYPE;

            cmd.ExecuteNonQuery();

            cmd.CommandText = "select  "
              + "(select nvl(val,'') from params where par='DPT_BANK_TYPE') BANKTYPE "
              + "from dual";

            OracleDataReader rdr = cmd.ExecuteReader();
            if (!rdr.Read()) throw new Exception("Свое МФО не найдено или не определено.");

            PAR_BANKYPE = Convert.ToString(rdr.GetValue(0));
            
            if (PAR_BANKYPE == "SBER")
            {
                L_VNCRR.Visible = true;
                DL_VNCRR.Visible = true;
            }
            else if (String.IsNullOrEmpty(Convert.ToString(PAR_BANKYPE)))
            {
                L_VNCRR.Visible = true;
                DL_VNCRR.Visible = true;
            }
            else
            {
                L_VNCRR.Visible = false;
                DL_VNCRR.Visible = false;
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
            ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
           // ImageButton2.Visible = false;
        }
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        if (Request["okpo"] != null)
        {
            tbOKPO.Text = Convert.ToString(Request["okpo"]);
        }
        if (Request["frm"] != null)
        {
            tbFrm.Value = Convert.ToDecimal(Request["frm"]);
        }
        if (Request["dat"] != null)
        {
            if (!IsPostBack)
                  tbFDat.Text = Convert.ToString(Request["dat"]);
           }
        if (Request["rnk"] != null)
        {
            tbRNK.Text = Convert.ToString(Request["rnk"]);
        }

        if (!IsPostBack)
        {
            if (Request["custype"] == null || Request["custype"] == "2")
            {
                Panel1.Visible = false;
                ID2.Visible = false;
                pnGrid.Visible = false;
                
            }
            else if (Convert.ToString(Request["custype"]) == "3")
            {
                
                Panel1.Visible = false;
                //   ID2.Visible = false;
                ID1.Visible = true;   //показав панель з питаннями для контролю класу по пост.НБУ
                pnGrid.Visible = true;
                Bt_klass.Visible = false;

                L_p_kl3.Text = "Документи, що підтверджують отримання боржником – фізичною особою постійних доходів з урахуванням періодичності";
                L_p_kl4.Text = "Проти боржника – фізичної особи порушено справу про банкрутство";

                Tb_FIN23.IsRequired = true;     // обовязкове поле
                Tb_FIN23.ReadOnly = false;      // Разрешить редактировать поле
                Tb_FIN23.MaxValue = 4;          // максимальне значення  
                Tb_FIN23.MinValue = 1;          // мінімальне значення
                //Tb_KAT23.MinMaxValueErrorText = "Увага Клас може приймати значення  від 1 до 4 (1-А, 2-Б, 3-В, 4-Г)";
            }
           else if (Convert.ToString(Request["custype"]) == "4")
            {
                
                Panel1.Visible = false;
                //   ID2.Visible = false;
                ID1.Visible = true;   //показав панель з питаннями для контролю класу по пост.НБУ
                pnGrid.Visible = true;
                Bt_klass.Visible = false;

                L_p_kl3.Text = "Документи, що підтверджують отримання боржником – постійних доходів з урахуванням періодичності";
                L_p_kl4.Text = "Проти боржника – особи порушено справу про банкрутство";

                Tb_FIN23.IsRequired = true;     // обовязкове поле
                Tb_FIN23.ReadOnly = false;      // Разрешить редактировать поле
                Tb_FIN23.MaxValue = 4;          // максимальне значення  
                Tb_FIN23.MinValue = 1;          // мінімальне значення
                //Tb_KAT23.MinMaxValueErrorText = "Увага Клас може приймати значення  від 1 до 4 (1-А, 2-Б, 3-В, 4-Г)";
            }






        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                if (Request["custype"] == null || Request["custype"] == "2")
                {
                    SetParameters("OKPO", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                    tbFDat.DataSource = SQL_SELECT_dataset("select to_char(fdat,'dd/MM/yyyy') fdat, fdat qqq from fin_fm where okpo = :OKPO order by qqq desc").Tables[0];
                }
                else
                {
                    tbFDat.DataSource = SQL_SELECT_dataset("select to_char(GL.BD,'dd/MM/yyyy') as fdat from dual ").Tables[0];
                }
                tbFDat.DataTextField = "fdat";
                tbFDat.DataValueField = "fdat";
                //Биндим
                tbFDat.DataBind();
                //pnGrid.Visible = false;
            }
            finally
            {
                DisposeOraConnection();
            }
                   // Розрахуємо субєктивні показники
                    if (Request["rnk"] != null || Request["frm"] != null || Request["dat"] != null)
                    {
                        if (Request["custype"] == null || Request["custype"] == "2")
                        get_subpok(sender, e);
                    }

            Lb1.Visible = false;
            //            ID2.Visible = false;
            btRefresh.Visible = false;
            btOk.Visible = false;
            FillData();
            Load_Pkpb();


        }
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                Dl_obs.DataSource = SQL_SELECT_dataset("select obs, upper(name) as name from stan_obs23").Tables[0];
                Dl_obs.DataTextField = "name";
                Dl_obs.DataValueField = "obs";
                //Биндим
                Dl_obs.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

                DL_VNCRR.DataSource = SQL_SELECT_dataset("select code from CCK_RATING").Tables[0];
                DL_VNCRR.DataTextField = "code";
                DL_VNCRR.DataValueField = "code";
                //Биндим
                DL_VNCRR.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                D_p_kl1.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod='KP1'").Tables[0];
                D_p_kl1.DataTextField = "name";
                D_p_kl1.DataValueField = "val";
                //Биндим
                D_p_kl1.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }

        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                D_p_kl2.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod='KP2'").Tables[0];
                D_p_kl2.DataTextField = "name";
                D_p_kl2.DataValueField = "val";
                //Биндим
                D_p_kl2.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
        }
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                D_p_kl3.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod='KP3'").Tables[0];
                D_p_kl3.DataTextField = "name";
                D_p_kl3.DataValueField = "val";
                //Биндим
                D_p_kl3.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
        }
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                D_p_kl4.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod='KP4'").Tables[0];
                D_p_kl4.DataTextField = "name";
                D_p_kl4.DataValueField = "val";
                //Биндим
                D_p_kl4.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                D_p_kl5.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod='KP5'").Tables[0];
                D_p_kl5.DataTextField = "name";
                D_p_kl5.DataValueField = "val";
                //Биндим
                D_p_kl5.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
            //   Panel1.Visible = false;
            //   ID2.Visible = false;

        }


        //Питання про валютну виручку
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                D_p_kl6.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod='KP6'").Tables[0];
                D_p_kl6.DataTextField = "name";
                D_p_kl6.DataValueField = "val";
                //Биндим
                D_p_kl6.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }


        }

        GetGlobalData();

    }

    protected void btRefresh_Click(object sender, ImageClickEventArgs e)
    {
        FillData();
        Load_Pkpb();
    }

    //Перейдем на ту сторінку з якої прийшли
    protected void backToFolders(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
    }

    protected void btOk_Click(object sender, ImageClickEventArgs e)
    {
        calculation_ZPR();
    }


    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            decimal s = Convert.ToDecimal(((DataRowView)e.Row.DataItem).Row["S"]);
            //string kod = Convert.ToString(((DataRowView)e.Row.DataItem).Row["KOD"]);
            //string pob = Convert.ToString(((DataRowView)e.Row.DataItem).Row["POB"]);

            //if ( kod == "")
            //{
            //    e.Row.BackColor = System.Drawing.Color.LightGray;
            //    e.Row.Cells[0].Style.Add("border-bottom", "1px dotted black");
            //    e.Row.Cells[1].Style.Add("border-bottom", "1px dotted black");
            //    e.Row.Cells[2].Style.Add("border-bottom", "1px dotted black");
            //    e.Row.Cells[3].Style.Add("border-bottom", "1px dotted black");
            //    e.Row.Cells[4].Style.Add("border-bottom", "1px dotted black");
            //    e.Row.Cells[5].Style.Add("border-bottom", "1px dotted black");
            //    e.Row.Font.Bold = true;
            //}
            //if (pob == "1")
            //{
            //    e.Row.BackColor = System.Drawing.Color.Pink;
            //}
        }
    }

    private void ShowError(String ErrorText)
    {
        //Response.Write("!" + ErrorText + "!");
       ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText.Replace("\n","").Replace("\r", "") + "');", true);
    }


    // Вирахуємо Коофіциент покриття боргу
    protected void Bt10_Click(object sender, EventArgs e)
    {
        {
            DnKPB.Value = 0;
            Dn6.Value = 0;
            Dn6.Value = Convert.ToDecimal(Dn1.Value) + Convert.ToDecimal(Dn2.Value) + Convert.ToDecimal(Dn3.Value) + Convert.ToDecimal(Dn4.Value) + Convert.ToDecimal(Dn5.Value);
        }
        if ((Convert.ToDecimal(Dn7.Value) + Convert.ToDecimal(Dn8.Value)) > 0)
        { DnKPB.Value = Convert.ToDecimal(Dn6.Value) / (Convert.ToDecimal(Dn7.Value) + Convert.ToDecimal(Dn8.Value)); }
        else
        { DnKPB.Value = 0; }



        if (IsPostBack)
        {

            if (DnKPB.Value > 1)
            {
                pnGrid.Visible = true;
                FillData();
                //  btOk.Visible = true;
                Lb1.Visible = false;
            }
            else
            {
                pnGrid.Visible = true;
                // btOk.Visible = true;
                Lb1.Visible = false;
                //calculation_Pkb();
            }
        }

        save_Pkpb();
        Load_Pkpb();


    }


    // -----   Загрузка даних для коофіциента показнику боргу --------
    protected void Load_Pkpb()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
            Decimal OKPO = Convert.ToDecimal(tbOKPO.Text);
            Decimal ND = Convert.ToDecimal(tbFrm.Value);
            Decimal D_p_kl1_;
            Decimal D_p_kl2_;
            Decimal D_p_kl3_;
            Decimal D_p_kl3k;
            Decimal D_p_kl4_;
            Decimal D_p_kl5_;
            Decimal D_p_kl6_;
            Decimal D_p_kl6p;
            // установка роли
            cmd.ExecuteNonQuery();

            //    Response.Write("Read - 1");

            //cmd.Parameters.Add("ND", OracleDbType.Decimal, ND, ParameterDirection.Input);
            //cmd.Parameters.Add("okpo", OracleDbType.Decimal, OKPO, ParameterDirection.Input);
            //cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            //cmd.CommandText = ("select " +
            //                           " fin_nbu.ZN_FDK('220', fdat, okpo)-fin_nbu.ZN_FDK('225', fdat , okpo) as dn1, " +
            //                           " fin_nbu.ZN_FDK('260', fdat, okpo) as Dn2,   " +
            //                           " -fin_nbu.ZN_FDK('140', fdat, okpo) as Dn3,  " +
            //                           "  fin_nbu.ZN_P('Dn3', 8, fdat, okpo) as Dn3, " + 
            //                           "  fin_nbu.ZN_P('Dn4', 8, fdat, okpo) as Dn4,   " +
            //                           "  fin_nbu.ZN_P('Dn5', 8, fdat, okpo) as Dn5,   " + 
            //                           "  fin_nbu.ZN_P('Dn7', 8, fdat, okpo) as Dn7, " +
            //                           "  fin_nbu.ZN_P('Dn8', 8, fdat, okpo) as Dn8 ," +
            //                           "  fin_nbu.ZN_P('KP1', 5, fdat, okpo) as KP1," +
            //                           "  fin_nbu.ZN_P('KP2', 5, fdat, okpo) as KP2," +
            //                           " (case when (select sum(s) from fin_rnk where okpo = f.okpo and idf in (1,2) and fdat = f.fdat ) = 0 then 2  else 1 end) as KP3," +
            //                           " fin_nbu.ZN_P('KP4', 5, fdat, okpo) as KP4," +
            //                           " fin_nbu.ZN_P('KP5', 5, fdat, okpo) as KP5," +
            //                           " fin_nbu.ZN_P('KP6', 5, fdat, okpo) as KP6," +
            //                           " (select count(*) from v_fin_cc_deal c where  ND = :ND and exists (select 1 from cc_add where c.nd = nd and kv != 980)) as KP6P  " +
            //                       "   from fin_fm f where okpo = :okpo and fdat = :dat"); 

            cmd.Parameters.Add("rnk", OracleDbType.Decimal, tbRNK.Text, ParameterDirection.Input);
            cmd.Parameters.Add("okpo", OracleDbType.Decimal, OKPO, ParameterDirection.Input);
            //            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("ND", OracleDbType.Decimal, ND, ParameterDirection.Input);

            cmd.CommandText = ("select " +
                                //"  fin_zp.f_get_fin_nd (rnk , nd,  'KP1' , fdat) as KP1," +
                                "  fin_NBU.ZN_P_ND('KP1', 5, fdat, nd, rnk) as KP1," +
                                "  fin_NBU.ZN_P_ND('KP2', 5, fdat, nd, rnk) as KP2," +
                                " (case when (select sum(s) from fin_rnk where okpo = f.okpo and idf in (1,2) and fdat = f.fdat ) = 0 then 2  else 1 end) as KP3K," +
                                " fin_NBU.ZN_P_ND('KP3', 5, fdat, nd, rnk) as KP3," +
                                " fin_NBU.ZN_P_ND('KP4', 5, fdat, nd, rnk) as KP4," +
                                " fin_NBU.ZN_P_ND('KP5', 5, fdat, nd, rnk) as KP5," +
                                " fin_NBU.ZN_P_ND('KP6', 5, fdat, nd, rnk) as KP6," +
                                " (select count(*) from v_fin_cc_deal c where  rnk = f.rnk and (ND = f.nd or f.nd = 0) and  kv != 980) as KP6P  " +
                                "   from (select :rnk as rnk,  :okpo as okpo, :nd as nd,"); //+
            if (Request["custype"] == null || Request["custype"] == "2")
            {
                cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.CommandText += "    :dat as fdat ";

            }
            else if (Request["custype"] == "3" || Request["custype"] == "4")
            {
                cmd.CommandText += "  (select max(fdat) from fin_nd where nd = :nd) as fdat ";
                cmd.Parameters.Add("ND", OracleDbType.Decimal, ND, ParameterDirection.Input);
            }
            //          cmd.Parameters.Add("ND", OracleDbType.Decimal, ND, ParameterDirection.Input);
            //          cmd.CommandText += "    from v_fin_cc_deal c where nd = :nd) f";
            cmd.CommandText += "    from dual) f";


            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                //Dn1.Value = 10;
                //Dn1.Value = rdr["Dn1"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Dn1"];
                //Dn2.Value = rdr["Dn2"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Dn2"];
                //Dn3.Value = rdr["Dn3"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Dn3"];
                //Dn4.Value = rdr["Dn4"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Dn4"];
                //Dn5.Value = rdr["Dn5"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Dn5"];
                //Dn7.Value = rdr["Dn7"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Dn7"];
                //Dn8.Value = rdr["Dn8"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Dn8"];

                //     Response.Write("Read - 2");

                D_p_kl1_ = rdr["KP1"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP1"];
                if (D_p_kl1_ != 0) { D_p_kl1.SelectedValue = Convert.ToString(D_p_kl1_); }
                else { D_p_kl1.SelectedValue = "1"; D_p_kl1_ = 1; }

                D_p_kl2_ = rdr["KP2"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP2"];
                if (D_p_kl2_ != 0) { D_p_kl2.SelectedValue = Convert.ToString(D_p_kl2_); }
                else { D_p_kl2.SelectedValue = "1"; }

                D_p_kl3_ = rdr["KP3"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP3"];
                D_p_kl3k = rdr["KP3K"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP3K"];

                
                if (D_p_kl3_ != 0)
                {
                    
                    D_p_kl3.SelectedValue = Convert.ToString(D_p_kl3_);
                    if (Request["custype"] == null || Request["custype"] == "2")
                    {
                        if (D_p_kl3k == 2) 
                        {
                            
                            D_p_kl3.SelectedValue = Convert.ToString(D_p_kl3k);
                            D_p_kl3.Enabled = false;
                        }
                    }
                }
                else {
                    
                       D_p_kl3.SelectedValue = "1";
                       if (Request["custype"] == null || Request["custype"] == "2")
                       {
                           if (D_p_kl3k == 2)
                           {
                               
                               D_p_kl3.SelectedValue = Convert.ToString(D_p_kl3k);
                               D_p_kl3.Enabled = false;
                           }
                       }
                     }

                D_p_kl4_ = rdr["KP4"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP4"];
                if (D_p_kl4_ != 0) { D_p_kl4.SelectedValue = Convert.ToString(D_p_kl4_); }
                else { D_p_kl4.SelectedValue = "2"; }

                D_p_kl5_ = rdr["KP5"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP5"];
                if (D_p_kl5_ != 0) { D_p_kl5.SelectedValue = Convert.ToString(D_p_kl5_); }
                else { D_p_kl5.SelectedValue = "2"; }

                D_p_kl6_ = rdr["KP6"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP6"];
                D_p_kl6p = rdr["KP6P"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["KP6P"];

                if (D_p_kl6p == 0) { D_p_kl6.Visible = false; L_p_kl6.Visible = false; L_p_klv.Visible = false; }
                else
                {
                    if (D_p_kl6_ != 0) { D_p_kl6.SelectedValue = Convert.ToString(D_p_kl6_); }
                    else { D_p_kl6.SelectedValue = "1"; }
                }

                if (Convert.ToString(D_p_kl1_) == "1")
                {
                    D_p_kl2.Visible = true;
                    L_p_kl2.Visible = true;
                }
                else
                {
                    D_p_kl2.Visible = false;
                    L_p_kl2.Visible = false;
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
        Load_Pok_kl();
    }




    // загрузка даних про показники боржника (стан обслуг. боргуб класб і т.д.) 
    protected void Load_Pok_kl()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

             DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
            // Decimal OKPO = Convert.ToDecimal(tbOKPO.Text);
            // Decimal RNK = Convert.ToDecimal(tbRNK.Text);
            Decimal ND = Convert.ToDecimal(tbFrm.Value);

            Decimal obs23_;
            String vncrr_;
            Decimal fin23_;
            Decimal sos_;
            // установка роли
            cmd.ExecuteNonQuery();

            //            cmd.Parameters.Add("rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            //            cmd.Parameters.Add("rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);
            //            cmd.Parameters.Add("okpo", OracleDbType.Decimal, OKPO, ParameterDirection.Input);
            //            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            //            cmd.CommandText = (@"select fin_nbu.ZN_P('110', 6, fdat, okpo) as fin23,
            //                                            fin_nbu.ZN_P('080', 6, fdat, okpo) as kat23,
            //                                            fin_nbu.ZN_P('KPB', 9, fdat, okpo) as k23  ,
            //                                            fin_zp.Zn_obs(:rnk, fdat, okpo) as OBS23,
            //                                            fin_zp.zn_vncrr(:rnk)as VNCRR
            //                                       from fin_fm where okpo = :okpo and fdat = :dat");


            if (tbFrm.Value == 0)
            {
                //Response.Write("0 " + tbFrm.Value);
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, tbRNK.Text, ParameterDirection.Input);
                cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, tbRNK.Text, ParameterDirection.Input);
                cmd.CommandText = (@"select  nvl((fin23),  fin_zp.f_get_fin_nd (rnk , 0,  '110' , dat)) as fin23, 
                                             nvl((kat23),  fin_zp.f_get_fin_nd (rnk , 0,  '080' , dat)) as kat23, 
                                             nvl((k23),    fin_zp.f_get_fin_nd (rnk , 0,  'KPB' , dat)) as k23, 
                                             nvl((OBS23),  fin_zp.f_get_fin_nd (rnk , 0,  'OBS' , dat)) as obs23,  
                                             null VNCRR, 1 as sos
                                             from 
                                               (select  max(fin23) as fin23, 
                                                         max(kat23) as kat23, 
                                                         max(k23)   as k23, 
                                                         max(OBS23) as obs23,  
                                                         null VNCRR, :rnk as rnk, :dat as dat
                                                   from v_fin_cc_deal where rnk = :rnk 
                                                                                          ) ");
            }
            else
            {
                //Response.Write("1 " + tbFrm.Value);
                cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, tbRNK.Text, ParameterDirection.Input);
                cmd.Parameters.Add("nd", OracleDbType.Decimal, ND, ParameterDirection.Input);
                cmd.CommandText = (@"select  nvl((fin23),  fin_zp.f_get_fin_nd (rnk , nd,  '110' , dat)) as fin23, 
                                             nvl((kat23),  fin_zp.f_get_fin_nd (rnk , nd,  '080' , dat)) as kat23, 
                                             nvl((k23),    fin_zp.f_get_fin_nd (rnk , nd,  'KPB' , dat)) as k23, 
                                             nvl((OBS23),  0) as obs23,
                                             trim(fin_zp.zn_vncrr(rnk, nd)) VNCRR, sos
                                       from (select rnk, nd, sos,  fin23, kat23, k23, obs23, :dat as dat from v_fin_cc_deal) where rnk = :rnk and nd = :nd");
            }
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {

                fin23_ = rdr["Fin23"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["Fin23"];
                Tb_KAT23.Value = rdr["kat23"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["kat23"];
                N_K23.Value = rdr["k23"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["k23"];
                obs23_ = rdr["OBS23"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["OBS23"];
                vncrr_ = rdr["VNCRR"] == DBNull.Value ? (String)null : (String)rdr["VNCRR"];
                sos_ = rdr["SOS"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SOS"];


                if (Convert.ToString(fin23_) != "0") { Tb_FIN23.Value = fin23_;};

                if (Convert.ToString(obs23_) != "0")
                {
                    Dl_obs.SelectedValue = Convert.ToString(obs23_);
                    // блокуем  якщо значення поступило з бази
                    if (sos_ > 0) { Dl_obs.ReadOnly = true; } else { Dl_obs.ReadOnly = false; }
                }
                else
                {
                    Dl_obs.SelectedValue = "1";
                    Dl_obs.ReadOnly = false;
                }
                

                
                if (!String.IsNullOrEmpty(Convert.ToString(vncrr_)))
                {
                    DL_VNCRR.SelectedValue = vncrr_;
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


    //------ Зберегти показники коофіциента покриття боргу----
    protected void save_Pkpb()
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);

            InitOraConnection();
            {
                ClearParameters();

                SetParameters("idf", DB_TYPE.Varchar2, "8", DIRECTION.Input);
                SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                SetParameters("OKPO", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                SetParameters("kod1", DB_TYPE.Varchar2, "Dn1", DIRECTION.Input);
                SetParameters("S1", DB_TYPE.Decimal, Dn1.Value, DIRECTION.Input);

                SetParameters("kod2", DB_TYPE.Varchar2, "Dn2", DIRECTION.Input);
                SetParameters("S2", DB_TYPE.Decimal, Dn2.Value, DIRECTION.Input);

                SetParameters("kod3", DB_TYPE.Varchar2, "Dn3", DIRECTION.Input);
                SetParameters("S3", DB_TYPE.Decimal, Dn3.Value, DIRECTION.Input);

                SetParameters("kod4", DB_TYPE.Varchar2, "Dn4", DIRECTION.Input);
                SetParameters("S4", DB_TYPE.Decimal, Dn4.Value, DIRECTION.Input);

                SetParameters("kod5", DB_TYPE.Varchar2, "Dn5", DIRECTION.Input);
                SetParameters("S5", DB_TYPE.Decimal, Dn5.Value, DIRECTION.Input);

                SetParameters("kod6", DB_TYPE.Varchar2, "Dn6", DIRECTION.Input);
                SetParameters("S6", DB_TYPE.Decimal, Dn6.Value, DIRECTION.Input);

                SetParameters("kod7", DB_TYPE.Varchar2, "Dn7", DIRECTION.Input);
                SetParameters("S7", DB_TYPE.Decimal, Dn7.Value, DIRECTION.Input);

                SetParameters("kod8", DB_TYPE.Varchar2, "Dn8", DIRECTION.Input);
                SetParameters("S8", DB_TYPE.Decimal, Dn8.Value, DIRECTION.Input);

                SetParameters("kod9", DB_TYPE.Varchar2, "Dn9", DIRECTION.Input);
                SetParameters("S9", DB_TYPE.Decimal, DnKPB.Value, DIRECTION.Input);

                SetParameters("OBS_", DB_TYPE.Varchar2, "OBS", DIRECTION.Input);
                SetParameters("S_obs", DB_TYPE.Decimal, Dl_obs.Value, DIRECTION.Input);


                SetParameters("ND", DB_TYPE.Decimal, tbFrm.Value, DIRECTION.Input);
                SetParameters("RNK", DB_TYPE.Varchar2, tbRNK.Text, DIRECTION.Input);
                SetParameters("VNCRR", DB_TYPE.Varchar2, DL_VNCRR.SelectedValue, DIRECTION.Input);

               // Response.Write("qwerty-" + DL_VNCRR.SelectedValue);

                //Response.Write(KOD + " " + IDF + " " + OKPO + " " + dat + " " + tb1.Value + "# <br />");
                SQL_NONQUERY(" declare " +
                                "idf_ number := :idf; " +
                                "dat_ date   := :DAT;   " +
                                "okpo_ varchar2(10) := :OKPO; " +
                                "begin  " +
                                "fin_nbu.record_fp(:kod1, :S1, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod2, :S2, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod3, :S3, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod4, :S4, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod5, :S5, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod6, :S6, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod7, :S7, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod8, :S8, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:kod9, :S9, idf_, dat_, okpo_ );  " +
                                "fin_nbu.record_fp(:OBS_, :S_obs, 6, dat_, okpo_ );  " +
                         //       "cck_app.Set_ND_TXT(:ND, 'VNCRR',  trim (:VNCRR) );  " +
                                "fin_zp.set_nd_vncrr(:ND, :RNK,  trim (:VNCRR));" +
                                "end;");
                //ShowError("Форма №" + IDF + "( окп - " + OKPO + ")" + " за дату " + dat + ". Збережено успішно!!!");
            }



            //lock_form();

            //FillData();
        }
        finally
        {
            DisposeOraConnection();
        }
    }



    //---------Розрахунок значення показнику ризику кредиту---------------------
    protected void calculation_Pkb()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
          //  Response.Write("1");
            save_Pkpb();
          //  Response.Write("2");
          //  calc_class();
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
            Int64 ND = Convert.ToInt64(tbFrm.Value);
            String vnkr_ = Convert.ToString(DL_VNCRR.SelectedValue);


            cmd.ExecuteNonQuery();


            Decimal? ErrCode;
            String ErrMessage;

            cmd.CommandType = CommandType.StoredProcedure;

            if (Request["custype"] == null || Request["custype"] == "2")
            { cmd.CommandText = "fin_ZP.get_zprk"; }
            else if (Request["custype"] == "3")
            { cmd.CommandText = "fin_ZP.get_zprk_fl"; }
            else if (Request["custype"] == "4")
            { cmd.CommandText = "fin_ZP.get_zprk_bd"; }

            cmd.Parameters.Add("RNK_", OracleDbType.Int64, tbRNK.Text, ParameterDirection.Input);
            cmd.Parameters.Add("ND_", OracleDbType.Int64, ND, ParameterDirection.Input);
            cmd.Parameters.Add("DAT_", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("VNCR_", OracleDbType.Varchar2, vnkr_, ParameterDirection.Input);
            cmd.Parameters.Add("ERR_Code", OracleDbType.Decimal, null, ParameterDirection.Output);
            cmd.Parameters.Add("ERR_Message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);


            cmd.ExecuteNonQuery();


            ErrCode = ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["ERR_Code"].Value).Value;
            ErrMessage = ((OracleString)cmd.Parameters["ERR_Message"].Value).IsNull ? (String)null : ((OracleString)cmd.Parameters["ERR_Message"].Value).Value;

            // анализируем результат
            if (ErrCode.HasValue)
            {
                ShowError(ErrMessage);
                //return false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Розрахунок виконано '); ", true);
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "alert('Розрахунок виконано '); location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
                // ViewState.Remove("PREV_URL");
            }


        }

        finally
        {
            con.Close();
            con.Dispose();
            //DisposeOraConnection();
        }
        Load_Pok_kl();
    }


    protected void calculation_ZPR()
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);

            InitOraConnection();
            int pos = 0;
            foreach (GridViewRow row in gvMain.Rows)
            {

                if (row.Cells[3].Controls[1] is DropDownList)

                {

                    DropDownList tb1 = ((DropDownList)row.Cells[3].Controls[1]);
                    string NAME_ = Convert.ToString(gvMain.DataKeys[pos].Values[3]);
                    if (tb1.Text != "-99")
                    {
                    
                        string ND = Convert.ToString(gvMain.DataKeys[pos].Values[0]);
                        string KOD = Convert.ToString(gvMain.DataKeys[pos].Values[1]);
                        string IDF = Convert.ToString(gvMain.DataKeys[pos].Values[2]);

                        ClearParameters();


                        SetParameters("kod", DB_TYPE.Varchar2, KOD, DIRECTION.Input);
                        SetParameters("S", DB_TYPE.Varchar2, tb1.Text, DIRECTION.Input);
                        SetParameters("idf", DB_TYPE.Varchar2, IDF, DIRECTION.Input);
                        SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                        SetParameters("ND", DB_TYPE.Varchar2, ND, DIRECTION.Input);
                        SetParameters("rnk", DB_TYPE.Varchar2, tbRNK.Text, DIRECTION.Input);
                        SQL_NONQUERY(" begin fin_nbu.record_fp_nd(:kod, :S, :idf, :DAT, :nd, :rnk ); end;");
                       
                    
                    }
                    else
                    {
                        ShowError(" Не заповнено показник:   " + NAME_.ToUpper());
                        ErrR = "1";
                        return;
                    }
                }
                pos++;
            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void BtZPR_Click(object sender, EventArgs e)
    {

        Bt_klass_Click(sender, e);
        calculation_ZPR();

        if (ErrR != "1")
        {
        calculation_Pkb();
        FillData();
        if (Request["custype"] == null || Request["custype"] == "2")
            if (PAR_BANKYPE == "UPB" ) Bt_Print.Visible = true;
        }
        
    }



    protected void Changed_D_p_kl1(object sender, EventArgs e)
    {
        if (D_p_kl1.SelectedValue == "1")
        {
            D_p_kl2.Visible = true;
            L_p_kl2.Visible = true;
        }
        else
        {
            D_p_kl2.Visible = false;
            L_p_kl2.Visible = false;
        }
        //ShowError("Zn" + D_p_kl1.SelectedValue);

    }
    protected void Bt_klass_Click(object sender, EventArgs e)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);

            InitOraConnection();
            {
                ClearParameters();

                SetParameters("idf", DB_TYPE.Varchar2, "5", DIRECTION.Input);
                SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                SetParameters("OKPO", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                SetParameters("ND", DB_TYPE.Decimal, Convert.ToDecimal(tbFrm.Value), DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Decimal, Convert.ToDecimal(tbRNK.Text), DIRECTION.Input);

                SetParameters("kod1", DB_TYPE.Varchar2, "KP1", DIRECTION.Input);
                SetParameters("S1", DB_TYPE.Decimal, Convert.ToDecimal(D_p_kl1.SelectedValue), DIRECTION.Input);

                SetParameters("kod2", DB_TYPE.Varchar2, "KP2", DIRECTION.Input);
                SetParameters("S2", DB_TYPE.Varchar2, Convert.ToString(D_p_kl2.SelectedValue), DIRECTION.Input);

                SetParameters("kod3", DB_TYPE.Varchar2, "KP3", DIRECTION.Input);
                SetParameters("S3", DB_TYPE.Decimal, Convert.ToDecimal(D_p_kl3.SelectedValue), DIRECTION.Input);

                SetParameters("kod4", DB_TYPE.Varchar2, "KP4", DIRECTION.Input);
                SetParameters("S4", DB_TYPE.Decimal, Convert.ToDecimal(D_p_kl4.SelectedValue), DIRECTION.Input);

                SetParameters("kod5", DB_TYPE.Varchar2, "KP5", DIRECTION.Input);
                SetParameters("S5", DB_TYPE.Decimal, Convert.ToDecimal(D_p_kl5.SelectedValue), DIRECTION.Input);

                SetParameters("kod6", DB_TYPE.Varchar2, "KP6", DIRECTION.Input);
                SetParameters("S6", DB_TYPE.Varchar2, Convert.ToString(D_p_kl6.SelectedValue), DIRECTION.Input);

                SetParameters("VNCRR", DB_TYPE.Varchar2, DL_VNCRR.SelectedValue, DIRECTION.Input);

                SetParameters("obs", DB_TYPE.Varchar2, "OBS", DIRECTION.Input);
                SetParameters("Sobs", DB_TYPE.Varchar2, Convert.ToString(Dl_obs.SelectedValue), DIRECTION.Input);


                SQL_NONQUERY(" declare " +
                                "idf_ number := :idf; " +
                                "dat_ date   := :DAT;   " +
                                "okpo_ number  := :OKPO; " +
                                "ND_   number      := :ND; " +
                                "RNK_   number      := :rnk; " +
                                "begin  " +
                                "null;" +
                                "fin_nbu.record_fp_nd(:kod1, :S1, idf_, dat_, ND_,RNK_ );  " +
                                "fin_nbu.record_fp_nd(:kod2, nvl(:S2,0), idf_, dat_, ND_, RNK_ );  " +
                                "fin_nbu.record_fp_nd(:kod3, :S3, idf_, dat_, ND_, RNK_ );  " +
                                "fin_nbu.record_fp_nd(:kod4, :S4, idf_, dat_, ND_, RNK_ );  " +
                                "fin_nbu.record_fp_nd(:kod5, :S5, idf_, dat_, ND_, RNK_ );  " +
                                "fin_nbu.record_fp_nd(:kod6, nvl(:S6,0), idf_, dat_, ND_, RNK_ );  " +
                                "fin_zp.set_nd_vncrr(ND_, RNK_,  trim (:VNCRR));" +
                                "fin_nbu.record_fp_nd(:obs, :Sobs, 6, dat_, ND_, RNK_ );  " +
                                "end;");

            }


            pnGrid.Visible = true;
            ID2.Visible = true;

        }
        finally
        {
            DisposeOraConnection();
        }
        calc_class();


    }

    protected void calc_class()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
      
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
            Int64 ND = Convert.ToInt64(tbFrm.Value);
            String vnkr_ = Convert.ToString(DL_VNCRR.SelectedValue);


            cmd.ExecuteNonQuery();


            cmd.CommandType = CommandType.StoredProcedure;

            if (Request["custype"] == null || Request["custype"] == "2")
            { cmd.CommandText = "fin_nbu.get_class"; }
            else   //тимчасово поки розбиремось для бюджета контроль неха буде такий як і для фізиків
            { cmd.CommandText = "fin_nbu.get_class_fl"; }


            cmd.Parameters.Add("ND_", OracleDbType.Int64, ND, ParameterDirection.Input);
            cmd.Parameters.Add("OKPO", OracleDbType.Varchar2, tbOKPO.Text, ParameterDirection.Input);
            cmd.Parameters.Add("DAT_", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("RNK_", OracleDbType.Int64, tbRNK.Text, ParameterDirection.Input);
            cmd.ExecuteNonQuery();
        }

        finally
        {
            con.Close();
            con.Dispose();
            //DisposeOraConnection();
        }
        Load_Pok_kl();
    }

    protected void Tb_fn23_value(object sender, EventArgs e)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);

            InitOraConnection();
            {
                ClearParameters();

               // SetParameters("FIN", DB_TYPE.Varchar2, Tb_FIN23.Value, DIRECTION.Input);
                SetParameters("FIN", DB_TYPE.Varchar2, Tb_FIN23.Value, DIRECTION.Input);
                SetParameters("ND", DB_TYPE.Decimal, tbFrm.Value, DIRECTION.Input);
                SetParameters("RNK", DB_TYPE.Decimal, tbRNK.Text, DIRECTION.Input);

                SQL_NONQUERY(" declare  " +
                             "fin_ varchar2(10); " +
                             "nd_ varchar2(10); " +
                             "rnk_ varchar2(10); " +
                             "begin  " +
                             "fin_ :=  :FIN;" +
                             "nd_  :=  :ND;" +
                             "rnk_ :=  :RNK;" +
                             "if ( fin_ between 1 and 4 ) then " +
                             "update v_fin_cc_deal set fin23 = fin_ where (nd = nd_ or nd_ = 0) and rnk = rnk_ ;" +
                             "end if;" +
                              "end;");
                
            }
        }
        finally
        {
            DisposeOraConnection();
        }
        Bt_klass_Click(sender, e);
        //calc_class();
    }

    protected void get_subpok(object sender, EventArgs e)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);

            InitOraConnection();
            {
                ClearParameters();


                SetParameters("DAT", DB_TYPE.Date, dat, DIRECTION.Input);
                SetParameters("ND", DB_TYPE.Decimal, tbFrm.Value, DIRECTION.Input);
                SetParameters("RNK", DB_TYPE.Decimal, tbRNK.Text, DIRECTION.Input);

                SQL_NONQUERY("declare  " +
                             "dat_ date; " +
                             "nd_ varchar2(10); " +
                             "rnk_ varchar2(10); " +
                             "begin  " +
                             "dat_ :=  :DAT;" +
                             "nd_  :=  :ND;" +
                             "rnk_ :=  :RNK;" +
                             "fin_zp.get_subpok(RNK_, ND_, DAT_);" +
                             "end;");

            }
        }
        finally
        {
            DisposeOraConnection();
        }

    }


    protected void Bt_Print_Click(object sender, EventArgs e)
    {

        String TemplateId = "Fin_nbu_CGD23.frx";

        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("datf", TypeCode.String, tbFDat.SelectedValue));
        pars.Add(new FrxParameter("rnk1", TypeCode.String, tbRNK.Text));
        pars.Add(new FrxParameter("nd", TypeCode.String, tbFrm.Value));


        //Response.Write(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)));
        //Response.Write(TemplateId);
        //Response.Write(tbFDat.SelectedValue);

        FrxDoc doc = new FrxDoc(
            //   FrxDoc.GetTemplatePathByFileName(TemplateId),
            FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId,
                  pars,
                this.Page);

        doc.Print(FrxExportTypes.Pdf);
                
        //switch ("DOCEXP_TYPE_ID")
        //{
        //    case "PDF": doc.Print(FrxExportTypes.Pdf);
        //        break;
        //    case "RTF": doc.Print(FrxExportTypes.Rtf);
        //        break;
        //    default: doc.Print(FrxExportTypes.Pdf);
        //        break;
        //}


       

    }


}
