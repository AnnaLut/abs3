using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;
using System.Threading;

public partial class credit_repayment_dostr : Bars.BarsPage
{
    private string sClassSessionID = "REPAYMENT_DATA_DOSR";
    public string sFormatingString = "### ### ### ### ### ##0.00";

    public cRePayment_dosr rp_dosr
    {
        get
        {
            if (Session[sClassSessionID] == null) Session[sClassSessionID] = new cRePayment_dosr();
            return (cRePayment_dosr)Session[sClassSessionID];
        }
        set
        {
            Session[sClassSessionID] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // первоначальное наполнение
        //decimal gpk;
        //decimal kl_ = 0;
        if (!IsPostBack)
        {
            rp_dosr = null; 
            
            form2.DataBind();
            pb_del.Visible = false;
            pb_GPK_NEW.Visible = false;
            pb_GPK_OLD.Visible = false;
  
        }

        // если параметры передали в урл то наполняем
        if (!IsPostBack && Request.Params.Get("ccid") != null )
        {
            String CC_ID = Request.Params.Get("ccid");

            DateTimeFormatInfo dtfi = new DateTimeFormatInfo();
            dtfi.ShortDatePattern = "yyyyMMdd";
            dtfi.FullDateTimePattern = "yyyyMMdd HH:mm:ss";
            //DateTime DAT1 = DateTime.ParseExact(Request.Params.Get("dat1"), "yyyyMMdd", dtfi);

            tbsCC_ID.Value = CC_ID;
            tbsCC_ID.Enabled = false;
            ibSearch.Visible = false;
           
            ibSearch_Click(sender, null);
        }


        ///  0 - справка, 
        ///  1 - досрочное пог.+модификация ГПК 
        ///  2 - только модификация ГПК
        if (Request.Params.Get("type") == "1")
        {
            btPay.Visible = true;
            btPgpk.Visible = false;
            K1.Enabled = true;
            lbPageTitle.Text = "Дострокового погашення з перебудовою графіка погашення";
            
        }
        else if (Request.Params.Get("type") == "2")
        {
            btPay.Visible = false;
            btPgpk.Visible = true;
            K1.Enabled = false;
            K1.Value = 0;
            lbPageTitle.Text = "Перебудова графіка погашення";
        }
        else
        {
            btPay.Visible = false;
            btPgpk.Visible = false;
            K1.Enabled = false;
            K1.Value = 0;
            lbPageTitle.Text = "Довiдка про можливість дострокового погашення";
        }


        
    }
    protected void ibSearch_Click(object sender, ImageClickEventArgs e)
    {
        Send_load();
        load_nms();
        Decimal? res = rp_dosr.FindCredit1(tbsCC_ID.Value, Request.Params.Get("type"));
        decimal gpk;

        if (res == 1)
        {
            ClientScript.RegisterStartupScript(typeof(string), "error_text", "alert('" + "При поиске произошла ошибка : " + rp_dosr.RetText + "')", true);
            rp_dosr = null;
        }
        else {
            
            pb_del.Visible = true;
            pb_GPK_NEW.Visible = true;
            pb_GPK_OLD.Visible = true;

            gpk = Convert.ToDecimal(rp_dosr.LbGPK_);
            //Response.Write(gpk + " " + rp_dosr.LbGPK_ + " - " + lb_gpk.Text);
            if (gpk == 0)
            { //LbGPK.Text = "Класичний"; 
                drl_gpl.SelectedValue = "0"; }
            else
            { //LbGPK.Text = "Антуітет"; 
                drl_gpl.SelectedValue = "1"; }

            LinREF.Visible = false;
            LinREF.Text = "0";
            lbRef.Visible = false;

        }
        form2.DataBind();
    }

    /// <summary>
    /// Обновлення даних на екранній формі
    /// </summary>
    protected void refreh_date()
    {
        Decimal? res = rp_dosr.FindCredit1(tbsCC_ID.Value, Request.Params.Get("type"));
        Tb_dat_mod.DataBind();
        tb_dat_next.DataBind();
        tb_dat_prev.DataBind();
        tb_wdat.DataBind();
        Label5.DataBind();
        Label7.DataBind();
        Label9.DataBind();
        Label11.DataBind();
        Label13.DataBind();
        Label14.DataBind();
        Label3.DataBind();

        if (Convert.ToDecimal(rp_dosr.LbGPK_) == 0)
        { //LbGPK.Text = "Класичний"; 
            drl_gpl.SelectedValue = "0"; }
        else
        { //LbGPK.Text = "Антуітет"; 
            drl_gpl.SelectedValue = "1"; }

    }

    /// <summary>
    /// Зміна графіка і проведення дострокового погашення
    /// </summary>
    protected void btPay_Click(object sender, EventArgs e)
    {
        SendZay(1);
        btPay.Enabled = false;
        btPgpk.Enabled = false;
        refreh_date();
        pb_del.Enabled = true;

     }

    /// <summary>
    /// Зміна графіка  
    /// </summary>
    protected void btPgpk_Click(object sender, EventArgs e)
    {
        SendZay(2);
        btPay.Enabled = false;
        btPgpk.Enabled = false;
      //  lbRef.Enabled = false;
      //  LinREF.Enabled = false;
        refreh_date();
        pb_del.Enabled = true;
    }
 
    /// <summary>
    /// Розбор проплат 
    /// </summary>
    /// <returns></returns>
    private Boolean Send_load()
    {
        // скрываем ошибки
        //HideError();

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            Decimal? ND1;
           
     

            //ND1 = -Convert.ToDecimal(tbsCC_ID.Value);
            ND1 = Convert.ToDecimal(tbsCC_ID.Value);
         


            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.CommandText = "cck.cc_asg";
            cmd.CommandText = "CCK_DPK.PREV";

            cmd.Parameters.Add("p_ND", OracleDbType.Decimal, ND1, ParameterDirection.Input);
            //Response.Write("договір " + ND1);
            cmd.ExecuteNonQuery();
            
           



        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return true;
    }

    private Boolean load_nms()
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            Decimal? ND2;
            ND2 = Convert.ToDecimal(tbsCC_ID.Value);
            InitOraConnection();
            cmd.ExecuteNonQuery();
            ClearParameters();
            cmd.Parameters.Add("ND2", OracleDbType.Decimal, ND2, ParameterDirection.Input);
            cmd.CommandText = "select c.nmk||' (№ '||cc_id||' від '||to_char(sdate,'dd/mm/yyyy')||')' as NMS from cc_deal d, customer c where d.rnk = c.rnk and d.nd = :ND2";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                lbFIO.Text = Convert.ToString(rdr["NMS"]);
            }
            cmd.ExecuteNonQuery();
            
        }
        finally
        {
            con.Close();
            con.Dispose();
            DisposeOraConnection();
        }
        return true;

    }

    /// <summary>
    /// Процедура оплати та зміни графіку погашення КД
    ///  0 - справка, 
    ///  1 - досрочное пог.+модификация ГПК 
    ///  2 - только модификация ГПК
    /// </summary>
    /// <param name="p_mode"></param>
    /// <returns></returns>
    private Boolean SendZay(Decimal p_mode)
    {
        // скрываем ошибки
        //HideError();

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            Decimal? ND1;
            Decimal? S;
            Decimal? Ref_;
            Int16?   p_gpk_;
           // Decimal? p_mode; //0 - справка, 1 - модификация
            //Decimal? ErrCode;
            //String ErrMessage;

            ND1 = Convert.ToDecimal(tbsCC_ID.Value);
            //p_mode = 1;
            S = K1.Value * 100;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "CCK_dpk.dpk";

            //(p_mode IN  int   , -- 0 - справка, 1 - досрочное пог.+модификация ГПК 2 - только модификация ГПК
            // p_ND   IN  number, -- реф КД
            // p_K1   IN  number, -- <Сумма для досрочного пог>, по умолч = R2,   CC_GET_INFO
            // p_K2   IN  number, -- <Платежный день>, по умол = DD от текущего банк.дня
            // p_K3   IN  number, -- 1=ДА ,<с сохранением суммы одного платежа?>
            //                    -- 2=НЕТ (с перерасчетом суммы до последней ненулевой даты)

            p_gpk_ = Convert.ToInt16(drl_gpl.SelectedValue);
          //  Response.Write(p_mode + " " + Convert.ToString(p_gpk_));
            cmd.Parameters.Add("p_mode", OracleDbType.Decimal, p_mode, ParameterDirection.Input);
            cmd.Parameters.Add("p_ND", OracleDbType.Decimal, ND1, ParameterDirection.Input);
            cmd.Parameters.Add("p_K0", OracleDbType.Decimal, p_gpk_, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_K1", OracleDbType.Decimal, S, ParameterDirection.Input);
            cmd.Parameters.Add("p_K2", OracleDbType.Decimal, K2.Value, ParameterDirection.Input);
            cmd.Parameters.Add("p_K3", OracleDbType.Decimal, Convert.ToDecimal(K3.SelectedValue), ParameterDirection.Input);

            cmd.Parameters.Add("p_Z1", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_Z2", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_Z3", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_Z4", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_Z5", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_R1", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_R2", OracleDbType.Decimal, null, ParameterDirection.InputOutput);
            cmd.Parameters.Add("p_P1", OracleDbType.Decimal, null , ParameterDirection.Output);



           //  drl_gpl.SelectedValue = Convert.ToString( p_gpk_); 

            cmd.ExecuteNonQuery();
            Ref_ = (cmd.Parameters["p_P1"].Status == OracleParameterStatus.Success ? ((OracleDecimal)cmd.Parameters["p_P1"].Value).Value : (Decimal?)null);
            pb_del.Visible = true;

            if (Ref_ != null)
            { LinREF.Visible = true;
            lbRef.Visible = true;
            lbRef.Text = "Документ Реф. №: ";
            LinREF.Text =  Convert.ToString(Ref_);
            LinREF.NavigateUrl = "/barsroot/documentview/default.aspx?ref=" + Convert.ToString(Ref_) ;
                

          LinREF.Attributes.Add("onclick",
            "javascript:"+
            "window.showModalDialog("+
            LinREF.ClientID+".href,"+
            "'ModalDialog',"+
            "'dialogHeight:600px; dialogLeft:100px; dialogTop:100px; dialogWidth:1100px; help:no; resizable:yes; scroll:yes;'"+
            ");"+
            "return false;"
            );
            }
                
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        
        return true;
    }
    
    protected void pb_del_Click(object sender, ImageClickEventArgs e)
    {
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        try
        {
            // установка роли
            cmd.ExecuteNonQuery();

            Decimal? ND1;
            Decimal? ref_;


            ND1 = Convert.ToDecimal(tbsCC_ID.Value);

            if (LinREF.Text == null)
            { ref_ = 0; }
            else
            { ref_ = Convert.ToDecimal(LinREF.Text); }

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "CCK_dpk.MODI_RET";

            cmd.Parameters.Add("p_ND", OracleDbType.Decimal, ND1, ParameterDirection.Input);
            cmd.Parameters.Add("p_REF", OracleDbType.Decimal, ref_, ParameterDirection.Input);
     



            cmd.ExecuteNonQuery();
            LinREF.Font.Strikeout = true;

            pb_del.Enabled = false;

        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        refreh_date();
    }

    protected void pb_GPK_NEW_Click(object sender, ImageClickEventArgs e)
    {
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.showModalDialog('/barsroot/barsweb/references/refbook.aspx?tabname=CC_W_LIM&mode=RO&force=1&code=CC_DEAL_LIM&mtpar_N_ND=" + tbsCC_ID.Value + "', 'ModalDialog', 'dialogwidth:1050Px; dialogheight:500Px; help:no; resizable:yes; scroll:yes; status:yes;" + "')", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/barsweb/references/refbook.aspx?tabname=CC_W_LIM&mode=RO&force=1&code=CC_DEAL_LIM&mtpar_N_nd=" + tbsCC_ID.Value + "', 'aaaa', 'width=1050, height=500, resizable=yes,scrollbars=yes,status=yes" + "')", true);
        //перейдем на іншу сторінку...
    }

    protected void pb_GPK_OLD_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/barsweb/references/refbook.aspx?tabname=CC_W_LIM_ARC&mode=RO&force=1&code=CC_DEAL_LIM&mtpar_N_nd=" + tbsCC_ID.Value + "', 'aaaa', 'width=1050, height=500, resizable=yes,scrollbars=yes,status=yes" + "')", true);
    }

    protected void PB_NLSKD_CLICK(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "send_success", "window.open('/barsroot/customerlist/custacc.aspx?type=3&nd=" + tbsCC_ID.Value + "', 'aaaa', 'width=1050, height=500, resizable=yes,scrollbars=yes,status=yes" + "')", true);
    }

}

