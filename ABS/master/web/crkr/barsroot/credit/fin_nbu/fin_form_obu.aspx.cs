using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Drawing;
using Oracle.DataAccess.Client;
using System.Globalization;
using Oracle.DataAccess.Types;
using System.Threading;
using System.Web.Security;
using Bars.UserControls;
using Bars.Web.Controls;
using Bars.Application;
using System.Web.UI.HtmlControls;



public partial class credit_fin_form_obu : Bars.BarsPage
{
    

    String ErrR = "0";  

    protected OracleConnection con;

 
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        pnGrid.Visible = true;

        
         
        if (Request["dat"] != null)
        {
            if (!IsPostBack)
                tb_datf.Text = Convert.ToString(Request["dat"]);
        }

        if (Request["frm"] != null && !IsPostBack)
        {
             tb_nd.Text = Convert.ToString(Request["frm"]);
             bt_v.Enabled = false;

                     if (tb_nd.Text =="-1")
                     {
                       bt_v.SelectedValue = "2";
                     }
                     else
                     { bt_v.SelectedValue = "1"; }





        }

                if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

                tb_kv.DataSource = SQL_SELECT_dataset("select kv, name from tabval where kv in (980, 840, 978, 643) order by grp").Tables[0];
                tb_kv.DataTextField = "name";
                tb_kv.DataValueField = "kv";
                tb_kv.DataBind();

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

