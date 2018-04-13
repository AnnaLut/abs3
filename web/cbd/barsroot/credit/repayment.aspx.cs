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

public partial class credit_repayment : Bars.BarsPage
{
    private string sClassSessionID = "REPAYMENT_DATA";
    public string sFormatingString = "### ### ### ### ### ##0.00";

    public cRePayment rp
    {
        get
        {
            if (Session[sClassSessionID] == null) Session[sClassSessionID] = new cRePayment();
            return (cRePayment)Session[sClassSessionID];
        }
        set
        {
            Session[sClassSessionID] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // первоначальное наполнение
        if (!IsPostBack)
        {
            form1.DataBind();
        }

        // если параметры передали в урл то наполняем
        if (!IsPostBack && Request.Params.Get("ccid") != null && Request.Params.Get("dat1") != null)
        {
            String CC_ID = Request.Params.Get("ccid");

            DateTimeFormatInfo dtfi = new DateTimeFormatInfo();
            dtfi.ShortDatePattern = "yyyyMMdd";
            dtfi.FullDateTimePattern = "yyyyMMdd HH:mm:ss";
            DateTime DAT1 = DateTime.ParseExact(Request.Params.Get("dat1"), "yyyyMMdd", dtfi);

            tbsCC_ID.Value = CC_ID;
            tbdDAT1.Value = DAT1;

            ibSearch_Click(sender, null);
        }
    }
    protected void ibSearch_Click(object sender, ImageClickEventArgs e)
    {
        Decimal? res = rp.FindCredit(tbsCC_ID.Value, tbdDAT1.Value);

        if (res == 1)
        {
            ClientScript.RegisterStartupScript(typeof(string), "error_text", "alert('" + "При поиске произошла ошибка : " + rp.RetText + "')", true);
            rp = null;
        }

        form1.DataBind();
    }
    protected void btPay_Click(object sender, EventArgs e)
    {
        if (tbdSumm.Value + tbdPeny.Value + (tbdCommission.Value.HasValue && tbdCommission.Visible ? tbdCommission.Value : 0) > 0)
        {
            string sDocInputUrl = "/barsroot/DocInput/DocInput.aspx?";
            sDocInputUrl += "tt=" + "CCK";
            // sDocInputUrl += "&nd=" + HttpUtility.UrlEncode(rp.CC_ID.Length > 10 ? rp.CC_ID.Substring(0, 10) : rp.CC_ID);
            sDocInputUrl += "&SumC_t=" + (tbdSumm.Value * 100 + tbdPeny.Value * 100 + (tbdCommission.Value.HasValue && tbdCommission.Visible ? tbdCommission.Value : 0) * 100).ToString();
            sDocInputUrl += "&Kv_A=" + rp.KV.ToString();
            sDocInputUrl += "&Sk=" + HttpUtility.UrlEncode(rp.NLSK.Substring(0, 2).ToString() == "29" || rp.NLSK.Substring(0, 2).ToString() == "37" ? "14" : "16");
            sDocInputUrl += "&Kv_B=" + rp.KV.ToString();
            sDocInputUrl += "&rnd=" + (new Random()).Next(1000, 9999).ToString();
            sDocInputUrl += "&Nls_B=" + rp.NLSK;
            sDocInputUrl += "&Id_B=" + HttpUtility.UrlEncode(rp.OKPO);
            sDocInputUrl += "&Nam_B=" + HttpUtility.UrlEncode(rp.NMK);
            sDocInputUrl += "&reqv_SN8=" + Convert.ToInt32(tbdPeny.Value * 100).ToString();
            sDocInputUrl += "&reqv_CC_ID=" + HttpUtility.UrlEncode(rp.CC_ID);
            sDocInputUrl += "&reqv_DAT1=" + rp.DAT1.Value.ToString("dd-MM-yyyy");

            sDocInputUrl += "&reqv_SN8KV=" + rp.KV_SN8.ToString();
            sDocInputUrl += "&reqv_SK0KV=" + rp.KV_KOM.ToString();
            sDocInputUrl += "&reqv_SK0=" + Convert.ToInt32((tbdCommission.Value.HasValue && tbdCommission.Visible ? tbdCommission.Value : 0) * 100).ToString();

            if (rp.NLSK.Substring(0, 2).ToString() == "29" || rp.NLSK.Substring(0, 2).ToString() == "37")
            {
                sDocInputUrl += "&nazn=" + HttpUtility.UrlEncode(tbdSumm.Value > 0 ? "Сплата боргу за кредит згідно договору №" + rp.CC_ID + " від " + rp.DAT1.Value.ToShortDateString() : "Сплата штрафу (пенi) за просрочені відсотки згідно договору №" + rp.CC_ID + " від " + rp.DAT1.Value.ToShortDateString());
            }
            else
            {
                sDocInputUrl += "&nazn=" + HttpUtility.UrlEncode("Зарахування коштів на поточний рахунок");
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "show_pay_dialog", "ShowPayDialog('" + sDocInputUrl + "')", true);
            rp.ClearData();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "inc_summ", "alert('Укажите сумму')", true);
        }
    }
    protected void tbdPeny_ValueChanged(object sender, EventArgs e)
    {
        tbdCommission.DataBind();
        tbdSumm.DataBind();
        lbE.DataBind();
        lbE1.DataBind();
    }
    protected void tbdCommission_ValueChanged(object sender, EventArgs e)
    {
        tbdSumm.DataBind();
        lbE1.DataBind();
    }
    protected void ddlPaymentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        form1.DataBind();
    }
    public Decimal? GetEquivalent(Decimal? Summ, Decimal? Kv)
    {
        Decimal? res = 0;

        if (Summ.HasValue && Kv.HasValue)
        {
            InitOraConnection();
            try
            {
                SetRole("WR_CREDIT");

                ClearParameters();
                SetParameters("icur", DB_TYPE.Decimal, Kv, DIRECTION.Input);
                SetParameters("isum", DB_TYPE.Decimal, Summ * 100, DIRECTION.Input);
                res = (Decimal?)SQL_SELECT_scalar("select gl.p_icurval(:icur, :isum, bankdate) from dual");
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        return res / 100;
    }
}

public class cRePayment
{
    # region Приватные свойства
    private Boolean _HasData = false;
    private String _sCC_ID;
    private DateTime? _dDAT1;
    private Decimal? _nRet;
    private String _sRet;
    private Decimal? _nRNK;
    private Decimal? _nS;
    private Decimal? _nS1;
    private String _sNMK;
    private String _sOKPO;
    private String _sADRES;
    private Decimal? _nKV;
    private String _sLCV;
    private String _sNAMEV;
    private String _sUNIT;
    private String _sGENDER;
    private Decimal? _nSS;
    private DateTime? _dDAT4;
    private Decimal? _nSS1;
    private DateTime? _dDAT_SN;
    private Decimal? _nSN;
    private Decimal? _nSN1;
    private DateTime? _dDAT_SK;
    private Decimal? _nSK;
    private Decimal? _nSK1;
    private Decimal? _nKV_KOM;
    private String _sNAMEV_KOM;
    private DateTime? _dDAT_SP;
    private Decimal? _nSP;
    private Decimal? _KV_SN8;
    private String _NAMEV_SN8;
    private String _sSN8_NLS;
    private String _sSD8_NLS;
    private String _sMFOK;
    private String _sNLSK;
    private Decimal? _nSSP;
    private Decimal? _nSSPN;
    private Decimal? _nSSPK;
    private String _sAddInfo;
    private Decimal _nPayType;
    # endregion

    # region Публичные свойства
    /// <summary>
    /// Содержит ли данные
    /// </summary>
    public Boolean HasData
    {
        get
        {
            return this._HasData;
        }
    }
    /// <summary>
    /// идентификатор   КД
    /// </summary>
    public String CC_ID
    {
        get { return _sCC_ID; }
        set { _sCC_ID = value; }
    }
    /// <summary>
    /// дата ввода      КД
    /// </summary>
    public DateTime? DAT1
    {
        get { return _dDAT1; }
        set { _dDAT1 = value; }
    }
    /// <summary>
    /// Код возврата: =1 не найден, Найден =0
    /// </summary>
    public Decimal? RetCode
    {
        get { return _nRet; }
        set { _nRet = value; }
    }
    /// <summary>
    /// Текст ошибки (?)
    /// </summary>
    public String RetText
    {
        get { return _sRet; }
        set { _sRet = value; }
    }
    /// <summary>
    /// Рег № заемщика
    /// </summary>
    public Decimal? RNK
    {
        get { return _nRNK; }
        set { _nRNK = value; }
    }
    /// <summary>
    /// Сумма текущего платежа
    /// </summary>
    public Decimal? S
    {
        get {
            HttpContext.Current.Trace.Write("returned S = " + Convert.ToString(_nS));
            return _nS; 
        }
        set { _nS = value; }
    }
    /// <summary>
    /// Сумма окончательного платежа
    /// </summary>
    public Decimal? S1
    {
        get { return _nS1; }
        set { _nS1 = value; }
    }
    /// <summary>
    /// наименованик клиента
    /// </summary>
    public String NMK
    {
        get
        {
            return (HasData ? _sNMK : "");
        }
        set { _sNMK = value; }
    }
    /// <summary>
    /// OKPO         клиента
    /// </summary>
    public String OKPO
    {
        get { return _sOKPO; }
        set { _sOKPO = value; }
    }
    /// <summary>
    /// адрес        клиента
    /// </summary>
    public String ADRES
    {
        get { return _sADRES; }
        set { _sADRES = value; }
    }
    /// <summary>
    /// код валюты   КД
    /// </summary>
    public Decimal? KV
    {
        get { return _nKV; }
        set { _nKV = value; }
    }
    /// <summary>
    /// ISO валюты   КД
    /// </summary>
    public String LCV
    {
        get { return _sLCV; }
        set { _sLCV = value; }
    }
    /// <summary>
    /// валютa       КД
    /// </summary>
    public String NAMEV
    {
        get { return _sNAMEV; }
        set { _sNAMEV = value; }
    }
    /// <summary>
    /// коп.валюты   КД
    /// </summary>
    public String UNIT
    {
        get { return _sUNIT; }
        set { _sUNIT = value; }
    }
    /// <summary>
    /// пол валюты   КД
    /// </summary>
    public String GENDER
    {
        get { return _sGENDER; }
        set { _sGENDER = value; }
    }
    /// <summary>
    /// Тек.Сумма осн.долга
    /// </summary>
    public Decimal? SS
    {
        get { return _nSS; }
        set { _nSS = value; }
    }
    /// <summary>
    /// дата завершения КД
    /// </summary>
    public DateTime? DAT4
    {
        get { return _dDAT4; }
        set { _dDAT4 = value; }
    }
    /// <summary>
    /// Оконч.Сумма осн.долга
    /// </summary>
    public Decimal? SS1
    {
        get { return _nSS1; }
        set { _nSS1 = value; }
    }
    /// <summary>
    /// По какую дату нач %
    /// </summary>
    public DateTime? DAT_SN
    {
        get { return _dDAT_SN; }
        set { _dDAT_SN = value; }
    }
    /// <summary>
    /// Сумма нач %
    /// </summary>
    public Decimal? SN
    {
        get { return _nSN; }
        set { _nSN = value; }
    }
    /// <summary>
    /// Оконч.Сумма проц.долга
    /// </summary>
    public Decimal? SN1
    {
        get { return _nSN1; }
        set { _nSN1 = value; }
    }
    /// <summary>
    /// По какую дату нач ком
    /// </summary>
    public DateTime? DAT_SK
    {
        get { return _dDAT_SK; }
        set { _dDAT_SK = value; }
    }
    /// <summary>
    /// сумма уже начисленной комиссии
    /// </summary>
    public Decimal? SK
    {
        get { return _nSK; }
        set { _nSK = value; }
    }
    /// <summary>
    /// Оконч.Сумма комис.долга
    /// </summary>
    public Decimal? SK1
    {
        get { return _nSK1; }
        set { _nSK1 = value; }
    }
    /// <summary>
    /// Вал комиссии
    /// </summary>
    public Decimal? KV_KOM
    {
        get { return _nKV_KOM; }
        set { _nKV_KOM = value; }
    }
    public String NAMEV_KOM
    {
        get { return _sNAMEV_KOM; }
        set { _sNAMEV_KOM = value; }
    }
    /// <summary>
    /// По какую дату нач пеня
    /// </summary>
    public DateTime? DAT_SP
    {
        get { return _dDAT_SP; }
        set { _dDAT_SP = value; }
    }
    /// <summary>
    /// сумма уже начисленной пени
    /// </summary>
    public Decimal? SP
    {
        get { return _nSP; }
        set { _nSP = value; }
    }
    /// <summary>
    /// валюта пени
    /// </summary>
    public Decimal? KV_SN8
    {
        get { return _KV_SN8; }
        set { _KV_SN8 = value; }
    }
    /// <summary>
    /// наименование валюты пени
    /// </summary>
    public String NAMEV_SN8
    {
        get { return _NAMEV_SN8; }
    }
    /// <summary>
    /// счета начисления пени
    /// </summary>
    public String SN8_NLS
    {
        get { return _sSN8_NLS; }
        set { _sSN8_NLS = value; }
    }
    /// <summary>
    /// счета начисления пени
    /// </summary>
    public String SD8_NLS
    {
        get { return _sSD8_NLS; }
        set { _sSD8_NLS = value; }
    }
    /// <summary>
    /// счет гашения
    /// </summary>
    public String MFOK
    {
        get { return _sMFOK; }
        set { _sMFOK = value; }
    }
    /// <summary>
    /// счет гашения
    /// </summary>
    public String NLSK
    {
        get { return _sNLSK; }
        set { _sNLSK = value; }
    }
    /// <summary>
    /// Сумма просроченного тела
    /// </summary>
    public Decimal? SSP
    {
        get { return _nSSP; }
        set { _nSSP = value; }
    }
    /// <summary>
    /// Сумма просроченных процентов
    /// </summary>
    public Decimal? SSPN
    {
        get { return _nSSPN; }
        set { _nSSPN = value; }
    }
    /// <summary>
    /// Сумма  просроченной комиссии
    /// </summary>
    public Decimal? SSPK
    {
        get { return _nSSPK; }
        set { _nSSPK = value; }
    }
    /// <summary>
    /// Дополнительная информация
    /// </summary>
    public String sAddInfo
    {
        get { return _sAddInfo; }
        set { _sAddInfo = value; }
    }
    /// <summary>
    /// Погашення КД готівк. 1-сплата по типам (SN8,SK0,SS) 0-у довіл порядк
    /// </summary>
    public Decimal nPayType
    {
        get { return _nPayType; }
    }
    # endregion

    # region Публичные методы
    public Decimal? FindCredit(String CC_ID, DateTime? DAT1)
    {
        this.CC_ID = CC_ID;
        this.DAT1 = DAT1;

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand com = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CREDIT"), con);

        if (con.State == ConnectionState.Closed) con.Open();
        try
        {
            // установка роли
            com.ExecuteNonQuery();

            // вычитка глобальных параметров
            com.CommandType = CommandType.Text;
            com.CommandText = "select nvl(min(p.val), 0) from params p where p.par = 'CC_PAY_T'";
            this._nPayType = Convert.ToDecimal(com.ExecuteScalar());

            HttpContext.Current.Trace.Write("this._nPayType = " + this._nPayType.ToString());

            // поиск договора
            com.CommandType = CommandType.StoredProcedure;
            com.CommandText = "get_info_upb_ext";
            com.Parameters.Clear();
            com.Parameters.Add("CC_ID_", OracleDbType.Varchar2, 100, this.CC_ID, ParameterDirection.Input);
            com.Parameters.Add("DAT1_", OracleDbType.Date, 100, this.DAT1, ParameterDirection.Input);
            com.Parameters.Add("nRet_", OracleDbType.Decimal, 100, this.RetCode, ParameterDirection.Output);
            com.Parameters.Add("sRet_", OracleDbType.Varchar2, 3000, "test".PadLeft(3000, 't'), ParameterDirection.InputOutput);
            com.Parameters.Add("RNK_", OracleDbType.Decimal, 100, this.RNK, ParameterDirection.Output);
            com.Parameters.Add("nS_", OracleDbType.Decimal, 100, this.S, ParameterDirection.Output);
            com.Parameters.Add("nS1_", OracleDbType.Decimal, 100, this.S1, ParameterDirection.Output);
            com.Parameters.Add("NMK_", OracleDbType.Varchar2, 100, this.NMK, ParameterDirection.Output);
            com.Parameters.Add("OKPO_", OracleDbType.Varchar2, 100, this.OKPO, ParameterDirection.Output);
            com.Parameters.Add("ADRES_", OracleDbType.Varchar2, 100, this.ADRES, ParameterDirection.Output);
            com.Parameters.Add("KV_", OracleDbType.Decimal, 100, this.KV, ParameterDirection.Output);
            com.Parameters.Add("LCV_", OracleDbType.Varchar2, 100, this.LCV, ParameterDirection.Output);
            com.Parameters.Add("NAMEV_", OracleDbType.Varchar2, 100, this.NAMEV, ParameterDirection.Output);
            com.Parameters.Add("UNIT_", OracleDbType.Varchar2, 100, this.UNIT, ParameterDirection.Output);
            com.Parameters.Add("GENDER_", OracleDbType.Varchar2, 100, this.GENDER, ParameterDirection.Output);
            com.Parameters.Add("nSS_", OracleDbType.Decimal, 100, this.SS, ParameterDirection.Output);
            com.Parameters.Add("DAT4_", OracleDbType.Date, 100, this.DAT4, ParameterDirection.Output);
            com.Parameters.Add("nSS1_", OracleDbType.Decimal, 100, this.SS1, ParameterDirection.Output);
            com.Parameters.Add("DAT_SN_", OracleDbType.Date, 100, this.DAT_SN, ParameterDirection.Output);
            com.Parameters.Add("nSN_", OracleDbType.Decimal, 100, this.SN, ParameterDirection.Output);
            com.Parameters.Add("nSN1_", OracleDbType.Decimal, 100, this.SN1, ParameterDirection.Output);
            com.Parameters.Add("DAT_SK_", OracleDbType.Date, 100, this.DAT_SK, ParameterDirection.Output);
            com.Parameters.Add("nSK_", OracleDbType.Decimal, 100, this.SK, ParameterDirection.Output);
            com.Parameters.Add("nSK1_", OracleDbType.Decimal, 100, this.SK1, ParameterDirection.Output);
            com.Parameters.Add("KV_KOM_", OracleDbType.Decimal, 100, this.KV_KOM, ParameterDirection.Output);
            com.Parameters.Add("DAT_SP_", OracleDbType.Date, 100, this.DAT_SP, ParameterDirection.Output);
            com.Parameters.Add("nSP_", OracleDbType.Decimal, 100, this.SP, ParameterDirection.Output);
            com.Parameters.Add("KV_SN8", OracleDbType.Decimal, 100, this.KV_SN8, ParameterDirection.Output);
            com.Parameters.Add("SN8_NLS", OracleDbType.Varchar2, 100, this.SN8_NLS, ParameterDirection.Output);
            com.Parameters.Add("SD8_NLS", OracleDbType.Varchar2, 100, this.SD8_NLS, ParameterDirection.Output);
            com.Parameters.Add("MFOK_", OracleDbType.Varchar2, 100, this.MFOK, ParameterDirection.Output);
            com.Parameters.Add("NLSK_", OracleDbType.Varchar2, 100, this.NLSK, ParameterDirection.Output);
            com.Parameters.Add("nSSP_", OracleDbType.Decimal, 100, this.SSP, ParameterDirection.Output);
            com.Parameters.Add("nSSPN_", OracleDbType.Decimal, 100, this.SSPN, ParameterDirection.Output);
            com.Parameters.Add("nSSPK_", OracleDbType.Decimal, 100, this.SSPK, ParameterDirection.Output);
            com.Parameters.Add("sAddInfo_", OracleDbType.Varchar2, 3000, "test".PadLeft(3000, 't'), ParameterDirection.InputOutput);
            com.ExecuteNonQuery();

            this.RetCode = (com.Parameters["nRet_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nRet_"].Value).Value : (Decimal?)null);
            this.RetText = (com.Parameters["sRet_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["sRet_"].Value).Value : (String)null);
            this.RNK = (com.Parameters["RNK_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["RNK_"].Value).Value : (Decimal?)null);

            this.S = (com.Parameters["nS_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nS_"].Value).Value : (Decimal?)null);
            HttpContext.Current.Trace.Write("com.Parameters[nS_].Value = " + Convert.ToString(com.Parameters["nS_"].Value));
            HttpContext.Current.Trace.Write("com.Parameters[nS_].Status = " + Convert.ToString(com.Parameters["nS_"].Status));
            HttpContext.Current.Trace.Write("seted S = " + Convert.ToString(this.S));
            
            this.S1 = (com.Parameters["nS1_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nS1_"].Value).Value : (Decimal?)null);
            this.NMK = (com.Parameters["NMK_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["NMK_"].Value).Value : (String)null);
            this.OKPO = (com.Parameters["OKPO_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["OKPO_"].Value).Value : (String)null);
            this.ADRES = (com.Parameters["ADRES_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["ADRES_"].Value).Value : (String)null);
            this.KV = (com.Parameters["KV_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["KV_"].Value).Value : (Decimal?)null);
            this.LCV = (com.Parameters["LCV_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["LCV_"].Value).Value : (String)null);
            this.NAMEV = (com.Parameters["NAMEV_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["NAMEV_"].Value).Value : (String)null);
            this.UNIT = (com.Parameters["UNIT_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["UNIT_"].Value).Value : (String)null);
            this.GENDER = (com.Parameters["GENDER_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["GENDER_"].Value).Value : (String)null);
            this.SS = (com.Parameters["nSS_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSS_"].Value).Value : (Decimal?)null);
            this.DAT4 = (com.Parameters["DAT4_"].Status == OracleParameterStatus.Success ? ((OracleDate)com.Parameters["DAT4_"].Value).Value : (DateTime?)null);
            this.SS1 = (com.Parameters["nSS1_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSS1_"].Value).Value : (Decimal?)null);
            this.DAT_SN = (com.Parameters["DAT_SN_"].Status == OracleParameterStatus.Success ? ((OracleDate)com.Parameters["DAT_SN_"].Value).Value : (DateTime?)null);
            this.SN = (com.Parameters["nSN_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSN_"].Value).Value : (Decimal?)null);
            this.SN1 = (com.Parameters["nSN1_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSN1_"].Value).Value : (Decimal?)null);
            this.DAT_SK = (com.Parameters["DAT_SK_"].Status == OracleParameterStatus.Success ? ((OracleDate)com.Parameters["DAT_SK_"].Value).Value : (DateTime?)null);
            this.SK = (com.Parameters["nSK_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSK_"].Value).Value : (Decimal?)null);
            this.SK1 = (com.Parameters["nSK1_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSK1_"].Value).Value : (Decimal?)null);
            this.KV_KOM = (com.Parameters["KV_KOM_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["KV_KOM_"].Value).Value : (Decimal?)null);
            this.DAT_SP = (com.Parameters["DAT_SP_"].Status == OracleParameterStatus.Success ? ((OracleDate)com.Parameters["DAT_SP_"].Value).Value : (DateTime?)null);
            this.SP = (com.Parameters["nSP_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSP_"].Value).Value : (Decimal?)null);
            this.KV_SN8 = (com.Parameters["KV_SN8"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["KV_SN8"].Value).Value : (Decimal?)null);
            this.SN8_NLS = (com.Parameters["SN8_NLS"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["SN8_NLS"].Value).Value : (String)null);
            this.SD8_NLS = (com.Parameters["SD8_NLS"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["SD8_NLS"].Value).Value : (String)null);
            this.MFOK = (com.Parameters["MFOK_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["MFOK_"].Value).Value : (String)null);
            this.NLSK = (com.Parameters["NLSK_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["NLSK_"].Value).Value : (String)null);
            this.SSP = (com.Parameters["nSSP_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSSP_"].Value).Value : (Decimal?)null);
            this.SSPN = (com.Parameters["nSSPN_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSSPN_"].Value).Value : (Decimal?)null);
            this.SSPK = (com.Parameters["nSSPK_"].Status == OracleParameterStatus.Success ? ((OracleDecimal)com.Parameters["nSSPK_"].Value).Value : (Decimal?)null);
            this.sAddInfo = (com.Parameters["sAddInfo_"].Status == OracleParameterStatus.Success ? ((OracleString)com.Parameters["sAddInfo_"].Value).Value : (String)null);

            // наименование валюты комиссии
            com.CommandType = CommandType.Text;
            com.CommandText = "select name from tabval tv where tv.kv = :pkv";
            com.Parameters.Clear();
            com.Parameters.Add("pkv", OracleDbType.Decimal, this.KV_KOM, ParameterDirection.Input);

            this._sNAMEV_KOM = Convert.ToString(com.ExecuteScalar());

            // наименование валюты пени
            com.CommandType = CommandType.Text;
            com.CommandText = "select name from tabval tv where tv.kv = :pkv";
            com.Parameters.Clear();
            com.Parameters.Add("pkv", OracleDbType.Decimal, this.KV_SN8, ParameterDirection.Input);

            this._NAMEV_SN8 = Convert.ToString(com.ExecuteScalar());
        }
        finally
        {
            con.Close();
        }

        this._HasData = (this.RetCode == 0);

        return this.RetCode;
    }
    public void ClearData()
    {
        this._HasData = false;
    }
    # endregion

    # region Конструкторы
    public cRePayment()
    {
    }
    # endregion
}