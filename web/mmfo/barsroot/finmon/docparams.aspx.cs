using System;
using System.Web.UI;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using System.Linq;

public partial class finmon_docparams : Bars.BarsPage
{
    const string PARAMS_REF_KEY = "ParamsRef";

    private bool isLoaded = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        isLoaded = false;
        if (!IsPostBack)
        {
            errLbl.Text = "";
            FillInfo();

            lbTitle.Text = "Параметри фінансового моніторингу, реф " + Request["ref"];
        }
        isLoaded = true;
    }

    protected void FillInfo()
    {
        decimal p_ref = Convert.ToDecimal(Request["ref"]);
        string p_rnk_a = null;
        string p_nls_a = null;
        string p_okpo_a = null;
        string p_rnk_b = null;
        string p_nls_b = null;
        string p_okpo_b = null;
        string p_kv_a = null;
        string p_kv_b = null;
        string p_mfo_a = null;
        string p_mfo_b = null;

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

                p_rnk_a = Convert.ToString(res[10]);
                p_nls_a = Convert.ToString(res[0]);
                p_kv_a = Convert.ToString(res[14]);
                p_mfo_a = Convert.ToString(res[6]);
                p_okpo_a = Convert.ToString(res[12]);

                p_rnk_b = Convert.ToString(res[11]);
                p_nls_b = Convert.ToString(res[1]);
                p_kv_b = Convert.ToString(res[15]);
                p_mfo_b = Convert.ToString(res[7]);
                p_okpo_b = Convert.ToString(res[13]);

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
                    // есть ВМ - включаем ВМ
                    cbInternalMob.Checked = true;

                    tbKDFM03.Enabled = true;
                    tbKDFM03Name.Enabled = true;
                    tbPlus2.Enabled = true;
                    InCodesTextBox.Enabled = true;
                    ibKDFM03.Enabled = true;

                    if (tbKDFM02.Text == "0000")
                    {
                        // если есть ВМ, но нет ОМ - выключаем ОМ
                        cbCompulsoryMon.Checked = false;
                        tbKDFM02.Enabled = false;
                        tbKDFM02_Name.Enabled = false;
                        tbPlus.Enabled = false;
                        MandatoryCodesTextBox.Enabled = false;
                        ibKDFM02.Enabled = false;
                    }
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

                //получаем данные клиентов-участников
                Dictionary<string, string> ClientA = SearchClientData(p_rnk_a, p_nls_a, p_kv_a, p_mfo_a, p_okpo_a);

                Dictionary<string, string> ClientB = SearchClientData(p_rnk_b, p_nls_b, p_kv_b, p_mfo_b, p_okpo_b);

                tbDailyOKPOA.Text = ClientA["okpo"];
                tbDailyNMKA.Text = ClientA["nmk"];
                tbDailyRNKA.Text = ClientA["rnk"];

                tbDailyOKPOB.Text = ClientB["okpo"];
                tbDailyNMKB.Text = ClientB["nmk"];
                tbDailyRNKB.Text = ClientB["rnk"];
            }
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
    /// <summary>
    /// Поиск данных клиента по РНК или счету или ОКПО
    /// </summary>
    /// <param name="p_rnk"></param>
    /// <param name="p_nls"></param>
    /// <param name="p_kv"></param>
    /// <param name="p_mfo"></param>
    /// <param name="p_okpo"></param>
    /// <returns></returns>
    protected Dictionary<string, string> SearchClientData(string p_rnk, string p_nls, string p_kv, string p_mfo, string p_okpo)
    {
        Dictionary<string, string> ClientData = new Dictionary<string, string>();
        object[] resClient = new object[3];
        try
        {
            ClearParameters();
            SetParameters("p_rnk", DB_TYPE.Decimal, string.IsNullOrEmpty(p_rnk) ? null : p_rnk, DIRECTION.Input);
            SetParameters("p_nls", DB_TYPE.Varchar2, p_nls, DIRECTION.Input);
            SetParameters("p_kv", DB_TYPE.Decimal, Convert.ToDecimal(p_kv), DIRECTION.Input);
            SetParameters("p_mfo", DB_TYPE.Varchar2, p_mfo, DIRECTION.Input);
            SetParameters("p_nlsalt", DB_TYPE.Varchar2, p_nls, DIRECTION.Input);
            SetParameters("p_kvalt", DB_TYPE.Decimal, Convert.ToDecimal(p_kv), DIRECTION.Input);
            SetParameters("p_mfoalt", DB_TYPE.Varchar2, p_mfo, DIRECTION.Input);
            SetParameters("p_okpo", DB_TYPE.Varchar2, p_okpo, DIRECTION.Input);

            resClient = SQL_SELECT_reader(@"select to_char(c.rnk), c.nmk, c.okpo from customer c
                                                    where c.rnk = coalesce(:p_rnk, -- если уже заполнен
                                                                           (select a.rnk
                                                                            from accounts a 
                                                                            where a.nls = :p_nls 
                                                                            and a.kv = :p_kv 
                                                                            and a.kf = :p_mfo), -- ищем по счету
                                                                           (select a.rnk
                                                                            from accounts a 
                                                                            where a.nlsalt = :p_nlsalt
                                                                            and a.kv = :p_kvalt
                                                                            and a.kf = :p_mfoalt), -- пошук по альтернативному рахунку
                                                                           (select max(co.rnk) -- ищем по окпо в документе - если такой клиент один
                                                                            from customer co
                                                                            where co.okpo = :p_okpo
                                                                            group by co.okpo
                                                                            having count(*)=1)
                                                                           )");
        }
        catch (Exception e)
        {
            ClientData["rnk"] = null;
            ClientData["nmk"] = null;
            ClientData["okpo"] = null;
        }
        ClientData["rnk"] = resClient != null ? Convert.ToString(resClient[0]) : null;
        ClientData["nmk"] = resClient != null ? Convert.ToString(resClient[1]) : null;
        ClientData["okpo"] = resClient != null ? Convert.ToString(resClient[2]) : null;

        return ClientData;
    }

    protected void cbCompulsoryMon_CheckedChanged(object sender, EventArgs e)
    {
        tbKDFM02.Enabled = cbCompulsoryMon.Checked;
        tbKDFM02_Name.Enabled = cbCompulsoryMon.Checked;
        ibKDFM02.Enabled = cbCompulsoryMon.Checked;
        tbPlus.Enabled = cbCompulsoryMon.Checked;
        MandatoryCodesTextBox.Enabled = cbCompulsoryMon.Checked;
    }

    protected void cbInternalMob_CheckedChanged(object sender, EventArgs e)
    {
        tbKDFM03.Enabled = cbInternalMob.Checked;
        tbKDFM03Name.Enabled = cbInternalMob.Checked;
        ibKDFM03.Enabled = cbInternalMob.Checked;
        tbPlus2.Enabled = cbInternalMob.Checked;
        InCodesTextBox.Enabled = cbInternalMob.Checked;
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

    protected void btCancel_Click(object sender, EventArgs e)
    {
        Session["ParamsRef"] = null;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_pay_dialog", "window.close();", true);
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        bool saveApproved = isLoaded;

        //получение стороны мониторинга при сохранении
        int p_mode = rbDailySideA.Checked ? 1 : 2;

        decimal p_ref = Convert.ToDecimal(Request["ref"]);
        string p_vid1 = tbCode.Text;
        string p_vid2 = tbKDFM02.Enabled ? tbKDFM02.Text.Trim() : "";
        string p_comm2 = tbKDFM02.Enabled ? tbPlus.Text : "";
        string p_vid3 = tbKDFM03.Enabled ? tbKDFM03.Text.Trim() : "";
        string p_comm3 = tbKDFM03.Enabled ? tbPlus2.Text : "";
        string p_rnka = tbDailyRNKA.Text;
        string p_rnkb = tbDailyRNKB.Text;

        List<string> vid2 = tbKDFM02.Enabled ? MandatoryCodesTextBox.Text.Split(' ').ToList().Distinct().Where(x => !string.IsNullOrWhiteSpace(x)).ToList() : new List<string>();
        List<string> vid3 = tbKDFM03.Enabled ? InCodesTextBox.Text.Split(' ').ToList().Distinct().Where(x => !string.IsNullOrWhiteSpace(x)).ToList() : new List<string>();

        // проверяем основные  и доп. коды
        saveApproved = saveApproved && CheckCode(p_vid2, "k_dfm02") && CheckCode(p_vid3, "k_dfm03") && Code900Check() && vid2.All(x => CheckCode(x, "k_dfm02")) && vid3.All(x => CheckCode(x, "k_dfm03"));

        // сохраняем
        if (saveApproved)
        {
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
                SetParameters("p_ref", DB_TYPE.Decimal, p_ref, DIRECTION.Input);
                p_id = p_id == "" ? SQL_SELECT_scalar("select id from finmon_que where ref=:p_ref").ToString() : p_id;

                insert_additional_codes(p_id, vid2, "finmon_que_vid2");
                insert_additional_codes(p_id, vid3, "finmon_que_vid3");

                string[] updated_ref = new string[] { Request["ref"], p_vid2, p_vid3 };
                Session[PARAMS_REF_KEY] = updated_ref;

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "close", " window.close('this');", true);
            }
            catch (OracleException E)
            {
                errLbl.Text = "Помилка: btOK_Click - " + E.Message;
                Session["FinminReload"] = "1"; //обновляем данные из БД
                Session[PARAMS_REF_KEY] = null; //обнуляем референс, по которому проставляется статус "Повідомлено"
            }
            finally
            {
                DisposeOraConnection();
            } 
        }
    }

    /// <summary>
    /// Проверка кода мониторинга на существование
    /// </summary>
    /// <param name="p_code"></param>
    /// <param name="tab"></param>
    /// <returns></returns>
    private bool CheckCode(string p_code, string tab)
    {
        if (p_code == "") return true;
        object code;
        try
        {
            InitOraConnection();
            ClearParameters();
            SetParameters("p_code", DB_TYPE.Varchar2, p_code, DIRECTION.Input);

            code = SQL_SELECT_scalar(String.Format("select code from {0} where code = :p_code and (d_close is null or d_close > sysdate)", tab));
        }
        catch (OracleException E)
        {
            errLbl.Text = "Помилка: код " + p_code + " не існує або не використовується (CheckCode: " + E.Message + ")";
            return false;
        }
        finally
        {
            DisposeOraConnection();
        }

        if (code == null)
        {
            errLbl.Text = "Помилка: код " + p_code + " не існує або не використовується";
            return false;
        }
        else
            return true;
    }

    /// <summary>
    /// Вставка дополнительных кодов ОМ/ВМ
    /// </summary>
    /// <param name="p_vids"></param>
    /// <param name="tabname"></param>
    private void insert_additional_codes(string p_id, List<string> p_vids, string tabname)
    {
        // удаляем существующие
        if (!string.IsNullOrEmpty(Request["id"]))
        {
            ClearParameters();
            SetParameters("id", DB_TYPE.Decimal, Request["id"], DIRECTION.Input);
            SQL_NONQUERY(String.Format("delete from {0} where id=:id", tabname));
        }
        // вставляем новые
        if (tabname == "finmon_que_vid2")
        {
            int order_id = 1;
            foreach (var code in p_vids)
            {
                ClearParameters();
                SetParameters("id", DB_TYPE.Decimal, p_id, DIRECTION.Input);
                SetParameters("code", DB_TYPE.Varchar2, code, DIRECTION.Input);
                SetParameters("order_id", DB_TYPE.Decimal, order_id, DIRECTION.Input);
                SQL_NONQUERY(String.Format("insert into {0}(id, vid, order_id) values(:id, :code, :order_id)", tabname));
                order_id++;
            }
        }
        else
        {
            foreach (var code in p_vids)
            {
                ClearParameters();
                SetParameters("id", DB_TYPE.Decimal, p_id, DIRECTION.Input);
                SetParameters("code", DB_TYPE.Varchar2, code, DIRECTION.Input);
                SQL_NONQUERY(String.Format("insert into {0}(id, vid) values(:id, :code)", tabname));
            }
        }
    }


    /// <summary>
    /// Проверка на заполнение комментария при коде ВМ 900
    /// </summary>
    private bool Code900Check()
    {        
        if (cbInternalMob.Checked == true && tbPlus2.Text == "" && tbKDFM03.Text == "900")
        {
            tbPlus2.BorderColor = System.Drawing.Color.Red;
            errLbl.Text = "Увага! Для коду 900 внутрішнього моніторингу має бути заповнене поле коментар";
            return false;
        }
        else
        {
            return true;
        }
    }

}