                DDL_obs.DataSource = SQL_SELECT_dataset("select obs, name as name from stan_obs23 order by obs ").Tables[0];
                DDL_obs.DataTextField = "name";
                DDL_obs.DataValueField = "obs";
                DDL_obs.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }
        }


        // END****** отримуємо РНК і визначаємо параметри клієнта

        if (!IsPostBack)
        {
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                if (tb_datf.Text.Length == 0) return;

                DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

                InitOraConnection();

                {


                    ClearParameters();



                    SetParameters("rnk", DB_TYPE.Varchar2, Convert.ToString(Request["rnk"]), DIRECTION.Input);
                    SetParameters("ND", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
                    SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);

                    SQL_NONQUERY(@" declare 
                                rnk_ number := :RNK;
                                nd_ number :=  :ND;
                                dat_ date   := :dat;
                                begin 
                                 if nd_ != -1 then
                                             fin_nbu.Load_testND(rnk_, nd_, dat_);
                                 end if;
                                fin_nbu.ZN_IPB(RNK_, null, DAT_);
	                            fin_zp.get_subpok ( rnk_, nd_, dat_ ); 
                                end;");


                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }


//****** отримуємо РНК і визначаємо параметри клієнта
        if (Request["rnk"] != null && !IsPostBack)
        {
            tb_RNK.Text  = Convert.ToString(Request["rnk"]);

                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        try
                {
                    CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                    cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                    cinfo.DateTimeFormat.DateSeparator = "/";

                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Add("rnk", OracleDbType.Decimal, tb_RNK.Text, ParameterDirection.Input);
                    cmd.CommandText = ("select nmk, okpo, to_char(datea,'dd/mm/yyyy') as dat_st from fin_customer where rnk = :rnk");
            
                    OracleDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read())
                    {
                         TB_NMS.Text  = rdr["NMK"]  == DBNull.Value ? (String)null : (String)rdr["NMK"];
                         tb_okpo.Text = rdr["OKPO"] == DBNull.Value ? (String)null : (String)rdr["OKPO"];
                            if (TB_NMS.Text.Length != 0)
                                TB_NMS.Width = TB_NMS.Text.Length * 7;

                            if (!IsPostBack)
                            {
                                tb_DP.SelectedValue = read_nd(tb_nd.Text, tb_RNK.Text, "VDP", "32", tb_datf.Text);
                              //  bt_v.SelectedValue = read_nd(tb_nd.Text, tb_RNK.Text, "VIS", "32", tb_datf.Text);
                                tb_tiprnk.SelectedValue = read_nd(tb_nd.Text, tb_RNK.Text, "TIP", "32", tb_datf.Text);


                               
                                tb_NSM.Text = calc_nd("NSM", tb_datf.Text, tb_okpo.Text, tb_RNK.Text, tb_nd.Text);
                                //tb_ZMO.Text = calc_nd("ZM0", tb_datf.Text, tb_okpo.Text, tb_RNK.Text, tb_nd.Text);
                                tb_ZI0.Value = Convert.ToDecimal( read_nd_n(tb_nd.Text, tb_RNK.Text, "ZI0", "30", tb_datf.Text));


                            }
                            String Dat_st;
                            Dat_st = rdr["dat_st"] == DBNull.Value ? (String)null : (String)rdr["dat_st"];

                        //  if ((DateTime)rdr["dat_st"]  != null)
                            if (Dat_st != null)
                            {
                                // Response.Write("l_99 date_stv_"+(DateTime)rdr["dat_st"]);
                                //  tb_datst.Value = (DateTime)rdr["dat_st"];
                                tb_datst.Value = Convert.ToDateTime(Dat_st, cinfo);
                                //  Response.Write("l_101 *** stv_" + tb_datst.Value);
                                tb_datst.Enabled = false;
                            }
                            else { tb_datst.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DST", "32", tb_datf.Text)); }
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







// ****** отримуємо РНК і  НД  визначаємо параметри кредиту
        if ((Request["rnk"] != null && Request["frm"] != null) && !IsPostBack)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                if (tb_datf.Text.Length == 0) return;

                String graf = (read_nd(tb_nd.Text, tb_RNK.Text, "GRF", "32", tb_datf.Text));
                if (graf != null)
                    tb_graf.SelectedValue = graf;

                DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

                cmd.ExecuteNonQuery(); 
                cmd.Parameters.Add("fdat", OracleDbType.Date,           dat, ParameterDirection.Input);
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, tb_RNK.Text, ParameterDirection.Input);
                cmd.Parameters.Add("nd", OracleDbType.Decimal,  tb_nd.Text , ParameterDirection.Input);
                cmd.CommandText = (@"    select c.nd, 
                                            decode(c.vidd,2,4,3,5, DECODE (c.gpk,4,1,2,2,3) ) as vidd,
                                            c.dsdate as sdate,
                                            c.AwDATE as sdatp,
                                            c.DWDATE as wdate,
                                            c.cc_id,
                                            (case when vidd = 3 then (select acrN.FPROCN (a8.ACC, 0, '') from accounts a8, nd_acc nd where nd.nd = c.nd and nd.acc = a8.acc and a8.nbs = '8999' and a8.tip = 'LIM'  ) 
                                                  else pr
                                                  end  
                                            ) as pr,
                                            to_char(c.kv) as kv,
                                            nvl(c.obs,0) as obs,
                                            c.sos,
                                            cc.datea as dat_st,
                                            (p_icurval(c.kv, fin_obu.SUM_LIM_ND(c.nd, c.rnk, d.fdat ), sysdate))/100 as limit,
                                            (p_icurval(c.kv, fin_obu.SUM_LIM_ND(c.nd, c.rnk, d.fdat ), sysdate))/100 as ost_e,
                                            fin_obu.SUM_LIM_ND(c.nd, c.rnk, d.fdat )/100 as s,
                                            fin_obu.SUM_LIM_ND(c.nd, c.rnk, d.fdat )/100 as ostc,
                                            cc.rnk,
                                            nvl(c.obs,0) as obs23
                                            from CC_V c, fin_customer cc, (select :fdat as fdat from dual) d 
                                            where  c.rnk = cc.rnk
                                             and cc.rnk = :rnk
                                             and c.nd = :nd ");

                OracleDataReader rdr = cmd.ExecuteReader();
                
                if (rdr.Read())
                {



                    //TB_NMS.Text = rdr["NMK"] == DBNull.Value ? (String)null : (String)rdr["NMK"];
                    if ((DateTime)rdr["sdate"] != null)
                    {
                        // дата видачі
                        tb_sdate.Value = (DateTime)rdr["sdatp"];
                        tb_sdate.Enabled = false;
                        //дата заключення
                        tb_datp.Value = (DateTime)rdr["sdate"];
                        tb_datp.Enabled = false;
                        
                    }
                    if ((DateTime)rdr["wdate"] != null)
                    {
                        tb_wdate.Value = (DateTime)rdr["wdate"];
                        tb_wdate.Enabled = false;
                        
                    }
                    if ((String)rdr["cc_id"] != null)
                    {
                        tb_cc_id.Text = (String)rdr["cc_id"];
                        tb_cc_id.Enabled = false;
                    }

                    if ((String)rdr["kv"] != null)
                    {
                        tb_kv.SelectedValue = ((String)rdr["kv"]);
                        tb_kv.Enabled = false;
                       

                    }
                    if ((Decimal)rdr["pr"] != null)
                    {
                        tb_rat.Value = (Decimal)rdr["pr"];
                        tb_rat.Enabled = false;
                        //   для теста !!!!!!!!!!!!!!!!!!!!!!

                    }
                    else{
                            tb_rat.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "PRC", "32", tb_datf.Text));
                    }
                    if ((Decimal)rdr["vidd"] != null && (Decimal)rdr["SOS"] != 0)
                    {

                        tb_graf.SelectedValue = Convert.ToString(((Decimal)rdr["vidd"]));
                        tb_graf.Enabled = false;
                    }
                    else 
                    {
                        tb_graf.SelectedValue = (read_nd(tb_nd.Text, tb_RNK.Text, "GRF", "32", tb_datf.Text));
                        tb_graf.Enabled = false;
                    }


                    if ((Decimal)rdr["SOS"] == 0)
                    {
                        tb_sumn.Value = Convert.ToDecimal(read_nd(tb_nd.Text, tb_RNK.Text, "SUN", "32", tb_datf.Text));
                        tb_summ.Value = Convert.ToDecimal(read_nd(tb_nd.Text, tb_RNK.Text, "SUM", "32", tb_datf.Text));
                       // tb_rat.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "PRC", "32", tb_datf.Text));
                       // tb_kv.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "VAL", "30", tb_datf.Text));
                       // DDL_obs.Enabled = true;
                       // DDL_obs.IsRequired = true;
                       // DDL_obs.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "OBS", "6", tb_datf.Text));
                        tb_summ.Visible = false;
                        tb_summ.Enabled = false;
                    }
                    else
                    {
                        if (Convert.ToString((Decimal)rdr["vidd"]) == "4" || Convert.ToString((Decimal)rdr["vidd"]) == "5")
                        {
                            tb_summ.Value = (Decimal)rdr["limit"];
                            tb_sumn.Value = (Decimal)rdr["s"];
                            tb_summ.Enabled = false;
                            tb_sumn.Enabled = false;
                        }
                        else
                        {
                            tb_summ.Value = (Decimal)rdr["ost_e"];
                            tb_sumn.Value = (Decimal)rdr["ostc"];
                            tb_summ.Enabled = false;
                            tb_sumn.Enabled = false;
                        }
                    }


                    if ((Decimal)rdr["obs23"] != 0)
                    {
                        //DDL_obs.SelectedValue = "4";
                        DDL_obs.SelectedValue = Convert.ToString((Decimal)rdr["obs23"]);
                    }
                    else
                    {
                       // DDL_obs.SelectedValue = "1";
                       // DDL_obs.Enabled = true;
                        DDL_obs.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "OBS", "6", tb_datf.Text));
                    }
                    if ((Decimal)rdr["SOS"] == 0 || (Decimal)rdr["obs23"] == 0) DDL_obs.Enabled = true; DDL_obs.IsRequired = true;  // якщо sos = 0 то стан ослуговування боргу дем мінять 

                    if ((Decimal)rdr["SOS"] == 0)  bt_v.SelectedValue = "2"; //Якщо sos = 0 то Попередня оцінка
                }

                else 
                {
                    tb_sumn.Value = Convert.ToDecimal(read_nd(tb_nd.Text, tb_RNK.Text, "SUN", "32", tb_datf.Text));
                    tb_summ.Value = Convert.ToDecimal( read_nd(tb_nd.Text, tb_RNK.Text, "SUM", "32", tb_datf.Text));
                    tb_rat.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "PRC", "32", tb_datf.Text));
                    tb_datp.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DAP", "32", tb_datf.Text));
                    tb_sdate.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DAS", "32", tb_datf.Text));
                    tb_wdate.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DAW", "32", tb_datf.Text));
                  //  tb_datst.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DST", "32", tb_datf.Text));
                    tb_kv.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "VAL", "30", tb_datf.Text));
                    DDL_obs.Enabled = true;
                    DDL_obs.IsRequired = true;
                    DDL_obs.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "OBS", "6", tb_datf.Text));
                    tb_summ.Visible = false;
                    tb_summ.Enabled = false;
                    
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