public class cRePayment_dosr
{
    # region Приватные свойства
    private Boolean _HasData_dosr = false;
    private String _sCC_ID_dosr;
    private Decimal? _nRet_dosr;
    private String _sRet_dosr;
    private String _sNMK_dosr;
    private Decimal? _Z1;
    private Decimal? _Z2;
    private Decimal? _Z3;
    private Decimal? _Z4;
    private Decimal? _Z5;
    private Decimal? _R1;
    private Decimal? _R2;
    private Decimal? _K1;
    private Decimal? _sDD_dosr;
    private Decimal? _LbGPK;
    
    private String   _branch;
    private String _sdat;
    private String _wdat;
    private String _dat_prev;
    private String _dat_next;
    private String _glbd;
    private String _dat_mod;

  # endregion

    # region Публичные свойства
    /// <summary>
    /// Содержит ли данные
    /// </summary>
    public Boolean HasData_dosr
    {
        get
        {
            return this._HasData_dosr;
        }
    }
    /// <summary>
    /// идентификатор   КД
    /// </summary>
    public String CC_ID
    {
        get { return _sCC_ID_dosr; }
        set { _sCC_ID_dosr = value; }
    }
   
    /// <summary>
    /// Код возврата: =1 не найден, Найден =0
    /// </summary>
    public Decimal? RetCode
    {
        get { return _nRet_dosr; }
        set { _nRet_dosr = value; }
    }
    /// <summary>
    /// Текст ошибки (?)
    /// </summary>
    public String RetText
    {
        get { return _sRet_dosr; }
        set { _sRet_dosr = value; }
    }
    /// <summary>
    ///  
    /// </summary>
    public Decimal? Z1
    {
        get { return _Z1; }
        set { _Z1 = value; }
    }
    ///// <summary>
    /////  
    ///// </summary>
    //public Decimal? Z2
    //{
    //    get {
    //        HttpContext.Current.Trace.Write("returned S = " + Convert.ToString(_nS));
    //        return _nS; 
    //    }
    //    set { _nS = value; }
    //}
    /// <summary>
    ///  
    /// </summary>
    public Decimal? Z2
    {
        get { return _Z2; }
        set { _Z2 = value; }
    }
    /// <summary>
    /// наименованик клиента
    /// </summary>
    public String NMK
    {
        get { return (HasData_dosr ? _sNMK_dosr : ""); }
        //get { return _sNMK_dosr; }
        set { _sNMK_dosr = value; }
    }
    /// <summary>
    ///  
    /// </summary>
    public Decimal? Z3
    {
        get { return _Z3; }
        set { _Z3 = value; }
    }
    /// <summary>
    ///  
    /// </summary>
    public Decimal? Z4
    {
        get { return _Z4; }
        set { _Z4 = value; }
    }
    /// <summary>
    ///  
    /// </summary>
    public Decimal? Z5
    {
        get { return _Z5; }
        set { _Z5 = value; }
    }
    /// <summary>
    ///  
    /// </summary>
    public Decimal? R2
    {
        get { return _R2; }
        set { _R2 = value; }
    }
    /// <summary>
    ///  
    /// </summary>
    public Decimal? R1
    {
        get { return _R1; }
        set { _R1 = value; }
    }

