using System;
using System.Web.UI;
using Oracle.DataAccess.Client;
using Bars.Classes;
using Bars.Oracle;
using System.Data;
using System.Collections.Generic;
using System.Linq;

public partial class finmon_docparams_bulk : Bars.BarsPage
{

    const string BULK_REFS_KEY = "FinmonBulkRefs";

    private bool isLoaded = false;

    private List<decimal> BULKSELECTEDROWS
    {
        get
        {
            if (Session[BULK_REFS_KEY] != null)
                return (List<decimal>)Session[BULK_REFS_KEY];
            else
                return new List<decimal>();
        }
        set
        {
            Session[BULK_REFS_KEY] = value;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        isLoaded = false;
        if (!IsPostBack)
        {
            errLbl.Text = "";
            FillInfo();
            lbTitle.Text = "Параметри фінансового моніторингу (пакетне встановлення)";
        }
        isLoaded = true;
    }

    protected void FillInfo()
    {
        string l_cur_mfo = null;
        string l_mode_constr = null;

        OracleConnection connection = OraConnector.Handler.UserConnection;
        OracleDataAdapter adapter = new OracleDataAdapter();
        try
        {
            OracleCommand command = new OracleCommand(@"select opr_vid1, opr_vid2, opr_vid3, f_ourmfo, MD 
                                                        from (
                                                            select case min(MD) when 'A' then '999999999999999' when 'B' then '999999999999998' else '999999999999999' end opr_vid1, 
                                                                   opr_vid2, 
                                                                   opr_vid3, 
                                                                   f_ourmfo, 
                                                                   min(MD) as MD, 
                                                                   count(*) over (partition by 1, 2, 3) as cnt  
                                                            from (
                                                                    select  
                                                                     '0000' opr_vid2,
                                                                     '000' opr_vid3,
                                                                     f_ourmfo as f_mfo,
                                                                     case when f_ourmfo=v.mfoa and v.mfoa!=v.mfob then 'A' when f_ourmfo=v.mfob and v.mfoa!=v.mfob then 'B' else 'BOTH' end as MD
                                                                   from v_finmon_que_oper v                                                    
                                                                   where v.ref in (select column_value from TABLE(CAST(:p_refs AS number_list)))
                                                                   and nvl(v.status, 'Z') not in ('B', 'D')
                                                                )
                                                            group by opr_vid2, opr_vid3, MD
                                                             )
                                                        where MD != 'BOTH' or cnt = 1", connection);

            //коллекция референсов для обновления
            decimal[] refsArr = BULKSELECTEDROWS.ToArray();
            OracleParameter p_refs = new OracleParameter("p_refs", OracleDbType.Array, refsArr.Length, (NumberList)refsArr, ParameterDirection.Input);
            p_refs.UdtTypeName = "BARS.NUMBER_LIST";
            command.Parameters.Add(p_refs);
            //наполняем датасет
            DataSet res = new DataSet();
            adapter.SelectCommand = command;
            adapter.Fill(res);
            adapter.Dispose();
            
            MandatoryCodesTextBox.Text = "";  //коды обяз. мониторинга
            InCodesTextBox.Text = ""; //коды внутренн. мониторинга
            
            if (null != res)
            {
                if (res.Tables[0].Rows.Count == 1)
                {
                    tbCode.Text = Convert.ToString(res.Tables[0].Rows[0].ItemArray[0]);
                    tbKDFM02.Text = Convert.ToString(res.Tables[0].Rows[0].ItemArray[1]);
                    tbPlus.Text = ""; //comment ОМ
                    tbKDFM03.Text = Convert.ToString(res.Tables[0].Rows[0].ItemArray[2]);
                    tbPlus2.Text = ""; //comment ВМ

                    l_cur_mfo = Convert.ToString(res.Tables[0].Rows[0].ItemArray[3]); //наше текущее МФО

                    //Ограничение на режим мониторинга (А - можем выбрать только сторону А, В - сторону В, BOTH - нет ограничений)
                    l_mode_constr = Convert.ToString(res.Tables[0].Rows[0].ItemArray[4]);

                    cbCompulsoryMon.Checked = true; //по-умолчанию выбран режим обяз. мониторинга
                    if (tbKDFM03.Text != "000")
                    {
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
                        rbDailySideA.Checked = false;
                        rbDailySideB.Checked = false;
                    }

                    // Режим моніторингу = Сторона А
                    if (l_mode_constr == "A")
                    {
                        rbDailySideA.Checked = true;
                        rbDailySideA.Enabled = false;
                        rbDailySideB.Enabled = false;
                    }
                    // Режим моніторингу = Сторона В
                    if (l_mode_constr == "B")
                    {
                        rbDailySideB.Checked = true;
                        rbDailySideA.Enabled = false;
                        rbDailySideB.Enabled = false;
                    }
                    //лочим кнопку, если не выбрана сторона мониторинга
                    btOK.Enabled = (rbDailySideA.Checked || rbDailySideB.Checked);
                }
                else
                {
                    errLbl.Text = "Помилка: неоднорідні дані";
                    btOK.Enabled = false;
                    rbDailySideA.Enabled = false;
                    rbDailySideB.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            errLbl.Text = "Помилка: FillInfo - " + ex.Message;
        }
        finally
        {
            connection.Close();
        }
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

        if (tbCode.Text != "")
        {
            tbCode.Text = tbCode.Text.Substring(0, 14) + "9";
        }
    }
    protected void rbDailySideB_CheckedChanged(object sender, EventArgs e)
    {
        btOK.Enabled = true;

        rbDailySideA.Checked = false;

        if (tbCode.Text != "")
        {
            tbCode.Text = tbCode.Text.Substring(0, 14) + "8";
        }
    }

    protected void btCancel_Click(object sender, EventArgs e)
    {
        BULKSELECTEDROWS.Clear();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_pay_dialog", "window.close();", true);
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        bool saveApproved = isLoaded;

        //получение стороны мониторинга при сохранении
        int p_mode = rbDailySideA.Checked ? 1 : 2;

        string p_vid1 = tbCode.Text;
        string p_vid2 = tbKDFM02.Enabled ? tbKDFM02.Text.Trim() : "";
        string p_comm2 = tbKDFM02.Enabled ? tbPlus.Text : "";
        string p_vid3 = tbKDFM03.Enabled ? tbKDFM03.Text.Trim() : "";
        string p_comm3 = tbKDFM03.Enabled ? tbPlus2.Text : "";

        List<string> vid2 = tbKDFM02.Enabled ? MandatoryCodesTextBox.Text.Split(' ').ToList().Distinct().Where(x => !string.IsNullOrWhiteSpace(x)).ToList() : new List<string>();
        List<string> vid3 = tbKDFM03.Enabled ? InCodesTextBox.Text.Split(' ').ToList().Distinct().Where(x => !string.IsNullOrWhiteSpace(x)).ToList() : new List<string>();

        // проверяем основные  и доп. коды
        saveApproved = saveApproved && CheckCode(p_vid2, "k_dfm02") && CheckCode(p_vid3, "k_dfm03") && Code900Check() && vid2.All(x => CheckCode(x, "k_dfm02")) && vid3.All(x => CheckCode(x, "k_dfm03"));

        // сохраняем
        if (saveApproved)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("begin p_fm_bulk_set_params(:p_refs, :p_vid1, :p_vid2, :p_comm2, :p_vid3, :p_comm3, :p_mode, :p_vids2, :p_vids3); end;", connection);
                //коллекция референсов для обновления
                decimal[] refsArr = BULKSELECTEDROWS.ToArray();
                OracleParameter p_refs = new OracleParameter("p_refs", OracleDbType.Array, refsArr.Length, (NumberList)refsArr, ParameterDirection.Input);
                p_refs.UdtTypeName = "BARS.NUMBER_LIST";
                command.Parameters.Add(p_refs);

                command.Parameters.Add(new OracleParameter("p_vid1", OracleDbType.Varchar2, 15, p_vid1, ParameterDirection.Input));
                command.Parameters.Add(new OracleParameter("p_vid2", OracleDbType.Varchar2, 4, p_vid2, ParameterDirection.Input));
                command.Parameters.Add(new OracleParameter("p_comm2", OracleDbType.Varchar2, 256, p_comm2, ParameterDirection.Input));
                command.Parameters.Add(new OracleParameter("p_vid3", OracleDbType.Varchar2, 3, p_vid3, ParameterDirection.Input));
                command.Parameters.Add(new OracleParameter("p_comm3", OracleDbType.Varchar2, 256, p_comm3, ParameterDirection.Input));
                command.Parameters.Add(new OracleParameter("p_mode", OracleDbType.Decimal, 1, p_mode, ParameterDirection.Input));

                //коллекция доп кодов ОМ
                OracleParameter p_vids2 = new OracleParameter("p_vids2", OracleDbType.Array, vid2.Count, vid2.ToArray<string>(), ParameterDirection.Input);
                p_vids2.UdtTypeName = "BARS.STRING_LIST";
                command.Parameters.Add(p_vids2);

                //коллекция доп кодов ВМ
                OracleParameter p_vids3 = new OracleParameter("p_vids3", OracleDbType.Array, vid3.Count, vid3.ToArray<string>(), ParameterDirection.Input);
                p_vids3.UdtTypeName = "BARS.STRING_LIST";
                command.Parameters.Add(p_vids3);
                
                command.ExecuteNonQuery();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "close", " window.close('this');", true);
            }
            catch (OracleException E)
            {
                errLbl.Text = "Помилка збереження(sql): " + E.Message + " ;";
            }
            catch (Exception E)
            {
                errLbl.Text += "Помилка збереження: " + E.Message + " ;";
            }
            finally
            {
                connection.Close();
                BULKSELECTEDROWS.Clear();
                Session["FinminReload"] = "1";
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