// END****** отримуємо РНК і  НД  визначаємо параметри кредиту
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

                tb_tiprnk.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "TIP" + ((char)39).ToString() + "and idf = 32 ").Tables[0];
                tb_tiprnk.DataTextField = "name";
                tb_tiprnk.DataValueField = "val";
                tb_tiprnk.DataBind();

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

                Tb_INV.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "INV" + ((char)39).ToString() + "and idf = 32 ").Tables[0];
                Tb_INV.DataTextField = "name";
                Tb_INV.DataValueField = "val";
                Tb_INV.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }


            if (Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "INV", "32", tb_datf.Text)) != null)
            { Tb_INV.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "INV", "32", tb_datf.Text)); }
            else
            { Tb_INV.SelectedValue = "1"; }


            if (Tb_INV.SelectedValue == "2")
            {
                Lb_ETAP.Visible = true;
                Tb_ETAP.Visible = true;
                lb_IKY.Visible = true;
                tb_IKY.Visible = true;
            }
            else
            {
                Lb_ETAP.Visible = false;
                Tb_ETAP.Visible = false;
                lb_IKY.Visible = false;
                tb_IKY.Visible = false;
            }
        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

                Tb_ETAP.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "ETP" + ((char)39).ToString() + "and idf = 32 ").Tables[0];
                Tb_ETAP.DataTextField = "name";
                Tb_ETAP.DataValueField = "val";
                Tb_ETAP.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }

            if (Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "ETP", "32", tb_datf.Text)) != null)
            { Tb_ETAP.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "ETP", "32", tb_datf.Text)); }
            else
            { Tb_ETAP.SelectedValue = "2"; }

        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

                tb_IKY.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "IKY" + ((char)39).ToString() + "and idf = 32 ").Tables[0];
                tb_IKY.DataTextField = "name";
                tb_IKY.DataValueField = "val";
                tb_IKY.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }

            if (Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "IKY", "32", tb_datf.Text)) != null)
            { tb_IKY.SelectedValue = Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "IKY", "32", tb_datf.Text)); }
            else
            { tb_IKY.SelectedValue = "2"; }

        }


        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

               Tb_MZ0.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "MZ0" + ((char)39).ToString() + "and idf = 33 ").Tables[0];
               Tb_MZ0.DataTextField = "name";
               Tb_MZ0.DataValueField = "val";
               Tb_MZ0.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }

            Tb_MZ0.SelectedValue = Convert.ToString (read_nd(tb_nd.Text, tb_RNK.Text, "MZ0", "30", tb_datf.Text));
            Tb_MZ1.Value         = (read_nd_n(tb_nd.Text, tb_RNK.Text, "MZ1", "30", tb_datf.Text));

            if (Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "MZ0", "30", tb_datf.Text)) == "8")
            {
                Tb_MZ1.Visible = true;
                Lb_MZ1.Visible = true;
            }
            else
            {
                Tb_MZ1.Visible = false;
                Lb_MZ1.Visible = false;
            }

            // обмеження на макисмальну суму tb_BZB , не повинна перевищувати суму за рядками балансу 500+440  (ZPB_max)
            tb_BZB.MaxValue = Convert.ToDecimal(calc_nd("ZPB_max", tb_datf.Text, tb_okpo.Text, tb_RNK.Text, tb_nd.Text))*1000; 
        }

        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

                tb_graf.DataSource = SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + "GRF" + ((char)39).ToString() + "and idf = 32 ").Tables[0];
                tb_graf.DataTextField = "name";
                tb_graf.DataValueField = "val";
                tb_graf.DataBind();

            }
            finally
            {
                DisposeOraConnection();
            }


            //String graf = (read_nd(tb_nd.Text, tb_RNK.Text, "GRF", "32", tb_datf.Text));
            //if (graf != null)
            //    tb_graf.SelectedValue = graf;

            Decimal p_ZB = (read_nd_n(tb_nd.Text, tb_RNK.Text, "ZB0", "32", tb_datf.Text));
            if (p_ZB != null)
                tb_ZB.Value = Convert.ToDecimal(p_ZB);

            Decimal p_BZB = (read_nd_n(tb_nd.Text, tb_RNK.Text, "BZB", "32", tb_datf.Text));
            if (p_BZB != null)
                tb_BZB.Value = Convert.ToDecimal(p_BZB);

            Decimal p_NKO = (read_nd_n(tb_nd.Text, tb_RNK.Text, "NKO", "32", tb_datf.Text));
            if (p_NKO != null)
                tb_NKO.Value = Convert.ToDecimal(p_NKO);

        }


        if (!IsPostBack && read_nd_hist(tb_nd.Text, tb_RNK.Text, "BAL", "35", tb_datf.Text) != null) 
        {Bt_print.Visible = true;
        ddl_print.Visible = true;
        Bt_print.Focus();
        review_forms2();
        //pnRez.Visible = true;
        }

        if (!IsPostBack && read_nd_hist(tb_nd.Text, tb_RNK.Text, "000", "30", tb_datf.Text) == "1") { review_forms(); review_forms2(); }
        //if (!IsPostBack) FillData();
        if (!IsPostBack && read_nd_hist(tb_nd.Text, tb_RNK.Text, "000", "30", tb_datf.Text) == "1") 
        {
            FillData_hist();
        }
        else if (!IsPostBack && read_nd_hist(tb_nd.Text, tb_RNK.Text, "000", "30", tb_datf.Text) != "1")
        {
            FillData();
        }
    }




    //Перейдем на ту сторінку з якої прийшли
    protected void backToFolders(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    private void FillData()
    {
        try
        {
            InitOraConnection();

            //Обязательно биндим

            //ОКПО клиента
        //    tbOKPO.DataBind();

            //Номер форми 
        //    tbFrm.DataBind();

            // Переводим в формат дати
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if ( tb_datf.Text.Length == 0) return;
              

            //tb_datf.Text = "01/10/2012";
            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);


            // Дата(присваиваем сегодняшнюю дату)
            //tbFDat.Value= DateTime.Now;

            ClearParameters();

            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
        //    SetParameters("nd", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);

            gvMain.DataSource = SQL_SELECT_dataset(@"select :dat as fdat, :nd as nd, q.KOD, q.ord, q.IDF, q.NAME, nvl(r.s, -99) as s, nvl(pob,0) as pob, q.descript
                                                          from  FIN_QUESTION q, 
                                                                (select * from fin_nd rr where  nd = :nd and rnk = :rnk 
                                                                  and exists (select 1 from fin_question_reply where kod= rr.kod and val = rr.s AND IDF in (5,7,31))) r
                                                           where r.kod(+) = q.kod
                                                              and r.idf(+) = q.idf
                                                              and q.idf in (5,7,31)
--                                                              and case when q.kod = 'KP6' then 
--                                                                                            nvl((  select max( decode(a.kv,980,0,1))
--                                                                                                    from cc_deal c, nd_acc nd, accounts a  
--                                                                                                   where c.nd = :nd
--                                                                                                     and c.nd = nd.nd   
--                                                                                                    and nd.acc = a.acc and a.dazs is null
--                                                                                                     and a.tip in ('SS ','SP ') ),1)
--                                                                                         else 1
--                                                                  end = 1 
                                                           ORDER BY q.idf, q.ord");
            
            gvMain.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    private void FillData_hist()
    {
        try
        {
            InitOraConnection();


            // Переводим в формат дати
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tb_datf.Text.Length == 0) return;


            //tb_datf.Text = "01/10/2012";
            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);


            // Дата(присваиваем сегодняшнюю дату)
            //tbFDat.Value= DateTime.Now;

            ClearParameters();

            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
            SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
            SetParameters("nd", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
       //     SetParameters("nd", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);

            gvMain.DataSource = SQL_SELECT_dataset(@" select :dat as fdat, :nd as nd, q.KOD, q.ord, q.IDF, q.NAME, nvl(r.s, -99) as s, 1 as pob, q.descript
                                                          from  FIN_QUESTION q,  (select * from (select kod, idf, fin_obu. F_GET_FIN_ND ( :rnk ,   :nd ,  kod ,  idf,  :dat) as s from FIN_QUESTION rr where idf in (5,7,31)) rr where exists(select 1 from fin_question_reply where kod= rr.kod and val = rr.s AND IDF in (5,7,31)) ) r
                                                           where r.kod(+) = q.kod 
                                                              and r.idf(+) = q.idf
                                                              and q.idf in (5,7,31)
--                                                              and case when q.kod = 'KP6' then 
--                                                                                            nvl((  select max( decode(a.kv,980,0,1))
--                                                                                                     from cc_deal c, nd_acc nd, accounts a  
--                                                                                                   where c.nd = :nd
--                                                                                                     and c.nd = nd.nd   
--                                                                                                    and nd.acc = a.acc and a.dazs is null
--                                                                                                     and a.tip in ('SS ','SP ') ),1)
--                                                                                         else 1
--                                                                  end = 1 
                                                               ORDER BY q.idf, q.ord");

            gvMain.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }
    }


    protected void calculation_VNKR(  )
    {
            
      try
        {            
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tb_datf.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

            InitOraConnection();
            int pos = 0;
            foreach (GridViewRow row in gvMain.Rows)
            {

                //DropDownList ttt = ((DropDownList)row.Cells[3].Controls[1]);

                //Response.Write("test1" + ttt.Text);
                //return;


                if (row.Cells[3].Controls[1] is DropDownList)
                // if (row.Cells[3].Controls[1] is  DDLList)
                {
                   // Response.Write("test1");
                   


                    DropDownList tb1 = ((DropDownList)row.Cells[3].Controls[1]);
                    string NAME_ =   Convert.ToString(gvMain.DataKeys[pos].Values[3]) ;

                    
                    
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
                        SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
                        SQL_NONQUERY(" begin fin_nbu.record_fp_nd(:kod, :S, :idf, :DAT, :nd, :rnk ); end;");
                        //  Response.Write(pos + " " + KOD + " " + IDF + " " + " " + dat + " " + tb1.Text + "# <br />");

                    }
                    else 
                    {
                        ShowError(" Не заповнено показник:   " + NAME_.ToUpper());
                        ErrR = "1";
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

    protected void GET_POK()
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tb_datf.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

            InitOraConnection();

            {


                ClearParameters();



                SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
                SetParameters("ND", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
                SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                SetParameters("v_tip", DB_TYPE.Varchar2, bt_v.SelectedValue, DIRECTION.Input);
                
  
                SQL_NONQUERY(@" declare 
                                rnk_ number := :RNK;
                                nd_ number := :ND;
                                dat_ date   := :dat;
                                v_tip_ number := :v_tip;
                                begin 
                                fin_OBU.GET_POK( rnk_, nd_, dat_ ); 
                                fin_OBU.calc_points(nd_, rnk_, dat_);
                                fin_OBU.GET_calc_print(rnk_, nd_,  dat_, v_tip_, fin_obu.GET_VNKR(dat_,  rnk_, nd_));
                                end;");
                //  Response.Write(pos + " " + KOD + " " + IDF + " " + " " + dat + " " + tb1.Text + "# <br />");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void save_infcl( String kod_, String idf_, String s_)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tb_datf.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

            InitOraConnection();
           
 

            
            {

   
                        ClearParameters();

                        SetParameters("kod", DB_TYPE.Varchar2, kod_, DIRECTION.Input);
                        SetParameters("S", DB_TYPE.Varchar2,   s_, DIRECTION.Input);
                      //  Response.Write("save_"+"kod_"+kod_ + "s_" + s_);
                        SetParameters("idf", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                        SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                        SetParameters("ND", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
                        SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
                        SQL_NONQUERY(" begin fin_nbu.record_fp_nd(:kod, :S, :idf, :DAT, :nd, :rnk ); end;");
                      //   Response.Write(pos + " " + KOD + " " + IDF + " " + " " + dat + " " + tb1.Text + "# <br />");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void save_infcl( String kod_, String idf_, Decimal s_)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tb_datf.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

            InitOraConnection();

            {


                ClearParameters();

                SetParameters("kod", DB_TYPE.Varchar2, kod_, DIRECTION.Input);
                SetParameters("S", DB_TYPE.Decimal, s_, DIRECTION.Input);
                //  Response.Write("save_"+"kod_"+kod_ + "s_" + s_);
                SetParameters("idf", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                SetParameters("ND", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
                SQL_NONQUERY(" begin fin_nbu.record_fp_nd(:kod, :S, :idf, :DAT, :nd, :rnk ); end;");
                //  Response.Write(pos + " " + KOD + " " + IDF + " " + " " + dat + " " + tb1.Text + "# <br />");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void save_infcl_date(String kod_, String idf_, DateTime Val_date_)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tb_datf.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

            InitOraConnection();

            {


                ClearParameters();

                SetParameters("kod", DB_TYPE.Varchar2, kod_, DIRECTION.Input);
                SetParameters("S", DB_TYPE.Date, Val_date_,  DIRECTION.Input);
                SetParameters("idf", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                SetParameters("ND", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
                SQL_NONQUERY(" begin fin_obu.record_fp_nd_date(:kod, :S, :idf, :DAT, :nd, :rnk ); end;");
                //  Response.Write(pos + " " + KOD + " " + IDF + " " + " " + dat + " " + tb1.Text + "# <br />");

            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

//    protected void save_kod_null(String kod_, String idf_)
//    {
//        try
//        {
//            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
//            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
//            cinfo.DateTimeFormat.DateSeparator = "/";

//            if (tb_datf.Text.Length == 0) return;

//            DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

//            InitOraConnection();

//            {


//                ClearParameters();

//                SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
//                SetParameters("ND", DB_TYPE.Varchar2, tb_nd.Text, DIRECTION.Input);
//                SetParameters("rnk", DB_TYPE.Varchar2, tb_RNK.Text, DIRECTION.Input);
//                SetParameters("kod", DB_TYPE.Varchar2, kod_, DIRECTION.Input);
//                SetParameters("idf", DB_TYPE.Varchar2, idf_, DIRECTION.Input);
                
                
//                SQL_NONQUERY(@" begin UPDATE FIN_ND
//                                          SET S = null, fdat = :DAT
//                                            WHERE 
//	                                          ND = :ND and rnk = :RNK
//	                                          AND kod = :KOD
//	                                          AND idf = :IDF; end;");

//            }

//        }
//        finally
//        {
//            DisposeOraConnection();
//        }
//    }

    public static String read_nd( String nd_, String rnk_, String kod_, String idf_,  String FDAT_)
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

           cmd.CommandText = ("select to_char(fin_OBU.ZN_P_ND(:KOD, :IDF, :FDAT, :ND, :RNK)) as SN from dual");
               

           OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                //String SS_;
                //SS_ = rdr["SN"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SN"];
                SS_ = rdr["SN"] == DBNull.Value ? (String) null : (String)rdr["SN"];
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

    //return "123";
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

                cmd.CommandText = ("select fin_OBU.ZN_P_ND(:KOD, :IDF, :FDAT, :ND, :RNK) as SN from dual");


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

    public static String read_nd_hist(String nd_, String rnk_, String kod_, String idf_, String FDAT_)
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

                if (FDAT_ == null) return null;



                DateTime dat = Convert.ToDateTime(FDAT_, cinfo);


                //якщо перегляд то будемо шукать по історії

                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(rnk_), ParameterDirection.Input);
                cmd.Parameters.Add("ND", OracleDbType.Int64, Convert.ToInt64(nd_), ParameterDirection.Input);
                cmd.Parameters.Add("KOD", OracleDbType.Varchar2, kod_, ParameterDirection.Input);
                cmd.Parameters.Add("IDF", OracleDbType.Varchar2, idf_, ParameterDirection.Input);
                cmd.Parameters.Add("FDAT", OracleDbType.Date, dat, ParameterDirection.Input);

                cmd.CommandText = ("select fin_OBU.F_GET_FIN_ND ( :rnk ,   :nd ,  :kod ,  :IDF,  :fdat) as SN from dual");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    
                    SS_ = rdr["SN"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["SN"];
                    if (SS_ != 0)
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

        //return "123";
    }


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

                if (FDAT_ == null) return  Convert.ToDateTime(null);



                DateTime dat = Convert.ToDateTime(FDAT_, cinfo);



                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("KOD", OracleDbType.Varchar2, kod_, ParameterDirection.Input);
                cmd.Parameters.Add("IDF", OracleDbType.Varchar2, idf_, ParameterDirection.Input);
                cmd.Parameters.Add("FDAT", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("ND", OracleDbType.Int64, Convert.ToInt64(nd_), ParameterDirection.Input);
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64(rnk_), ParameterDirection.Input);

                cmd.CommandText = ("select fin_OBU.ZN_P_ND_date(:KOD, :IDF, :FDAT, :ND, :RNK) as SN from dual");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    
                    SS_ = rdr["SN"] == DBNull.Value ? (DateTime) Convert.ToDateTime(null) : (DateTime)rdr["SN"];
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

    public static String calc_nd(String kod_, String FDAT_, String okpo_, String rnk_, String nd_)
    {
        String SS_;
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



                cmd.ExecuteNonQuery();
                cmd.Parameters.Add("KOD", OracleDbType.Varchar2, kod_, ParameterDirection.Input);
                cmd.Parameters.Add("FDAT", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("OKPO", OracleDbType.Int64, Convert.ToInt64(okpo_), ParameterDirection.Input);
                cmd.Parameters.Add("RNK", OracleDbType.Int64, Convert.ToInt64( rnk_  ), ParameterDirection.Input);
                cmd.Parameters.Add("ND",  OracleDbType.Int64, Convert.ToInt64( nd_ ), ParameterDirection.Input);
                

                cmd.CommandText = ("select to_char(round(fin_OBU.CALC_POK(:KOD, :FDAT, :OKPO, :RNK, :ND),2)) as SN from dual");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    //String SS_;
                    SS_ = rdr["SN"] == DBNull.Value ? (String)"0" : (String)rdr["SN"];
                    if (SS_ != null)
                    { return Convert.ToString(SS_).Replace(",","."); }
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

        //return "123";
    }



    protected void Bt_get_Click(object sender, ImageClickEventArgs e)
    {
        //        save_infcl("000", "30", "1");   //Блокування на перегляд
        //save_kod_null("KP6", "5");

        save_infcl("VDP", "32", tb_DP.SelectedValue);
        save_infcl("VIS", "32", bt_v.SelectedValue);
        save_infcl("TIP", "32", tb_tiprnk.SelectedValue);
        save_infcl("SUN", "32", Convert.ToDecimal(tb_sumn.Value));
        save_infcl("SUM", "32", Convert.ToDecimal(tb_summ.Value));
        save_infcl("PRC", "32", Convert.ToDecimal(tb_rat.Value));
        save_infcl("ZI0", "30", Convert.ToDecimal(tb_ZI0.Value));

        save_infcl("ZB0", "32", Convert.ToDecimal(tb_ZB.Value));
        save_infcl("BZB", "32", Convert.ToDecimal(tb_BZB.Value));
        save_infcl("NKO", "32", Convert.ToDecimal(tb_NKO.Value));

        save_infcl("GRF", "32", Convert.ToString(tb_graf.SelectedValue));
        save_infcl("INV", "32", Convert.ToString(Tb_INV.SelectedValue));
        save_infcl("ETP", "32", Convert.ToString(Tb_ETAP.SelectedValue));
        save_infcl("IKY", "32", Convert.ToString(tb_IKY.SelectedValue));
        save_infcl("VAL", "30", Convert.ToString(tb_kv.SelectedValue));

        save_infcl("MZ0", "30", Convert.ToString(Tb_MZ0.SelectedValue));

        if (!String.IsNullOrEmpty(Convert.ToString(DDL_obs.SelectedValue)))
            save_infcl("OBS", "6", Convert.ToString(DDL_obs.SelectedValue));


        save_infcl("MZ1", "30", Convert.ToDecimal(Tb_MZ1.Value));

        tb_NSM.Text = calc_nd("NSM", tb_datf.Text, tb_okpo.Text, tb_RNK.Text, tb_nd.Text);

        //  хрень місце знаходження застави або... або комбіноване
        if (Tb_MZ0.SelectedValue == "8")
        { save_infcl("MZ0", "33", Convert.ToDecimal(Tb_MZ1.Value)); }
        else
        { save_infcl("MZ0", "33", Convert.ToString(Tb_MZ0.SelectedValue)); }
        


        save_infcl_date("DAP", "32", Convert.ToDateTime(tb_datp.Value));
        save_infcl_date("DAS", "32", Convert.ToDateTime(tb_sdate.Value));
        save_infcl_date("DAW", "32", Convert.ToDateTime(tb_wdate.Value));
        save_infcl_date("DST", "32", Convert.ToDateTime(tb_datst.Value));


        tb_DP.SelectedValue = read_nd(tb_nd.Text, tb_RNK.Text, "VDP", "32", tb_datf.Text);
        bt_v.SelectedValue = read_nd(tb_nd.Text, tb_RNK.Text, "VIS", "32", tb_datf.Text);
        tb_tiprnk.SelectedValue = read_nd(tb_nd.Text, tb_RNK.Text, "TIP", "32", tb_datf.Text);



        calculation_VNKR();
        GET_POK();



        tb_ZMO.Text = calc_nd("ZM0", tb_datf.Text, tb_okpo.Text, tb_RNK.Text, tb_nd.Text);
        tb_ZMO.Visible = true;
        lb_ZMO.Visible = true;


        tb_nmis.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "NKD", "30", tb_datf.Text));
        tb_nmis.Visible = true;
        lb_nmis.Visible = true;

        tb_sk.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "SK0", "30", tb_datf.Text));
        lb_sk.Visible = true;
        tb_sk.Visible = true;



        FillData();


        //Bt_get.Focus();
        if (ErrR == "1")
        { return; }
        else
        {
            Bt_print.Visible = true;
            ddl_print.Visible = true;
            Bt_print.Focus();
        }

        tb_bal.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "BAL", "35", tb_datf.Text));
        tb_klas.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "110", "6", tb_datf.Text));
        tb_obs.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "OBS", "6", tb_datf.Text));
        tb_kat.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "080", "6", tb_datf.Text));

        try
        {
            if (!String.IsNullOrEmpty(read_nd(tb_nd.Text, tb_RNK.Text, "KPB", "6", tb_datf.Text)))
                tb_kat23.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "KPB", "6", tb_datf.Text));
        }
        catch (Exception) { }
        


        tb_kv.SelectedValue  =   Convert.ToString(read_nd(tb_nd.Text, tb_RNK.Text, "VAL", "30", tb_datf.Text));
        

        pnRez.Visible = true;

 
        
  //вичитаєм внутрішній кредитний рейтинг і інтегральний показник        
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

                cmd.ExecuteNonQuery();

                cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("nd", OracleDbType.Decimal, tb_nd.Text, ParameterDirection.Input);
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, tb_RNK.Text, ParameterDirection.Input);
                
                cmd.CommandText = (@"    select    fin_obu.GET_VNKR(dat_,  rnk_, nd_) as vnkr,
                                                   fin_nbu.ZN_P('IPB', 6, dat_, c.okpo) ipb
                                           from fin_customer c, (select :dat as dat_, :nd as nd_, :rnk as rnk_ from dual) d, cc_deal cd
                                          where c.rnk(+) = d.rnk_ and d.nd_ = cd.nd (+)");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                  tb_vnkr.Value = rdr["VNKR"] == DBNull.Value ? (String)null : (String)rdr["VNKR"];
                  tb_ip.Value   = rdr["IPB"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["IPB"];

                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            lb_zbv_z.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "ZVB", "32", tb_datf.Text));
            lb_zcd_z.Value = Convert.ToDecimal(read_nd_n(tb_nd.Text, tb_RNK.Text, "ZCD", "32", tb_datf.Text));

            if (lb_zbv_z.Value >  Convert.ToDecimal(0.8) && lb_zcd_z.Value < Convert.ToDecimal(1.2))
            { 
              lb_zbv_k.Text = "заборгованість (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника перед Банком за основною сумою має значну питому вагу у валюті балансу без врахування такої заборгованості перед Банком";
              lb_zcd_k.Text = "сума заборгованості (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника за основною сумою боргу перед Банком майже не покривається чистим доходом (виручкою) від реалізації продукції (товарів, робіт, послуг) протягом планового (договірного) терміну кредитування (термінів обігу облігацій, дії договорів гарантії, авалів)";
            }
            else if (lb_zbv_z.Value > Convert.ToDecimal(1.0) && lb_zcd_z.Value < Convert.ToDecimal(1.0))
            {
                lb_zbv_k.Text = "заборгованість (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника перед Банком за основною сумою значно перевищує валюту балансу без врахування такої заборгованості перед Банком";
                lb_zcd_k.Text = "сума заборгованості (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника за основною сумою боргу перед Банком не покривається чистим доходом (виручкою) від реалізації продукції (товарів, робіт, послуг) протягом планового (договірного) терміну кредитування (термінів обігу облігацій, дії договорів гарантії, авалів)";
            }
            else { 
                lb_zbv_k.Text = "";
                lb_zcd_k.Text = "";
            }
 
        }
    // End --вичитаєм внутрішній кредитний рейтинг і інтегральний показник  

        //FillDataPok();
        Bt_Pok.Visible = true;

    }

    protected void ValueChanged_Tb_MZ0(object sender, EventArgs e)
    {

        //result = i != 0 ? 100 / i : 0;

        Tb_MZ1.Visible = (Tb_MZ0.SelectedValue == "8" ? true : false);
        Lb_MZ1.Visible = (Tb_MZ0.SelectedValue == "8" ? true : false);
        Bt_zast.Focus();

        //if (Tb_MZ0.SelectedValue == "8")
        //{
        //    Tb_MZ1.Visible = true;
        //    Lb_MZ1.Visible = true;
        //    Bt_zast.Focus();
        //    //Tb_MZ1.Focus();
            
        //}
        //else 
        //{
        //    Tb_MZ1.Visible = false;
        //    Lb_MZ1.Visible = false;
        //    Bt_zast.Focus();
        //    //Tb_MZ0.Focus();
            
        //}


    }
    
    protected void Bt_zast_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/barsweb/dynform.aspx?form=frm_fin2_OBU_PAWN&RNK_=" +  tb_RNK.Text + "&ND_=" + tb_nd.Text + "', 'aaaa', 'width=1050, height=500, resizable=yes,scrollbars=yes,status=yes" + "')", true);
    }

    protected void Bt_print_Click(object sender, ImageClickEventArgs e)
    {
        String TemplateId = "fin_obu_CGD_Pot.frx";
        String DOCEXP_TYPE_ID;

        if (bt_v.SelectedValue == "1")
        {TemplateId = "fin_obu_CGD_Pot.frx";}
        else if (bt_v.SelectedValue == "2")
        {TemplateId = "fin_obu_CGD_Pop.frx";}
        else
        { TemplateId = "fin_obu_CGD_Pot.frx"; }



        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("fdat", TypeCode.String, tb_datf.Text));
        pars.Add(new FrxParameter("rnk", TypeCode.String, Convert.ToString(tb_RNK.Text)));
        pars.Add(new FrxParameter("ND", TypeCode.String, Convert.ToString(tb_nd.Text)));


        //Response.Write(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId);
        //Response.Write(tb_datp.Value);
        //Response.Write(tb_RNK.Text);
        //Response.Write(tb_nd.Text);

        FrxDoc doc = new FrxDoc(
            //      FrxDoc.GetTemplatePathByFileName(TemplateId),
            FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId,
                  pars,
                this.Page);

       // doc.Print(FrxExportTypes.Pdf);

        DOCEXP_TYPE_ID = ddl_print.SelectedValue;

        switch (DOCEXP_TYPE_ID)
        {
            case "PDF": doc.Print(FrxExportTypes.Pdf);
                break;
            case "RTF": doc.Print(FrxExportTypes.Rtf);
                break;
            case "XLS": doc.Print(FrxExportTypes.Excel2007);
                break;
            default: doc.Print(FrxExportTypes.Pdf);
                break;
        }
    }

    protected void Bt_Pok_Click(object sender, ImageClickEventArgs e)
    {
        Bt_Pok.Focus();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_pvnkr&RNK_=" + tb_RNK.Text + "&ND_=" + tb_nd.Text + "&dat_=" + tb_datf.Text + "', 'aaaa', 'width=1050, height=770, center=yes, resizable=no,scrollbars=yes,status=yes" + "')", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.showModalDialog('/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_pvnkr&RNK_=" + tb_RNK.Text + "&ND_=" + tb_nd.Text + "&dat_=" + tb_datf.Text + "', 'aaaa', 'dialogwidth=1050Px; dialogheight=770Px;  resizable=no;scrollbars=yes;status=yes;" + "')", true);
        //Bt_Pok.Focus();

    }

    protected void review_forms()
    {

       
        ShowError(" Форма використовується в режимі перегляду !!!!! ");
        Bt_get.Visible = false;
        Bt_print.Visible = true;
        ddl_print.Visible = true;
        pnRez.Visible = true;

        tb_ZMO.Text = calc_nd("ZM0", tb_datf.Text, tb_okpo.Text, tb_RNK.Text, tb_nd.Text);
        tb_ZMO.Visible = true;
        lb_ZMO.Visible = true;


        tb_nmis.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "NKD", "30", tb_datf.Text));
        tb_nmis.Visible = true;
        lb_nmis.Visible = true;

        tb_sk.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "SK0", "30", tb_datf.Text));
        lb_sk.Visible = true;
        tb_sk.Visible = true;

        tb_DP.SelectedValue = read_nd_hist(tb_nd.Text, tb_RNK.Text, "VDP", "32", tb_datf.Text);
        bt_v.SelectedValue = read_nd_hist(tb_nd.Text, tb_RNK.Text, "VIS", "32", tb_datf.Text);
        tb_tiprnk.SelectedValue = read_nd_hist(tb_nd.Text, tb_RNK.Text, "TIP", "32", tb_datf.Text);


        tb_kv.SelectedValue = Convert.ToString(read_nd_hist(tb_nd.Text, tb_RNK.Text, "VAL", "30", tb_datf.Text));
        tb_kv.Enabled = true;

        tb_sumn.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "SUN", "32", tb_datf.Text));
        tb_summ.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "SUM", "32", tb_datf.Text));
        tb_rat.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "PRC", "32", tb_datf.Text));
        tb_datp.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DAP", "32", tb_datf.Text));
        tb_sdate.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DAS", "32", tb_datf.Text));
        tb_wdate.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DAW", "32", tb_datf.Text));
        tb_datst.Value = Convert.ToDateTime(read_nd_date(tb_nd.Text, tb_RNK.Text, "DST", "32", tb_datf.Text));
        tb_kv.SelectedValue = Convert.ToString(read_nd_hist(tb_nd.Text, tb_RNK.Text, "VAL", "30", tb_datf.Text));
        DDL_obs.Enabled = true;
        DDL_obs.SelectedValue = Convert.ToString(read_nd_hist(tb_nd.Text, tb_RNK.Text, "OBS", "6", tb_datf.Text));

        Tb_MZ0.SelectedValue = Convert.ToString(read_nd_hist(tb_nd.Text, tb_RNK.Text, "MZ0", "30", tb_datf.Text));
        Tb_MZ1.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "MZ1", "30", tb_datf.Text));


        Tb_MZ0.Enabled = false;
        Tb_MZ1.Enabled = false;
        tb_ZB.Enabled = false;
        tb_BZB.Enabled = false;
        tb_kv.Enabled = false;
        DDL_obs.Enabled = false;
        tb_NKO.Enabled = false;
        tb_DP.Enabled = false;
        tb_tiprnk.Enabled = false;
        tb_datst.Enabled = false;
        tb_ZI0.Enabled = false;
        

    }


    protected void review_forms2()
    {


        pnRez.Visible = true;



        //вичитаєм внутрішній кредитний рейтинг і інтегральний показник        
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
            try
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";

                DateTime dat = Convert.ToDateTime(tb_datf.Text, cinfo);

                cmd.ExecuteNonQuery();

                cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
                cmd.Parameters.Add("nd", OracleDbType.Decimal, tb_nd.Text, ParameterDirection.Input);
                cmd.Parameters.Add("rnk", OracleDbType.Decimal, tb_RNK.Text, ParameterDirection.Input);

                cmd.CommandText = (@"    select    fin_obu.GET_VNKR(dat_,  rnk_, nd_) as vnkr,
                                                   fin_nbu.ZN_P ('IPB',  6,  DAT_, c.OKPO) ipb 
                                           from fin_customer c, (select :dat as dat_, :nd as nd_, :rnk as rnk_ from dual) d, cc_deal cd
                                          where c.rnk(+) = d.rnk_ and d.nd_ = cd.nd (+)");

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    tb_vnkr.Value = rdr["VNKR"] == DBNull.Value ? (String)null : (String)rdr["VNKR"];
                    tb_ip.Value = rdr["IPB"] == DBNull.Value ? (Decimal)0 : (Decimal)rdr["IPB"];

                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            lb_zbv_z.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "ZVB", "32", tb_datf.Text));
            lb_zcd_z.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "ZCD", "32", tb_datf.Text));
            

            if (lb_zbv_z.Value > Convert.ToDecimal(0.8) && lb_zcd_z.Value < Convert.ToDecimal(1.2))
            {
                lb_zbv_k.Text = "заборгованість (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника перед Банком за основною сумою має значну питому вагу у валюті балансу без врахування такої заборгованості перед Банком";
                lb_zcd_k.Text = "сума заборгованості (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника за основною сумою боргу перед Банком майже не покривається чистим доходом (виручкою) від реалізації продукції (товарів, робіт, послуг) протягом планового (договірного) терміну кредитування (термінів обігу облігацій, дії договорів гарантії, авалів)";
            }
            else if (lb_zbv_z.Value > Convert.ToDecimal(1.0) && lb_zcd_z.Value < Convert.ToDecimal(1.0))
            {
                lb_zbv_k.Text = "заборгованість (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника перед Банком за основною сумою значно перевищує валюту балансу без врахування такої заборгованості перед Банком";
                lb_zcd_k.Text = "сума заборгованості (включаючи надані зобов'язання з кредитування, гарантії, авалі) позичальника за основною сумою боргу перед Банком не покривається чистим доходом (виручкою) від реалізації продукції (товарів, робіт, послуг) протягом планового (договірного) терміну кредитування (термінів обігу облігацій, дії договорів гарантії, авалів)";
            }
            else
            {
                lb_zbv_k.Text = "";
                lb_zcd_k.Text = "";
            }

        }

        tb_bal.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "BAL", "35", tb_datf.Text));
        tb_klas.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "110", "6", tb_datf.Text));
        tb_obs.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "OBS", "6", tb_datf.Text));
        tb_kat.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "080", "6", tb_datf.Text));
        tb_kat23.Value = Convert.ToDecimal(read_nd_hist(tb_nd.Text, tb_RNK.Text, "KPB", "6", tb_datf.Text));
        Bt_Pok.Visible = true;
        tb_ZMO.Text = (read_nd_hist(tb_nd.Text, tb_RNK.Text, "ZM0", "30", tb_datf.Text));
            //calc_nd("ZM0", tb_datf.Text, tb_okpo.Text, tb_RNK.Text, tb_nd.Text);
        tb_ZMO.Visible = true;
        lb_ZMO.Visible = true;
    }


    protected void Changed_Tb_INV(object sender, EventArgs e)
    {
        if (Tb_INV.SelectedValue == "2")
        {
            Lb_ETAP.Visible = true;
            Tb_ETAP.Visible = true;
            lb_IKY.Visible = true;
            tb_IKY.Visible = true;
        }
        else
        {
            Lb_ETAP.Visible = false;
            Tb_ETAP.Visible = false;
            lb_IKY.Visible = false;
            tb_IKY.Visible = false;
        }
  }

    protected void forms_Click(object sender, EventArgs e)
    {
        String TemplateId = "Fin_nbu_CGD23_forms.frx";
              
        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("datf", TypeCode.String, tb_datf.Text));
        pars.Add(new FrxParameter("rnk1", TypeCode.String, Convert.ToInt64(tb_RNK.Text)));
        pars.Add(new FrxParameter("nd", TypeCode.String, Convert.ToInt64(tb_nd.Text)));
 

        FrxDoc doc = new FrxDoc(
              FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId,
                  pars,
                this.Page);

         doc.Print(FrxExportTypes.Excel2007);

        
    }
    protected void agr_bal_Click(object sender, EventArgs e)
    {
        String TemplateId = "Fin_nbu_CGD23_agr_bal.frx";

        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("fdat", TypeCode.String, tb_datf.Text));
        pars.Add(new FrxParameter("rnk", TypeCode.String, Convert.ToString(tb_RNK.Text)));
        pars.Add(new FrxParameter("ND", TypeCode.String, Convert.ToString(tb_nd.Text)));

        FrxDoc doc = new FrxDoc(
              FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId,
                  pars,
                this.Page);

        doc.Print(FrxExportTypes.Excel2007);


    }
}
