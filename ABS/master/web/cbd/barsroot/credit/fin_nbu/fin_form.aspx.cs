using System;
using System.Collections.Generic;
using Bars.Classes;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
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
using System.Web.UI.WebControls.WebParts;

public partial class credit_fin_form : Bars.BarsPage
{
    //protected void Page_Load1(object sender, EventArgs e)
    //{
    //    if (!IsPostBack)
    //    {
    //         сохраняем страничку с которой перешли
    //        ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
    //    }
    //}

    String par_read;
    String par_kved;

    protected OracleConnection con;

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

            SetParameters("OKPO1", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
            SetParameters("frm", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            SetParameters("frm", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            SetParameters("OKPO1", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("OKPO1", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("frm", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            SetParameters("OKPO1", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
            SetParameters("frm", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            SetParameters("frm", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            SetParameters("OKPO1", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("OKPO1", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
            SetParameters("frm", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            gvMain.DataSource = SQL_SELECT_dataset(@"select idf, fm, fdat, ord, pob, name, kod, s, okpo
                                                from (SELECT  f.IDF, ' ' FM,
                                                       FIN_RNK.FDAT,
                                                       NVL (f.ord, 0) AS ord,
                                                       f.pob,
                                                       '(' || f.kod || ')  ' || f.name name,
                                                       f.kod,
                                                       nvl(FIN_RNK.s,0) S,
                                                       TO_NUMBER (:OKPO1) AS okpo
                                                  FROM FIN_RNK,
                                                           (SELECT 1 AS idf,
                                                                   name,
                                                                   ord,
                                                                   kod,
                                                                   pob, fm
                                                              FROM fin_forma1
                                                                UNION ALL
                                                                SELECT 2 AS idf,
                                                                       name,
                                                                       ord,
                                                                       kod,
                                                                       pob, fm
                                                                  FROM fin_forma2) f
                                                         WHERE     FIN_RNK.IDF = :frm
                                                               AND f.IDF = :frm
                                                               AND f.kod = FIN_RNK.kod
                                                               AND FIN_RNK.OKPO = :OKPO1
                                                               AND SUBSTR (fin_nbu.F_FM (FIN_RNK.OKPO, FIN_RNK.FDAT), 1, 1) = f.fm
                                                               AND DECODE (:dat, NULL, NULL, fdat) = DECODE (:dat, NULL, NULL, :dat)
                                                        UNION ALL
                                                        SELECT f.IDF,' ',
                                                               TO_DATE (NULL),
                                                               NVL (ord, 0),
                                                               pob,
                                                               name,
                                                               kod,
                                                               0 S,
                                                               TO_NUMBER (NULL)
                                                          FROM (SELECT 1 AS idf,
                                                                       name,
                                                                       ord,
                                                                       kod,
                                                                       pob, fm
                                                                  FROM fin_forma1
                                                                UNION ALL
                                                                SELECT 2 AS idf,
                                                                       name,
                                                                       ord,
                                                                       kod,
                                                                       pob, fm
                                                                  FROM fin_forma2) f
                                                         WHERE kod IS NULL
                                                               AND EXISTS
                                                                      (SELECT 1
                                                                         FROM fin_fm
                                                                        WHERE okpo = :OKPO1 AND SUBSTR (fin_nbu.F_FM (OKPO, FDAT), 1, 1) = f.fm
                                                                              AND DECODE (:dat, NULL, NULL, fdat) =
                                                                                     DECODE (:dat, NULL, NULL, :dat))
                                                               AND f.IDF = :frm
                                                        UNION ALL                                               
                                                        SELECT f.IDF,'M',
                                                               FIN_RNK.FDAT,
                                                               NVL (f.ord, 0),
                                                               f.pob,
                                                               '(' || f.kod || ')  ' || f.name name,
                                                               f.kod,
                                                               nvl(FIN_RNK.s,0) S,
                                                               TO_NUMBER (:OKPO1)
                                                          FROM FIN_RNK,
                                                               (SELECT 1 AS idf,
                                                                       name,
                                                                       ord,
                                                                       kod,
                                                                       pob,fm
                                                                  FROM fin_forma1m
                                                                UNION ALL
                                                                SELECT 2 AS idf,
                                                                       name,
                                                                       ord,
                                                                       kod,
                                                                       pob, fm
                                                                  FROM fin_forma2m) f
                                                         WHERE     FIN_RNK.IDF = :frm
                                                               AND f.kod = FIN_RNK.kod
                                                               AND f.IDF = :frm
                                                               AND FIN_RNK.OKPO = :OKPO1
                                                               AND SUBSTR (fin_nbu.F_FM (FIN_RNK.OKPO, FIN_RNK.FDAT), 1, 1) = f.fm
                                                               AND DECODE (:dat, NULL, NULL, fdat) = DECODE (:dat, NULL, NULL, :dat)
                                                        UNION ALL
                                                        SELECT f.IDF,'M',
                                                               TO_DATE (NULL),
                                                               NVL (ord, 0),
                                                               pob,
                                                               name,
                                                               kod,
                                                               0 S,
                                                               TO_NUMBER (NULL)
                                                          FROM (SELECT 1 AS idf,
                                                                       name,
                                                                       ord,
                                                                       kod,
                                                                       pob, fm
                                                                  FROM fin_forma1m
                                                                UNION ALL
                                                                SELECT 2 AS idf,
                                                                       name,
                                                                       ord,
                                                                       kod,
                                                                       pob, fm
                                                                  FROM fin_forma2m) f
                                                         WHERE kod IS NULL
                                                               AND EXISTS
                                                                      (SELECT 1
                                                                         FROM fin_fm
                                                                        WHERE okpo = :OKPO1 
                                                                              AND SUBSTR (fin_nbu.F_FM (OKPO, FDAT), 1, 1) = f.fm
                                                                              AND DECODE (:dat, NULL, NULL, fdat) =
                                                                                     DECODE (:dat, NULL, NULL, :dat))
                                                               AND f.IDF = :frm
                                                        ORDER BY 2, 4, 3)");


            gvMain.DataBind();

        }
        finally
        {
            DisposeOraConnection();
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // сохраняем страничку с которой перешли
            ViewState.Add("PREV_URL", Request.UrlReferrer.PathAndQuery);
        }
        dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        if (Request["okpo"] != null)
        {
            tbOKPO.Text = Convert.ToString(Request["okpo"]);
        }
        if (!String.IsNullOrEmpty(Request["rnk"])) tbOKPO.ToolTip = Convert.ToString(Request["rnk"]);
        else tbOKPO.ToolTip = "null";


        if (Request["frm"] != null)
        {
            tbFrm.Value = Convert.ToDecimal(Request["frm"]);
            if (Request["frm"] == "2" || Convert.ToInt64(Request["rnk"]) <= 0) 
            {
                tb_kol.Visible = false;
                lb_kol.Visible = false;
                ReqFVal1.Visible = false;
                ReqEVal1.Visible = false;
            }

            if (Request["frm"] == "2" )
            {
                tb_kved.Visible = false;
                lb_kved.Visible = false;
                Reqtb_kved.Visible = false;
                btKVED.Visible = false;
                Lb_n_ved.Visible = false;
            }
        }
        if (Request["dat"] != null)
        {
            //CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            //cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            //cinfo.DateTimeFormat.DateSeparator = "/";
            if (!IsPostBack)
            tbFDat.Text = Convert.ToString(Request["dat"]);
            //tbFDat.Text = Convert.ToString(Convert.ToDateTime(Request["dat"], cinfo));
        }
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                SetParameters("OKPO", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                tbFDat.DataSource = SQL_SELECT_dataset("select to_char(fdat,'dd/MM/yyyy') fdat, fdat qqq from fin_fm where okpo = :OKPO order by qqq desc").Tables[0];
                tbFDat.DataTextField = "fdat";
                tbFDat.DataValueField = "fdat";
                //Биндим
                tbFDat.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
            Get_read();   //блокування введення даних якщо форма завведенна правильно і недаємо зберігати
            FillData();
        }

        // Блокування введення КВЕД якщо звітність 
        if (!IsPostBack)
            if (Convert.ToString(Request["dat"]).Substring(0, 5) == "01/011")
            {
                tb_kved.Enabled = true;
                btKVED.Enabled = true;
            }
            else
            {
                tb_kved.Enabled = false;
                btKVED.Enabled = false;
            }

    }

    protected void btRefresh_Click(object sender, ImageClickEventArgs e)
    {
        FillData();
        Get_read();
    }


    protected void backToFolders(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
    }

    protected void btOk_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
            
            InitOraConnection();
            int pos =0;
            foreach (GridViewRow row in gvMain.Rows)
            {
                //if (row.Cells[4].Controls[1] is TextBoxDecimal)
                if (row.Cells[4].Controls[1] is NumericEdit)
                {
                    //TextBoxDecimal tb = ((TextBoxDecimal)row.Cells[4].Controls[1]);
                    NumericEdit tb = ((NumericEdit)row.Cells[4].Controls[1]);
                    //if (tb.Value > 0)
                    {
                        string OKPO = Convert.ToString(gvMain.DataKeys[pos].Values[0]);
                        string KOD = Convert.ToString(gvMain.DataKeys[pos].Values[1]);
                        string IDF = Convert.ToString(gvMain.DataKeys[pos].Values[2]);
                        //string dat = Convert.ToString(gvMain.DataKeys[pos].Values[4]);

                        //DateTime dat1 = Convert.ToDateTime(gvMain.DataKeys[pos].Values[4], cinfo);
                        
                        ClearParameters();
                        SetParameters("S", DB_TYPE.Decimal, tb.Value, DIRECTION.Input);
                        SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                        //SetParameters("dat", DB_TYPE.Varchar2, dat, DIRECTION.Input);
                        SetParameters("kod", DB_TYPE.Varchar2, KOD, DIRECTION.Input);
                        SetParameters("OKPO", DB_TYPE.Varchar2, OKPO, DIRECTION.Input);
                        SetParameters("idf", DB_TYPE.Varchar2, IDF, DIRECTION.Input);

                        SQL_NONQUERY(" begin UPDATE FIN_RNK set S=:s where FDAT=:dat and kod=:kod and OKPO=:OKPO and idf=:idf;  end;");
                    }
                }
                pos++;
            }
            save_sec();
            lock_form();
            FillData();
        }
        finally
        {
            DisposeOraConnection();
        }
    }


    protected void lock_form()
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
            string IDF = Convert.ToString(tbFrm.Value);
            // установка роли
            cmd.ExecuteNonQuery();

           
          
            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("OKPO", OracleDbType.Decimal, OKPO, ParameterDirection.Input);
            cmd.Parameters.Add("idf", OracleDbType.Varchar2, IDF, ParameterDirection.Input);
            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("OKPO", OracleDbType.Varchar2, tbOKPO.Text, ParameterDirection.Input);
            cmd.Parameters.Add("idf", OracleDbType.Varchar2, IDF, ParameterDirection.Input);
            cmd.CommandText = "select fin_nbu.logk(trunc(:dat), :OKPO, :idf) as sos, to_char(:dat,'dd/mm/yyyy') as dat, :OKPO as okpo, : idf as idf  from dual";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                Decimal SOS = Convert.ToDecimal(rdr["SOS"]);
                if (SOS != 0 )
                {

                    ShowError("Увага в формі №" + rdr["idf"] + "( окпо - " + rdr["OKPO"] + ")" + " за дату " + rdr["dat"] + " є помилки!!!");
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('" + (String)ViewState["PREV_URL"] + "', 'aaaa', 'width=850, height=600, resizable=yes,scrollbars=yes,status=yes" + "')", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_k&OKPO=" + rdr["OKPO"] + "&nForm=" + rdr["idf"] + "&DAT=" + rdr["dat"] + "', 'aaaa', 'width=1050, height=400, resizable=yes,scrollbars=yes,status=yes" + "')", true);
                    
                    
                }
                else if (par_kved == "0")
                { ShowError("КВЕД заповнений з помилками " + ".  є помилки!!!"); }
                else
                {

                    ShowError("Форма №" + rdr["idf"] + "( окп - " + rdr["OKPO"] + ")" + " за дату " + rdr["dat"] + ". Збережено успішно!!!");


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


    protected void gvMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            decimal s = Convert.ToDecimal(((DataRowView)e.Row.DataItem).Row["S"]);
            string kod = Convert.ToString(((DataRowView)e.Row.DataItem).Row["KOD"]);
            string pob = Convert.ToString(((DataRowView)e.Row.DataItem).Row["POB"]);
         
            if ( kod == "")
            {
                e.Row.BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[0].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[1].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[2].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[3].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[4].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[5].Style.Add("border-bottom", "1px dotted black");
                e.Row.Font.Bold = true;
            }
            if (pob == "1")
            {
               // e.Row.BackColor = System.Drawing.Color.Pink;
                e.Row.Cells[2].Font.Bold = true;
                e.Row.Cells[3].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }

            //if (pob == "2")
            //{
            //    e.Row.Cells[3].BackColor = System.Drawing.Color.SeaShell;
            //    e.Row.Cells[2].Font.Italic = true;
            //    e.Row.Cells[3].Font.Italic = true;
            //    e.Row.Cells[5].Font.Italic = true;
            //}
        }
    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    //------ Зберегти показники коофіциента покриття боргу----
    protected void save_sec()
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


                SetParameters("OKPO", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                SetParameters("dat", DB_TYPE.Date, dat, DIRECTION.Input);
                SetParameters("p_ved", DB_TYPE.Varchar2,  tb_kved.Text, DIRECTION.Input);
                SetParameters("OKPO1", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, dat, DIRECTION.Input);
                //SetParameters("dat2", DB_TYPE.Date, dat, DIRECTION.Input);
                //SetParameters("OKPO2", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                SetParameters("p_Rnk", DB_TYPE.Int64, Convert.ToDecimal(Request["rnk"]), DIRECTION.Input);
                SetParameters("p_kol", DB_TYPE.Varchar2, tb_kol.Text, DIRECTION.Input);


                if (tbFrm.Value == 1)
                {
                    SQL_NONQUERY("   begin  " +
                                 "   update fin_fm set date_f1 = sysdate where okpo = :okpo and fdat = :dat;" +
                                 "   update fin_fm set ved = :p_ved      where okpo = :okpo1 and fdat = :dat1 and 1=0;" +
                                 //"   Fin_rnk_check(:dat2, 1, to_number(:okpo2)); " +
                                 "   for k in (select rnk from customer where rnk = :p_pnk) loop" +
                                 "   kl.setCustomerElement(k.rnk, 'FSKPR', :p_kol, 0);  end loop;" +
                                 "   end;");
                }
                else if (tbFrm.Value == 2)
                {
                    SQL_NONQUERY("   begin  " +
                                 "   update fin_fm set date_f2 = sysdate where okpo = :okpo and fdat = :dat;" +
                                 "   update fin_fm set ved = :p_ved      where okpo = :okpo1 and fdat = :dat1 and 1=0;" +
                                 //"   Fin_rnk_check(:dat2, 2, to_number(:okpo2)); " +
                                 "   for k in (select rnk from customer where rnk = :p_pnk and 1=0) loop" +
                                 "   kl.setCustomerElement(k.rnk, 'FSKPR', :p_kol, 0);  end loop;" +
                                 "   end;");
                }
            
            }

         
        }
        finally
        {
            DisposeOraConnection();
        }
        Get_read();
    }

    // блокування введення даних якщо форма завведенна правильно і недаємо зберігати
    private void Get_read()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {


            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
//            String par_read;

            cmd.ExecuteNonQuery();

            cmd.Parameters.Add("dat",   OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("okpo",  OracleDbType.Varchar2, tbOKPO.Text, ParameterDirection.Input);
            cmd.Parameters.Add("frm",   OracleDbType.Varchar2, tbFrm.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToDecimal(Request["rnk"]), ParameterDirection.Input);
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, Convert.ToDecimal(Request["rnk"]), ParameterDirection.Input);
            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.CommandText = "select  "
              + "  fin_nbu.LOGK_read ( :dat , :OKPO , :frm, 1 ) as par_read, "
              + "  F_GET_CUSTW_H(:P_RNK, 'FSKPR', sysdate) as p_kol,"
              + "  fin_nbu.GET_KVED(:P_RNK,:dat ) as kved"
              + "  from dual";

            OracleDataReader rdr = cmd.ExecuteReader();
            if (!rdr.Read()) throw new Exception("Свое МФО не найдено или не определено.");

            par_read = Convert.ToString(rdr.GetValue(0));

            // t_read.Text = par_read;
            // блокумвання кнопки зберегти коли форма заповнена без помилок
            //if (par_read == "0") btOk.Enabled = false;
            //return 0;           -- повністю заповненна форма та пройде
            //return 1;           -- створена форма , клієгт ненадав дан або не заповнена
            //return 2;           -- створена форма , набрана з помилками

//            Response.Write(par_read);

            // Не виводить на екран кількість працівників коли форма не заповнялась.
            if (par_read != "1") { tb_kol.Text = Convert.ToString(rdr.GetValue(1));}
            else { tb_kol.Text = null;  tb_kol.Enabled = true; }
            
            if (par_read == "1" && tbFDat.Text.Substring(3, 2) == "01")
            { 
                //tb_kved.Text=null;
                tb_kved.Text = Convert.ToString(rdr.GetValue(2)); 
                // тимчасово жавжди показуєм (немає заявки)
            }
            else 
            { 
                tb_kved.Text = Convert.ToString(rdr.GetValue(2)); 
            }

           // if (par_read == "0")  tb_kol.Enabled = false;
            



            
                

            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        Tb_kved();
    }

    protected void BtPrint_Click(object sender, ImageClickEventArgs e)
    {
        String TemplateId = "Fin_nbu_forms.frx";

        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("datf", TypeCode.String, tbFDat.SelectedValue));
        pars.Add(new FrxParameter("okpo", TypeCode.String, Convert.ToInt64( tbOKPO.Text)));
        pars.Add(new FrxParameter("frm", TypeCode.String, Convert.ToInt64(  tbFrm.Value )));


        FrxDoc doc = new FrxDoc(
              FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId,
                  pars,
                this.Page);

        doc.Print(FrxExportTypes.Excel2007);
    }
    protected void ChangetTb_kved(object sender, EventArgs e)
    {
        Tb_kved();
    }


    protected void Tb_kved()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            cmd.ExecuteNonQuery();
            cmd.Parameters.Add("p_kved", OracleDbType.Varchar2, tb_kved.Text, ParameterDirection.Input);
            cmd.CommandText = "select  "
              + "  name from ved"
              + "  where ved = :p_kved";

            OracleDataReader rdr = cmd.ExecuteReader();

            if (!rdr.Read())
            {
                if (!String.IsNullOrEmpty(tb_kved.Text))
                {
                    Lb_n_ved.Text = "Вид економічної діяльності не знайдено в довіднику.";
                    Lb_n_ved.ForeColor = System.Drawing.Color.Red;
                    par_kved = "0";
                }
                else
                {
                    Lb_n_ved.Text = "";
                    Lb_n_ved.ForeColor = System.Drawing.Color.Black;
                    par_kved = "0";
                }
            }
            else
            {
                Lb_n_ved.Text = Convert.ToString(rdr.GetValue(0));
                Lb_n_ved.ForeColor = System.Drawing.Color.Black;
                par_kved = "1";
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
}
