using System;
using System.Collections.Generic;
//using System.Linq;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using Bars.Oracle;
using BarsWeb.Core.Logger;
using Bars.Exception;

public partial class DpuViddDetails : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DpuViddDetails()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Boolean newVidd = (Request["vidd"] == null ? true : false);

            FillDropDownLists(newVidd);

            if (newVidd)
            {
                //
                // створення нового виду депозиту
                //

                // Валюта
//              tbCurrencyId.Text = "980";
//              tbCurrencyCode.Text = "UAH";
//              ddlCurrencies.SelectedValue = "980";

                // Строковість депозиту
//              tbPeriodId.Text = "1";
//              ddlPeriods.SelectedValue = "1";

                // База нарахування
                tbBaseYId.Text = "0";
                ddlBaseY.SelectedValue = "0";

                // Періодичність нарахування
                tbClcIntFrqId.Text = "1";
                ddlClcIntFrqs.SelectedValue = "1";

                // Метод нарахування
                tbMethodId.Text = "0";
                ddlMethods.SelectedValue = "0";

                // Періодичність сплати
                tbFrequencyId.Text = "5";
                ddlFrequencies.SelectedValue = "5";

                // Штраф за дострокове вилучення
                tbPenaltyId.Text = "1";
                ddlPenalties.SelectedValue = "1";

                // Тип терміну
                rbTermFixed.Checked = true;

                // Граничні терміни
                tbTermMinMonths.Text = "1";
                tbTermMinDays.Text = "0";

                tbTermMaxMonths.Text = "12";
                tbTermMaxDays.Text = "0";

                //
                rbStandard.Checked = true;

                tbOperationCode.Text = "DU%";
            }
            else
            {
                // 
                // редагування/перегляд виду депозиту
                //

                // Вид депозиту (DPU_VIDD.VIDD)
                Int32 vidd_id;

                try
                {
                    vidd_id = Convert.ToInt32(Request.QueryString["vidd"]);
                }
                finally
                {
                    _dbLogger.Info("DpuViddDetails (vidd=" + Request.QueryString["vidd"]+")", "udeposit");
                }

                // Населяємо форму
                tbViddId.Text = Request.QueryString["vidd"];

                GetViddParams(vidd_id);

                ddlTypes.SelectedValue = tbTypeId.Text;
                ddlCurrencies.SelectedValue = tbCurrencyId.Text;
                ddlNbsDepName.SelectedValue = tbNbsDepNum.Text;
                ddlPeriods.SelectedValue = tbPeriodId.Text;
                ddlBaseY.SelectedValue = tbBaseYId.Text;
                ddlClcIntFrqs.SelectedValue = tbClcIntFrqId.Text;
                ddlMethods.SelectedValue = tbMethodId.Text;
                ddlBaseRates.SelectedValue = tbBaseRateId.Text;
                ddlFrequencies.SelectedValue = tbFrequencyId.Text;
                ddlPenalties.SelectedValue = tbPenaltyId.Text;
                ddlExnMethods.SelectedValue = tbExnMethodId.Text;
                ddlTemplates.SelectedValue = tbTemplateId.Text;

                if (Request["mode"] == "1")
                {
                    // редагування
                    
                    #region unchangeable

                    // tbTypeId.ReadOnly = true;
                    ddlTypes.Enabled = false;

                    tbCurrencyId.ReadOnly = true;
                    ddlCurrencies.Enabled = false;

                    ddlPeriods.Enabled = false;

                    //tbNbsDepNum.ReadOnly = true;
                    ddlNbsDepName.Enabled = false;

                    rbStandard.Enabled = false;
                    rbLine.Enabled = false;
                    rbLine8.Enabled = false;

                    #endregion

                    tbBaseYId.ReadOnly = true;
                    tbBaseYId.BackColor = Color.LightGray;

                    tbMethodId.ReadOnly = true;
                    tbMethodId.BackColor = Color.LightGray;

                    tbBaseRateId.ReadOnly = true;
                    tbBaseRateId.BackColor = Color.LightGray;

                    tbOperationName.Enabled = false;
                    tbBaseRateId.BackColor = Color.LightGray;
                    
                    if (cbComproc.Checked)
                        ddlFrequencies.Enabled = false;

                    tbExnMethodId.ReadOnly = true;
                    tbExnMethodId.BackColor = Color.LightGray;

                    tbTemplateId.BackColor = Color.LightGray;
                }
                else
                {
                    // перегляд
                    foreach (Control ctrl in frmDpuViddDeails.Controls)
                    {
                        if (ctrl is TextBox)
                            ((TextBox)ctrl).Enabled = false;
                        else if (ctrl is DropDownList)
                            ((DropDownList)ctrl).Enabled = false;
                        else if (ctrl is CheckBox)
                            ((CheckBox)ctrl).Enabled = false;
                        else if (ctrl is HtmlInputButton)
                            ((HtmlInputButton)ctrl).Disabled = true;
                        else if (ctrl is HtmlInputText)
                            ((HtmlInputText)ctrl).Disabled = true;
                        else if (ctrl is HtmlInputCheckBox)
                            ((HtmlInputCheckBox)ctrl).Disabled = true;
                        else if (ctrl is Button)
                            ((Button)ctrl).Enabled = false;
                    }
                    
                    // Вихід
                    btnExit.Enabled = true;
                }
            }
        }
    }

    /// <summary>
    /// retrieve information (vidd parameters)
    /// </summary>
    /// <param name="p_vidd_id"></param>
    private void GetViddParams(Int32 p_vidd_id)
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = @"SELECT v.type_id, v.name, v.dpu_code 
                                        , tbv.kv, tbv.lcv
                                        , v.dpu_type, v.term_type, v.term_min, v.term_max
                                        , v.bsd, psd.name, v.bsn, psn.name
                                        , v.min_summ/100, v.max_summ/100, v.limit/100
                                        , v.fl_add, v.fl_extend, v.fl_autoextend
                                        , v.basey, v.metr, v.br_id, tts.tt, tts.name
                                        , v.freq_v, id_stop, v.penya
                                        , v.comproc, v.IRVK, v.shablon, v.comments, v.FREQ_N
                                        , case 
                                            when exists ( select 0 from DPU_DEAL where vidd = v.vidd )
                                            then 1
                                            else 0
                                          end as HAS_AGRM
                                     FROM bars.dpu_vidd    v
                                     JOIN bars.tabval      tbv
                                       ON ( tbv.kv = v.kv   )
                                     JOIN bars.ps          psd
                                       ON ( psd.nbs = v.bsd )
                                     JOIN bars.ps          psn
                                       ON ( psn.nbs = v.bsn )
                                     LEFT
                                     JOIN bars.tts
                                       ON ( tts.tt = v.tt )
                                    WHERE v.vidd = :vidd_id";

            cmdSQL.Parameters.Add("vidd_id", OracleDbType.Int32, p_vidd_id, ParameterDirection.Input);

            OracleDataReader rdrSQL = cmdSQL.ExecuteReader();

            if (rdrSQL.Read())
            {
                #region DATABIND

                // type_id
                if (!rdrSQL.IsDBNull(0))
                    tbTypeId.Text = rdrSQL.GetInt32(0).ToString();

                // vidd_name
                if (!rdrSQL.IsDBNull(1))
                    tbViddName.Text = rdrSQL.GetString(1);

                // dpu_code
                if (!rdrSQL.IsDBNull(2))
                    tbViddCode.Text = rdrSQL.GetString(2);

                // kv
                if (!rdrSQL.IsDBNull(3))
                    tbCurrencyId.Text = rdrSQL.GetOracleDecimal(3).ToString();

                // lcv
                if (!rdrSQL.IsDBNull(4))
                    tbCurrencyCode.Text = rdrSQL.GetString(4);

                // dpu_type
                if (!rdrSQL.IsDBNull(5))
                    tbPeriodId.Text = rdrSQL.GetOracleDecimal(5).ToString();

                // term_type
                if (!rdrSQL.IsDBNull(6))
                {
                    Int16 period = rdrSQL.GetInt16(6);

                    if (period == 1)
                    {
                        // фікований
                        rbTermFixed.Checked = true;
                        rbTermRange.Checked = false;
                        tbTermMaxMonths.Enabled = false;
                        tbTermMaxDays.Enabled = false;
                        TermType.Value = "1";
                    }

                    if (period == 2)
                    {
                        // діапазон
                        rbTermFixed.Checked = false;
                        rbTermRange.Checked = true;
                        tbTermMaxMonths.Enabled = true;
                        tbTermMaxDays.Enabled = true;
                        TermType.Value = "2";
                    }
                }

                // term_min
                if (!rdrSQL.IsDBNull(7))
                {
                    Decimal term_min = rdrSQL.GetDecimal(7);

                    tbTermMinMonths.Text = Convert.ToString(Math.Truncate(term_min));
                    tbTermMinDays.Text = Convert.ToString(Math.Truncate((term_min - Math.Truncate(term_min)) * 10000));
                }

                // term_max
                if (!rdrSQL.IsDBNull(8))
                {
                    Decimal term_max = rdrSQL.GetDecimal(8);

                    tbTermMaxMonths.Text = Convert.ToString(Math.Truncate(term_max));
                    tbTermMaxDays.Text = Convert.ToString(Math.Truncate((term_max - Math.Truncate(term_max)) * 10000));
                }

                // bsd
                if (!rdrSQL.IsDBNull(9))
                    tbNbsDepNum.Text = rdrSQL.GetString(9);

                //// bsd_name
                //if (!rdrSQL.IsDBNull(10))
                //{
                //    ddlNbsDepName.Items.Add(new ListItem(rdrSQL.GetString(10), tbNbsDepNum.Text, true));
                //}

                // bsn
                if (!rdrSQL.IsDBNull(11))
                    tbNbsIntNum.Text = rdrSQL.GetString(11);

                // bsn_name
                if (!rdrSQL.IsDBNull(12))
                    tbNbsIntName.Text = rdrSQL.GetString(12);

                // min_summ
                if (!rdrSQL.IsDBNull(13))
                    tbMinAmount.Value = rdrSQL.GetOracleDecimal(13).ToString();

                // max_summ
                if (!rdrSQL.IsDBNull(14))
                    tbMaxAmount.Value = rdrSQL.GetOracleDecimal(14).ToString();

                // limit
                if (!rdrSQL.IsDBNull(15))
                    tbMinAmntReplenishment.Value = rdrSQL.GetOracleDecimal(15).ToString();

                // fl_add
                if (!rdrSQL.IsDBNull(16))
                {
                    cbReplenishable.Checked = (rdrSQL.GetOracleDecimal(16) == 1 ? true : false);
                    tbMinAmntReplenishment.Disabled = (rdrSQL.GetOracleDecimal(16) == 1 ? true : false);
                }

                // fl_extend
                if (!rdrSQL.IsDBNull(17))
                {
                    Int16 line = rdrSQL.GetInt16(17);

                    rbStandard.Checked = (line == 0 ? true : false); // Стандарт
                    rbLine.Checked = (line == 1 ? true : false); // Деп. лінія
                    rbLine8.Checked = (line == 2 ? true : false); // Деп. лінія на 8 класі
                }

                // fl_autoextend
                if (!rdrSQL.IsDBNull(18))
                {
                    cbProlongation.Checked = (rdrSQL.GetOracleDecimal(18) == 1 ? true : false);
                    Prolongation.Value = (rdrSQL.GetOracleDecimal(27) == 1 ? "1" : "0");
                    ddlExnMethods.Enabled = (rdrSQL.GetOracleDecimal(18) == 1 ? true : false);
                }

                // basey
                if (!rdrSQL.IsDBNull(19))
                    tbBaseYId.Text = rdrSQL.GetOracleDecimal(19).ToString();

                // metr
                if (!rdrSQL.IsDBNull(20))
                    tbMethodId.Text = rdrSQL.GetOracleDecimal(20).ToString();

                // br_id
                if (!rdrSQL.IsDBNull(21))
                    tbBaseRateId.Text = rdrSQL.GetOracleDecimal(21).ToString();

                // tt
                if (!rdrSQL.IsDBNull(22))
                    tbOperationCode.Text = rdrSQL.GetString(22);

                // tt_name
                if (!rdrSQL.IsDBNull(23))
                    tbOperationName.Text = rdrSQL.GetString(23);

                // freq_v
                if (!rdrSQL.IsDBNull(24))
                    tbFrequencyId.Text = rdrSQL.GetOracleDecimal(24).ToString();

                // id_stop
                if (!rdrSQL.IsDBNull(25))
                    tbPenaltyId.Text = rdrSQL.GetOracleDecimal(25).ToString();

                // penya
                if (!rdrSQL.IsDBNull(26))
                    tbFine.Value = rdrSQL.GetOracleDecimal(26).ToString();

                // comproc
                if (!rdrSQL.IsDBNull(27))
                {
                    cbComproc.Checked = (rdrSQL.GetOracleDecimal(27) == 1 ? true : false);
                    Comproc.Value = (rdrSQL.GetOracleDecimal(27) == 1 ? "1" : "0");
                }

                // irrevocable
                if (!rdrSQL.IsDBNull(28))
                {
                    cbIrrevocable.Checked = (rdrSQL.GetOracleDecimal(28) == 1 ? true : false);
                    Irrevocable.Value = (rdrSQL.GetOracleDecimal(28) == 1 ? "1" : "0");
                    ddlPenalties.Enabled = (rdrSQL.GetOracleDecimal(28) == 1 ? false : true);
                }

                // shablon
                if (!rdrSQL.IsDBNull(29))
                    tbTemplateId.Text = rdrSQL.GetString(29);

                // comments
                if (!rdrSQL.IsDBNull(30))
                    tbComment.Text = rdrSQL.GetString(30);
                
                // FREQ_N
                if (!rdrSQL.IsDBNull(31))
                {
                    tbClcIntFrqId.Text = rdrSQL.GetOracleDecimal(31).ToString();
                }

                // HAS_AGRM
                if (!rdrSQL.IsDBNull(32))
                {
                    HasAgrm.Value = (rdrSQL.GetOracleDecimal(32) == 1 ? "1" : "0");
                }

                #endregion
            }
            else
            { 
                String script  = "bars.ui.alert({ text: 'Інформація про вид депозиту " + p_vidd_id.ToString() + " не знайдена!' })";
                ClientScript.RegisterStartupScript(this.GetType(), "Error", script, true);
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }

    /// <summary>
    /// Населення випадаючих списків
    /// </summary>
    protected void FillDropDownLists(Boolean NewSbTp)
    {
        try
        {
            InitOraConnection();

            // Тип депозиту
            ddlTypes.DataSource = SQL_SELECT_dataset("select TYPE_ID, TYPE_NAME from DPU_TYPES where FL_ACTIVE=1 order by SORT_ORD");
            // IifS(  ( (sSegmentExists = 'Y') AND ( SalStrTrimX(strParF) != '' ) ), " AND SEGMENT = " || strParF, " " )
            ddlTypes.DataBind();

            // Валюта
            ddlCurrencies.DataSource = SQL_SELECT_dataset("select KV as CURRENCY_ID, NAME as CURRENCY_NAME from bars.TABVAL where D_CLOSE IS NULL AND COUNTRY IS NOT NULL order by KV desc");
            ddlCurrencies.DataBind();

            // Строковість депозиту
            ddlPeriods.Items.Add(new ListItem("До запитання", "0", true));
            ddlPeriods.Items.Add(new ListItem("Короткостроковий", "1", true));
            ddlPeriods.Items.Add(new ListItem("Довгостроковий", "2", true));

            // Балансовий рахунок депозиту
            if (!NewSbTp)
            {
                ddlNbsDepName.DataSource = SQL_SELECT_dataset("select NBS_CODE, NBS_NAME from BARS.V_DPU_NBS");
                ddlNbsDepName.DataBind();
            }

            // База нарахування
            ddlBaseY.DataSource = SQL_SELECT_dataset("select BASEY as BASE_ID, NAME as BASE_NAME from BARS.BASEY order by 1");
            ddlBaseY.DataBind();

            // Метод нарахування
            ddlMethods.DataSource = SQL_SELECT_dataset("select METR as METHOD_ID, NAME as METHOD_NAME from BARS.INT_METR order by 1");
            ddlMethods.DataBind();

            // Базова відсоткова ставка
            ddlBaseRates.DataSource = SQL_SELECT_dataset("select BR_ID as BRATE_ID, NAME as BRATE_NAME from BARS.BRATES order by 1");
            ddlBaseRates.DataBind();
            ddlBaseRates.Items.Insert(0, new ListItem("", "", true));

            // Періодичність нарахування
            ddlClcIntFrqs.DataSource = SQL_SELECT_dataset("select FREQ as FREQ_ID, NAME as FREQ_NAME from BARS.FREQ order by 1");
            ddlClcIntFrqs.DataBind();

            // Періодичність сплати
            ddlFrequencies.DataSource = SQL_SELECT_dataset("select FREQ as FREQ_ID, NAME as FREQ_NAME from BARS.FREQ order by 1");
            ddlFrequencies.DataBind();

            // Штраф за дострокове вилучення
            ddlPenalties.DataSource = SQL_SELECT_dataset("select ID as STOP_ID, NAME as STOP_NAME from BARS.DPT_STOP where MOD_CODE = 'DPU' or MOD_CODE IS NULL order by 1");
            ddlPenalties.DataBind();

            // Метод переоформлення
            ddlExnMethods.DataSource = SQL_SELECT_dataset("select METHOD as METHOD_ID, NAME as METHOD_NAME from BARS.DPT_EXTENSION_METHOD order by 1");
            ddlExnMethods.DataBind();
            ddlExnMethods.Items.Insert(0, new ListItem("", "", true));

            // Шаблон договору
            ddlTemplates.DataSource = SQL_SELECT_dataset(@"select ID as TEMPLATE_ID, NAME as TEMPLATE_NAME 
                                                             from BARS.DOC_SCHEME 
                                                            where ID in ( SELECT r.id FROM doc_root r, cc_vidd v WHERE r.vidd = v.vidd AND v.custtype = 2 AND v.tipd = 2) ORDER BY 1" );
            ddlTemplates.DataBind();

            if (NewSbTp)
            {
                ddlTypes.Items.Insert(0, new ListItem("", "", true));
                ddlCurrencies.Items.Insert(0, new ListItem("", "", true));
                ddlPeriods.Items.Insert(0, new ListItem("", "", true));
                ddlTemplates.Items.Insert(0, new ListItem("", "", true));
            }
            
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    /// <summary>
    /// Реєстрація нової картки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Decimal? vidd_id = null;
        OracleString error_msg = null;

        Decimal term_tp = 0;
        Decimal term_min = 0;
        Decimal term_max = 0;
        Decimal amnt_min = 0;
        Decimal amnt_max = 0;
        Decimal? amnt_add = null;
        Decimal? brate_id = null;
        Decimal? fine = null;
        Decimal? exn_mth = null;

        term_tp = Convert.ToDecimal(TermType.Value);

        if (!String.IsNullOrEmpty(tbTermMinMonths.Text))
        {
            term_min += Convert.ToDecimal(tbTermMinMonths.Text);
        }
        
        if (!String.IsNullOrEmpty(tbTermMinDays.Text))
        {
            term_min += Convert.ToDecimal(tbTermMinDays.Text)/ 10000;
        }
        
        // rbTermRange.Checked
        if ( term_tp == 2 )
        {
            if (!String.IsNullOrEmpty(tbTermMaxMonths.Text))
            {
                term_max += Convert.ToDecimal(tbTermMaxMonths.Text);
            }

            if (!String.IsNullOrEmpty(tbTermMaxDays.Text))
            {
                term_max += Convert.ToDecimal(tbTermMaxDays.Text) / 10000;
            }
        }
        else
        {
            term_max = term_min;
        }

        // amnt_min
        if (!String.IsNullOrEmpty(tbMinAmount.Value))
        {
            amnt_min = Convert.ToDecimal(tbMinAmount.Value) * 100;
        }

        // amnt_max
        if (!String.IsNullOrEmpty(tbMaxAmount.Value))
        {
            amnt_max = Convert.ToDecimal(tbMaxAmount.Value) * 100;
        }

        // amnt_add
        if (!String.IsNullOrEmpty(tbMinAmntReplenishment.Value))
        {
            amnt_add = Convert.ToDecimal(tbMinAmntReplenishment.Value) * 100;
        }

        // Код базової ставки
        if (!String.IsNullOrEmpty(tbBaseRateId.Text))
        {
            brate_id =  Convert.ToDecimal(tbBaseRateId.Text);
        }

        // Пеня
        if (!String.IsNullOrEmpty(tbFine.Value))
        {
            fine = Convert.ToDecimal(tbFine.Value) * 100;
        }

        // Метод переоформлення
        if (!String.IsNullOrEmpty(tbExnMethodId.Text))
        {
            exn_mth = Convert.ToDecimal(tbExnMethodId.Text);
        }

        if (Request["vidd"] != null)
        {
            vidd_id = Convert.ToInt32(Request.QueryString["vidd"]);
        }

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.BindByName = true;

            if (vidd_id.HasValue)
            {
                // update
                cmd.CommandText = "DPU_UTILS.UPD_SUBTYPE";

                // Input
                cmd.Parameters.Add("p_sbtp_id", OracleDbType.Decimal, vidd_id, ParameterDirection.Input);
            }
            else
            {
                // create new one
                cmd.CommandText = "DPU_UTILS.ADD_SUBTYPE";
                
                Decimal line = ( rbStandard.Checked ? 0 : (rbLine8.Checked ? 2 : 1) );

                // Input
                cmd.Parameters.Add("p_tp_id", OracleDbType.Decimal, Convert.ToDecimal(tbTypeId.Text), ParameterDirection.Input);
                cmd.Parameters.Add("p_ccy_id", OracleDbType.Decimal, Convert.ToDecimal(tbCurrencyId.Text), ParameterDirection.Input);
                cmd.Parameters.Add("p_nbs_dep", OracleDbType.Varchar2, tbNbsDepNum.Text, ParameterDirection.Input);
                cmd.Parameters.Add("p_nbs_int", OracleDbType.Varchar2, tbNbsIntNum.Text, ParameterDirection.Input);
                cmd.Parameters.Add("p_prd_tp_id", OracleDbType.Decimal, Convert.ToDecimal(tbPeriodId.Text), ParameterDirection.Input);
                cmd.Parameters.Add("p_line", OracleDbType.Decimal, line, ParameterDirection.Input);

                cmd.Parameters.Add("p_basey", OracleDbType.Decimal, Convert.ToDecimal(tbBaseYId.Text), ParameterDirection.Input);
                cmd.Parameters.Add("p_metr", OracleDbType.Decimal, Convert.ToDecimal(tbMethodId.Text), ParameterDirection.Input);

                // Output
                cmd.Parameters.Add("p_sbtp_id", OracleDbType.Decimal, vidd_id, ParameterDirection.Output);
            }
            
            // Input
            cmd.Parameters.Add("p_sbtp_code", OracleDbType.Varchar2, tbViddCode.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_sbtp_nm", OracleDbType.Varchar2, tbViddName.Text, ParameterDirection.Input);

            cmd.Parameters.Add("p_term_tp", OracleDbType.Decimal, term_tp, ParameterDirection.Input);
            cmd.Parameters.Add("p_term_min", OracleDbType.Decimal, term_min, ParameterDirection.Input);
            cmd.Parameters.Add("p_term_max", OracleDbType.Decimal, term_max, ParameterDirection.Input);
            cmd.Parameters.Add("p_amnt_add", OracleDbType.Decimal, amnt_add, ParameterDirection.Input);

            cmd.Parameters.Add("p_amnt_min", OracleDbType.Decimal, amnt_min, ParameterDirection.Input);
            cmd.Parameters.Add("p_amnt_max", OracleDbType.Decimal, amnt_max, ParameterDirection.Input);

            cmd.Parameters.Add("p_longation", OracleDbType.Decimal, Convert.ToDecimal(Prolongation.Value), ParameterDirection.Input);
            cmd.Parameters.Add("p_replenish", OracleDbType.Decimal, (cbReplenishable.Checked ? 1 : 0), ParameterDirection.Input);
            cmd.Parameters.Add("p_comproc", OracleDbType.Decimal, Convert.ToDecimal(Comproc.Value), ParameterDirection.Input);
            cmd.Parameters.Add("p_irvcbl", OracleDbType.Decimal, Convert.ToDecimal(Irrevocable.Value), ParameterDirection.Input);
            cmd.Parameters.Add("p_freq", OracleDbType.Decimal, Convert.ToDecimal(tbFrequencyId.Text), ParameterDirection.Input);
            cmd.Parameters.Add("p_br_id", OracleDbType.Decimal, brate_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_tt", OracleDbType.Varchar2, tbOperationCode.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_pny_id", OracleDbType.Decimal, Convert.ToDecimal(tbPenaltyId.Text), ParameterDirection.Input);
            cmd.Parameters.Add("p_fine", OracleDbType.Decimal, fine, ParameterDirection.Input);
            cmd.Parameters.Add("p_exn_mth", OracleDbType.Decimal, exn_mth, ParameterDirection.Input);
            cmd.Parameters.Add("p_tpl_id", OracleDbType.Varchar2, tbTemplateId.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, tbComment.Text, ParameterDirection.Input);   

            // Output
            cmd.Parameters.Add("p_err_msg", OracleDbType.Varchar2, error_msg, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            if (!vidd_id.HasValue)
            {
                vidd_id = ((OracleDecimal)cmd.Parameters["p_sbtp_id"].Value).Value;
            }

            String script = null;

            error_msg = (OracleString)cmd.Parameters["p_err_msg"].Value;

            if ( error_msg.IsNull )
            {
                // без помилки
                if (Request["vidd"] == null)
                {
                    script = "bars.ui.alert({ text: 'Вид депозиту успішно створено!' }); ";
                    _dbLogger.Info("Користувач створив новий вид депозиту #" + Convert.ToString(vidd_id), "udeposit");
                }
                else
                {
                    script = "bars.ui.alert({ text: 'Параметри виду депозиту " + Convert.ToString(vidd_id) + " оновлено!' }); ";
                    _dbLogger.Info("Користувач змінив параметри вид депозиту #" + Convert.ToString(vidd_id), "udeposit");
                }

                script = "location.replace('/barsroot/udeposit_admin/DpuViddDetails.aspx?mode=1&vidd=" + Convert.ToString(vidd_id) + "'); " + script;
            }
            else
            {
                // з помилкою
                if (Request["vidd"] == null)
                {
                    script = "bars.ui.alert({ text: 'Помилка при створенні виду депозиту:" + error_msg.ToString() + "' }); ";
                }
                else
                {
                    script = "bars.ui.alert({ text: 'Помилка при оновленні параметрів виду депозиту:" + error_msg.ToString() + "' }); ";
                }
            }
            
            ClientScript.RegisterStartupScript( this.GetType(), "Done", script, true );
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

    }
}