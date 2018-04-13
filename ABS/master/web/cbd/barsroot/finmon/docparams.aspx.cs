using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;
using Bars.UserControls;
using Bars.Oracle;
using Bars.Classes;
using System.Web.Services;


public partial class finmon_docparams : Bars.BarsPage
{


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            FillInfo();

            lbTitle.Text = "Параметри фінансового моніторингу, реф " + Request["ref"];
        }
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

        string l_rnk_a = null;
        string l_okpo_a = null;
        string l_nmk_a = null;

        string l_rnk_b = null;
        string l_okpo_b = null;
        string l_nmk_b = null;
        decimal p_mode;
        string l_status = null;

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
                                                 nvl(v.opr_vid1,'000000000000000') opr_vid1,
                                                 nvl(v.opr_vid2,'0000') opr_vid2,
                                                 v.comm_vid2,
                                                 nvl(v.opr_vid3,'000') opr_vid3,
                                                 v.comm_vid3,
                                                 v.monitor_mode,
                                                 k2.name,
                                                 k3.name,
                                                 v.status   
                                               from v_finmon_que_oper v,
                                                    k_dfm02 k2,
                                                    k_dfm03 k3
                                               where v.ref=:p_ref
                                                 and nvl(v.opr_vid2,'0000') = k2.code
                                                 and nvl(v.opr_vid3,'000') = k3.code");
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
                p_rnk_a = Convert.ToString(res[10]);
                p_okpo_a = Convert.ToString(res[12]);
                p_kv_a = Convert.ToString(res[14]);

                p_nls_b = Convert.ToString(res[1]);
                p_rnk_b = Convert.ToString(res[11]);
                p_okpo_b = Convert.ToString(res[13]);
                p_kv_b = Convert.ToString(res[15]);

                tbCode.Text = Convert.ToString(res[16]);
                tbKDFM02.Text = Convert.ToString(res[17]);
                tbPlus.Text = Convert.ToString(res[18]);
                tbKDFM03.Text = Convert.ToString(res[19]);
                tbPlus2.Text = Convert.ToString(res[20]);
                p_mode = Convert.ToDecimal(res[21]);
                tbKDFM02_Name.Text = Convert.ToString(res[22]);
                tbKDFM03Name.Text = Convert.ToString(res[23]);

                l_status = Convert.ToString(res[24]);

                // Режим моніторингу відсутній
                if (p_mode == 0)
                {
                    rbDailySideA.Checked = false;
                    rbDailySideB.Checked = false;
                    rbDailyBouth.Checked = true;

                    cbCompulsoryMon.Checked = true;
                    rbSideA.Checked = true;
                    rbSideB.Checked = true;
                }


                // Режим моніторингу = Сторона А
                if (p_mode == 1)
                {
                    rbDailySideA.Checked = true;
                    rbDailySideB.Checked = false;
                    rbDailyBouth.Checked = false;

                    rbSideA.Visible = false;
                    rbSideB.Visible = false;
                    rbSideA2.Visible = false;
                    rbSideB2.Visible = false;
                    ibtDailySideA.Enabled = true;
                    ibtDailySideB.Enabled = false;

                    if (tbKDFM02.Text != "0000")
                    {
                        cbCompulsoryMon.Checked = true;
                        tbKDFM02.Enabled = true;
                        tbKDFM02_Name.Enabled = true;
                        tbPlus.Enabled = true;
                        ibKDFM02.Enabled = true;

                        tbKDFM03.Enabled = false;
                        tbKDFM03Name.Enabled = false;
                        tbPlus2.Enabled = false;
                        ibKDFM03.Enabled = false;

                        rbSideA.Checked = true;
                        rbSideB.Checked = true;

                        rbSideA2.Checked = false;
                        rbSideB2.Checked = false;
                    }

                    if (tbKDFM03.Text != "000")
                    {
                        cbInternalMob.Checked = true;

                        cbCompulsoryMon.Checked = false;
                        tbKDFM02.Enabled = false;
                        tbKDFM02_Name.Enabled = false;
                        tbPlus.Enabled = false;
                        ibKDFM02.Enabled = false;

                        tbKDFM03.Enabled = true;
                        tbKDFM03Name.Enabled = true;
                        tbPlus2.Enabled = true;
                        ibKDFM03.Enabled = true;

                        rbSideA.Checked = false;
                        rbSideB.Checked = false;

                        rbSideA2.Checked = true;
                        rbSideB2.Checked = true;
                    }
                }
                // Режим моніторингу = Сторона В
                if (p_mode == 2)
                {
                    rbDailySideA.Checked = false;
                    rbDailySideB.Checked = true;
                    rbDailyBouth.Checked = false;

                    rbSideA.Visible = false;
                    rbSideB.Visible = false;
                    rbSideA2.Visible = false;
                    rbSideB2.Visible = false;
                    ibtDailySideA.Enabled = false;
                    ibtDailySideB.Enabled = true;

                    if (tbKDFM02.Text != "0000")
                    {
                        cbCompulsoryMon.Checked = true;
                        tbKDFM02.Enabled = true;
                        tbKDFM02_Name.Enabled = true;
                        tbPlus.Enabled = true;
                        ibKDFM02.Enabled = true;

                        tbKDFM03.Enabled = false;
                        tbKDFM03Name.Enabled = false;
                        tbPlus2.Enabled = false;
                        ibKDFM03.Enabled = false;

                        rbSideA.Checked = true;
                        rbSideB.Checked = true;

                        rbSideA2.Checked = false;
                        rbSideB2.Checked = false;
                    }

                    if (tbKDFM03.Text != "000")
                    {
                        cbInternalMob.Checked = true;

                        cbCompulsoryMon.Checked = false;
                        tbKDFM02.Enabled = false;
                        tbKDFM02_Name.Enabled = false;
                        tbPlus.Enabled = false;
                        ibKDFM02.Enabled = false;

                        tbKDFM03.Enabled = true;
                        tbKDFM03Name.Enabled = true;
                        tbPlus2.Enabled = true;
                        ibKDFM03.Enabled = true;

                        rbSideA.Checked = false;
                        rbSideB.Checked = false;

                        rbSideA2.Checked = true;
                        rbSideB2.Checked = true;

                    }

                }
                // Режим моніторингу = Обидві сторони
                if (p_mode == 3)
                {
                    rbDailySideA.Checked = false;
                    rbDailySideB.Checked = false;
                    rbDailyBouth.Checked = true;

                    rbSideA.Visible = true;
                    rbSideB.Visible = true;
                    rbSideA2.Visible = true;
                    rbSideB2.Visible = true;
                    ibtDailySideA.Enabled = true;
                    ibtDailySideB.Enabled = true;

                    if (tbKDFM02.Text != "0000")
                    {
                        cbCompulsoryMon.Checked = true;
                        tbKDFM02.Enabled = true;
                        tbKDFM02_Name.Enabled = true;
                        tbPlus.Enabled = true;
                        ibKDFM02.Enabled = true;
                        rbSideA.Checked = true;
                        rbSideB.Checked = true;

                        tbKDFM03.Enabled = false;
                        tbKDFM03Name.Enabled = false;
                        tbPlus2.Enabled = false;
                        ibKDFM03.Enabled = false;
                        rbSideA2.Checked = false;
                        rbSideB2.Checked = false;

                    }

                    if (tbKDFM03.Text != "000")
                    {
                        cbInternalMob.Checked = true;

                        cbCompulsoryMon.Checked = false;
                        tbKDFM02.Enabled = false;
                        tbKDFM02_Name.Enabled = false;
                        tbPlus.Enabled = false;
                        ibKDFM02.Enabled = false;
                        rbSideA.Checked = false;
                        rbSideB.Checked = false;

                        tbKDFM03.Enabled = true;
                        tbKDFM03Name.Enabled = true;
                        tbPlus2.Enabled = true;
                        ibKDFM03.Enabled = true;
                        rbSideA2.Checked = true;
                        rbSideB2.Checked = true;
                    }

                    if (tbKDFM02.Text == "0000" && tbKDFM03.Text == "000")
                    {
                        cbCompulsoryMon.Checked = true;
                        tbKDFM02.Enabled = true;
                        tbKDFM02_Name.Enabled = true;
                        tbPlus.Enabled = true;
                        ibKDFM02.Enabled = true;
                        rbSideA.Checked = true;
                        rbSideB.Checked = true;

                        tbKDFM03.Enabled = false;
                        tbKDFM03Name.Enabled = false;
                        tbPlus2.Enabled = false;
                        ibKDFM03.Enabled = false;
                        rbSideA2.Checked = false;
                        rbSideB2.Checked = false;
                    }

                }
                // Режим моніторингу = Обидві сторони (Обов`язковий моніторинг Сторона А а Внутрішній моніторинг Сторона В)
                if (p_mode == 4)
                {
                    rbDailySideA.Checked = false;
                    rbDailySideB.Checked = false;
                    rbDailyBouth.Checked = true;

                    rbSideA.Visible = true;
                    rbSideB.Visible = true;
                    rbSideA2.Visible = true;
                    rbSideB2.Visible = true;
                    ibtDailySideA.Enabled = true;
                    ibtDailySideB.Enabled = true;

                    cbCompulsoryMon.Checked = true;
                    cbInternalMob.Checked = true;
                    tbKDFM02.Enabled = true;
                    tbKDFM02_Name.Enabled = true;
                    tbPlus.Enabled = true;
                    ibKDFM02.Enabled = true;
                    rbSideA.Checked = true;
                    rbSideB.Checked = false;

                    tbKDFM03.Enabled = true;
                    tbKDFM03Name.Enabled = true;
                    tbPlus2.Enabled = true;
                    ibKDFM03.Enabled = true;
                    rbSideA2.Checked = false;
                    rbSideB2.Checked = true;

                }
                // Режим моніторингу = Обидві сторони (Обов`язковий моніторинг Сторона В а Внутрішній моніторинг Сторона А)
                if (p_mode == 5)
                {
                    rbDailySideA.Checked = false;
                    rbDailySideB.Checked = false;
                    rbDailyBouth.Checked = true;

                    rbSideA.Visible = true;
                    rbSideB.Visible = true;
                    rbSideA2.Visible = true;
                    rbSideB2.Visible = true;
                    ibtDailySideA.Enabled = true;
                    ibtDailySideB.Enabled = true;

                    cbCompulsoryMon.Checked = true;
                    cbInternalMob.Checked = true;
                    tbKDFM02.Enabled = true;
                    tbKDFM02_Name.Enabled = true;
                    tbPlus.Enabled = true;
                    ibKDFM02.Enabled = true;
                    rbSideA.Checked = false;
                    rbSideB.Checked = true;

                    tbKDFM03.Enabled = true;
                    tbKDFM03Name.Enabled = true;
                    tbPlus2.Enabled = true;
                    ibKDFM03.Enabled = true;
                    rbSideA2.Checked = true;
                    rbSideB2.Checked = false;
                }



                //Поиск ОКПО, РНК и Найменования стороны А 
                // По РНК
                if (null != p_rnk_a)
                {
                    ClearParameters();
                    SetParameters("p_rnk_a", DB_TYPE.Varchar2, p_rnk_a, DIRECTION.Input);
                    object[] resRnkA = SQL_SELECT_reader(@"select okpo, nmk 
                                                         from customer
                                                         where to_char(rnk) = :p_rnk_a");
                    if (null != resRnkA)
                    {
                        l_rnk_a = p_rnk_a;
                        l_okpo_a = Convert.ToString(resRnkA[0]);
                        l_nmk_a = Convert.ToString(resRnkA[1]);
                    }
                }
                // Если не нашли тогда ищем по номеру счёта
                if (null != p_nls_a && null == l_nmk_a)
                {
                    ClearParameters();
                    SetParameters("p_nls_a", DB_TYPE.Varchar2, p_nls_a, DIRECTION.Input);
                    SetParameters("p_kv_a", DB_TYPE.Varchar2, p_kv_a, DIRECTION.Input);

                    object[] resNLSA = SQL_SELECT_reader(@"select c.rnk,
                                                           c.nmk, 
                                                           c.okpo
                                                         from customer c,
                                                           accounts a
                                                         where to_char(a.nls) = :p_nls_a 
                                                           and to_char(a.kv)  = :p_kv_a
                                                           and a.rnk = c.rnk");
                    if (null != resNLSA)
                    {
                        l_rnk_a = Convert.ToString(resNLSA[0]);
                        l_nmk_a = Convert.ToString(resNLSA[1]);
                        l_okpo_a = Convert.ToString(resNLSA[2]);
                    }
                }
                //Если не нашли тогда ищем по ОКПО
                if (null != p_okpo_a && null == l_nmk_a)
                {
                    ClearParameters();
                    SetParameters("p_okpo_a", DB_TYPE.Varchar2, p_okpo_a, DIRECTION.Input);
                    object[] resOKPOACOUNT = SQL_SELECT_reader(@"select count(c.okpo)
                                                           from customer c
                                                           where to_char(c.okpo) = :p_okpo_a");
                    decimal l_count_a = Convert.ToDecimal(resOKPOACOUNT[0]);

                    if (l_count_a == 1)
                    {
                        ClearParameters();
                        SetParameters("p_okpo_a", DB_TYPE.Varchar2, p_okpo_a, DIRECTION.Input);
                        object[] resOKPOA = SQL_SELECT_reader(@"select c.rnk,
                                                             c.nmk,
                                                             c.okpo 
                                                           from customer c
                                                           where to_char(c.okpo) = :p_okpo_a");
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
                    SetParameters("p_rnk_b", DB_TYPE.Varchar2, p_rnk_b, DIRECTION.Input);
                    object[] resRnkB = SQL_SELECT_reader(@"select okpo, nmk 
                                                         from customer
                                                         where to_char(rnk) = :p_rnk_b");
                    if (null != resRnkB)
                    {
                        l_rnk_b = p_rnk_b;
                        l_okpo_b = Convert.ToString(resRnkB[0]);
                        l_nmk_b = Convert.ToString(resRnkB[1]);
                    }
                }
                // Если не нашли тогда ищем по номеру счёта

                if (null != p_nls_b && null == l_nmk_b)
                {
                    ClearParameters();
                    SetParameters("p_nls_b", DB_TYPE.Varchar2, p_nls_b, DIRECTION.Input);
                    SetParameters("p_kv_b", DB_TYPE.Varchar2, p_kv_b, DIRECTION.Input);

                    object[] resNLSB = SQL_SELECT_reader(@"select c.rnk,
                                                           c.nmk, 
                                                           c.okpo
                                                         from customer c,
                                                           accounts a
                                                         where to_char(a.nls) = :p_nls_b 
                                                           and to_char(a.kv)  = :p_kv_b
                                                           and a.rnk = c.rnk");
                    if (null != resNLSB)
                    {
                        l_rnk_b = Convert.ToString(resNLSB[0]);
                        l_nmk_b = Convert.ToString(resNLSB[1]);
                        l_okpo_b = Convert.ToString(resNLSB[2]);
                    }
                }
                //Если не нашли тогда ищем по ОКПО
                if (null != p_okpo_b && null == l_nmk_b)
                {
                    ClearParameters();
                    SetParameters("p_okpo_b", DB_TYPE.Varchar2, p_okpo_b, DIRECTION.Input);
                    object[] resOKPOBCOUNT = SQL_SELECT_reader(@"select count(c.okpo)
                                                           from customer c
                                                           where to_char(c.okpo) = :p_okpo_b");
                    decimal l_count_b = Convert.ToDecimal(resOKPOBCOUNT[0]);

                    if (l_count_b == 1)
                    {
                        ClearParameters();
                        SetParameters("p_okpo_b", DB_TYPE.Varchar2, p_okpo_b, DIRECTION.Input);
                        object[] resOKPOB = SQL_SELECT_reader(@"select c.rnk,
                                                             c.nmk,
                                                             c.okpo 
                                                           from customer c
                                                           where to_char(c.okpo) = :p_okpo_b");
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
            btOK.Enabled = false;
        }

    }


    protected void cbCompulsoryMon_CheckedChanged(object sender, EventArgs e)
    {
        if (cbCompulsoryMon.Checked == true)
        {
            cbInternalMob.Checked = false;

            rbSideA.Checked = true;
            rbSideB.Checked = true;

            rbSideA2.Checked = false;
            rbSideB2.Checked = false;

            tbKDFM02.Enabled = true;
            tbKDFM02_Name.Enabled = true;
            ibKDFM02.Enabled = true;
            tbPlus.Enabled = true;

            tbKDFM03.Enabled = false;
            tbKDFM03Name.Enabled = false;
            ibKDFM03.Enabled = false;
            tbPlus2.Enabled = false;

            if (rbSideA2.Checked == false && rbSideB2.Checked == false)
            {
                tbKDFM03.Text = "000";
                tbPlus2.Text = "";
            }


        }
        else
        {
            cbInternalMob.Checked = true;

            rbSideA.Checked = false;
            rbSideB.Checked = false;

            rbSideA2.Checked = true;
            rbSideB2.Checked = true;

            tbKDFM02.Enabled = false;
            tbKDFM02_Name.Enabled = false;
            ibKDFM02.Enabled = false;
            tbPlus.Enabled = false;

            tbKDFM03.Enabled = true;
            tbKDFM03Name.Enabled = true;
            ibKDFM03.Enabled = true;
            tbPlus2.Enabled = true;
            tbKDFM02.Text = "0000";
            tbPlus.Text = "";
        }
    }
    protected void cbInternalMob_CheckedChanged(object sender, EventArgs e)
    {
        if (cbInternalMob.Checked == false)
        {
            cbCompulsoryMon.Checked = true;

            rbSideA.Checked = true;
            rbSideB.Checked = true;

            rbSideA2.Checked = false;
            rbSideB2.Checked = false;

            tbKDFM02.Enabled = true;
            tbKDFM02_Name.Enabled = true;
            ibKDFM02.Enabled = true;
            tbPlus.Enabled = true;

            tbKDFM03.Enabled = false;
            tbKDFM03Name.Enabled = false;
            ibKDFM03.Enabled = false;
            tbPlus2.Enabled = false;

            tbKDFM03.Text = "000";
            tbPlus2.Text = "";
        }
        else
        {
            cbCompulsoryMon.Checked = false;

            rbSideA.Checked = false;
            rbSideB.Checked = false;

            rbSideA2.Checked = true;
            rbSideB2.Checked = true;

            tbKDFM02.Enabled = false;
            tbKDFM02_Name.Enabled = false;
            ibKDFM02.Enabled = false;
            tbPlus.Enabled = false;

            tbKDFM03.Enabled = true;
            tbKDFM03Name.Enabled = true;
            ibKDFM03.Enabled = true;
            tbPlus2.Enabled = true;

            if (rbSideA.Checked == false && rbSideB.Checked == false)
            {
                tbKDFM02.Text = "0000";
                tbPlus.Text = "";
            }
        }
    }
    protected void rbDailySideA_CheckedChanged(object sender, EventArgs e)
    {
        rbDailySideB.Checked = false;
        rbDailyBouth.Checked = false;

        rbSideA.Visible = false;
        rbSideB.Visible = false;
        rbSideA2.Visible = false;
        rbSideB2.Visible = false;
        ibtDailySideA.Enabled = true;
        ibtDailySideB.Enabled = false;

        tbKDFM03.Text = "000";
        tbKDFM03.Enabled = false;
        tbKDFM03Name.Enabled = false;
        ibKDFM03.Enabled = false;
        tbPlus2.Text = "";
        tbPlus2.Enabled = false;
               
        tbKDFM02.Enabled = true;
        tbKDFM02_Name.Enabled = true;
        ibKDFM02.Enabled = true;
        tbPlus.Enabled = true;

        rbSideA.Checked = true;
        rbSideB.Checked = true;
        rbSideA2.Checked = false;
        rbSideB2.Checked = false;

        cbCompulsoryMon.Checked = true;
        cbInternalMob.Checked = false;



    }
    protected void rbDailySideB_CheckedChanged(object sender, EventArgs e)
    {
        rbDailySideA.Checked = false;
        rbDailyBouth.Checked = false;

        rbSideA.Visible = false;
        rbSideB.Visible = false;
        rbSideA2.Visible = false;
        rbSideB2.Visible = false;
        ibtDailySideA.Enabled = false;
        ibtDailySideB.Enabled = true;

        tbKDFM03.Text = "000";
        tbKDFM03.Enabled = false;
        tbKDFM03Name.Enabled = false;
        ibKDFM03.Enabled = false;
        tbPlus2.Text = "";
        tbPlus2.Enabled = false;

        tbKDFM02.Enabled = true;
        tbKDFM02_Name.Enabled = true;
        ibKDFM02.Enabled = true;
        tbPlus.Enabled = true;

        rbSideA.Checked = true;
        rbSideB.Checked = true;
        rbSideA2.Checked = false;
        rbSideB2.Checked = false;

        cbCompulsoryMon.Checked = true;
        cbInternalMob.Checked = false;

    }
    protected void rbDailyBouth_CheckedChanged(object sender, EventArgs e)
    {
        rbDailySideA.Checked = false;
        rbDailySideB.Checked = false;

        rbSideA.Visible = true;
        rbSideB.Visible = true;
        rbSideA2.Visible = true;
        rbSideB2.Visible = true;
        ibtDailySideA.Enabled = true;
        ibtDailySideB.Enabled = true;
    }
    protected void rbSideA_CheckedChanged(object sender, EventArgs e)
    {
        if (rbSideB.Checked == false)
        {
            rbSideA2.Checked = false;
            cbCompulsoryMon.Checked = true;
            tbKDFM02.Enabled = true;
            tbKDFM02_Name.Enabled = true;
            ibKDFM02.Enabled = true;
            tbPlus.Enabled = true;
        }
        else
        {

            cbInternalMob.Checked = false;

            rbSideA.Checked = true;
            rbSideB.Checked = true;

            rbSideA2.Checked = false;
            rbSideB2.Checked = false;

            tbKDFM02.Enabled = true;
            tbKDFM02_Name.Enabled = true;
            ibKDFM02.Enabled = true;
            tbPlus.Enabled = true;

            tbKDFM03.Enabled = false;
            tbKDFM03Name.Enabled = false;
            ibKDFM03.Enabled = false;
            tbPlus2.Enabled = false;

            tbKDFM03.Text = "000";
            tbPlus2.Text = "";
        }
    }
    protected void rbSideB_CheckedChanged(object sender, EventArgs e)
    {
        if (rbSideA.Checked == false)
        {
            rbSideB2.Checked = false;
            cbCompulsoryMon.Checked = true;
            tbKDFM02.Enabled = true;
            tbKDFM02_Name.Enabled = true;
            ibKDFM02.Enabled = true;
            tbPlus.Enabled = true;
        }
        else
        {
            cbInternalMob.Checked = false;

            rbSideA.Checked = true;
            rbSideB.Checked = true;

            rbSideA2.Checked = false;
            rbSideB2.Checked = false;

            tbKDFM02.Enabled = true;
            tbKDFM02_Name.Enabled = true;
            ibKDFM02.Enabled = true;
            tbPlus.Enabled = true;

            tbKDFM03.Enabled = false;
            tbKDFM03Name.Enabled = false;
            ibKDFM03.Enabled = false;
            tbPlus2.Enabled = false;

            tbKDFM03.Text = "000";
            tbPlus2.Text = "";
        }
    }
    protected void rbSideA2_CheckedChanged(object sender, EventArgs e)
    {
        if (rbSideB2.Checked == false)
        {
            rbSideA.Checked = false;
            cbInternalMob.Checked = true;
            tbKDFM03.Enabled = true;
            tbKDFM03Name.Enabled = true;
            ibKDFM03.Enabled = true;
            tbPlus2.Enabled = true;
        }
        else
        {
            cbCompulsoryMon.Checked = false;

            rbSideA.Checked = false;
            rbSideB.Checked = false;

            rbSideA2.Checked = true;
            rbSideB2.Checked = true;

            tbKDFM02.Enabled = false;
            tbKDFM02_Name.Enabled = false;
            ibKDFM02.Enabled = false;
            tbPlus.Enabled = false;

            tbKDFM03.Enabled = true;
            tbKDFM03Name.Enabled = true;
            ibKDFM03.Enabled = true;
            tbPlus2.Enabled = true;

            tbKDFM02.Text = "0000";
            tbPlus.Text = "";
        }
    }
    protected void rbSideB2_CheckedChanged(object sender, EventArgs e)
    {
        if (rbSideA2.Checked == false)
        {
            rbSideB.Checked = false;
            cbInternalMob.Checked = true;
            tbKDFM03.Enabled = true;
            tbKDFM03Name.Enabled = true;
            ibKDFM03.Enabled = true;
            tbPlus2.Enabled = true;
        }
        else
        {
            cbCompulsoryMon.Checked = false;

            rbSideA.Checked = false;
            rbSideB.Checked = false;

            rbSideA2.Checked = true;
            rbSideB2.Checked = true;

            tbKDFM02.Enabled = false;
            tbKDFM02_Name.Enabled = false;
            ibKDFM02.Enabled = false;
            tbPlus.Enabled = false;

            tbKDFM03.Enabled = true;
            tbKDFM03Name.Enabled = true;
            ibKDFM03.Enabled = true;
            tbPlus2.Enabled = true;
            
            tbKDFM02.Text = "0000";
            tbPlus.Text = "";

        }
    }
    protected void tbKDFM02_TextChanged(object sender, EventArgs e)
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

        finally
        {
            DisposeOraConnection();
        }
    }
    protected void tbKDFM03_TextChanged(object sender, EventArgs e)
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

        finally
        {
            DisposeOraConnection();
        }
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
        int p_mode = 0;
        decimal p_ref = Convert.ToDecimal(Request["ref"]);
        string p_vid1 = tbCode.Text;
        string p_vid2 = tbKDFM02.Text;
        string p_comm2 = tbPlus.Text;
        string p_vid3 = tbKDFM03.Text;
        string p_comm3 = tbPlus2.Text;
        string p_rnka = tbDailyRNKA.Text;
        string p_rnkb = tbDailyRNKB.Text;

        if (rbDailySideA.Checked == true)
        {
            p_mode = 1;
        }

        if (rbDailySideB.Checked == true)
        {
            p_mode = 2;
        }

        if (rbDailyBouth.Checked == true)
        {
            if (rbSideA.Checked == true && rbSideB2.Checked == true)
            {
                p_mode = 4;
            }
            else if (rbSideA2.Checked == true && rbSideB.Checked == true)
            {
                p_mode = 5;
            }
            else
            {
                p_mode = 3;
            }
        }



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

        }
        catch (OracleException E)
        {
            string error = E.Message;
        }

        finally
        {
            DisposeOraConnection();
        }

        Session["FinminReload"] = "1";

        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "close", " window.close('this');", true);
    }
}