    /// <summary>
    ///  
    /// </summary>
    public Decimal? K1
    {
        get { return _K1; }
        set { _K1 = value; }
    }

    /// <summary>
    ///  
    /// </summary>
    public Decimal? DD
    {
        //get { return (HasData_dosr ? _sDD_dosr : ""); }
        get { return _sDD_dosr; }
        set { _sDD_dosr = value; }
    }

    /// <summary>
    ///  
    /// </summary>
    public  Decimal? LbGPK_
    {
        
        get {return _LbGPK;   }
        set { _LbGPK = value; }
    }

    /// <summary>
    ///  Бранч КД
    /// </summary>
    public String  branch_
    {
        get { return _branch; }
        set { _branch = value; }
    }

    /// <summary>
    ///  Поч. дата
    /// </summary>
    public String sdat_
    {
        get { return _sdat; }
        set { _sdat = value; }
    }

    /// <summary>
    ///  Кінцева дата КД
    /// </summary>
    public String wdat_
    {
        get { return _wdat; }
        set { _wdat = value; }
    }

    /// <summary>
    ///  Попередня платьожна дата
    /// </summary>
    public String dat_prev_
    {
        get { return _dat_prev; }
        set { _dat_prev = value; }
    }

    /// <summary>
    ///  Наступна платьожна дата
    /// </summary>
    public String dat_next_
    {
        get { return _dat_next; }
        set { _dat_next = value; }
    }

