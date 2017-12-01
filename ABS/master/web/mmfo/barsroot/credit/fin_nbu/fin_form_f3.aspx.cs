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

public partial class credit_fin_form_f3 : Bars.BarsPage
{
   
    String par_read;
    String par_kved;


    protected OracleConnection con;

    /// <summary>
    /// Вичітка гріда&
    /// </summary>
    private void FillData()
    {
        try
        {
            InitOraConnection();
             
            //Обязательно биндим

            //ОКПО клиента
            tbOKPO.DataBind();

            // Переводим в формат дати
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

            if (tbFDat.Text.Length == 0) return;

            DateTime dat = Convert.ToDateTime(tbFDat.Text, cinfo);
            

            // Дата(присваиваем сегодняшнюю дату)
            //tbFDat.Value= DateTime.Now;

            ClearParameters();

            SetParameters("p_OKPO", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
            SetParameters("p_dat", DB_TYPE.Date, dat, DIRECTION.Input);
            //SetParameters("p_idf", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            SetParameters("p_idf", DB_TYPE.Varchar2, tbFrm.Value, DIRECTION.Input);
            if (tbFrm.Value == "3")
            {
            gvMain.DataSource = SQL_SELECT_dataset(@"select okpo, fdat, id, kod, name, colum3, colum4, type_row,  ord  
                                                       from table(fin_formaf3.f_forms(P_OKPO =>  :p_okpo,
                                                                                      P_FDAT =>  :p_dat,
                                                                                      P_IDF  =>  :p_idf   ))
                                                      order by ord");


            gvMain.DataBind();
            }
            else if (tbFrm.Value == "4")
            {
                gvMain4.DataSource = SQL_SELECT_dataset(@"select okpo, fdat, id, kod, name, colum3, colum4, col3,col4, type_row,  ord  
                                                       from table(fin_formaf3.f_forms(P_OKPO =>  :p_okpo,
                                                                                      P_FDAT =>  :p_dat,
                                                                                      P_IDF  =>  :p_idf   ))
                                                      order by ord");


                gvMain4.DataBind();
            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// Загрузка сторінки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
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


        if (Request["dat"] != null)
        {
            //CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            //cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            //cinfo.DateTimeFormat.DateSeparator = "/";
            if (!IsPostBack)
            tbFDat.Text = "01/01/"+Convert.ToString(Request["dat"]).Substring(6,4);
            //tbFDat.Text = Convert.ToString(Convert.ToDateTime(Request["dat"], cinfo));
        }
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();
                SetParameters("OKPO", DB_TYPE.Varchar2, tbOKPO.Text, DIRECTION.Input);
                tbFDat.DataSource = SQL_SELECT_dataset("select to_char(fdat,'dd/MM/yyyy') fdat, fdat qqq from fin_fm where okpo = :OKPO and fdat = trunc(fdat,'yyyy') order by qqq desc").Tables[0];
                tbFDat.DataTextField = "fdat";
                tbFDat.DataValueField = "fdat";
                //Биндим
                tbFDat.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
           
        }


        if (Request["frm"] != null)
        {
            tbFrm.Value = Convert.ToString(Request["frm"]);
            if (Request["frm"] == "3")
            {
                if (!IsPostBack) FillData();
                lbTitle.Text = "Рухгрошовиїх коштів за прямим методом";
            }

            if (Request["frm"] == "4")
            {
                if (!IsPostBack) FillData();
                lbTitle.Text = "Рухгрошовиїх коштів за не прямим методом";
            }
        }
        // Get_read();   //блокування введення даних якщо форма завведенна правильно і недаємо зберігати

  
    }


    /// <summary>
    /// Кнопка рефреш Перечитуємо дані гріда відповідно вказаної дати користувачем
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btRefresh_Click(object sender, ImageClickEventArgs e)
    {
        FillData();
        Get_read();
    }


    protected void backToFolders(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(Request["rnk"]).Length == 13)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kontr&rnk=" + Convert.ToString(Request["rnkk"]) + "')", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl&rnk=" + Convert.ToString(Request["rnk"]) + "')", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "location.replace('" + (String)ViewState["PREV_URL"] + "')", true);
        }
    }


    /// <summary>
    /// Кнопка зберегти. Зберігаємо дані гріда
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
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

            if (tbFrm.Value == "3")
            {
                int pos = 0;
                foreach (GridViewRow row in gvMain.Rows)
                {
                    //if (row.Cells[4].Controls[1] is TextBoxDecimal)
                    if (row.Cells[4].Controls[1] is NumericEdit)
                    {
                        //TextBoxDecimal tb = ((TextBoxDecimal)row.Cells[4].Controls[1]);
                        NumericEdit colum = ((NumericEdit)row.Cells[4].Controls[1]);
                        //if (tb.Value > 0)
                        {
                            string OKPO = Convert.ToString(gvMain.DataKeys[pos].Values[0]);
                            string KOD = Convert.ToString(gvMain.DataKeys[pos].Values[1]);
                            string ID = Convert.ToString(gvMain.DataKeys[pos].Values[2]);

                            //Response.Write("_"+KOD + "="+ Convert.ToString(colum3.Value) +",");                        

                            ClearParameters();


                            SetParameters("p_OKPO", DB_TYPE.Varchar2, OKPO, DIRECTION.Input);
                            SetParameters("pfdat", DB_TYPE.Date, dat, DIRECTION.Input);
                            SetParameters("p_id", DB_TYPE.Varchar2, ID, DIRECTION.Input);
                            SetParameters("p_colum3", DB_TYPE.Varchar2, Convert.ToString(colum.Value), DIRECTION.Input);

                            SQL_NONQUERY(@"begin
                                         fin_formaf3.data_entry_s(P_OKPO   =>  :p_OKPO, 
                                                                  P_FDAT   =>  :p_fdat, 
                                                                  P_ID     =>  :p_id, 
                                                                  P_COLUM3 =>  :p_colum3, 
                                                                  P_COLUM4 =>  null );
                                        end;     ");
                        }
                    }
                    pos++;
                }
            }

            if (tbFrm.Value == "4")
            {
                int pos4 = 0;
                foreach (GridViewRow row in gvMain4.Rows)
                {
                    NumericEdit colum3;
                    NumericEdit colum4;
                    if (row.Cells[4].Controls[1] is NumericEdit) { colum3 = ((NumericEdit)row.Cells[4].Controls[1]);} else { colum3 = null;};

                    if (row.Cells[5].Controls[1] is NumericEdit) { colum4 = ((NumericEdit)row.Cells[5].Controls[1]); } else { colum4 = null; };
                        
                        {
                            string OKPO = Convert.ToString(gvMain4.DataKeys[pos4].Values[0]);
                            string KOD = Convert.ToString(gvMain4.DataKeys[pos4].Values[1]);
                            string ID = Convert.ToString(gvMain4.DataKeys[pos4].Values[2]);

                            //Response.Write("_"+KOD + "="+ Convert.ToString(colum3.Value) +",");                        

                            ClearParameters();


                            SetParameters("p_OKPO", DB_TYPE.Varchar2, OKPO, DIRECTION.Input);
                            SetParameters("pfdat", DB_TYPE.Date, dat, DIRECTION.Input);
                            SetParameters("p_id", DB_TYPE.Varchar2, ID, DIRECTION.Input);
                            SetParameters("p_colum3", DB_TYPE.Varchar2, Convert.ToString(colum3.Value), DIRECTION.Input);
                            SetParameters("p_colum4", DB_TYPE.Varchar2, Convert.ToString(colum4.Value), DIRECTION.Input);

                            SQL_NONQUERY(@"begin
                                         fin_formaf3.data_entry_s(P_OKPO   =>  :p_OKPO, 
                                                                  P_FDAT   =>  :p_fdat, 
                                                                  P_ID     =>  :p_id, 
                                                                  P_COLUM3 =>  :p_colum3, 
                                                                  P_COLUM4 =>  :p_colum4 );
                                        end;     ");
                        }
                     
                    pos4++;
                }
            }



           
            lock_form();
            FillData();
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// Логічний контроль заповнення форми
    /// </summary>
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

           
          
            
            cmd.Parameters.Add("OKPO", OracleDbType.Decimal, OKPO, ParameterDirection.Input);
            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("idf", OracleDbType.Varchar2, IDF, ParameterDirection.Input);
            cmd.Parameters.Add("dat", OracleDbType.Date, dat, ParameterDirection.Input);
            cmd.Parameters.Add("OKPO", OracleDbType.Varchar2, tbOKPO.Text, ParameterDirection.Input);
            cmd.Parameters.Add("idf", OracleDbType.Varchar2, IDF, ParameterDirection.Input);
            cmd.CommandText = "select fin_formaf3.f_prot_kol( :OKPO, trunc(:dat), :idf) as sos, to_char(:dat,'dd/mm/yyyy') as dat, :OKPO as okpo, : idf as idf  from dual";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                Decimal SOS = Convert.ToDecimal(rdr["SOS"]);
                if (SOS != 0 )
                {

                    ShowError("Увага в формі №" + rdr["idf"] + "( окпо - " + rdr["OKPO"] + ")" + " за дату " + rdr["dat"] + " є помилки!!!");
                    
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/barsweb/dynform.aspx?form=frm_fin2_form_k&OKPO=" + rdr["OKPO"] + "&nForm=" + rdr["idf"] + "&DAT=" + rdr["dat"] + "', 'aaaa', 'width=1050, height=400, resizable=yes,scrollbars=yes,status=yes" + "')", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/credit/fin_nbu/Print_fin.aspx?frt=fin_form3_protokol&back=NOT&p_okpo=" + rdr["OKPO"] + "&p_idf=" + rdr["idf"] + "&p_fdat=" + rdr["dat"] + "', 'aaaa', 'width=1150, height=800, resizable=yes,scrollbars=yes,status=yes" + "')", true);
                    
                }
                else
                {
                    save_sec();
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
           // decimal s = Convert.ToDecimal(((DataRowView)e.Row.DataItem).Row["COLUM3"]);
            string kod = Convert.ToString(((DataRowView)e.Row.DataItem).Row["KOD"]);
            string pob = Convert.ToString(((DataRowView)e.Row.DataItem).Row["TYPE_ROW"]);

            if (pob == "1")
            {
                e.Row.BackColor = System.Drawing.Color.DarkGray;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[0].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[1].Style.Add("border-bottom", "1px dotted black"); 
                e.Row.Cells[2].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[3].Style.Add("border-bottom", "1px dotted black"); e.Row.Cells[3].Style.Add("font-size", "125%");
                e.Row.Cells[4].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[5].Style.Add("border-bottom", "1px dotted black");
                e.Row.Font.Bold = true;
            }
            if (pob == "2")
            {
                //e.Row.BackColor = System.Drawing.Color.LightGray;
                e.Row.Cells[0].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[1].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[2].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[3].Style.Add("border-bottom", "1px dotted black"); e.Row.Cells[3].Style.Add("font-size", "115%");
                e.Row.Cells[4].Style.Add("border-bottom", "1px dotted black");
                e.Row.Cells[5].Style.Add("border-bottom", "1px dotted black");
                e.Row.Font.Bold = true;
            }

            if (pob == "3")
            {
                e.Row.BackColor = System.Drawing.Color.SeaShell;
                e.Row.Cells[0].ForeColor = System.Drawing.Color.SeaShell;
                e.Row.Cells[1].ForeColor = System.Drawing.Color.SeaShell;
                e.Row.Cells[2].ForeColor = System.Drawing.Color.SeaShell;
                e.Row.Cells[5].ForeColor = System.Drawing.Color.SeaShell;
                e.Row.Cells[0].Font.Bold = true;
                e.Row.Cells[1].Font.Bold = true;
                e.Row.Cells[2].Font.Bold = true;
                e.Row.Cells[3].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            if (pob == "4")
            {
                e.Row.BackColor = System.Drawing.Color.GhostWhite;
                e.Row.Cells[0].ForeColor = System.Drawing.Color.GhostWhite;
                e.Row.Cells[1].ForeColor = System.Drawing.Color.GhostWhite;
                e.Row.Cells[2].ForeColor = System.Drawing.Color.GhostWhite;
                e.Row.Cells[5].ForeColor = System.Drawing.Color.GhostWhite;
                e.Row.Cells[0].Font.Italic = true;
                e.Row.Cells[1].Font.Italic = true;
                e.Row.Cells[2].Font.Italic = true;
                e.Row.Cells[3].Font.Italic = true;
                e.Row.Cells[5].Font.Italic = true;
            }
        }
    }

    private void ShowError(String ErrorText)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_error", "alert('" + ErrorText + "');", true);
    }

    
    /// <summary>
    ///  проставляжмо дату та час про редагування форми
    /// </summary>
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
              

                if (tbFrm.Value == "3")
                {
                    SQL_NONQUERY("   begin  " +
                                 "   update fin_fm set date_f3 = sysdate where okpo = :okpo and fdat = :dat;" +
                                 "   end;");
                }
                else if (tbFrm.Value == "4")
                {
                    SQL_NONQUERY("   begin  " +
                                 "   update fin_fm set date_f3n = sysdate where okpo = :okpo and fdat = :dat;" +
                                 "   end;");
                }
            
            }

         
        }
        finally
        {
            DisposeOraConnection();
        }
        //Get_read();
    }

    
    /// <summary>
    /// блокування введення даних якщо форма завведенна правильно і недаємо зберігати
    /// </summary>
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
              + "  fin_nbu.GET_KVED(:P_RNK,:dat,1 ) as kved"
              + "  from dual";

            OracleDataReader rdr = cmd.ExecuteReader();
            if (!rdr.Read()) throw new Exception("Свое МФО не найдено или не определено.");

            par_read = Convert.ToString(rdr.GetValue(0));

             t_read.Text = par_read;
            // блокумвання кнопки зберегти коли форма заповнена без помилок
            if (par_read == "0") btOk.Enabled = false;
            //return 0;           -- повністю заповненна форма та пройде
            //return 1;           -- створена форма , клієгт ненадав дан або не заповнена
            //return 2;           -- створена форма , набрана з помилками

                

            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

    }

    /// <summary>
    /// Визов друкованої форми звіту
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BtPrint_Click(object sender, ImageClickEventArgs e)
    {

        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/credit/fin_nbu/Print_fin.aspx?frt=fin_form3&back=NOT&p_okpo=" + tbOKPO.Text + "&p_idf=" + tbFrm.Value + "&p_fdat=" + tbFDat.SelectedValue + "', 'aaaa', 'width=1050, height=800, resizable=yes,scrollbars=yes,status=yes" + "')", true);

        //String TemplateId = "Fin_nbu_forms.frx";

        //FrxParameters pars = new FrxParameters();
        //pars.Add(new FrxParameter("datf", TypeCode.String, tbFDat.SelectedValue));
        //pars.Add(new FrxParameter("okpo", TypeCode.String, Convert.ToInt64( tbOKPO.Text)));
        //pars.Add(new FrxParameter("frm", TypeCode.String, Convert.ToInt64(  tbFrm.Value )));


        //FrxDoc doc = new FrxDoc(
        //      FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId,
        //          pars,
        //        this.Page);

        //doc.Print(FrxExportTypes.Excel2007);
    }

}
