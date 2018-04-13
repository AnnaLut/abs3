using System;
using System.Collections;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Bars;
using Bars.Configuration;
using Bars.DocHand;
using Bars.DocPrint;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.LinkDocs;
using System.Collections.Generic;

namespace DocInput
{
    /// <summary>
    /// 
    /// </summary>	
    public partial class DocInputPage : BarsPage
    {
        //private string sFlags;
        protected OracleConnection con;

        private string TT_Flags;
        private string TT_KvA;
        private string TT_KvB;
        private string TT_KvALcv;
        private string TT_KvBLcv;
        private string TT_NlsA;
        private string TT_NlsB;
        private string TT_MfoB;
        private string TT_IdB;
        private string TT_NamB;
        private string TT_Sk;
        private string TT_Nazn;
        private string TT_S;
        private string TT_S2;
        private string[] Drecs_DATA;
        private string TT_Name;

        private string TT;
        private DateTime bDATE;
        private DateTime DatP;
        private string ourBankMfo;
        private string ourBankName;
        private string userKeyID;
        private int PAR_INTSIGN = 0;
        private int PAR_VISASIGN = 0;
        private string PAR_SIGNTYPE = "NBU";
        private int PAR_SEPNUM = 1;
        private int PAR_VOB2SEP = 1;
        private string PAR_VOB2SEP2;
        private int PAR_VOBORD = 1;
        private int PAR_VOBCONFIRM = 0;
        private int PAR_TICTOFILE = 1;
        private int PAR_SIGNCC = 0;
        private string PAR_REGNCODE = "00";
        private string PAR_SYSDATE;
        private string PAR_DEPUP;
        private string PAR_BANKYPE;
        // флаг платежа через единое окно
        private bool isSWI = false;
        // признак транслитерации (реквизит 20 = +)
        private bool isTransliterate = false;
        /// <summary>
        /// 
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                (new Bars.Configuration.ModuleSettings()).JsSettingsBlockRegister(this);

                LinkedDocs.ClearData();
                // Нужно только для генерации на странице __doPostback функции
                Page.GetPostBackEventReference(btFile);
                __BARSAXVER.Value = ConfigurationSettings.AppSettings["BarsAx.Version"];

                // SWI - делаем подмену tt для общей операции
                isSWI = (Request.Params["swi"] != null);
                if (isSWI)
                    CheckSWIPayment();
                else
                {
                    /// Операція
                    if (null == Request.Params["tt"]) throw new Exception("Параметр 'tt'(тип операции) не задан.");
                    TT = Request.Params["tt"].PadRight(3, ' ').ToUpper();
                    __TT.Value = Convert.ToString(Request.Params["tt"]).ToUpper();
                }

                /// Номер договору (депозити)
                __ND.Value = Convert.ToString(Request.Params["nd"]);

                /// Имя сертификата
                string fullCertName = Request.ClientCertificate.Subject;
                string certName = string.Empty;
                if (fullCertName != string.Empty)
                    certName = fullCertName.Substring(fullCertName.IndexOf("CN=") + 3);
                __CERTNAME.Value = certName;

                /// Вичитуємо глобальні дані
                GetGlobalData();
                /// Вичитуємо опис операції
                GetTtsRec();
                /// Читаем данные переданые через Url
                /// та узгоджуємо їх із вичитаними з налаштувань операції
                GetUrlRec();

                /// Збочуємося бо в нас є чеки
                if (TT_Flags[61] == '1')
                {
                    linked_docs.Style["visibility"] = "visible";
                    SumC.Attributes.Add("readonly", "readonly");
                    Session["IS_CHECK_PAYMENT"] = "true";
                }
                else
                {
                    Session["IS_CHECK_PAYMENT"] = "false";
                    sum_check.Value = String.Empty;
                }

                /// Ексклюзивно для Правекса - № документа = реф. + міняти не можна
                if (BankType.GetCurrentBank() == BANKTYPE.PRVX && PAR_BANKYPE == "PRVX")
                {
                    SetReadOnly(DocN, __DOCREF.Value);
                }

                Mfo_A.Text = ourBankMfo;
                Bank_A.Text = ourBankName;
                LabelTTName.Text = TT_Name;
                __FLAGS.Value = TT_Flags;
                __INTSIGN.Value = PAR_INTSIGN.ToString();
                __VISASIGN.Value = PAR_VISASIGN.ToString();
                __SIGNTYPE.Value = PAR_SIGNTYPE.ToString();
                __SEPNUM.Value = PAR_SEPNUM.ToString();
                __VOB2SEP.Value = PAR_VOB2SEP.ToString();
                __VOB2SEP2.Value = PAR_VOB2SEP2;
                __VOBCONFIRM.Value = PAR_VOBCONFIRM.ToString();
                __OURMFO.Value = ourBankMfo;
                __TICTOFILE.Value = PAR_TICTOFILE.ToString();
                __SIGNCC.Value = PAR_SIGNCC.ToString();
                __REGNCODE.Value = PAR_REGNCODE;

                Kv_A.Style.Add("TEXT-ALIGN", "CENTER");
                Kv_B.Style.Add("TEXT-ALIGN", "CENTER");
                Id_A.Style.Add("TEXT-ALIGN", "CENTER");
                Id_B.Style.Add("TEXT-ALIGN", "CENTER");

                DocN.MaxLength = 10;
                Nam_B.MaxLength = 38;

                #region Локализация

                //string strPayer = " плательщика";
                //string strRecipient = " получателя";
                string strLabelNameA = Resources.docinput.GlobalResources.LabelNameA;
                string strLabelDKA = Resources.docinput.GlobalResources.LabelDKA;
                string strLabelNameB = Resources.docinput.GlobalResources.LabelNameB;
                string strLabelDKB = Resources.docinput.GlobalResources.LabelDKB;
                if ("NADRA" == Convert.ToString(ConfigurationSettings.AppSettings["Product.Spec"]))
                {
                    strLabelDKA = string.Empty;
                    strLabelDKB = string.Empty;
                }

                string strId_A_ToolTip = Resources.docinput.GlobalResources.Id_A;
                string strNam_A_ToolTip = Resources.docinput.GlobalResources.Nam_A;
                string strNls_A_ToolTip = Resources.docinput.GlobalResources.Nls_A;
                string strMfo_A_ToolTip = Resources.docinput.GlobalResources.Mfo_A;
                string strKv_A_ToolTip = Resources.docinput.GlobalResources.Kv_A;
                string strBank_A_ToolTip = Resources.docinput.GlobalResources.Bank_A;

                string strId_B_ToolTip = Resources.docinput.GlobalResources.Id_B;
                string strNam_B_ToolTip = Resources.docinput.GlobalResources.Nam_B;
                string strNls_B_ToolTip = Resources.docinput.GlobalResources.Nls_B;
                string strMfo_B_ToolTip = Resources.docinput.GlobalResources.Mfo_B;
                string strKv_B_ToolTip = Resources.docinput.GlobalResources.Kv_B;
                string strBank_B_ToolTip = Resources.docinput.GlobalResources.Bank_B;

                if ("0" == __DK.Value || "2" == __DK.Value)
                {
                    //Если параметр DEP_UP не пустой, то поле дебет всегда верху
                    if (!string.IsNullOrEmpty(PAR_DEPUP))
                    {
                        SideA.Style.Add("position", "absolute");
                        SideB.Style.Add("position", "absolute");
                        SideB.Style["top"] = "expression(document.getElementById('tdDebet').offsetTop)";
                        SideA.Style["top"] = "expression(document.getElementById('tdKredit').offsetTop)";

                        HtmlTableRow trA = trSumA;
                        HtmlTableRow trB = trSumB;
                        tabSums.Rows.Remove(trSumA);
                        tabSums.Rows.Remove(trSumB);
                        tabSums.Rows.Insert(0, trB);
                        tabSums.Rows.Insert(2, trA);
                    }
                    LabelNameA.Text = strLabelNameB;//"Получатель";
                    LabelNameB.Text = strLabelNameA;//"Плательщик";
                    LabelDKA.Text = strLabelDKB;//"КРЕДИТ";
                    LabelDKB.Text = strLabelDKA;//"ДЕБЕТ";
                    LabelDKA.ForeColor = Color.Red;
                    LabelDKB.ForeColor = Color.Red;
                    SumA.ToolTip += " " + strLabelDKB;
                    SumB.ToolTip += " " + strLabelDKA;
                    Id_A.ToolTip = strId_B_ToolTip;
                    Nam_A.ToolTip = strNam_B_ToolTip;
                    Nls_A.ToolTip = strNls_B_ToolTip;
                    Mfo_A.ToolTip = strMfo_B_ToolTip;
                    Bank_A.ToolTip = strBank_B_ToolTip;
                    Kv_A.ToolTip = strKv_B_ToolTip;
                    Id_B.ToolTip = strId_A_ToolTip;
                    Nam_B.ToolTip = strNam_A_ToolTip;
                    Nls_B.ToolTip = strNls_A_ToolTip;
                    Mfo_B.ToolTip = strMfo_A_ToolTip;
                    Bank_B.ToolTip = strBank_A_ToolTip;
                    Kv_B.ToolTip = strKv_A_ToolTip;
                }
                else if ("1" == __DK.Value || "3" == __DK.Value)
                {
                    LabelNameA.Text = strLabelNameA;//"Плательщик";
                    LabelNameB.Text = strLabelNameB;//"Получатель";
                    LabelDKA.Text = strLabelDKA;//"ДЕБЕТ";
                    LabelDKB.Text = strLabelDKB;//"КРЕДИТ";
                    LabelDKA.ForeColor = Color.Blue;
                    LabelDKB.ForeColor = Color.Blue;
                    SumA.ToolTip += " " + strLabelDKA;
                    SumB.ToolTip += " " + strLabelDKB;
                    Id_A.ToolTip = strId_A_ToolTip;
                    Nam_A.ToolTip = strNam_A_ToolTip;
                    Nls_A.ToolTip = strNls_A_ToolTip;
                    Mfo_A.ToolTip = strMfo_A_ToolTip;
                    Bank_A.ToolTip = strBank_A_ToolTip;
                    Kv_A.ToolTip = strKv_A_ToolTip;
                    Id_B.ToolTip = strId_B_ToolTip;
                    Nam_B.ToolTip = strNam_B_ToolTip;
                    Nls_B.ToolTip = strNls_B_ToolTip;
                    Mfo_B.ToolTip = strMfo_B_ToolTip;
                    Bank_B.ToolTip = strBank_B_ToolTip;
                    Kv_B.ToolTip = strKv_B_ToolTip;
                }

                #endregion

                Nam_A.MaxLength = 38;
                Nam_B.MaxLength = 38;
                Id_A.MaxLength = 10;
                Id_B.MaxLength = 10;
                Nazn.MaxLength = 160;