    /// <summary>
    ///  Попередня дата модифікації ГПК
    /// </summary>
    public String dat_mod_
    {
        get { return _dat_mod; }
        set { _dat_mod = value; }
    }

    /// <summary>
    ///  Поточна банківська дата
    /// </summary>
    public String glbd_
    {
        get { return _glbd; }
        set { _glbd = value; }
    }


    # endregion

    # region Публичные методы
    public Decimal? FindCredit1(String CC_ID, String type_)
    {
        this.CC_ID = CC_ID;
        //this.DAT1 = DAT1;
        //Decimal? p_mode = 0;
        //Decimal? ref1_; 

        //OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        //OracleCommand com = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);
        

        if (con.State == ConnectionState.Closed) con.Open();
        try
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";


            cmd.Parameters.Clear();
            cmd.Parameters.Add("ND_", OracleDbType.Decimal, 100, this.CC_ID, ParameterDirection.Input);
            cmd.CommandText = "select  BRANCH, ND, CC_ID, SDATE, WDATE, RNK, NMK, MES, KV, NLS, Z1,Z2,Z3,Z4,Z5,R1,R2,K1,K0, DAT_MOD from V_CCKDPK where nd = :ND_";
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                this.LbGPK_ = Convert.ToDecimal(rdr["K0"]);
                this.Z1 = Convert.ToDecimal(rdr["Z1"]);
                this.Z2 = Convert.ToDecimal(rdr["Z2"]);
                this.Z3 = Convert.ToDecimal(rdr["Z3"]);
                this.Z4 = Convert.ToDecimal(rdr["Z4"]);
                this.Z5 = Convert.ToDecimal(rdr["Z5"]);
                this.R1 = Convert.ToDecimal(rdr["R1"]);
                this.R2 = Convert.ToDecimal(rdr["R2"]);
                this.K1 = Convert.ToDecimal(rdr["K1"]);
                this._branch = Convert.ToString(rdr["branch"]);
                if (!String.IsNullOrEmpty(Convert.ToString(rdr["sdate"]))) this.sdat_ = Convert.ToString(rdr["sdate"], cinfo).Substring(0, 10);
                if (!String.IsNullOrEmpty(Convert.ToString(rdr["DAT_MOD"]))) this.dat_mod_ = Convert.ToString(rdr["DAT_MOD"], cinfo).Substring(0, 10); else this.dat_mod_ = null;

            }
            cmd.ExecuteNonQuery();

