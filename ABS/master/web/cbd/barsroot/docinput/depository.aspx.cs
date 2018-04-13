using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Globalization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Bars.Doc;
using Oracle.DataAccess.Client;
using Bars.Classes;

public partial class docinput_depository : Bars.BarsPage
{
    string ttNeedPesonList = "|VS5|VS6|VS9|VSM|VSN|";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillTts();


        }
        //FillData();
        imgChoosePerson1.Attributes["onclick"] = "ShowPodotch(1)";
        imgChoosePerson2.Attributes["onclick"] = "ShowPodotch(2)";
    }

    private void FillTts()
    {
        try
        {
            InitOraConnection();
            SetRole("WR_DOC_INPUT");
            ddTts.DataSource = SQL_SELECT_dataset(@"SELECT  tt, tt||'-'||name NAME
                                                    FROM tts
                                                    WHERE substr(flags,64,1) ='0' and tt like 'VS_' and tt <> 'VS*' order by 1 desc");
            ddTts.DataBind();
            ddTts.Attributes["onchange"] = "ShowPersonList()";

            ddTts.Items.Insert(0, "");

            ddBranches.DataSource = SQL_SELECT_dataset("select branch, name from branch where length(branch)=15 order by branch").Tables[0];
            ddBranches.DataTextField = "NAME";
            ddBranches.DataValueField = "BRANCH";
            ddBranches.DataBind();

            ddBranches.Items.Insert(0, new ListItem("", ""));
            ddBranches.SelectedIndex = 0;

        }
        finally
        {
            DisposeOraConnection();
        }
    }
    private void FillData()
    {
        string tt = ddTts.SelectedValue;
        if (string.IsNullOrEmpty(tt))
        {
            DataDepository.DataBind();
            pnDataDepository.Visible = false;
            imgPrintAll.Visible = false;
            return;
        }
        string nazn = ddTts.SelectedItem.Text.Substring(6);
        if (string.IsNullOrEmpty(tt)) return;

        string sSql = "SELECT v.OB22 OB22, k.name NAME, #COLD NLSD, #COLK NLSK, '" + nazn + ".'||k.NAME NAZN,(select -ostb/100 from accounts where kv=980 and nls=v.NLSD) OSTD, (select -ostb/100 from accounts where kv=980 and nls=v.NLSK) OSTK " +
                      "FROM VALUABLES k, (select branch, ob22, #NLSD NLSD, #NLSK NLSK from VALUABLES_NLS) v " +
                      "WHERE v.ob22 like '" + ddNbs.SelectedValue + "%' and v.NLSD is not null and v.NLSK is not null and k.OB22=v.OB22 ORDER BY v.OB22";
        string NLS99 = "GetAccNumb('NLS_9910')";
        string NLS989 = "VA_989(OB22,#RNK)";
        string nlsd = string.Empty, nlsk = string.Empty;
        switch (tt)
        {
            // VS1 Оприбуткувати цінності в сховище з 9910
            case "VS1": nlsd = "nls_9819"; nlsk = NLS99; ShowPar(1, false); break;
            // VS2 Списати цінності зі сховища на 9910
            case "VS2": nlsd = NLS99; nlsk = "nls_9819"; ShowPar(2, false); break;
            // VS3 Прийняти цінності  в сховище з дороги 
            case "VS3": nlsd = "nls_9819"; nlsk = "nls_9899"; ShowPar(3, true); break;
            // VS4 Видати цінності  зi сховища в дорогу
            case "VS4": nlsd = "nls_9899"; nlsk = "nls_9819"; ShowPar(3, true); break;
            // VS5 Прийняти цінності  в сховище з підзвіту
            case "VS5": nlsd = "nls_9819"; nlsk = NLS989; ShowPar(1, false); break;
            // VS6 Видати цінності  зi сховища в підзвіт
            case "VS6": nlsd = NLS989; nlsk = "nls_9819"; ShowPar(1, false); break;
            // VS7 Передача цінності:   сховище - > ОПЧ 
            //case "VS7": nlsd = "v.nls_9819"; nlsk = "v.nls_9819S"; break;
            // VS8 Передача цінності:  ОПЧ  ->  сховище
            //case "VS8": nlsd = "v.nls_9819S"; nlsk = "v.nls_9819"; break;
            // VS9 Списати цінності з підзвіту на 9910
            case "VS9": nlsd = NLS99; nlsk = NLS989; ShowPar(2, false); break;
            // VSA Прийняти цінності  в ОПЧ з дороги 
            case "VSA": nlsd = "nls_9812"; nlsk = "nls_9899spl"; ShowPar(3, true); break;
            // VSB Видати цінності  з ОПЧ в дорогу
            case "VSB": nlsd = "nls_9899spl"; nlsk = "nls_9812"; ShowPar(3, true); break;
            // VSC Прийняти цінності  в ОПЧ з підзвіту
            case "VSC": nlsd = NLS99; nlsk = "nls_9812"; ShowPar(2, false); break;
            // VSD Видати цінності  з ОПЧ  в підзвіт
            //case "VSD": nlsd = NLS989; nlsk = "v.nls_9819"; break;
            //VSM 9898-9910(об22=01)
            //VSM Видано цінності в підзвіт(ч-з 9910)
            case "VSM": nlsd = NLS989; nlsk = NLS99; ShowPar(1, false); break;
            //VSN Списання цінностей з підзвіту(ч-з 9910).
            //VSN 9910(об22=01)-9898
            case "VSN": nlsd = NLS99; nlsk = NLS989; ShowPar(1, false); break;
        }
        try
        {
            InitOraConnection();
            SetRole("WR_DOC_INPUT");
            string colD = "v.NLSD";
            string colK = "v.NLSK";
            if (trBranch.Visible && !string.IsNullOrEmpty(tbBranch.Text))
            {
                SetParameters("branch", DB_TYPE.Varchar2, tbBranch.Text, DIRECTION.Input);
                SetParameters("tt", DB_TYPE.Varchar2, tt, DIRECTION.Input);
                if (tt.Equals("VS3") || tt.Equals("VSA"))
                {
                    colK = @"(select a.nls from accounts a, specparam_int s, valuables v2 
                    where a.branch=:branch and a.nbs in decode(substr(v2.ob22,1,4),'9819','9899','9820','9891','9821','9893','9812','9899',NULL) and a.acc=s.acc 
                    and s.ob22=decode (:tt,'VS3',v2.OB22_DOR,v2.OB22_DORS) 
                    and v2.ob22=v.OB22 and a.dazs is null and rownum<2)";
                }
                else if (tt.Equals("VS4") || tt.Equals("VSB"))
                {
                    colD = @"(select a.nls from accounts a, specparam_int s, valuables v2 
                    where a.branch=:branch and a.nbs in decode(substr(v2.ob22,1,4),'9819','9899','9820','9891','9821','9893','9812','9899',NULL) and a.acc=s.acc 
                    and s.ob22=decode (:tt,'VS4',v2.OB22_DOR,v2.OB22_DORS) 
                    and v2.ob22=v.OB22 and a.dazs is null and rownum<2)";
                }
            }

            sSql = sSql.Replace("#NLSD", nlsd).Replace("#NLSK", nlsk);
            sSql = sSql.Replace("#COLD", colD).Replace("#COLK", colK);

            if (ttNeedPesonList.IndexOf(tt) > 0)
            {
                if (string.IsNullOrEmpty(hRnk.Value))
                {
                    tbPerson.Text = "Не вказано особу.";
                    hRnk.Value = "";
                    DataDepository.DataBind();
                    return;
                }
                sSql = sSql.Replace("#RNK", hRnk.Value);
            }
            DataDepository.DataSource = SQL_SELECT_dataset(sSql);
            DataDepository.DataBind();
            pnDataDepository.Visible = true;
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    private void ShowPar(byte par, bool showBranch)
    {
        trPerson1.Visible = (par == 1 || par == 3) ? (true) : (false);
        trPerson2.Visible = (par == 2 || par == 3) ? (true) : (false);
        trBranch.Visible = showBranch;
    }

    protected void ddTts_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbInfo.Text = "";
        pnResult.Visible = false;
        FillData();
    }
    protected void btPay_Click(object sender, EventArgs e)
    {
        int docsCount = 0;
        hRefList.Value = "";
        foreach (GridViewRow row in DataDepository.Rows)
        {
            string sCount = ((TextBox)row.Cells[2].Controls[1]).Text.Trim();
            if (string.IsNullOrEmpty(sCount))
                sCount = "0";
            decimal count = decimal.Parse(sCount);
            if (count > 0 && string.IsNullOrEmpty(HttpUtility.HtmlDecode(row.Cells[8].Text).Trim())
                          && !string.IsNullOrEmpty(HttpUtility.HtmlDecode(row.Cells[3].Text).Trim())
                          && !string.IsNullOrEmpty(HttpUtility.HtmlDecode(row.Cells[5].Text).Trim()))
            {
                docsCount++;
                string nlsd = row.Cells[3].Text;
                string nlsk = row.Cells[5].Text;
                string nmsd = string.Empty;
                string nmsk = string.Empty;
                string sVob = string.Empty;
                string nazn = ((TextBox)row.Cells[7].Controls[1]).Text;
                string name = row.Cells[1].Text;
                string kc = row.Cells[0].Text;
                DateTime bd;
                string userID = string.Empty; ;
                string okpo = string.Empty; ;
                string mfo = string.Empty;
                try
                {
                    InitOraConnection();
                    SetRole("WR_DOC_INPUT");
                    //vob
                    SetParameters("tt", DB_TYPE.Char, ddTts.SelectedValue, DIRECTION.Input);
                    sVob = Convert.ToString(SQL_SELECT_scalar("select vob from tts_vob where tt=:tt and rownum=1"));
                    //nms
                    ClearParameters();
                    SetParameters("nlsd", DB_TYPE.Varchar2, nlsd, DIRECTION.Input);
                    SetParameters("nlsk", DB_TYPE.Varchar2, nlsk, DIRECTION.Input);
                    ArrayList reader = SQL_reader("select d.nms,k.nms, to_char(nvl(web_utl.get_bankdate,sysdate), 'dd/MM/yyyy') BDATE, user_id, f_ourokpo OKPO, f_ourmfo MFO from accounts d, accounts k where d.kv=980 and k.kv=980 and d.nls=:nlsd and k.nls=:nlsk");
                    nmsd = Convert.ToString(reader[0]);
                    nmsk = Convert.ToString(reader[1]);
                    CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                    cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                    cinfo.DateTimeFormat.DateSeparator = "/";
                    bd = Convert.ToDateTime(reader[2], cinfo);
                    if (bd == DateTime.MinValue)
                        bd = DateTime.Now;
                    userID = Convert.ToString(reader[3]);
                    okpo = Convert.ToString(reader[4]);
                    mfo = Convert.ToString(reader[5]);
                }
                finally
                {
                    DisposeOraConnection();
                }
                long Ref = 0;	                // референс 
                string TT = ddTts.SelectedValue;   // Код операции
                byte Dk = 1;                // ДК (0-дебет, 1-кредит)
                short Vob = (string.IsNullOrEmpty(sVob)) ? ((short)222) : (Convert.ToInt16(sVob)); // Вид обработки
                string Nd = string.Empty;	// № док
                DateTime DatD = DateTime.Now;		// Дата док
                DateTime DatP = DatD;		// Дата ввода(поступления в банк)
                DateTime DatV1 = bd; // Дата валютирования основной операции
                DateTime DatV2 = DatV1;		// Дата валютирования связаной операции
                string NlsA = nlsd;		// Счет-А
                string NamA = nmsd;		// Наим-А
                string BankA = mfo; 		// МФО-А
                string NbA = string.Empty;		// Наим банка-А(м.б. '')
                short KvA = 980;			// Код вал-А
                decimal SA = count * 100;			// Сумма-А
                string OkpoA = okpo;		// ОКПО-А
                string NlsB = nlsk;		// Счет-Б
                string NamB = nmsk;		// Наим-Б
                string BankB = mfo;		// МФО-Б
                string NbB = string.Empty;			// Наим банка-Б(м.б. '')
                short KvB = 980;			// Код вал-Б
                decimal SB = count * 100;			// Сумма-Б
                string OkpoB = okpo;		// ОКПО-Б
                string Nazn = nazn;	// Назначение пл
                string Drec = string.Empty;		// Доп реквизиты
                string OperId = userID;		// Идентификатор ключа опрециониста
                byte[] Sign = new byte[0];		// ЭЦП опрециониста
                byte Sk = 0;			// СКП
                short Prty = 0;			// Приоритет документа
                decimal SQ = 0;			// Эквивалент для одновалютной оп
                string ExtSignHex = string.Empty;	// Внешняя ЭЦП в 16-ричном формате (оно же закодированное поле byte[] Sign)
                string IntSignHex = string.Empty;	// Внутренняя ЭЦП в 16-ричном формате
                string pAfterPayProc = string.Empty; /// процедура після оплати
                string pBeforePayProc = string.Empty; /// процедура перед оплатою
                OracleConnection con = OraConnector.Handler.UserConnection;
                cDoc ourDoc = new cDoc(con, Ref, TT, Dk, Vob, Nd, DatD, DatP, DatV1, DatV2, NlsA, NamA, BankA, NbA, KvA, SA, OkpoA, NlsB, NamB, BankB, NbB, KvB, SB, OkpoB, Nazn, Drec, OperId, Sign, Sk, Prty, SQ, ExtSignHex, IntSignHex, pAfterPayProc, pBeforePayProc);
                string fio1 = tbPersonGive.Text;
                string fio2 = tbPersonReceive.Text;
                if (ddTts.SelectedValue == "VS9")
                    fio1 = tbPerson.Text;
                if (ddTts.SelectedValue == "VS6")
                    fio2 = tbPerson.Text;

                try
                {
                    if (ourDoc.oDoc())
                    {
                        Ref = ourDoc.Ref;
                        Bars.Logger.DBLogger.Financial("Ввод док Ref" + Ref + ": " + NlsA + "(" + KvA + ") " + SA.ToString("F0") + " -> " + BankB + " " + NlsB + "(" + KvB + ") " + SB.ToString("F0") + "[" + NamB + "],[" + Nazn + "] " + OperId);

                        ArrayList DrecS = new ArrayList();
                        // Доп. реквизиты
                        if (Vob == 120)
                        {
                            DrecS.Add(new cDoc.Tags("GOLD", name));
                            DrecS.Add(new cDoc.Tags("PO_K1", count.ToString()));
                            DrecS.Add(new cDoc.Tags("PO_KK", count.ToString()));
                            DrecS.Add(new cDoc.Tags("SUMGD", count.ToString("#.00")));
                            DrecS.Add(new cDoc.Tags("VA_KC", kc));
                            if (!string.IsNullOrEmpty(fio1))
                                DrecS.Add(new cDoc.Tags("VLASN", fio1));
                            if (!string.IsNullOrEmpty(fio2))
                                DrecS.Add(new cDoc.Tags("FIO2", fio2));
                        }
                        else if (Vob == 121)
                        {
                            DrecS.Add(new cDoc.Tags("GOLD", name));
                            DrecS.Add(new cDoc.Tags("PO_K1", count.ToString()));
                            DrecS.Add(new cDoc.Tags("PO_KK", count.ToString()));
                            DrecS.Add(new cDoc.Tags("SUMGD", count.ToString("#.00")));
                            DrecS.Add(new cDoc.Tags("VA_KC", kc));
                            if (!string.IsNullOrEmpty(fio1))
                                DrecS.Add(new cDoc.Tags("FIO1", fio1));
                            if (!string.IsNullOrEmpty(fio2))
                                DrecS.Add(new cDoc.Tags("VLASN", fio2));
                        }
                        else
                        {
                            DrecS.Add(new cDoc.Tags("PO_N1", name));
                            DrecS.Add(new cDoc.Tags("PO_K1", count.ToString()));
                            DrecS.Add(new cDoc.Tags("PO_KK", count.ToString()));
                            DrecS.Add(new cDoc.Tags("PO_S1", count.ToString("#.00")));
                            DrecS.Add(new cDoc.Tags("VA_KC", kc));
                            if (!string.IsNullOrEmpty(fio1))
                                DrecS.Add(new cDoc.Tags("FIO1", fio1));
                            if (!string.IsNullOrEmpty(fio2))
                                DrecS.Add(new cDoc.Tags("FIO2", fio2));
                        }

                        try
                        {
                            InitOraConnection();
                            SetRole("WR_DOC_INPUT");
                            foreach (cDoc.Tags rec in DrecS)
                            {
                                ClearParameters();
                                SetParameters("ref", DB_TYPE.Decimal, Ref, DIRECTION.Input);  //0
                                SetParameters("tag", DB_TYPE.Varchar2, rec.Tag, DIRECTION.Input);
                                SetParameters("val", DB_TYPE.Varchar2, rec.Val, DIRECTION.Input);
                                SQL_NONQUERY("INSERT INTO operw (ref, tag, value) VALUES (:ref, :tag, :val)");
                            }
                        }
                        finally
                        { DisposeOraConnection(); }
                    }
                }
                finally
                {
                    if (ConnectionState.Open == con.State) con.Close();
                    con.Dispose();
                }
                row.Cells[8].Text = "<a href=# onclick=\"window.open('/barsroot/documentview/default.aspx?ref=" + Ref + "')\">" + Ref + "</a>";
                hRefList.Value += Ref + ";";
            }
            else
                row.Visible = false;
        }
        if (docsCount > 0)
        {
            lbInfo.Text = "Породжено " + docsCount + " документів(и). Детальніше - дивись колонку [РеФ.]. Для нового вводу - натисніть [Перечитати]";
            lbInfo.ForeColor = System.Drawing.Color.Green;
            imgPrintAll.Visible = true;
        }
        else
        {
            lbInfo.Text = "Не вказано кількості для жодної цінності.";
            lbInfo.ForeColor = System.Drawing.Color.Red;
            FillData();
        }
        pnResult.Visible = true;
    }

    protected void btRefresh_Click(object sender, EventArgs e)
    {
        lbInfo.Text = "";
        pnResult.Visible = false;
        FillData();
    }
    protected void ddBranches_SelectedIndexChanged(object sender, EventArgs e)
    {
        tbBranch.Text = ddBranches.SelectedValue;
        FillData();
    }
    protected void DataDepository_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (string.IsNullOrEmpty(HttpUtility.HtmlDecode(e.Row.Cells[3].Text).Trim())
               ||
               string.IsNullOrEmpty(HttpUtility.HtmlDecode(e.Row.Cells[5].Text).Trim()))
            {
                e.Row.Cells[2].Enabled = false;
            }
        }
    }
}
