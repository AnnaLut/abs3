using System;
using System.Web.UI;
using Oracle.DataAccess.Client;


public partial class finmon_docparams : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            errLbl.Text = "";
            FillInfo();

            lbTitle.Text = "Параметри фінансового моніторингу, реф " + Request["ref"];
        }
    }

    protected void FillInfo()
    {
        decimal p_ref = Convert.ToDecimal(Request["ref"]);
        object p_rnk_a = null;
        string p_nls_a = null;
        string p_okpo_a = null;
        object p_rnk_b = null;
        string p_nls_b = null;
        string p_okpo_b = null;
        string p_kv_a = null;
        string p_kv_b = null;

        string l_rnk_a = null;
        string l_okpo_a = null;
        string l_nmk_a = null;

        string l_rnk_b = null;
        string l_okpo_b = null;
        string l_nmk_b = null;
        decimal p_mode;
        string l_status = null;
        string l_cur_mfo = null;
        string l_mode_constr = null;

        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("p_ref", DB_TYPE.Varchar2, p_ref, DIRECTION.Input);
            object[] res = SQL_SELECT_reader(@"select v.nlsa, 
                                                 v.nlsb,
                                                 to_char(v.datd,'dd.mm.yyyy') datd,
                                                 v.nazn,
                                                 v.lcv,
                                                 v.s/100 s,
                                                 v.mfoa,
                                                 v.mfob,
                                                 v.nam_a,
                                                 v.nam_b,
                                                 v.rnk_a,
                                                 v.rnk_b,
                                                 v.id_a,
                                                 v.id_b,
                                                 v.kv,
                                                 v.kv2,
                                                 case when f_ourmfo=v.mfoa and v.mfoa!=v.mfob then nvl(v.opr_vid1,'999999999999999') when f_ourmfo=v.mfob and v.mfoa!=v.mfob then nvl(v.opr_vid1,'999999999999998') else nvl(v.opr_vid1,'999999999999999') end opr_vid1,
                                                 nvl(v.opr_vid2,'0000') opr_vid2,
                                                 v.comm_vid2,
                                                 nvl(v.opr_vid3,'000') opr_vid3,
                                                 v.comm_vid3,
                                                 v.monitor_mode,
                                                 k2.name,
                                                 k3.name,
                                                 v.status,
                                                 f_ourmfo,
                                                 case when f_ourmfo=v.mfoa and v.mfoa!=v.mfob then 'A' when f_ourmfo=v.mfob and v.mfoa!=v.mfob then 'B' else 'BOTH' end as MD,
                                                 v.fv2_agg,
                                                 v.fv3_agg
                                               from v_finmon_que_oper v,
                                                    k_dfm02 k2,
                                                    k_dfm03 k3
                                               where v.ref=:p_ref
                                                 and nvl(v.opr_vid2,'0000') = k2.code
                                                 and nvl(v.opr_vid3,'000') = k3.code");

            if (!string.IsNullOrEmpty(Request["id"]))
            {
                MandatoryCodesTextBox.Text = Convert.ToString(res[27]);  //коды обяз. мониторинга
                InCodesTextBox.Text = Convert.ToString(res[28]); //коды внутренн. мониторинга
            }
            if (null != res)
            {
                tbNLSA.Text = Convert.ToString(res[0]);
                tbNLSB.Text = Convert.ToString(res[1]);
                tbDocDat.Text = Convert.ToString(res[2]);
                tbNazn.Text = Convert.ToString(res[3]);
                tbVal.Text = Convert.ToString(res[4]);
                tbSum.Text = Convert.ToString(res[5]);
                tbMfoA.Text = Convert.ToString(res[6]);
                tbMfoB.Text = Convert.ToString(res[7]);
                tbNameNLSA.Text = Convert.ToString(res[8]);
                tbNameNLSB.Text = Convert.ToString(res[9]);

                p_nls_a = Convert.ToString(res[0]);
                p_rnk_a = res[10];
                p_okpo_a = Convert.ToString(res[12]);
                p_kv_a = Convert.ToString(res[14]);

                p_nls_b = Convert.ToString(res[1]);
                p_rnk_b = res[11];
                p_okpo_b = Convert.ToString(res[13]);
                p_kv_b = Convert.ToString(res[15]);

                tbCode.Text = Convert.ToString(res[16]);
                tbKDFM02.Text = Convert.ToString(res[17]);
                tbPlus.Text = Convert.ToString(res[18]);
                tbKDFM03.Text = Convert.ToString(res[19]);
                tbPlus2.Text = Convert.ToString(res[20]);
                p_mode = Convert.ToDecimal(res[21]);    //0, 1, 2
                tbKDFM02_Name.Text = Convert.ToString(res[22]);
                tbKDFM03Name.Text = Convert.ToString(res[23]);

                l_status = Convert.ToString(res[24]);

                l_cur_mfo = Convert.ToString(res[25]); //наше текущее МФО
                
                //Ограничение на режим мониторинга (А - можем выбрать только сторону А, В - сторону В, BOTH - нет ограничений)
                l_mode_constr = Convert.ToString(res[26]);

                cbCompulsoryMon.Checked = true; //по-умолчанию выбран режим обяз. мониторинга
                if (tbKDFM03.Text != "000")
                {
                    cbInternalMob.Checked = true;
                    cbCompulsoryMon.Checked = false;

                    tbKDFM02.Enabled = false;
                    tbKDFM02_Name.Enabled = false;
                    tbPlus.Enabled = false;
                    MandatoryCodesTextBox.Enabled = false;
                    ibKDFM02.Enabled = false;

                    tbKDFM03.Enabled = true;
                    tbKDFM03Name.Enabled = true;
                    tbPlus2.Enabled = true;
                    InCodesTextBox.Enabled = true;
                    ibKDFM03.Enabled = true;
                }

                // Режим моніторингу відсутній
                if (l_mode_constr == "BOTH")
                {
                    //если p_mode != 0 - значит это режим мониторинга, установленный ранее - выбираем нужный комбобокс
                    if (p_mode == 1)
                    {
                        rbDailySideA.Checked = true;
                    }
                    if (p_mode == 2)
                    {
                        rbDailySideB.Checked = true;
                    }
                }

                // Режим моніторингу = Сторона А
                if (l_mode_constr == "A")
                {
                    rbDailySideA.Checked = true;
                    rbDailySideA.Enabled = false;
                    rbDailySideB.Enabled = false;

                    ibtDailySideB.Enabled = false;
                }
                // Режим моніторингу = Сторона В
                if (l_mode_constr == "B")
                {
                    rbDailySideB.Checked = true;
                    rbDailySideA.Enabled = false;
                    rbDailySideB.Enabled = false;

                    ibtDailySideA.Enabled = false;
                }
                //лочим кнопку, если не выбрана сторона мониторинга
                btOK.Enabled = (rbDailySideA.Checked || rbDailySideB.Checked);

                //Поиск ОКПО, РНК и Найменования стороны А 
                // По РНК
                if (null != p_rnk_a)
                {
                    ClearParameters();
                    SetParameters("p_rnk_a", DB_TYPE.Decimal, Convert.ToDecimal(p_rnk_a), DIRECTION.Input);
                    object[] resRnkA = SQL_SELECT_reader(@"select okpo, nmk 
                                                         from customer
                                                         where rnk = :p_rnk_a");
                    if (null != resRnkA)
                    {
                        l_rnk_a = Convert.ToString(p_rnk_a);
                        l_okpo_a = Convert.ToString(resRnkA[0]);
                        l_nmk_a = Convert.ToString(resRnkA[1]);
                    }
                }
                // Если не нашли тогда ищем по номеру счёта
                if (!string.IsNullOrEmpty(p_nls_a) && null == l_nmk_a)
                {
                    ClearParameters();
                    SetParameters("p_nls_a", DB_TYPE.Varchar2, p_nls_a, DIRECTION.Input);
                    SetParameters("p_kv_a", DB_TYPE.Decimal, Convert.ToDecimal(p_kv_a), DIRECTION.Input);

                    object[] resNLSA = SQL_SELECT_reader(@"select c.rnk,
                                                           c.nmk, 
                                                           c.okpo
                                                         from customer c,
                                                           accounts a
                                                         where a.nls = :p_nls_a 
                                                           and a.kv  = :p_kv_a
                                                           and a.rnk = c.rnk");
                    if (null != resNLSA)
                    {
                        l_rnk_a = Convert.ToString(resNLSA[0]);
                        l_nmk_a = Convert.ToString(resNLSA[1]);
                        l_okpo_a = Convert.ToString(resNLSA[2]);
                    }
                }
                //Если не нашли тогда ищем по ОКПО
                if (!string.IsNullOrEmpty(p_okpo_a) && null == l_nmk_a)
                {
                    ClearParameters();
                    SetParameters("p_okpo_a", DB_TYPE.Varchar2, p_okpo_a, DIRECTION.Input);
                    object[] resOKPOACOUNT = SQL_SELECT_reader(@"select count(c.okpo)
                                                           from customer c
                                                           where c.okpo = :p_okpo_a");
                    decimal l_count_a = Convert.ToDecimal(resOKPOACOUNT[0]);

                    if (l_count_a == 1)
                    {
                        ClearParameters();
                        SetParameters("p_okpo_a", DB_TYPE.Varchar2, p_okpo_a, DIRECTION.Input);
                        object[] resOKPOA = SQL_SELECT_reader(@"select c.rnk,
                                                             c.nmk,
                                                             c.okpo 
                                                           from customer c
                                                           where c.okpo = :p_okpo_a");
                        if (null != resOKPOA)
                        {
                            l_rnk_a = Convert.ToString(resOKPOA[0]);
                            l_nmk_a = Convert.ToString(resOKPOA[1]);
                            l_okpo_a = Convert.ToString(resOKPOA[2]);
                        }
                    }
                    else
                    {
                        l_rnk_a = null;
                        l_nmk_a = null;
                        l_okpo_a = null;
                    }
                }


                tbDailyOKPOA.Text = l_okpo_a;
                tbDailyNMKA.Text = l_nmk_a;
                tbDailyRNKA.Text = l_rnk_a;

                //Поиск ОКПО, РНК и Найменования стороны B 
                // По РНК
                if (null != p_rnk_b)
                {
                    ClearParameters();
                    SetParameters("p_rnk_b", DB_TYPE.Decimal, Convert.ToDecimal(p_rnk_b), DIRECTION.Input);
                    object[] resRnkB = SQL_SELECT_reader(@"select okpo, nmk 
                                                         from customer
                                                         where rnk = :p_rnk_b");
                    if (null != resRnkB)
                    {
                        l_rnk_b = Convert.ToString(p_rnk_b);
                        l_okpo_b = Convert.ToString(resRnkB[0]);
                        l_nmk_b = Convert.ToString(resRnkB[1]);
                    }
                }
                // Если не нашли тогда ищем по номеру счёта

                if (!string.IsNullOrEmpty(p_nls_b) && null == l_nmk_b)
                {
                    ClearParameters();
                    SetParameters("p_nls_b", DB_TYPE.Varchar2, p_nls_b, DIRECTION.Input);
                    SetParameters("p_kv_b", DB_TYPE.Decimal, Convert.ToDecimal(p_kv_b), DIRECTION.Input);

                    object[] resNLSB = SQL_SELECT_reader(@"select c.rnk,
                                                           c.nmk, 
                                                           c.okpo
                                                         from customer c,
                                                           accounts a
                                                         where a.nls = :p_nls_b 
                                                           and a.kv  = :p_kv_b
                                                           and a.rnk = c.rnk");
                    if (null != resNLSB)
                    {
                        l_rnk_b = Convert.ToString(resNLSB[0]);
                        l_nmk_b = Convert.ToString(resNLSB[1]);
                        l_okpo_b = Convert.ToString(resNLSB[2]);
                    }
                }
                //Если не нашли тогда ищем по ОКПО
                if (!string.IsNullOrEmpty(p_okpo_b) && null == l_nmk_b)
                {
                    ClearParameters();
                    SetParameters("p_okpo_b", DB_TYPE.Varchar2, p_okpo_b, DIRECTION.Input);
                    object[] resOKPOBCOUNT = SQL_SELECT_reader(@"select count(c.okpo)
                                                           from customer c
                                                           where c.okpo = :p_okpo_b");
                    decimal l_count_b = Convert.ToDecimal(resOKPOBCOUNT[0]);

                    if (l_count_b == 1)
                    {
                        ClearParameters();
                        SetParameters("p_okpo_b", DB_TYPE.Varchar2, p_okpo_b, DIRECTION.Input);
                        object[] resOKPOB = SQL_SELECT_reader(@"select c.rnk,
                                                             c.nmk,
                                                             c.okpo 
                                                           from customer c
                                                           where c.okpo = :p_okpo_b");
                        if (null != resOKPOB)
                        {
                            l_rnk_b = Convert.ToString(resOKPOB[0]);
                            l_nmk_b = Convert.ToString(resOKPOB[1]);
                            l_okpo_b = Convert.ToString(resOKPOB[2]);
                        }
                    }
                    else
                    {
                        l_rnk_b = null;
                        l_nmk_b = null;
                        l_okpo_b = null;
                    }
                }
            }

            tbDailyOKPOB.Text = l_okpo_b;
            tbDailyNMKB.Text = l_nmk_b;
            tbDailyRNKB.Text = l_rnk_b;


        }
        catch (Exception ex)
        {
            errLbl.Text = "Помилка: FillInfo - " + ex.Message;
        }
        finally
        {
            DisposeOraConnection();
        }

        if (l_status == "B" || l_status == "D")
        {
            pnCharacter.Enabled = false;
            pnDailyMon.Enabled = false;
            tbCode.Enabled = false;
            ibtCode.Enabled = false;
            rbDailySideA.Enabled = false;
            rbDailySideB.Enabled = false;
            btOK.Enabled = false;
        }

    }


    protected void cbCompulsoryMon_CheckedChanged(object sender, EventArgs e)
    {
        cbInternalMob.Checked = !cbCompulsoryMon.Checked;
        tbKDFM02.Enabled = cbCompulsoryMon.Checked;
        tbKDFM02_Name.Enabled = cbCompulsoryMon.Checked;
        ibKDFM02.Enabled = cbCompulsoryMon.Checked;
        tbPlus.Enabled = cbCompulsoryMon.Checked;
        MandatoryCodesTextBox.Enabled = cbCompulsoryMon.Checked;

        tbKDFM03.Enabled = !cbCompulsoryMon.Checked;
        tbKDFM03Name.Enabled = !cbCompulsoryMon.Checked;
        tbPlus2.Enabled = !cbCompulsoryMon.Checked;
        InCodesTextBox.Enabled = !cbCompulsoryMon.Checked;

        Code900Check();
    }

    protected void cbInternalMob_CheckedChanged(object sender, EventArgs e)
    {
        cbCompulsoryMon.Checked = !cbInternalMob.Checked;

        tbKDFM02.Enabled = !cbInternalMob.Checked;
        tbKDFM02_Name.Enabled = !cbInternalMob.Checked;
        ibKDFM02.Enabled = !cbInternalMob.Checked;
        tbPlus.Enabled = !cbInternalMob.Checked;
        MandatoryCodesTextBox.Enabled = !cbInternalMob.Checked;

        tbKDFM03.Enabled = cbInternalMob.Checked;
        tbKDFM03Name.Enabled = cbInternalMob.Checked;
        ibKDFM03.Enabled = cbInternalMob.Checked;
        tbPlus2.Enabled = cbInternalMob.Checked;
        InCodesTextBox.Enabled = cbInternalMob.Checked;

        Code900Check();
    }

    protected void rbDailySideA_CheckedChanged(object sender, EventArgs e)
    {
        btOK.Enabled = true;

        rbDailySideB.Checked = false;

        ibtDailySideA.Enabled = true;
        ibtDailySideB.Enabled = false;

        if (tbCode.Text != "")
        {
            tbCode.Text = tbCode.Text.Substring(0, 14) + "9";
        }
    }
    protected void rbDailySideB_CheckedChanged(object sender, EventArgs e)
    {
        btOK.Enabled = true;

        rbDailySideA.Checked = false;

        ibtDailySideA.Enabled = false;
        ibtDailySideB.Enabled = true;

        if (tbCode.Text != "")
        {
            tbCode.Text = tbCode.Text.Substring(0, 14) + "8";
        }
    }


    private void tbKDFM02TextChanged()
    {
        string p_code_a = tbKDFM02.Text;
        InitOraConnection();

        try
        {
            ClearParameters();
            SetParameters("p_code_a", DB_TYPE.Varchar2, p_code_a, DIRECTION.Input);

            object[] resKDFM02Name = SQL_SELECT_reader(@"select name
                                                         from k_dfm02
                                                         where code = :p_code_a");
            if (null != resKDFM02Name)
            {
                tbKDFM02_Name.Text = Convert.ToString(resKDFM02Name[0]);
            }
            else
            {
                tbKDFM02.Text = "0000";
                tbKDFM02_Name.Text = "незаповнено (вн. моніторінг)";
            }
        }
        catch (Exception ex)
        {
            errLbl.Text = "Помилка: tbKDFM02TextChanged - " + ex.Message;
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void tbKDFM02_TextChanged(object sender, EventArgs e)
    {
        //tbKDFM02TextChanged();
    }

    private void tbKDFM03TextChanged()
    {
        string p_code_b = tbKDFM03.Text;
        InitOraConnection();

        try
        {
            ClearParameters();
            SetParameters("p_code_b", DB_TYPE.Varchar2, p_code_b, DIRECTION.Input);

            object[] resKDFM03Name = SQL_SELECT_reader(@"select name
                                                         from k_dfm03
                                                         where code = :p_code_b");
            if (null != resKDFM03Name)
            {
                tbKDFM03Name.Text = Convert.ToString(resKDFM03Name[0]);
            }
            else
            {
                tbKDFM03.Text = "000";
                tbKDFM03Name.Text = "незаповнено (вн. моніторинг)";
            }

        }
        catch (Exception ex)
        {
            errLbl.Text = "Помилка: tbKDFM03TextChanged - " +  ex.Message;
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void tbKDFM03_TextChanged(object sender, EventArgs e)
    {
        //tbKDFM03TextChanged();
    }
    protected void ibKDFM02_Click(object sender, EventArgs e)
    {
        string sDocInputUrl = "/barsroot/finmon/kdfm02.aspx";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "show_pay_dialog", "ShowPayDialog('" + sDocInputUrl + "');", true);

    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_pay_dialog", "window.close();", true);

    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        //получение стороны мониторинга при сохранении
        int p_mode = rbDailySideA.Checked ? 1 : 2;

        decimal p_ref = Convert.ToDecimal(Request["ref"]);
        string p_vid1 = tbCode.Text;
        string p_vid2 = tbKDFM02.Enabled ? tbKDFM02.Text : "";
        string p_comm2 = tbKDFM02.Enabled ? tbPlus.Text : "";
        string p_vid3 = tbKDFM03.Enabled ? tbKDFM03.Text : "";
        string p_comm3 = tbKDFM03.Enabled ? tbPlus2.Text : "";
        string p_rnka = tbDailyRNKA.Text;
        string p_rnkb = tbDailyRNKB.Text;

        bool saveApproved = true;
        tbKDFM02.ForeColor = System.Drawing.Color.Black;
        tbKDFM03.ForeColor = System.Drawing.Color.Black;
        tbPlus2.BorderColor = System.Drawing.Color.Black;


        if (p_vid2 != "" && !CheckCode(p_vid2, "k_dfm02"))
        {
            errLbl.Text = "Увага! Був введений невірний код для обо'язкового моніторингу";
            tbKDFM02.ForeColor = System.Drawing.Color.Red;
            saveApproved = false;
        }
        
        if (p_vid3 != "" && !CheckCode(p_vid3, "k_dfm03"))
        {
            errLbl.Text = "Увага! Був введений невірний код для внутрішнього моніторингу";
            tbKDFM03.ForeColor = System.Drawing.Color.Red;
            saveApproved = false;
        }

        if (p_vid3 == "900" && p_comm3 == "")
        {
            errLbl.Text = "Увага! Для коду 900 внутрішнього моніторингу має бути заповнене поле коментар";
            tbPlus2.BorderColor = System.Drawing.Color.Red;
            saveApproved = false;
        }
        

        if (saveApproved)
        {
            string[] vid2 = tbKDFM02.Enabled ? MandatoryCodesTextBox.Text.Split(' ') : new string[] { };
            string[] vid3 = tbKDFM03.Enabled ? InCodesTextBox.Text.Split(' ') : new string[] { };

            InitOraConnection();
            try
            {
                string p_id = Request["id"];
                ClearParameters();
                SetParameters("p_id", DB_TYPE.Varchar2, p_id, DIRECTION.Input);
                SetParameters("p_ref", DB_TYPE.Decimal, p_ref, DIRECTION.Input);
                SetParameters("p_rec", DB_TYPE.Varchar2, null, DIRECTION.Input);
                SetParameters("p_vid1", DB_TYPE.Varchar2, p_vid1, DIRECTION.Input);
                SetParameters("p_vid2", DB_TYPE.Varchar2, p_vid2, DIRECTION.Input);
                SetParameters("p_comm2", DB_TYPE.Varchar2, p_comm2, DIRECTION.Input);
                SetParameters("p_vid3", DB_TYPE.Varchar2, p_vid3, DIRECTION.Input);
                SetParameters("p_comm3", DB_TYPE.Varchar2, p_comm3, DIRECTION.Input);
                SetParameters("p_mode", DB_TYPE.Decimal, p_mode, DIRECTION.Input);
                SetParameters("p_rnka", DB_TYPE.Varchar2, p_rnka, DIRECTION.Input);
                SetParameters("p_rnkb", DB_TYPE.Varchar2, p_rnkb, DIRECTION.Input);

                SQL_NONQUERY("begin p_fm_set_params(to_number(:p_id), :p_ref, :p_rec, :p_vid1, :p_vid2, :p_comm2, :p_vid3, :p_comm3, :p_mode, :p_rnka, :p_rnkb); end;");

                ClearParameters();
                p_id = p_id == "" ? SQL_SELECT_scalar("select id from finmon_que where ref=" + p_ref).ToString() : p_id;

                if (!string.IsNullOrEmpty(Request["id"]))
                {
                    ClearParameters();

                    SetParameters("id", DB_TYPE.Decimal, Request["id"], DIRECTION.Input);
                    SQL_NONQUERY("delete from finmon_que_vid2 where id=:id");
                    SQL_NONQUERY("delete from finmon_que_vid3 where id=:id");
                }
                foreach (var code in vid2)
                {
                    if (code != "" && CheckCode(code, "k_dfm02"))
                    {
                        InitOraConnection();
                        ClearParameters();
                        SetParameters("id", DB_TYPE.Decimal, p_id, DIRECTION.Input);
                        SetParameters("code", DB_TYPE.Varchar2, code, DIRECTION.Input);
                        SQL_NONQUERY("insert into finmon_que_vid2(id, vid) values(:id, :code)");
                    }
                }
                foreach (var code in vid3)
                {
                    if (code != "" && CheckCode(code, "k_dfm03"))
                    {
                        InitOraConnection();
                        ClearParameters();
                        SetParameters("id", DB_TYPE.Decimal, p_id, DIRECTION.Input);
                        SetParameters("code", DB_TYPE.Varchar2, code, DIRECTION.Input);
                        SQL_NONQUERY("insert into finmon_que_vid3(id, vid) values(:id, :code)");
                    }
                }
            }
            catch (OracleException E)
            {
                errLbl.Text = "Помилка: btOK_Click - " + E.Message;
            }
            finally
            {
                DisposeOraConnection();

                Session["FinminReload"] = "1";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "close", " window.close('this');", true);
            } 
        }
    }


    private bool CheckCode(string p_code_b, string tab)
    {
        object code;

        try
        {
            InitOraConnection();
            ClearParameters();
            SetParameters("p_code_b", DB_TYPE.Varchar2, p_code_b, DIRECTION.Input);

            code = SQL_SELECT_scalar(String.Format("select code from {0} where code = :p_code_b", tab));

        }
        catch (OracleException E)
        {
            errLbl.Text = "Помилка: CheckCode - " + E.Message;
            return false;
        }
        finally
        {
            DisposeOraConnection();
        }

        return (code != null) ? true : false;

    }


    private void Code900Check()
    {        
        if (cbInternalMob.Checked == true && tbPlus2.Text == "" && tbKDFM03.Text == "900")
        {
            tbPlus2.BorderColor = System.Drawing.Color.Red;
            errLbl.Text = "Увага! Для коду 900 внутрішнього моніторингу має бути заповнене поле коментар";
        }
        else
        {
            tbPlus2.BorderColor = System.Drawing.Color.Black;
            errLbl.Text = "";
        }
    }

}