            // день
            //  cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select to_number(to_char(gl.bd,'DD')) as dd from dual where :ND is not null";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("ND", OracleDbType.Decimal, this.CC_ID, ParameterDirection.Input);
            this.DD = Convert.ToDecimal(cmd.ExecuteScalar());
            
            
            

            
            
            

            // дати угоди
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select gl.bd as glbd, max(fdat) as  wdat1, max(case when fdat <  gl.bd then fdat else null end) as dat_prev, min(case when fdat >  gl.bd then fdat else null end) as dat_next from cc_lim where nd = :ND";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("ND", OracleDbType.Decimal, this.CC_ID, ParameterDirection.Input);
            OracleDataReader rdr1 = cmd.ExecuteReader();

            if (rdr1.Read())
            {
                if (!String.IsNullOrEmpty(Convert.ToString(rdr1["glbd"]))) this.glbd_ = Convert.ToString(rdr1["glbd"], cinfo).Substring(0, 10);
                if (!String.IsNullOrEmpty(Convert.ToString(rdr1["wdat1"]))) this.wdat_ = Convert.ToString(rdr1["wdat1"], cinfo).Substring(0, 10);
                if (!String.IsNullOrEmpty(Convert.ToString(rdr1["dat_prev"]))) this.dat_prev_ = Convert.ToString(rdr1["dat_prev"], cinfo).Substring(0, 10);
                if (!String.IsNullOrEmpty(Convert.ToString(rdr1["dat_next"]))) this.dat_next_ = Convert.ToString(rdr1["dat_next"], cinfo).Substring(0, 10);
                
            }
           
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
   

       //If DAT_PREV > DAT1 and DAT_PREV < DAT4
       //   Set K2_OLD = SalDateDay( DAT_PREV)
       //Else If DAT_NEXT > DAT1 and DAT_NEXT < DAT4
       //   Set K2_OLD = SalDateDay( DAT_NEXT )


        if (Convert.ToDateTime(this.sdat_) < Convert.ToDateTime(this.dat_prev_) & Convert.ToDateTime(this.dat_prev_) < Convert.ToDateTime(this.wdat_) & type_ =="2")
        {
            this.DD = Convert.ToDecimal(this.dat_prev_.Substring(0, 2));
        }
        else if (Convert.ToDateTime(this.sdat_) < Convert.ToDateTime(this.dat_next_) & Convert.ToDateTime(this.dat_next_) < Convert.ToDateTime(this.wdat_) & type_ == "2")
        {
            this.DD = Convert.ToDecimal(this.dat_next_.Substring(0, 2));
        }      




        this.RetCode = 0;

        this._HasData_dosr = (this.RetCode == 0);

        return this.RetCode;
    }
    public void ClearData()
    {
        this._HasData_dosr = false;
    }
    # endregion

    # region Конструкторы
    public cRePayment_dosr()
    {
    }

  

  
    # endregion
}