                /// MultyCurrency
                if (TT_Flags[65] == '1')
                {
                    SumC.Style["VISIBILITY"] = "hidden";
                    LabelSumС.Visible = false;
                    Kv_A.Attributes["onchange"] = "checkKv(0,form);if(form.Kv_A.value != '' && form.Kv_B.value != '') cDocHand(5,form)";
                    Kv_B.Attributes["onchange"] = "checkKv(1,form);if(form.Kv_A.value != '' && form.Kv_B.value != '') cDocHand(5,form)";
                    CrossRat.Attributes["onblur"] = "CRat_Blur()";
                    if (TT_Flags[11] == '1')
                    {
                        CrossRat.ReadOnly = true;
                        SumB.ReadOnly = true;
                    }
                    if (string.Empty != TT_KvA && string.Empty != TT_KvB)
                    {
                        string[] rates = GetXRate(TT_KvA, TT_KvB);
                        // Признак торговой операции
                        if (TT_Flags[59] == '1')
                        {
                            if ("0" == __DK.Value || "2" == __DK.Value)
                                CrossRat.Text = (rates[2] == "null") ? ("0") : (rates[2]);
                            else
                                CrossRat.Text = (rates[1] == "null") ? ("0") : (rates[1]);
                        }
                        else
                            CrossRat.Text = rates[0];
                    }
                    lbNominal.Text = "Курс";
                    lbNominal.Visible = true;
                    CrossRat.ToolTip = lbNominal.Text;
                }
                else
                {
                    LabelSumA.Visible = false;
                    LabelSumALcv.Visible = false;
                    LabelSumB.Visible = false;
                    LabelSumBLcv.Visible = false;
                    SumA.Style["VISIBILITY"] = "hidden";
                    SumB.Style["VISIBILITY"] = "hidden";
                    CrossRat.Style["VISIBILITY"] = "hidden";
                    Kv_A.Attributes["onchange"] = "javascript:checkKv(0,form);";
                    Kv_B.Attributes["onchange"] = "javascript:checkKv(1,form);";
                }
                // Срочные платежи
                if (TT_Flags[12] == '1' || TT_Flags[12] == '2')
                {
                    cbPriority.Visible = true;
                    if (TT_Flags[12] == '2')
                        cbPriority.Checked = true;
                }
                /// Номинал
                if (TT_Flags[58] == '1')
                {
                    CrossRat.Style["VISIBILITY"] = "visible";
                    CrossRat.Attributes["onblur"] = "Nom_Calc('" + TT_S + "',form)";
                    lbNominal.Visible = true;
                    CrossRat.ToolTip = lbNominal.Text;
                }
                else if (TT_Flags[14] == '1')
                {
                    CrossRat.Style["VISIBILITY"] = "visible";
                    //CrossRat.Attributes["onblur"] = "Nom_Calc('" + TT_S + "',form)";
                    lbNominal.Visible = true;
                    lbNominal.Text = "Еквівалент";
                    CrossRat.ToolTip = lbNominal.Text;
                }
                else
                {
                    if (TT_Flags[65] == '1')
                    {
                        if (!string.IsNullOrEmpty(TT_S))
                        {
                            SumA.Attributes["onfocus"] = "Sum_Calc('" + TT_S + "',form,this)";
                            SumA.Attributes["formula"] = TT_S;
                        }
                        if (!string.IsNullOrEmpty(TT_S2))
                        {
                            SumB.Attributes["onfocus"] = "Sum_Calc('" + TT_S2 + "',form,this)";
                            SumB.Attributes["formula"] = TT_S2;
                        }
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(TT_S))
                        {
                            SumC.Attributes["onfocus"] = "Sum_Calc('" + TT_S + "',form,this)";
                            SumC.Attributes["formula"] = TT_S;
                        }
                    }
                }

                Kv_A.Attributes["onblur"] = "javascript:chkAccount(0,form,this)";
                Nls_A.Attributes["onblur"] = "javascript:chkAccount(0,form,this);";

                btPayIt.Attributes["onclick"] = "javascript:return (Validate(form))";

                CkAcc();

                /// Вичитка даних про рахунки + перевірка доступності
                if ((TT_NlsA != string.Empty) && (TT_KvA != string.Empty))
                    GetNlsName(Id_A, Nam_A, TT_NlsA, Convert.ToDecimal(TT_KvA));

                // InterBank
                if (TT_MfoB != string.Empty)
                {
                    SetReadOnly(Mfo_B, TT_MfoB);
                    /// підставляємо що прийшло з URL тому що виплата по міжбанку
                    if (!string.IsNullOrEmpty(TT_IdB))
                        SetReadOnly(Id_B, TT_IdB);
                    if (!string.IsNullOrEmpty(TT_NamB))
                        SetReadOnly(Nam_B, TT_NamB);
                    cDocHandler.Bank bank = new cDocHandler.Bank(Context, TT_MfoB);
                    Bank_B.Text = bank.Nb;

                    if ((TT_NlsB != string.Empty) && (TT_KvB != string.Empty))
                        GetNlsNameAlien(Id_B, Nam_B, TT_NlsB, Convert.ToDecimal(TT_KvB), TT_MfoB);
                }
                /// Для правексу виключаємо перевірку
                /// бо там не зовсім такі як треба операції
                /// fli = 0 але вони міжбанківські
                if (TT_Flags[64] == '0' || TT_Flags[64] == '2')
                {
                    SetReadOnly(Mfo_B, ourBankMfo);
                    Bank_B.Text = ourBankName;
                    if ((TT_NlsB != string.Empty) && (TT_KvB != string.Empty))
                        GetNlsName(Id_B, Nam_B, TT_NlsB, Convert.ToDecimal(TT_KvB));
                    Kv_B.Attributes["onblur"] = "javascript:chkAccount(1,form,this);";
                }
                else
                {

                    Mfo_B.Attributes["onblur"] = "javascript:cDocHand(2,form);";
                    Mfo_B.Attributes["onkeydown"] = "javascript:selectMfo(event);";
                }

                Nls_B.Attributes["onblur"] = "javascript:chkAccount(1,form,this);";
                Nazn.Attributes["onkeydown"] = "javascript:selectNazn(event);";
                string b_mfo_a = (Mfo_A.Text == ourBankMfo) ? ("1") : ("0");
                string b_mfo_b = (Mfo_B.Text == ourBankMfo) ? ("1") : ("0");
                Nls_A.Attributes["onkeydown"] = "javascript:selectAccounts(event,this," + b_mfo_a + ");";
                Nls_B.Attributes["onkeydown"] = "javascript:selectAccounts(event,this," + b_mfo_b + ");";

                VobListFill();
                DatDFill();

                if (Request.Params["bal"] == "0")
                {
                    // tbOst.Visible = false;
                    tbOst.Style.Add("display", "none");
                    // tbZn.Visible = false;
                    tbZn.Style.Add("display", "none");
                }

                /// Востановление данных по существуещему документу
                if (null != Request.Params["refDoc"])
                    RessurectDocFromRef();

                if (null != Request.Params["insession"] && Request.Params["insession"] == "1")
                    RessurectDocFromSession();

                if (!String.IsNullOrEmpty(Request.QueryString["qdoc"]))
                {
                    QdocPrepareControls();
                    QdocDrecsFill();
                }
                /// Створюємо додаткові реквізити операції
                else
                    DRecsFill();

                ///--tvSukhov--
                /// Читаємо додаткові реквізити передані через url
                GetUrlDRec();

                __DOCKEY.Value = userKeyID;
                __BDATE.Value = bDATE.ToString("yyMMdd");
                __BDATEF.Value = bDATE.ToString("yyyy/MM/dd hh:mm:ss");
                __DATP.Value = DatP.ToString("yyMMdd");
                if (TT_Flags[5] == '1')
                    __VDATE.Value = DateTime.Now.ToString("yyMMdd");
                else
                    __VDATE.Value = bDATE.ToString("yyMMdd");

                //дата информационного запроса (используется при подписи документа)
                if (!String.IsNullOrEmpty(Request.QueryString["datp"]))
                {
                    DateTime qDocDatP;
                    try
                    {
                        qDocDatP = Convert.ToDateTime(Request.QueryString["datp"].ToString());
                    }
                    catch (FormatException)
                    {
                        qDocDatP = DatP;
                    }
                    __QDOC_DATP.Value = qDocDatP.ToString("yyMMdd");
                }
                __IS_QDOC.Value = String.IsNullOrEmpty(Request.QueryString["qdoc"]) ? "0" : "1";
            }
            else
            {
                string val = Drecs_ids.Value;
                string[] items = val.Split(',');
                Drecs_DATA = new string[items.Length - 1];

                for (int i = 0; i < items.Length - 1; i++)
                {
                    Drecs_DATA[i] = Request.Form[items[i]];
                }
            }

            // Register our javascripts
            string[] js_list = new string[7] { "cDocHand", "cDocHandAcc", "chkForm", "chkSum", "cDocSign", "cFormProc", "cDocPay" };
            foreach (string js_nam in js_list)
            {
                if (!ClientScript.IsClientScriptBlockRegistered(js_nam))
                    ClientScript.RegisterClientScriptBlock(Page.GetType(), js_nam, "<script language=\"javascript\" src=\"js/" + js_nam + ".js?v1.9.45\"></script>");
            }
            if (1 == PAR_SIGNCC)
            {
                if (!ClientScript.IsClientScriptBlockRegistered("capicom"))
                    ClientScript.RegisterClientScriptBlock(Page.GetType(), "capicom", "<script language=\"javascript\" src=\"/Common/Script/CapiComSign.js\"></script>");
            }

            // Для Надр прячем платежные инструкции, 
            if ("NADRA" == Convert.ToString(ConfigurationSettings.AppSettings["Product.Spec"]))
            {
                HideControl(Nls_A);
                //HideControl(Kv_A);
                HideControl(Nam_A);
                HideControl(Id_A);
                //HideControl(Bank_A);
                //HideControl(Mfo_A);
                HideControl(Nls_B);
                //HideControl(Kv_B);
                HideControl(Nam_B);
                HideControl(Id_B);
                //HideControl(Bank_B);
                //HideControl(Mfo_B);
                if (!IsPostBack && TT_Flags[38] == '1')
                    Nls_B.Width = Unit.Pixel(1);
            }

            //if (BankType.GetCurrentBank() == BANKTYPE.PRVX)
            //{
            //    Session["DPT_NAM_A"] = null;
            //    Session["DPT_ID_A"] = null;
            //    Session["DPT_NAM_B"] = null;
            //    Session["DPT_ID_B"] = null;

            //    if (Convert.ToString(__ND.Value) != String.Empty)
            //    {
            //        if (Deposit.AccountIsCash(Nls_A.Text, Kv_A.Text) == "1")
            //        {
            //            Deposit dpt = new Deposit(Convert.ToDecimal(__ND.Value));
            //            Session["DPT_NAM_A"] = dpt.Client.Name;
            //            Session["DPT_ID_A"] = dpt.Client.Code;
            //        }
            //        if (Deposit.AccountIsCash(Nls_B.Text, Kv_B.Text) == "1")
            //        {
            //            Deposit dpt = new Deposit(Convert.ToDecimal(__ND.Value));
            //            Session["DPT_NAM_B"] = dpt.Client.Name;
            //            Session["DPT_ID_B"] = dpt.Client.Code;
            //        }
            //    }
            //}
        }

        private void HideControl(TextBox tb)
        {
            if (tb.ReadOnly)
                tb.ForeColor = Color.FromName("#f0f0f0");
        }

        /// <summary>
        /// Установка параметров документа из сессии
        /// </summary>
        private void RessurectDocFromSession()
        {
            if (Session["Doc.Mfo_A"] != null)
            {
                SetReadOnly(Mfo_A, Convert.ToString(Session["Doc.Mfo_A"]));
                cDocHandler.Bank bank = new cDocHandler.Bank(Context, Mfo_A.Text);
                SetReadOnly(Bank_A, bank.Nb);
            }
            if (Session["Doc.Mfo_B"] != null)
            {

                cDocHandler.Bank bank = new cDocHandler.Bank(Context, Convert.ToString(Session["Doc.Mfo_B"]));
                if (string.IsNullOrEmpty(bank.Mfo))
                {
                    Response.Write("<script>alert('Не знайдено банк " + Convert.ToString(Session["Doc.Mfo_B"]) + " або заблоковано.' )</script>");
                    Mfo_B.Text = string.Empty;
                }
                else
                {
                    SetReadOnly(Mfo_B, Convert.ToString(Session["Doc.Mfo_B"]));
                    SetReadOnly(Bank_B, bank.Nb);
                }
            }

            if (Session["Doc.Nls_A"] != null)
                SetReadOnly(Nls_A, Convert.ToString(Session["Doc.Nls_A"]));
            if (Session["Doc.Nam_A"] != null)
                SetReadOnly(Nam_A, Convert.ToString(Session["Doc.Nam_A"]));
            if (Session["Doc.Kv_A"] != null)
                SetReadOnly(Kv_A, Convert.ToString(Session["Doc.Kv_A"]));
            if (Session["Doc.Id_A"] != null)
                SetReadOnly(Id_A, Convert.ToString(Session["Doc.Id_A"]));

            if (Session["Doc.SumA"] != null)
                SetReadOnly(SumA, Convert.ToString(Session["Doc.SumA"]));
            if (Session["Doc.SumB"] != null)
                SetReadOnly(SumB, Convert.ToString(Session["Doc.SumB"]));
            if (Session["Doc.SumC"] != null)
                SetReadOnly(SumC, Convert.ToString(Session["Doc.SumC"]));

            if (Session["Doc.Nls_B"] != null)
                SetReadOnly(Nls_B, Convert.ToString(Session["Doc.Nls_B"]));
            if (Session["Doc.Nam_B"] != null)
                SetReadOnly(Nam_B, Convert.ToString(Session["Doc.Nam_B"]));
            if (Session["Doc.Kv_B"] != null)
                SetReadOnly(Kv_B, Convert.ToString(Session["Doc.Kv_B"]));
            if (Session["Doc.Id_B"] != null)
                SetReadOnly(Id_B, Convert.ToString(Session["Doc.Id_B"]));

            if (Session["Doc.Nazn"] != null)
                SetReadOnly(Nazn, Convert.ToString(Session["Doc.Nazn"]));
            else
                SetReadOnly(Nazn, Nazn.Text);

            SetReadOnly(Nazn, Nazn.Text.Replace("\n", "").Replace("\r", ""));
            SetReadOnly(DocN, DocN.Text);
            DocN.Text = DocN.Text.Trim();

            // Доп. реквизиты
            foreach (string sessionKey in Session.Keys)
            {
                if (sessionKey.StartsWith("Doc.Reqv_"))
                {
                    string reqv = "reqv_" + sessionKey.Replace("Doc.Reqv_", "");
                    Control ctrl = FindControl(reqv);
                    if (ctrl != null && ctrl is HtmlInputText)
                    {
                        (ctrl as HtmlInputText).Value = Convert.ToString(Session[sessionKey]);
                        (ctrl as HtmlInputText).Disabled = true;
                        if (ctrl.Parent.Controls.Count > 1)
                            ctrl.Parent.Controls[1].Visible = false;
                    }
                }
            }
            // Закрываем все реквизиты
            foreach (string elem in Drecs_ids.Value.Split(','))
            {
                Control ctrl = FindControl(elem);
                if (ctrl != null && ctrl is HtmlInputText)
                {
                    (ctrl as HtmlInputText).Disabled = true;
                    if (ctrl.Parent.Controls.Count > 1)
                        ctrl.Parent.Controls[1].Visible = false;
                }
            }

            Hashtable tabSesionKeysForRemove = new Hashtable();
            foreach (string sessionKey in Session.Keys)
            {
                if (sessionKey.StartsWith("Doc."))
                    tabSesionKeysForRemove.Add(sessionKey, sessionKey);
            }

            foreach (string sessionKey in tabSesionKeysForRemove.Keys)
            {
                Session.Remove(sessionKey);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void RessurectDocFromRef()
        {
            try
            {
                InitOraConnection();
                string strRef = Request.Params["refDoc"];
                SetRole("WR_DOCVIEW");
                ClearParameters();
                SetParameters("ref", DB_TYPE.Decimal, strRef, DIRECTION.Input);
                ArrayList reader = SQL_reader("select id_a,nam_a,kv,nlsa,mfoa,id_b,nam_b,kv2,nlsb,mfob,nazn,s,s2,v.vob,v.name, (select value from operw where ref=o.ref and tag='20') from oper o, vob v where o.vob=v.vob and o.ref=:ref");
                if (reader.Count > 0)
                {
                    if (string.Empty == Id_A.Text)
                        Id_A.Text = Convert.ToString(reader[0]);
                    if (string.Empty == Nam_A.Text)
                        Nam_A.Text = Convert.ToString(reader[1]);
                    if (string.Empty == Kv_A.Text)
                        Kv_A.Text = Convert.ToString(reader[2]);
                    if (string.Empty == Nls_A.Text)
                        Nls_A.Text = Convert.ToString(reader[3]);
                    if (string.Empty == Mfo_A.Text)
                        Mfo_A.Text = Convert.ToString(reader[4]);
                    if (string.Empty == Id_B.Text)
                        Id_B.Text = Convert.ToString(reader[5]);
                    if (string.Empty == Nam_B.Text)
                        Nam_B.Text = Convert.ToString(reader[6]);
                    if (string.Empty == Kv_B.Text)
                        Kv_B.Text = Convert.ToString(reader[7]);
                    if (string.Empty == Nls_B.Text)
                        Nls_B.Text = Convert.ToString(reader[8]);
                    if (string.Empty == Mfo_B.Text)
                    {
                        Mfo_B.Text = Convert.ToString(reader[9]);
                        cDocHandler.Bank bank = new cDocHandler.Bank(Context, Mfo_B.Text);
                        if (string.IsNullOrEmpty(bank.Mfo))
                        {
                            Response.Write("<script>alert('Не знайдено банк " + Mfo_B.Text + " або заблоковано.' )</script>");
                            Mfo_B.Text = string.Empty;
                        }
                        else
                            Bank_B.Text = bank.Nb;

                    }
                    if (string.Empty == Nazn.Text)
                    {
                        Nazn.Text = Convert.ToString(reader[10]);
                        __NAZN.Value = Nazn.Text;
                    }
                    if (VobList.Items.Count == 0)
                    {
                        VobList.Items.Add(Convert.ToString(reader[14]));
                        VobList.Items[0].Value = Convert.ToString(reader[13]);
                    }
                    isTransliterate = (Convert.ToString(reader[15]) == "+");
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        /// <summary>
        /// Крос-курс 
        /// </summary>
        private string[] GetXRate(string kv1, string kv2)
        {
            string[] result = new string[3];
            string bdate = "20" + bDATE.ToString("yyMMdd");

            try
            {
                cDocHandler.CrossRate rates = new cDocHandler.CrossRate(Context, kv1, kv2, bdate);
                result[0] = rates.RatO;
                result[1] = rates.RatB;
                result[2] = rates.RatS;
            }
            catch
            {
                result[0] = "0";
                result[1] = "0";
                result[2] = "0";
            }

            return result;
        }
        /// <summary>
        /// Заполнение даты документа
        /// </summary>
        private void DatDFill()
        {
            string s_dateD = string.Empty;
            if (TT_Flags[4] == '1')
                s_dateD = PAR_SYSDATE;
            else if (TT_Flags[4] == '2')
                s_dateD = DateTime.Now.ToString("dd/MM/yyyy");
            else
                s_dateD = bDATE.ToString("dd/MM/yyyy");
            DocD_TextBox.Text = s_dateD.Replace(".", "/");
        }
        /// <summary>
        /// Заполнение списка видов документов
        /// </summary>
        private void VobListFill()
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            con = conn.GetUserConnection(Context);

            try
            {
                OracleCommand cmd = con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                ModuleSettings ms = new ModuleSettings();
                // Новая колонка в табличке VOB
                string colFRTempate = string.Empty;
                if (ms.Documents.EnhancePrint)
                    colFRTempate = ",v.rep_prefix_fr";

                cmd.CommandText = "SELECT v.name,v.vob " + colFRTempate + " FROM vob v, tts_vob t WHERE t.vob=v.vob AND t.tt=:TT ORDER by ";

                if (PAR_VOBORD == 1)
                    cmd.CommandText += "t.ord";
                else
                    cmd.CommandText += "v.name";

                cmd.Parameters.Add("TT", OracleDbType.Varchar2, TT, ParameterDirection.Input);

                OracleDataReader rdr = cmd.ExecuteReader();
                int i = -1;
                while (rdr.Read())
                {
                    i++;
                    VobList.Items.Add(rdr.GetOracleString(0).Value);
                    VobList.Items[i].Value = Convert.ToString(rdr.GetOracleDecimal(1).Value);
                    if (ms.Documents.EnhancePrint)
                        VobList.Items[i].Attributes.Add("frt", Convert.ToString(rdr.GetValue(2)));
                }
                rdr.Close();
                rdr.Dispose();
                //VOB from url
                if (Request["Vob"] != null)
                    VobList.SelectedValue = Request["Vob"];
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
        /// <summary>
        /// Заповнення додаткових реквізитів операції
        /// </summary>
        private void DRecsFill()
        {
            HtmlTable drecs = Drecs;

            if (TT_Flags[15] == '1')
            {
                drecs = DrecsTop;
                Drecs.Visible = false;
            }
            else
            {
                DrecsTop.Visible = false;
            }

            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            con = conn.GetUserConnection(Context);

            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                if (TT_Flags[3] == '1')
                {
                    lbDatVal.Visible = true;
                    DatV_TextBox.Visible = true;
                    bool valid_request_vdat = false;
                    try
                    {
                        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                        cinfo.DateTimeFormat.DateSeparator = "/";

                        DateTime vdat_param = DateTime.Now;
                        if (Request["DATV_R"] != null)
                            vdat_param = Convert.ToDateTime(Request["DATV_R"], cinfo);
                        else
                            vdat_param = Convert.ToDateTime(Request["DatV"], cinfo);
                        valid_request_vdat = true;
                    }
                    catch
                    {
                        valid_request_vdat = false;
                    }

                    // Корегуючі проводки
                    if (VobList.SelectedValue == "96")
                    {
                        DateTime startDate = new DateTime(bDATE.Year, bDATE.Month, 1);
                        startDate = startDate.AddDays(-1);
                        cmd.CommandText = "select kv from holiday where kv=980 and holiday=:startDate";
                        while (true)
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("startDate", OracleDbType.Date, startDate, ParameterDirection.Input);
                            string result = Convert.ToString(cmd.ExecuteScalar());
                            if (string.IsNullOrEmpty(result)) break;
                            startDate = startDate.AddDays(-1);
                        }
                        DatV_TextBox.Text = startDate.ToString("dd/MM/yyyy").Replace(".", "/");
                    }
                    else if (VobList.SelectedValue == "99")
                    {
                        DateTime startDate = new DateTime(bDATE.Year, 1, 1);
                        startDate = startDate.AddDays(-1);
                        cmd.CommandText = "select kv from holiday where kv=980 and holiday=:startDate";
                        while (true)
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("startDate", OracleDbType.Date, startDate, ParameterDirection.Input);
                            string result = Convert.ToString(cmd.ExecuteScalar());
                            if (string.IsNullOrEmpty(result)) break;
                            startDate = startDate.AddDays(-1);
                        }
                        DatV_TextBox.Text = startDate.ToString("dd/MM/yyyy").Replace(".", "/");
                    }
                    // 5-флаг - дата валютирования системная
                    else if (TT_Flags[5] == '1')
                    {
                        DatV_TextBox.Text = DateTime.Now.ToString("dd/MM/yyyy").Replace(".", "/");
                    }
                    else if (Request["DatV"] != null && valid_request_vdat)
                    {
                        DatV_TextBox.Text = Request["DatV"];
                    }
                    else if (Request["DATV_R"] != null && valid_request_vdat)
                    {
                        DatV_TextBox.Text = Request["DATV_R"];
                        DatV_TextBox.Enabled = false;
                    }
                    else
                    {
                        DatV_TextBox.Text = bDATE.ToString("dd/MM/yyyy").Replace(".", "/");
                    }

                    if ("NADRA" == Convert.ToString(ConfigurationSettings.AppSettings["Product.Spec"]) ||
                        (new ModuleSettings()).Documents.ShiftValueDate)
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandText = "select bars_cash.current_shift from dual";
                        int shift = Convert.ToInt32(cmd.ExecuteScalar());
                        // Якщо 2 зміна, то дата валютування наступна
                        if (shift > 2)
                        {
                            cmd.CommandText = "select to_char(NP_BDATE(sysdate, 1),'dd/MM/yyyy') from dual";
                            DatV_TextBox.Text = Convert.ToString(cmd.ExecuteScalar());
                        }
                    }
                }
                if (TT_Flags[49] == '1')
                {
                    lbDatVal2.Visible = true;
                    DatV2_TextBox.Visible = true;
                    DatV2_TextBox.Text = bDATE.ToString("dd/MM/yyyy").Replace(".", "/");
                }

                // Flag 6 - заборона вводу дати валютування
                if (TT_Flags[6] == '1')
                {
                    DatV_TextBox.Enabled = false;
                }

                cmd.Parameters.Clear();

                /// Якщо немає значення по замовчуванню 
                cmd.CommandText = "select column_name from all_tab_cols where owner = 'BARS' and table_name = 'OP_FIELD' and column_name = 'DEFAULT_VALUE'";
                String col_name = Convert.ToString(cmd.ExecuteScalar());

                cmd.CommandText = "select column_name from all_tab_cols where owner = 'BARS' and table_name = 'OP_RULES' and column_name = 'NOMODIFY'";
                String col_nomod = Convert.ToString(cmd.ExecuteScalar());

                col_name = (col_name != "DEFAULT_VALUE") ? " null " : " a.default_value ";
                col_nomod = (col_nomod != "NOMODIFY") ? " 0 " : " b.nomodify ";

                cmd.CommandText = "SELECT a.tag, a.name, a.browser, " +
                    " b.opt, b.val, a.chkr, a.vspo_char, b.used4input, " +
                    " decode(a.browser,null,0,1), " +
                    col_name + "," + col_nomod + ", fmt" +
                    " FROM op_field a, op_rules b " +
                    " WHERE a.tag=b.tag AND b.tt=:TT AND (b.used4input=1 or b.tag in ('KURS','HERIT','NOM','f') ) " +
                    " ORDER BY b.ord ";
                cmd.Parameters.Add("TT", OracleDbType.Varchar2, TT, ParameterDirection.Input);

                OracleDataReader rdr = cmd.ExecuteReader();

                drecs.Rows.Clear();
                int i = -1, deltaTab = 0;

                while (rdr.Read())
                {
                    i++;
                    HtmlTableRow dop_rec_row = new HtmlTableRow();
                    dop_rec_row.Cells.Add(new HtmlTableCell());
                    dop_rec_row.Cells.Add(new HtmlTableCell());

                    drecs.Rows.Add(dop_rec_row);

                    String Checker = Convert.ToString(rdr.GetValue(5));
                    String op_field = Convert.ToString(rdr.GetValue(0));
                    String vspo_char = Convert.ToString(rdr.GetValue(6)).Trim();
                    op_field = op_field.Trim();
                    String fmt = Convert.ToString(rdr.GetValue(11)).Trim().ToUpper();
                    String ControlName = String.Format("reqv_{0}", op_field);

                    /// Хоч якось намагаємося вирішити проблему з N і n
                    if (ControlName == "reqv_n")
                        ControlName = "reqv_n$";
                    else if (ControlName == "reqv_ф")
                        ControlName = "reqv_ф$";

                    Drecs_ids.Value += ControlName + ",";

                    if (!rdr.IsDBNull(3))
                    {
                        if (Convert.ToString(rdr.GetValue(3)).ToUpper() == "M")
                        {
                            drecs.Rows[i].Cells[0].Style.Add("color", "red");
                            Mand_Drecs_ids.Value += ControlName + ",";
                        }
                    }

                    drecs.Rows[i].Cells[0].Style.Add("WIDTH", "222px");
                    drecs.Rows[i].Cells[0].InnerText = Convert.ToString(rdr.GetValue(1));
                    drecs.Rows[i].Cells[0].Style.Add("FONT-FAMILY", "Verdana");
                    drecs.Rows[i].Cells[0].Style.Add("FONT-SIZE", "10pt");

                    int tab_index = (70 + i) + deltaTab;

                    String nomodify = Convert.ToString(rdr.GetValue(10));
                    /// Обчислення значення по замовчуванню
                    String query = Convert.ToString(rdr.GetValue(9));
                    /// Значення задане у налаштуванні операції є найбільш пріоритетним
                    String valueDopReq = Convert.ToString(rdr.GetValue(4));
                    /// Заповняємо додатковий реквізит КУРС
                    if (ControlName.ToUpper() == "REQV_KURS" && !string.IsNullOrEmpty(CrossRat.Text) && CrossRat.Text != "null")
                        valueDopReq = Convert.ToString(Math.Round(Convert.ToDecimal(CrossRat.Text.Replace(" ", "").Replace(",", ".")), 4));
                    /// Якщо воно не задане - обчислюємо формулу
                    if (valueDopReq == String.Empty && query != String.Empty)
                    {
                        int paramstart = query.IndexOf(":") + 1;
                        int length = (query.IndexOf(" ", paramstart) > 0) ? query.IndexOf(" ", paramstart) - paramstart : query.Length - paramstart;
                        String parname = (paramstart > 1) ? query.Substring(paramstart, length) : String.Empty;
                        String param = Request[parname];
                        bool isBindPar = query.IndexOf(":") > 0; // чи є bind-змінна в запиті
                        valueDopReq = EvalOpField(TT, op_field, param, isBindPar);
                        if (string.IsNullOrEmpty(valueDopReq))
                            valueDopReq = Convert.ToString(rdr.GetValue(4));
                    }
                    // Если пришли POST-ом доп. реквизиты 
                    decimal sd = 0;
                    if (ControlName == "reqv_PCOMA")
                    {
                        if (Request.Form["reqv_SUM_COM_ALL"] != null)
                        {
                            valueDopReq = System.Web.HttpUtility.UrlDecode(Convert.ToString(Request.Form["reqv_SUM_COM_ALL"])).Replace(",", ".").Replace(" ", "");
                        }
                        if (decimal.TryParse(valueDopReq, out sd))
                            valueDopReq = Math.Round(sd, 2).ToString();
                    }
                    else if (ControlName == "reqv_PCOMB")
                    {
                        if (Request.Form["reqv_SUM_COM_BANK"] != null)
                            valueDopReq = System.Web.HttpUtility.UrlDecode(Convert.ToString(Request.Form["reqv_SUM_COM_BANK"])).Replace(",", ".").Replace(" ", "");
                        if (decimal.TryParse(valueDopReq, out sd))
                            valueDopReq = Math.Round(sd, 2).ToString();
                    }
                    else
                    {
                        if (Request.Form[ControlName] != null)
                            valueDopReq = Convert.ToString(Request.Form[ControlName]);
                    }

                    if (__ISSWI.Value == "1")
                    {
                        if (ControlName == "reqv_NDREZ" && Request.Form["reqv_REZID"] == "2")
                        {
                            drecs.Rows[i].Cells[0].Style.Add("color", "red");
                            Mand_Drecs_ids.Value += ControlName + ",";
                        }
                        if (ControlName == "reqv_NAMED")
                        {
                            cmd.CommandText = "select f_swi_map_passp(:val) from dual";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("val", OracleDbType.Varchar2, Request.Form[ControlName], ParameterDirection.Input);
                            valueDopReq = Convert.ToString(cmd.ExecuteScalar());
                        }
                    }

                    if (null != Request.Params["refDoc"])
                    {
                        cmd.CommandText = conn.GetSetRoleCommand("WR_DOCVIEW");
                        cmd.ExecuteNonQuery();
                        if (isTransliterate && ",reqv_50K,reqv_52D,reqv_57D,reqv_58D,reqv_59,reqv_70,reqv_72".IndexOf(ControlName) > 0)
                            cmd.CommandText = "select bars_swift.SwiftToStr(value,'RUR6') from operw where trim(tag)=:tag and ref=:ref";
                        else
                            cmd.CommandText = "select value from operw where trim(tag)=:tag and ref=:ref";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("tag", OracleDbType.Varchar2,
                            ControlName.Replace("$", String.Empty).Replace("reqv_", ""),
                            ParameterDirection.Input);
                        cmd.Parameters.Add("ref", OracleDbType.Decimal, Request.Params["refDoc"], ParameterDirection.Input);
                        valueDopReq = Convert.ToString(cmd.ExecuteScalar());
                    }

                    drecs.Rows[i].Cells[1].Style.Add("WIDTH", "332px");
                    drecs.Rows[i].Cells[1].NoWrap = true;

                    HtmlControl field;
                    if ("SWT" == fmt && "F" == vspo_char)
                    {
                        field = new HtmlTextArea();
                        (field as HtmlTextArea).Value = valueDopReq;
                        (field as HtmlTextArea).Rows = 3;
                    }
                    else
                    {
                        field = new HtmlInputText();
                        (field as HtmlInputText).Value = valueDopReq;
                        (field as HtmlInputText).MaxLength = 200;
                    }

                    field.ID = ControlName;
                    field.Attributes["checker"] = Checker;
                    field.Attributes["tag"] = ControlName.Replace("reqv_", "");
                    field.Attributes["vspo"] = vspo_char;
                    field.Attributes["TabIndex"] = Convert.ToString(tab_index);

                    if (nomodify == "1")
                    {
                        field.Attributes["readOnly"] = "true";
                        field.Style["background"] = "#f0f0f0";
                        field.Attributes["TabIndex"] = "1000";
                    }

                    /// Ексклюзивно для Правекса - заповнені дод. реквізити міняти не можна
                    if (BankType.GetCurrentBank() == BANKTYPE.PRVX && PAR_BANKYPE == "PRVX")
                    {
                        if (!String.IsNullOrEmpty(valueDopReq))
                            field.Disabled = true;
                    }

                    /// Даний доп. реквізит не можна редагувати
                    if (ControlName.Replace("$", String.Empty).ToUpper() == "REQV_HERIT" || (ControlName.Replace("$", String.Empty).ToUpper() == "REQV_KURS" && TT_Flags[65] == '1'))
                        field.Disabled = true;

                    if (ControlName.Replace("$", String.Empty).ToUpper() == "REQV_SCPFU")
                        field.Attributes["formula"] = Regex.Replace(query, @":(\w+)", " #($1)");

                    if (rdr.GetOracleDecimal(8) == 1 && (nomodify != "1" || ControlName.ToUpper() == "REQV_PASPV" || ControlName.ToUpper() == "REQV_PASNR" || ControlName.ToUpper() == "REQV_NAMET" || ControlName.ToUpper() == "REQV_LCSDE" || ControlName.ToUpper() == "REQV_DJNR" || ControlName.ToUpper() == "REQV_META"))
                    {
                        field.Attributes["onfocusin"] = "ShowF12()";
                        field.Attributes["onfocusout"] = "HideF12()";
                        field.Attributes["onkeydown"] = "selectDopReq(event,'" + ControlName + "')";
                        field.Style.Add(HtmlTextWriterStyle.Width, "318px");

                        HtmlInputButton bt = new HtmlInputButton();
                        bt.ID = "ref_" + ControlName;
                        bt.Style.Add(HtmlTextWriterStyle.Width, "14px");
                        bt.Value = "?";
                        bt.Attributes["onclick"] = "selectDopReq(event,'" + ControlName + "',1)";
                        bt.Attributes["TabIndex"] = Convert.ToString(tab_index);

                        drecs.Rows[i].Cells[1].Controls.Add(field);
                        drecs.Rows[i].Cells[1].Controls.Add(bt);
                    }
                    else
                    {
                        field.Style.Add(HtmlTextWriterStyle.Width, "332px");
                        drecs.Rows[i].Cells[1].Controls.Add(field);
                    }

                    //--- DRDAY - Дата рождения
                    if (ControlName.ToUpper() == "REQV_DRDAY")
                    {
                        field.Attributes["onchange"] = "chkCustomReq('DRDAY')";
                    }

                    //--- FIO
                    if (ControlName.ToUpper() == "REQV_FIO" && ",045,436,437,AA0,AA3,AA4,AA5,AA6,AA7,AA8,AA9,AAB,AAC,AAK,AAL,AAM,AAN,AAE,025,150,A16,116,136,146,MUI,MUK,MUV,CUV,CN1,CNU,MUU,MUJ,CFS,CFO,CFB,CAA,CAB,CAS,CVO,CVS,CVB,M37,MMV,CN3,CN4,MUB".Contains(TT))
                    {
                        HtmlGenericControl tab = new HtmlGenericControl();
                        tab.InnerHtml = "<table style='font-family:verdana;font-size:8pt' border=1>";
                        tab.InnerHtml += "<tr><td><input type='text' id='part_FIO_SURNAME' style='width:328px;' TabIndex='" + (tab_index) + "' onchange='setFio()'></td></tr>";
                        tab.InnerHtml += "<tr><td><input type='text' id='part_FIO_NAME' style='width:328px;' TabIndex='" + (tab_index + 1) + "' onchange='setFio()'></td></tr>";
                        tab.InnerHtml += "<tr><td><input type='text' id='part_FIO_PATR' style='width:328px;' TabIndex='" + (tab_index + 2) + "' onchange='setFio()'></td></tr>";
                        tab.InnerHtml += "</table>";
                        drecs.Rows[i].Cells[1].Controls.Add(tab);
                        deltaTab = 2;

                        string color = (drecs.Rows[i].Cells[0].Style["color"] != null) ? ("color:" + drecs.Rows[i].Cells[0].Style["color"]) : ("");

                        tab = new HtmlGenericControl();
                        tab.InnerHtml = "<table cellpadding=5 style='font-family:verdana;font-size:10pt;" + color + "'>";
                        tab.InnerHtml += "<tr><td>ПІБ</td></tr>";
                        tab.InnerHtml += "<tr><td>&nbsp;&nbsp;&nbsp;Прізвище</td></tr>";
                        tab.InnerHtml += "<tr><td>&nbsp;&nbsp;&nbsp;Iм'я</td></tr>";
                        tab.InnerHtml += "<tr><td>&nbsp;&nbsp;&nbsp;По-батькові</td></tr>";
                        tab.InnerHtml += "</table>";

                        drecs.Rows[i].Cells[0].Controls.RemoveAt(0);
                        drecs.Rows[i].Cells[0].Style.Add("vertical-align", "top");
                        drecs.Rows[i].Cells[0].Controls.Add(tab);

                        field.Attributes["readOnly"] = "true";
                        field.Style["background"] = "#f0f0f0";
                        field.Attributes["TabIndex"] = "1000";
                    }
                    //---
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
        /// <summary>
        /// Обчислення значення додаткового реквізиту
        /// по замовчуванню
        /// </summary>
        private String EvalOpField(String tt, String op_field, String param, bool isBindPar)
        {
            /// Якщо в url не знайшли потрібного параметра
            /// додатковий реквізит не заповнюємо
            if (isBindPar && String.IsNullOrEmpty(param)) return String.Empty;

            OracleConnection connect = new OracleConnection();

            try
            {
                IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
                connect = conn.GetUserConnection(Context);

                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                /// Якщо параметрів нам не передали - посилаємо далі нул.
                param = (param == String.Empty) ? null : param;

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "EVAL_OP_FIELD";
                cmd.Parameters.Add(":TT", OracleDbType.Char, tt, ParameterDirection.Input);
                cmd.Parameters.Add(":OP_TAG", OracleDbType.Char, op_field, ParameterDirection.Input);
                cmd.Parameters.Add(":PARAM", OracleDbType.Varchar2, param, ParameterDirection.Input);
                OracleParameter def_val = cmd.Parameters.Add(":DEF_VAL", OracleDbType.Varchar2, 5000);
                def_val.Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                return ((OracleString)def_val.Value == OracleString.Null) ? String.Empty : Convert.ToString(def_val.Value);
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }
        }
        /// <summary>
        /// 
        /// </summary>
        private void QdocDrecsFill()
        {
            #region Перезаполнение некоторых полей. Связяно с разницей urlencode в jscript и c#

            DocN.Text = Request.QueryString["docn"];
            Nam_B.Text = Request.QueryString["nam_b"];
            Nam_A.Text = Request.QueryString["nam_a"];
            Nazn.Text = Request.QueryString["nazn"];
            //переопределить дату
            DocD_TextBox.Text = Request.QueryString["datd"];

            #endregion

            #region Заполнить назначение платежа в скрытые поля
            InitOraConnection();
            try
            {
                SetRole("WR_QDOCS");
                DataTable drecs = SQL_SELECT_dataset("select * from s_nr where k_rk in ('!','-','+')").Tables[0];
                if (3 == drecs.Rows.Count)
                {
                    foreach (DataRow row in drecs.Rows)
                    {
                        switch (Convert.ToString(row["k_rk"]))
                        {
                            case "-":
                                qDocsNaznReturn.Value = Convert.ToString(row["n_rk"]);
                                break;
                            case "+":
                                qDocsNaznNls.Value = Convert.ToString(row["n_rk"]);
                                break;
                            case "!":
                                qDocsNaznOkpo.Value = Convert.ToString(row["n_rk"]);
                                break;
                        }
                    }
                }
                else
                {
                    throw new Exception("Остутствуют необходимые назначения платежа для информационных запросов (S_NR)");
                }
            }
            finally
            {
                DisposeOraConnection();
            }
            #endregion

            #region Добавить отображение доп. реквизитов
            Drecs.Rows.Clear();
            HtmlTableRow dop_rec_row;
            int drecItemId = 0;

            //не отображать таблицу с назначением платежа
            /*if ("*" != Request.Params["qdoc"] && "-" != Request.Params["qdoc"] )
                Details.Style.Add("display", "none");*/

            SetReadOnly(Nazn, Nazn.Text);
            btNewDoc.Style.Add("display", "none");

            //добавить все доп. реквизиты из URL
            for (int i = 0; i < Request.QueryString.Count; i++)
            {
                if (Request.QueryString.AllKeys[i] != null && Request.QueryString.AllKeys[i].StartsWith("drec_"))
                {

                    string key = Request.QueryString.AllKeys[i].Remove(0, 5);
                    string val = Request.QueryString["drec_" + key];
                    dop_rec_row = new HtmlTableRow();
                    dop_rec_row.Style.Add("display", "none");
                    dop_rec_row.Cells.Add(new HtmlTableCell());
                    dop_rec_row.Cells.Add(new HtmlTableCell());
                    Drecs.Rows.Add(dop_rec_row);

                    Drecs_ids.Value += key + ",";

                    //name
                    Drecs.Rows[drecItemId].Cells[0].InnerText = key;
                    //value
                    Drecs.Rows[drecItemId].Cells[1].InnerHtml = "<input name=\"" + key
                    + "\" vspo=\"" + key + "\" type=\"text\" runat=\"server\"" + " value=\"" + val + "\"/>";
                    drecItemId += 1;

                }
            }
            #endregion

            //устанавливаем фокус на этот контрол, если не дернуть его, то при показе
            //страницы не выполнится javascript, который подтянет имя банка из справочника банков
            Mfo_B.Focus();
        }
        /// <summary>
        /// 
        /// </summary>
        private void QdocPrepareControls()
        {
            string qDoc = Convert.ToString(Request.Params["qdoc"]);

            foreach (Control contr in DocInputForm.Controls)
            {
                if (btPayIt != contr)
                {
                    if (contr is TextBox)
                        SetReadOnly(contr as TextBox, (contr as TextBox).Text);
                    if (contr is DropDownList)
                        (contr as DropDownList).Enabled = false;
                }
            }
            Style st = new Style();
            st.BackColor = Color.LightPink;
            st.ForeColor = Color.Black;
            st.Font.Bold = true;
            st.BorderStyle = BorderStyle.Inset;
            if ("?" == qDoc)
            {
                Nls_B.ReadOnly = false;
                Nls_B.ApplyStyle(st);

                Id_B.ReadOnly = false;
                Id_B.ApplyStyle(st);

                Nam_B.ReadOnly = false;
                Nam_B.ApplyStyle(st);

                Nls_B.Focus();
            }
        }

        private void CheckSWIPayment()
        {
            __ISSWI.Value = "1";
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            con = conn.GetUserConnection();
            string swi = Request.Params["swi"].PadRight(3, ' ');
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                string mtiCode = swi.Substring(0, 2).ToLower();
                string operCode = swi.Substring(2, 1).ToLower();
                cmd.CommandText = "select name, ob22_2909,ob22_2809,ob22_kom, num from swi_mti_list where id=:id";
                cmd.Parameters.Add("id", OracleDbType.Varchar2, mtiCode, ParameterDirection.Input);

                OracleDataReader rdr = cmd.ExecuteReader();
                if (!rdr.Read()) throw new Exception("Не знайдено відповідну до коду [" + mtiCode + "] систему грошових переказів (довідник swi_mti_list).");
                string mtiName = Convert.ToString(rdr.GetValue(0));

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "barsweb_session.set_session_id";
                cmd.Parameters.Add("session_id", OracleDbType.Varchar2, 24).Value = Session.SessionID;
                cmd.ExecuteNonQuery();

                cmd.CommandText = "barsweb_session.set_varchar2";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_var_name", OracleDbType.Varchar2, 32).Value = "swi_mti_code";
                cmd.Parameters.Add("p_var_value", OracleDbType.Varchar2, 4000).Value = Convert.ToString(rdr.GetValue(4));
                cmd.ExecuteNonQuery();

                cmd.CommandText = "barsweb_session.set_varchar2";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_var_name", OracleDbType.Varchar2, 32).Value = "swi_ob22_2909";
                cmd.Parameters.Add("p_var_value", OracleDbType.Varchar2, 4000).Value = Convert.ToString(rdr.GetValue(1));
                cmd.ExecuteNonQuery();

                cmd.CommandText = "barsweb_session.set_varchar2";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_var_name", OracleDbType.Varchar2, 32).Value = "swi_ob22_2809";
                cmd.Parameters.Add("p_var_value", OracleDbType.Varchar2, 4000).Value = Convert.ToString(rdr.GetValue(2));
                cmd.ExecuteNonQuery();

                cmd.CommandText = "barsweb_session.set_varchar2";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_var_name", OracleDbType.Varchar2, 32).Value = "swi_ob22_kom";
                cmd.Parameters.Add("p_var_value", OracleDbType.Varchar2, 4000).Value = Convert.ToString(rdr.GetValue(3));
                cmd.ExecuteNonQuery();

                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select tt,nazn_template, tt_980, tt_pa from swi_oper_list where oper_id=:oper_id";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("oper_id", OracleDbType.Varchar2, operCode, ParameterDirection.Input);
                rdr = cmd.ExecuteReader();
                if (!rdr.Read()) throw new Exception("Не знайдено відповідну до коду [" + operCode + "] операцію (довідник swi_oper_list).");

                string tt980 = Convert.ToString(rdr.GetValue(2));
                string ttpa = Convert.ToString(rdr.GetValue(3));
                string ttswi = Convert.ToString(rdr.GetValue(0));
                // если платеж в гривне - берем отдельную операцию
                if (Request.Params["KV_A"] == "980" && Request.Params["KV_B"] == "980" && !string.IsNullOrEmpty(tt980))
                    ttswi = tt980;
                // если есть параметр pa_flag=1 - выплата на счет, код операции из колонки tt_pa
                if (Request.Params["pa_flag"] == "1" && !string.IsNullOrEmpty(ttpa))
                    ttswi = ttpa;

                TT = ttswi;
                __TT.Value = TT;
                string nazn_templ = Convert.ToString(rdr.GetValue(1));
                __SWINAZN.Value = nazn_templ.Replace("{MTI_NAME}", mtiName);

                rdr.Close();
                rdr.Dispose();

                // Проверка подписи, если нужно 
                if (!string.IsNullOrEmpty(Request.Form["Signature"]))
                {
                    string buffer = "SumC={0}&reqv_SUM_COM_BANK={1}&reqv_SUM_COM_ALL={2}&TransactionId={3}&WalletId={4}";
                    buffer = string.Format(buffer, Request.Form["SumC"], Request.Form["reqv_SUM_COM_BANK"], Request.Form["reqv_SUM_COM_ALL"], Request.Form["TransactionId"], Request.Form["WalletId"]);
                    ClientScript.RegisterHiddenField("swiSign", Request.Form["Signature"]);
                    ClientScript.RegisterHiddenField("swiSignKey", Request.Form["SignKeyId"]);
                    ClientScript.RegisterHiddenField("swiSignBuf", buffer);
                    ClientScript.RegisterStartupScript(this.GetType(), "swiCheck", "preCheckSign();", true);
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }


        /// <summary>
        /// чтение глобальных данных(банковская дата, наше МФО, наименование и пр.)
        /// </summary>
        private void GetGlobalData()
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            con = conn.GetUserConnection(Context);
            try
            {
                OracleCommand cmd = con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText =
                 "select web_utl.get_bankdate,mfo,nb,docsign.GetIdOper, "
                + "(select nvl(min(to_number(val)),0) from params where par='INTSIGN') INTSIGN, "
                + "(select nvl(min(to_number(val)),0) from params where par='VISASIGN') VISASIGN, "
                + "docsign.GetSignType SIGNTYPE, "
                + "(select nvl(min(to_number(val)),1) from params where par='SEPNUM') SEPNUM, "
                + "(select nvl(min(to_number(val)),1) from params where par='VOB2SEP') VOB2SEP, "
                + "(select nvl(min(to_number(val)),0) from params where par='VOB_ORD') VOB_ORD, "
                + "(select nvl(min(to_number(val)),0) from params where par='VOB_CNFM') VOB_CNFM, "
                + "(select nvl(min(to_number(val)),0) from params where par='W_TICFL') W_TICFL, "
                + "(select nvl(min(to_number(val)),0) from params where par='W_SIGNCC') W_SIGNCC, "
                + "(select nvl(val,'00') from params where par='REGNCODE') REGNCODE, "
                + "TO_CHAR(SYSDATE,'dd/MM/yyyy'), "
                + "(select val from params where par='NAME') BANK_NAME, "
                + "(select nvl(min(val),'') from params where par='INFDB_OP') INFDB_OP, "
                + "(select nvl(min(val),'') from params where par='INFKR_OP') INFKR_OP, "
                + "LEAST(trunc(sysdate),web_utl.get_bankdate) DATP, "
                + "(select nvl(val,'') from params where par='VOB2SEP2') VOB2SEP2, "
                + "(select nvl(val,'') from params where par='DEP_UP') DEP_UP, "
                + "(select nvl(val,'') from params where par='WARNPAY') WARNPAY, "
                + "(select nvl(val,'') from params where par='BANKTYPE') BANKTYPE "
                + "from banks where mfo=(select val from params where par='MFO')";

                OracleDataReader rdr = cmd.ExecuteReader();
                if (!rdr.Read()) throw new Exception("Свое МФО не найдено или не определено.");

                bDATE = rdr.GetDateTime(0);
                ourBankMfo = Convert.ToString(rdr.GetValue(1));
                ourBankName = Convert.ToString(rdr.GetValue(2));
                if (rdr.IsDBNull(3)) userKeyID = string.Empty;
                else userKeyID = Convert.ToString(rdr.GetValue(3));
                PAR_INTSIGN = Convert.ToInt32(rdr.GetValue(4));
                PAR_VISASIGN = Convert.ToInt32(rdr.GetValue(5));
                PAR_SIGNTYPE = Convert.ToString(rdr.GetValue(6));
                PAR_SEPNUM = Convert.ToInt32(rdr.GetValue(7));
                PAR_VOB2SEP = Convert.ToInt32(rdr.GetValue(8));
                PAR_VOBORD = Convert.ToInt32(rdr.GetValue(9));
                PAR_VOBCONFIRM = Convert.ToInt32(rdr.GetValue(10));
                PAR_TICTOFILE = Convert.ToInt32(rdr.GetValue(11));
                PAR_SIGNCC = Convert.ToInt32(rdr.GetValue(12));
                PAR_REGNCODE = Convert.ToString(rdr.GetValue(13));
                PAR_SYSDATE = Convert.ToString(rdr.GetValue(14));

                __BANKNAME.Value = Convert.ToString(rdr.GetValue(15));
                qDocsTT_dk2.Value = Convert.ToString(rdr.GetValue(16));
                qDocsTT_dk3.Value = Convert.ToString(rdr.GetValue(17));
                DatP = rdr.GetDateTime(18);
                PAR_VOB2SEP2 = Convert.ToString(rdr.GetValue(19));
                PAR_DEPUP = Convert.ToString(rdr.GetValue(20));
                __WARNPAY.Value = Convert.ToString(rdr.GetValue(21));
                PAR_BANKYPE = Convert.ToString(rdr.GetValue(22));

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
        /// Чтение описания транзакции
        /// </summary>
        private void GetTtsRec()
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            con = conn.GetUserConnection(Context);

            try
            {
                OracleCommand cmd = con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = @"	SELECT	t.name, t.flags||t.fli||t.flv ,t.kv, t.kvk, 
												t.nlsa, t.nlsb, t.mfob, t.sk, t.dk, substr(t.flags,1,1),t.nazn,t.s,t.s2,t1.dig,t2.dig, t1.lcv, t2.lcv 
										FROM tts t, tabval t1, tabval t2 
										WHERE t.TT=:TT AND t.KV=t1.KV(+) AND t.KVK=t2.KV(+)";
                cmd.Parameters.Add("TT", OracleDbType.Varchar2, TT, ParameterDirection.Input);

                OracleDataReader rdr = cmd.ExecuteReader();
                if (!rdr.Read()) throw new Exception("Операция " + TT + " не найдена, недоступна пользователю или запрещена для ручного ввода.");

                string AUTO = string.Empty;
                if (!rdr.IsDBNull(9))
                    AUTO = rdr.GetOracleString(9).Value;

                // Всегда проверяем наличие
                if (AUTO != "0")
                {
                    cmd.CommandText = @"SELECT	t.name, t.flags||t.fli||t.flv, t.kv, t.kvk, t.nlsa, 
												t.nlsb, t.mfob, t.sk, t.dk, substr(t.flags,1,1),t.nazn,t.s,t.s2,t1.dig,t2.dig, t1.lcv, t2.lcv
										FROM tts t, staff_tts s, tabval t1, tabval t2  
										WHERE   t.kv=t1.kv(+) and t.kvk=t2.kv(+) 
												and	t.tt = :TT and t.tt=s.tt and t.fli<3 
												and substr(t.flags,1,1)='1' 
												and (s.id=USER_ID OR s.id IN 
														(	SELECT id_whom 
															FROM staff_substitute 
															WHERE	id_who=USER_ID 
																	AND date_is_valid(date_start, date_finish, NULL, NULL)=1
														)
													) 
												AND decode((select nvl(min(to_number(val)),0) from params where par='LOSECURE'),0,NVL(s.approve,0),1)=1 
												AND date_is_valid(s.adate1,s.adate2,s.rdate1,s.rdate2)=1";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("_TT", OracleDbType.Varchar2, TT, ParameterDirection.Input);

                    rdr = cmd.ExecuteReader();
                    if (!rdr.Read()) throw new Exception("Операция " + TT + " не найдена, недоступна пользователю или запрещена для ручного ввода.");
                }

                try { TT_Name = rdr.GetOracleString(0).Value; }
                catch (InvalidCastException) { TT_Name = string.Empty; }
                try { TT_Flags = Convert.ToString(rdr.GetValue(1)); }
                catch (InvalidCastException) { TT_Flags = string.Empty; }
                try { TT_KvA = Convert.ToString(rdr.GetValue(2)).Trim(); }
                catch (InvalidCastException) { TT_KvA = string.Empty; }
                try { TT_KvB = Convert.ToString(rdr.GetValue(3)).Trim(); }
                catch (InvalidCastException) { TT_KvB = string.Empty; }
                try { TT_NlsA = Convert.ToString(rdr.GetValue(4)).Trim(); }
                catch (InvalidCastException) { TT_NlsA = string.Empty; }
                try { TT_NlsB = Convert.ToString(rdr.GetValue(5)); }
                catch (InvalidCastException) { TT_NlsB = string.Empty; }
                try { TT_MfoB = Convert.ToString(rdr.GetValue(6)); }
                catch (InvalidCastException) { TT_MfoB = string.Empty; }
                try { TT_Sk = Convert.ToString(rdr.GetValue(7)); }
                catch (InvalidCastException) { TT_Sk = string.Empty; }
                try { __DK.Value = Convert.ToString(rdr.GetValue(8)); }
                catch (InvalidCastException) { __DK.Value = string.Empty; }
                try { TT_Nazn = Convert.ToString(rdr.GetValue(10)); }
                catch (InvalidCastException) { TT_Nazn = string.Empty; }
                try { TT_S = Convert.ToString(rdr.GetValue(11)); }
                catch (InvalidCastException) { TT_S = string.Empty; }
                try { TT_S2 = Convert.ToString(rdr.GetValue(12)); }
                catch (InvalidCastException) { TT_S2 = string.Empty; }
                try { TT_KvALcv = Convert.ToString(rdr.GetValue(15)); }
                catch (InvalidCastException) { TT_KvALcv = string.Empty; }
                try { TT_KvBLcv = Convert.ToString(rdr.GetValue(16)); }
                catch (InvalidCastException) { TT_KvBLcv = string.Empty; }

                __DIGA.Value = Convert.ToString(rdr.GetValue(13));
                __DIGB.Value = Convert.ToString(rdr.GetValue(14));

                if (string.Empty == TT_KvA)
                    TT_KvA = (null == Request.Params["Kv_A"]) ? ("") : (Request.Params["Kv_A"]);
                if (string.Empty == TT_KvB)
                    TT_KvB = (null == Request.Params["Kv_B"]) ? ("") : (Request.Params["Kv_B"]);

                if (__DIGA.Value == string.Empty && TT_KvA != string.Empty)
                {
                    cmd.CommandText = "select dig from tabval where kv=:kv";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("kv", OracleDbType.Decimal, TT_KvA, ParameterDirection.Input);
                    __DIGA.Value = Convert.ToString(cmd.ExecuteScalar());
                }
                if (__DIGB.Value == string.Empty && TT_KvB != string.Empty)
                {
                    cmd.CommandText = "select dig from tabval where kv=:kv";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("kv", OracleDbType.Decimal, TT_KvB, ParameterDirection.Input);
                    __DIGB.Value = Convert.ToString(cmd.ExecuteScalar());
                }

                if (string.Empty == __DIGA.Value)
                    __DIGA.Value = "2";
                if (string.Empty == __DIGB.Value)
                    __DIGB.Value = "2";

                if (TT_Nazn == string.Empty)
                    lbHint.Visible = false;

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
        /// Получить LCV по коду валюти
        /// </summary>
        /// <param name="kv">цифровой код валюты</param>
        /// <returns>LCV валюты</returns>
        private string GetLcvForKv(string kv)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            con = conn.GetUserConnection(Context);

            try
            {
                OracleCommand cmd = con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                cmd.CommandText = "select lcv from tabval where kv=:kv";
                cmd.Parameters.Add("kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
                return Convert.ToString(cmd.ExecuteScalar());
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        /// <summary>
        /// Заповняємо поля відповідно до
        /// налаштувань операції та параметрів, що надійшли з url
        /// Пріоритетними є налаштування операції
        /// </summary>
        private void GetUrlRec()
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            cinfo.NumberFormat.CurrencyDecimalSeparator = ".";

            /// Обробляємо NLS_A
            string urlNls_A = Convert.ToString(Request.Params["Nls_A"]);
            TT_NlsA = (string.Empty == TT_NlsA) ? urlNls_A : TT_NlsA;
            TT_NlsA = (TT_NlsA == null) ? String.Empty : TT_NlsA;
            if (TT_NlsA == string.Empty) Nls_A.MaxLength = 14;
            else if (TT_NlsA.StartsWith("#") && (urlNls_A != null && urlNls_A.StartsWith("#")))
            {
                Nls_A.Attributes["formula"] = urlNls_A;
            }
            else if (TT_NlsA.StartsWith("#"))
            {
                Nls_A.Text = TT_NlsA;
            }
            else
                SetReadOnly(Nls_A, TT_NlsA);

            if (Request.Params["DisA"] == "1")
                SetReadOnly(Nls_A, Nls_A.Text);

            /// Обробляємо NLS_B
            string urlNls_B = Convert.ToString(Request.Params["Nls_B"]);
            TT_NlsB = (string.Empty == TT_NlsB) ? urlNls_B : TT_NlsB;
            TT_NlsB = (TT_NlsB == null) ? String.Empty : TT_NlsB;
            if (TT_NlsB == string.Empty) Nls_B.MaxLength = 14;
            else if (TT_NlsB.StartsWith("#") && (urlNls_B != null && urlNls_B.StartsWith("#")))
            {
                Nls_B.Attributes["formula"] = TT_NlsB;
            }
            else if (TT_NlsB.StartsWith("#"))
            {
                Nls_B.Text = TT_NlsB;
            }
            else
                SetReadOnly(Nls_B, TT_NlsB);

            if (Request.Params["DisB"] == "1")
                SetReadOnly(Nls_B, Nls_B.Text);

            /// Обробляємо MFO_B
            TT_MfoB = (string.Empty == TT_MfoB) ? Convert.ToString(Request.Params["Mfo_B"]) : TT_MfoB;
            TT_MfoB = (TT_MfoB == null) ? String.Empty : TT_MfoB;

            /// ОКПО
            TT_IdB = Request["Id_B"];
            /// Найменування
            TT_NamB = Request["Nam_B"];
            if (Request["kekv_b"] != null)
            {
                tbSubAccount.Value = Request["kekv_b"];
                tbSubAccount.Disabled = true;
            }

            //Dk
            if (Request["Dk"] != null)
                __DK.Value = Request["Dk"];

            /// Обробка валют
            if ((TT_Flags[65] != '1') && (TT_KvA != TT_KvB))
                if (string.Empty == TT_KvA && string.Empty != TT_KvB)
                    TT_KvA = TT_KvB;
                else
                    TT_KvB = TT_KvA;

            TT_KvA = (string.Empty == TT_KvA) ? Convert.ToString(Request.Params["Kv_A"]) : TT_KvA;
            TT_KvA = (TT_KvA == null) ? String.Empty : TT_KvA;
            TT_KvB = (string.Empty == TT_KvB) ? Convert.ToString(Request.Params["Kv_B"]) : TT_KvB;
            TT_KvB = (TT_KvB == null) ? String.Empty : TT_KvB;
            if (TT_KvA == string.Empty)
                Kv_A.MaxLength = 3;
            else
            {
                SetReadOnly(Kv_A, TT_KvA);
                LabelSumALcv.Text = GetLcvForKv(TT_KvA);
            }
            if (TT_KvB == string.Empty)
                Kv_B.MaxLength = 3;
            else
            {
                SetReadOnly(Kv_B, TT_KvB);
                LabelSumBLcv.Text = GetLcvForKv(TT_KvB);
            }

            /// Обробка сум
            if (Request["SumA_t"] != null)
            {
                SumA.Text = SumTrans(Decimal.Parse(Request["SumA_t"], cinfo), TT_S).ToString();
                SumA.Enabled = false;
                if (string.Empty != TT_S2)
                {
                    string sum = (Request["SumB_t"] == null) ? (Request["SumA_t"]) : (Request["SumB_t"]);
                    SumB.Text = SumTrans(Decimal.Parse(sum, cinfo), TT_S2).ToString();
                    CrossRat.Style["VISIBILITY"] = "hidden";
                    SumB.Enabled = false;
                }
            }
            if (Request["SumB_t"] != null)
            {
                SumB.Text = SumTrans(Decimal.Parse(Request["SumB_t"], cinfo), TT_S2).ToString();
                SumB.ReadOnly = true;
            }
            if (Request["SumC_t"] != null)
            {
                SumC.Text = SumTrans(Decimal.Parse(Request["SumC_t"], cinfo), TT_S).ToString();
                SumC.ReadOnly = true;
                if (__DIGA.Value == "3")
                    CrossRat.Text = (Decimal.Parse(Request["SumC_t"], cinfo) / 1000).ToString();
                else if (TT_Flags[58] == '1')
                    CrossRat.Text = (Decimal.Parse(Request["SumC_t"], cinfo) / 100).ToString();
            }
            if (Request["flag_se"] == "1") SumC.ReadOnly = false;
            if (Request["SumC"] != null)
            {
                SumC.Text = Decimal.Parse(System.Web.HttpUtility.UrlDecode(Request["SumC"]).Replace(",", ".").Replace(" ", ""), cinfo).ToString();
                SumC.ReadOnly = true;
            }
            // Номер документа
            if (Request["Nd"] != null)
                DocN.Text = Request["Nd"].Trim();
            if (DocN.Text.Length > 10)
                DocN.Text = DocN.Text.Substring(0, 10);

            /// Обробка призначення
            __NAZN.Value = (string.Empty == TT_Nazn) ? Convert.ToString(Request.Params["nazn"]) : TT_Nazn;
            __NAZN.Value = (__NAZN.Value == null) ? String.Empty : __NAZN.Value;

            // Додаткове призначення - пріорітетніше за налаштування операції
            if (Request.Params["NaznPr"] != null)
            {
                __NAZN.Value = Convert.ToString(Request.Params["NaznPr"]);
            }

            if (Session["Doc.Nazn"] != null)
            {
                Nazn.Text = Convert.ToString(Session["Doc.Nazn"]);
                __NAZN.Value = Nazn.Text;
            }

            Nazn.Text = __NAZN.Value;

            // Если платеж по SWI, то назначение сами проставляем со справочника swi_oper_list
            if ("1" == __ISSWI.Value)
            {
                Nazn.Text = __SWINAZN.Value;
                // Символ касплана
                if (Kv_A.Text == "980" && string.IsNullOrEmpty(TT_Sk))
                {
                    if (TT.Equals("CN1"))
                        TT_Sk = "32";
                    else
                        TT_Sk = "61";
                }
            }

            // Отключаем проверку остатка на счете
            if (Request.Params["ChOst"] != null)
            {
                Session["CheckOst"] = Request.Params["ChOst"];
            }
            else
                Session.Remove("CheckOst");
            /// Ексклюзивно для Правекса - заповнене призначення платежу міняти не можна
            if (BankType.GetCurrentBank() == BANKTYPE.PRVX && PAR_BANKYPE == "PRVX")
            {
                if (!String.IsNullOrEmpty(__ND.Value))
                    SetReadOnly(Nazn, Nazn.Text);
            }
            Nazn.Attributes["oncontextmenu"] = "javascript:reTransNazn(form);return false;";

            /// Символ касплану
            TT_Sk = (string.Empty == TT_Sk) ? Convert.ToString(Request.Params["sk"]) : TT_Sk;
            TT_Sk = (TT_Sk == null) ? String.Empty : TT_Sk;
            Sk.Text = TT_Sk.Trim();
            if (TT_Flags[9] == '0')
                Sk.Style["VISIBILITY"] = "hidden";
            else if (TT_Flags[9] == '1' && TT_Sk.Trim() != string.Empty)
                SetReadOnly(Sk, TT_Sk);
            else
            {
                Sk.MaxLength = 2;
                Sk.Attributes["onblur"] = "javascript:chkCashSymbol();";
                Sk.Attributes["onkeypress"] = "javascript:return numeralsOnly(event);";
                Sk.Attributes["onkeydown"] = "javascript:selectCashSymbol(event);";
            }

            return;

            //string url_Name = ((Request.Params.Get("name") == null)?(""):(Request.Params.Get("name")));
            //string url_Flags = ((Request.Params.Get("flags") == null)?(""):(Request.Params.Get("flags")));
            //string url_KvA = ((Request.Params.Get("kva") == null)?(""):(Request.Params.Get("kva")));
            //string url_KvB = ((Request.Params.Get("kvb") == null)?(""):(Request.Params.Get("kvb")));
            //string url_NlsA = ((Request.Params.Get("nlsa") == null)?(""):(Request.Params.Get("nlsa")));
            //string url_NlsB = ((Request.Params.Get("nlsb") == null)?(""):(Request.Params.Get("nlsb")));
            //string url_MfoB = ((Request.Params.Get("mfob") == null)?(""):(Request.Params.Get("mfob")));
            //string url_Sk = ((Request.Params.Get("sk") == null)?(""):(Request.Params.Get("sk")));
            //string url_Sa = ((Request.Params.Get("sa") == null)?(""):(Request.Params.Get("sa")));
            //string url_Sb = ((Request.Params.Get("sb") == null)?(""):(Request.Params.Get("sb")));
            //string url_Sc = ((Request.Params.Get("sc") == null)?(""):(Request.Params.Get("sc")));
            //string url_nazn = ((Request.Params.Get("nazn") == null)?(""):(Request.Params.Get("nazn")));

            //TT_Name = ((TT_Name == "")?(url_Name):(TT_Name));
            //TT_Flags = ((TT_Flags == "")?(url_Flags):(TT_Flags));
            //TT_KvA = ((TT_KvA == "")?(url_KvA):(TT_KvA));
            //TT_KvB = ((TT_KvB == "")?(url_KvB):(TT_KvB));
            //TT_NlsA = ((TT_NlsA == "")?(url_NlsA):(TT_NlsA));
            //TT_NlsB = ((TT_NlsB == "")?(url_NlsB):(TT_NlsB));
            //TT_MfoB = ((TT_MfoB == "")?(url_MfoB):((url_MfoB == "")?(TT_MfoB):(url_MfoB)));
            //TT_Sk = ((TT_Sk == "")?(url_Sk):(TT_Sk));
            //Nazn.Text = ((Nazn.Text == "")?(url_nazn):((url_nazn == "")?(Nazn.Text):(url_nazn)));

            //if(url_Sa.Trim() != "") 
            //{
            //	SumA.Text = Convert.ToString(decimal.Parse(url_Sa.Trim())/100);
            //	SumA.Enabled = false;
            //}
            //if(url_Sb.Trim() != "") 
            //{
            //	SumB.Text = Convert.ToString(decimal.Parse(url_Sb.Trim())/100);
            //	SumB.Enabled = false;
            //}

            //if(url_Sc.Trim() != "") 
            //{
            //	SumC.Text = Convert.ToString(decimal.Parse(url_Sc.Trim())/100);
            //	SumC.Enabled = false;
            //}
        }
        /// <summary>
        /// подставляем значения допреквизитов переданые через Url
        /// Формат: reqv_ + назва додаткового реквізиту
        /// </summary>
        private void GetUrlDRec()
        {
            ListItemCollection DRecTag = new ListItemCollection();
            // Дисейблим реквизиты, которые были переданы через урл при присутствии параметра DisR=1
            bool disR = (Request["DisR"] == "1");

            foreach (String par_name in Request.QueryString)
                if (!String.IsNullOrEmpty(par_name) && par_name.StartsWith("reqv_"))
                {
                    string par = par_name;
                    if (par_name.ToLower() == "reqv_sum_com_all")
                        par = "reqv_PCOMA";
                    if (par_name.ToLower() == "reqv_sum_com_bank")
                        par = "reqv_PCOMB";
                    DRecTag.Add(new ListItem(par, Request.QueryString[par_name]));
                }

            /// Враховуємо пріоритетність налаштувань бази.
            /// Якщо в базі формула порахувалась - ігноруємо урл.
            Control dr;
            for (int i = 0; i < DRecTag.Count; i++)
                if (null != (dr = FindControl(DRecTag[i].Text)) && dr.GetType().Name == "HtmlInputText")
                    if (((HtmlInputText)dr).Value == String.Empty)
                    {
                        ((HtmlInputText)dr).Value = DRecTag[i].Value;
                        if (disR && !string.IsNullOrEmpty(DRecTag[i].Value))
                        {
                            ((HtmlInputText)dr).Disabled = true;
                            Control drRef = FindControl("ref_" + DRecTag[i].Text);
                            if (drRef != null) drRef.Visible = false;
                        }


                        /// Ексклюзивно для Правекса - заповнені дод. реквізити міняти не можна
                        if (BankType.GetCurrentBank() == BANKTYPE.PRVX && PAR_BANKYPE == "PRVX")
                        {
                            if (!String.IsNullOrEmpty(((HtmlInputText)dr).Value))
                                ((HtmlInputText)dr).Disabled = true;
                        }
                    }
        }
        /// <summary>
        /// Перевірка полів рахунків
        /// якщо в них формули - обчислюємо і 
        /// записуємо в ці поля отримані значення
        /// </summary>
        private void CkAcc()
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];

            try
            {
                con = conn.GetUserConnection(Context);

                OracleCommand cmd = con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();

                string formula = string.Empty;
                string text = string.Empty;

                cmd.CommandText = "begin doc_strans(:text_,:res_);end;";

                if (Nls_A.Text.StartsWith("#"))
                {
                    formula = Nls_A.Text.Remove(0, 1);

                    text = "select " + formula + " from dual";

                    cmd.Parameters.Add("text_", OracleDbType.Varchar2, text, ParameterDirection.Input);
                    cmd.Parameters.Add("res_", OracleDbType.Decimal, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    OracleDecimal val = (OracleDecimal)cmd.Parameters["res_"].Value;
                    if (val.IsNull)
                        Nls_A.Text = string.Empty;
                    else
                    {
                        SetReadOnly(Nls_A, Convert.ToString(cmd.Parameters["res_"].Value));
                    }
                    TT_NlsA = Nls_A.Text;
                    cmd.Parameters.Clear();
                }

                if (Nls_B.Text.StartsWith("#"))
                {
                    formula = Nls_B.Text.Remove(0, 1);

                    text = "select " + formula + " from dual";

                    cmd.Parameters.Add("text_", OracleDbType.Varchar2, text, ParameterDirection.Input);
                    cmd.Parameters.Add("res_", OracleDbType.Decimal, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    OracleDecimal val = (OracleDecimal)cmd.Parameters["res_"].Value;
                    if (val.IsNull)
                        Nls_B.Text = string.Empty;
                    else
                    {
                        SetReadOnly(Nls_B, Convert.ToString(cmd.Parameters["res_"].Value));
                    }
                    TT_NlsB = Nls_B.Text;
                }
            }
            finally
            {
                con.Close();
            }
        }
        /// <summary>
        /// Функция установки поля в READ_ONLY
        /// </summary>
        private void SetReadOnly(TextBox e, string text)
        {
            e.Text = text;
            if (TT_Flags[17] == '1' && (e == Nls_A || e == Nam_A || e == Id_A))
                return;
            if (TT_Flags[18] == '1' && (e == Nls_B || e == Nam_B || e == Id_B))
                return;

            e.ReadOnly = true;
            e.TabIndex = 0;
            Style st = new Style();
            st.BackColor = Color.FromName(Color.Transparent.Name);
            st.BorderStyle = BorderStyle.None;
            e.ApplyStyle(st);

        }
        /// <summary>
        /// Вычитка названия счета и ОКПО
        /// + перевірка на доступність
        /// </summary>
        private void GetNlsName(TextBox eId, TextBox eNam, string Nls, decimal Kv)
        {
            string side = (eId.ID.Substring(eId.ID.Length - 1, 1) == "A") ? ("A") : ("B");
            string dk = string.Empty;
            if ("A" == side)
                dk = ("1" != __DK.Value) ? ("1") : ("0");
            else
                dk = ("0" != __DK.Value) ? ("1") : ("0");

            cDocHandler.Saldo saldo = new cDocHandler.Saldo(Context, Nls, Convert.ToString(Kv), dk, TT);
            if (!String.IsNullOrEmpty(saldo.Nls))
            {
                if (!string.IsNullOrEmpty(saldo.Nms))
                {
                    if (Request["mode_nam_a"] == "1") // подстановка имени клиента вместо наименования счета
                        SetReadOnly(eNam, saldo.Nmk);
                    else
                        SetReadOnly(eNam, saldo.Nms);
                }
                if (!string.IsNullOrEmpty(saldo.Okpo))
                    SetReadOnly(eId, saldo.Okpo);
                if (side == "A" && saldo.Ostc != string.Empty)
                {
                    __OSTB.Value = saldo.Ostb;
                    __OSTC.Value = saldo.Ostc;
                    __PAP.Value = saldo.Pap;
                }
            }
            else
            {
                eNam.Text = "";
                eId.Text = "";
            }
        }


        private void GetNlsNameAlien(TextBox eId, TextBox eNam, string Nls, decimal Kv, string mfo)
        {
            string side = (eId.ID.Substring(eId.ID.Length - 1, 1) == "A") ? ("A") : ("B");
            string dk = string.Empty;
            if ("A" == side)
                dk = ("1" != __DK.Value) ? ("1") : ("0");
            else
                dk = ("0" != __DK.Value) ? ("1") : ("0");

            cDocHandler.Alien alien = new cDocHandler.Alien(Context, Nls, Convert.ToString(Kv), mfo);
            if (!String.IsNullOrEmpty(alien.Nls))
            {
                if (!string.IsNullOrEmpty(alien.Nms))
                    SetReadOnly(eNam, alien.Nms);
                if (!string.IsNullOrEmpty(alien.Okpo))
                    SetReadOnly(eId, alien.Okpo);
            }
        }

        /// <summary>
        /// Вычисление формул сум
        /// </summary>
        private decimal SumTrans(decimal nS, string sS)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            con = conn.GetUserConnection(Context);

            Decimal denom = 100;
            if (__DIGA.Value == "3")
                denom = 1000;

            try
            {
                if (sS == string.Empty) { return nS / denom; }
                else
                {
                    StringBuilder s = new StringBuilder(sS.ToUpper());

                    s.Replace("#(NLSA)", TT_NlsA);
                    s.Replace("#(NLSB)", TT_NlsB);
                    s.Replace("#(MFOA)", ourBankMfo);
                    s.Replace("#(MFOB)", TT_MfoB);
                    s.Replace("#(KVA)", TT_KvA);
                    s.Replace("#(KVB)", TT_KvB);

                    if (TT_Flags[65] == '1')
                    {
                        s.Replace("#(S)", Request["SumA_t"]);
                        s.Replace("#(S2)", Request["SumB_t"]);
                    }
                    else
                        s.Replace("#(S)", Request["SumC_t"]);

                    s.Replace("#(ND)", __ND.Value);
                    s.Replace("#(NOM)", Request["SumC_t"]);
                    s.Replace("#(SMAIN)", Convert.ToString(Request["SMAIN"]));
                    s.Replace("#(KVMAIN)", Convert.ToString(Request["KVMAIN"]));

                    Decimal result = Decimal.MinValue;
                    OracleCommand cmd = con.CreateCommand();

                    cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "begin DOC_STRANS(:text_,:res_);end;";
                    cmd.Parameters.Add("text_", OracleDbType.Varchar2, string.Format("SELECT ROUND({0},0) FROM dual", s), ParameterDirection.Input);
                    cmd.Parameters.Add("res_", OracleDbType.Decimal, result, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();
                    result = Convert.ToDecimal(cmd.Parameters["res_"].Value.ToString()) / denom;
                    return result;
                }
            }
            finally
            {
                con.Close();
            }
        }
        /// <summary>
        /// ПЕЧАТЬ ТИКЕТОВ
        /// </summary>
        private void PrintTicket(long DocRef, bool printTrnModel)
        {
            ModuleSettings ms = new ModuleSettings();
            if (ms.Documents.EnhancePrint && GetFlagUserPrintPdf())
            {
                PrintTiketPdf();
            }
            else
            {
                IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
                con = conn.GetUserConnection(Context);

                try
                {
                    OracleCommand cmd = con.CreateCommand();

                    cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                    cmd.ExecuteNonQuery();

                    cDocPrint ourTick = new cDocPrint(con,
                        DocRef,
                        Server.MapPath("/TEMPLATE.RPT/"), printTrnModel);
                    try
                    {
                        Response.ClearContent();
                        Response.ClearHeaders();
                        Response.Charset = "windows-1251";
                        Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
                        if (__TICTOFILE.Value == "3")
                        {
                            Response.AppendHeader("content-disposition", "attachment;filename=ticket.barsprn");
                            Response.ContentType = "application/octet-stream";
                        }
                        else
                        {
                            Response.AppendHeader("content-disposition", "attachment;filename=ticket.txt");
                            Response.ContentType = "text/html";
                        }
                        Response.WriteFile(ourTick.GetTicketFileName(), true);
                        Response.Flush();
                        Response.End();
                    }
                    finally
                    {
                        ourTick.DeleteTempFiles();
                    }
                }
                finally
                {
                    if (ConnectionState.Open == con.State) con.Close();
                    con.Dispose();
                }
            }
        }
        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btFile.Click += new System.Web.UI.ImageClickEventHandler(this.btFile_Click);
            this.btFR_PDF.Click += new System.Web.UI.ImageClickEventHandler(this.btFR_PDF_Click);
        }
        #endregion
        /// <summary>
        /// 
        /// </summary>
        private void btFile_Click(object sender, ImageClickEventArgs e)
        {
            PrintTicket(Convert.ToInt64(__DOCREF.Value), cbPrintTrnModel.Checked);
        }

        private void btFR_PDF_Click(object sender, ImageClickEventArgs e)
        {
            PrintTiketPdf();
        }

        private void PrintTiketPdf()
        {
            string frTempalte = __FR_TMPL.Value;
            if (!string.IsNullOrEmpty(frTempalte))
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                string printModel = string.IsNullOrEmpty(__FR_BM.Value) ? "0" : __FR_BM.Value;
                try
                {
                    FrxParameters pars = new FrxParameters();
                    pars.Add(new FrxParameter("p_ref_c", TypeCode.Decimal, __DOCREF.Value));
                    pars.Add(new FrxParameter("p_buh_c", TypeCode.Int16, printModel));

                    FrxDoc doc = new FrxDoc(
                        FrxDoc.GetTemplatePathByFileName(frTempalte),
                        pars,
                        this.Page);

                    doc.Print(FrxExportTypes.Pdf);
                }
                finally
                {
                    if (ConnectionState.Open == con.State) con.Close();
                    con.Dispose();
                }
            }
        }

        protected void gvLinkedDocs_DataBound(object sender, EventArgs e)
        {
            /// Збочуємося бо в нас є чеки
            if (Session["IS_CHECK_PAYMENT"] != null && Convert.ToBoolean(Session["IS_CHECK_PAYMENT"]))
            {
                Decimal s = 0;

                LinkedDocs l_docs = new LinkedDocs();
                List<LinkedDocs> l_doc_list = l_docs.SelectDocs();

                for (int i = 0; i < l_doc_list.Count; i++)
                {
                    s += Convert.ToDecimal(l_doc_list[i].S);
                }

                sum_check.Value = s.ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "calc_sum", "getSum4CheckTT();", true);
                //if (fvLinkedDocs.FindControl("NlsTextBox") != null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(),
                //        "calc_sum", "attach_nls_event('" +
                //        fvLinkedDocs.FindControl("NlsTextBox").ClientID +
                //        "')", true);
                //}
            }
            else
                sum_check.Value = String.Empty;
        }
        /// <summary>
        /// признак чи має користувач можливість друку в PDF
        /// </summary>
        /// <returns>true- має ; false-не має</returns>
        private static bool GetFlagUserPrintPdf()
        {
            bool res = false;
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                var select = @"select print_pdf 
                            from users_print_pdf 
                                where id=getcurrentuserid";
                OracleCommand cmd = new OracleCommand(select, con);
                res = Convert.ToString(cmd.ExecuteScalar()) == "1" ? true : false;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return res;
        }
    }
}
