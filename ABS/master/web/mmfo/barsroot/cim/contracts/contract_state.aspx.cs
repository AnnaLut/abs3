using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.DataComponents;
using barsroot.cim;


public partial class cim_contracts_contract_state : System.Web.UI.Page
{
    public override void VerifyRenderingInServerForm(Control control)
    { }

    private void showControls(bool isTrade, bool isCredit, bool isOthers)
    {
        tdTrade11.Visible = isTrade;
        tdTrade12.Visible = isTrade;
        tdTrade21.Visible = isTrade;
        tdTrade22.Visible = isTrade;
        tdTrade31.Visible = isTrade;
        tdTrade32.Visible = isTrade;
        tdTrade41.Visible = isTrade;
        tdTrade42.Visible = isTrade;
        tdTrade43.Visible = isTrade;
        tdTrade44.Visible = isTrade;
        tdTrade45.Visible = isTrade;

        tdCredit11.Visible = isCredit;
        tdCredit12.Visible = isCredit;
        tdCredit21.Visible = isCredit;
        tdCredit22.Visible = isCredit;
        tdCredit31.Visible = isCredit;
        tdCredit32.Visible = isCredit;
        tdCredit41.Visible = isCredit;
        tdCredit42.Visible = isCredit;
        tdCredit51.Visible = isCredit;
        tdCredit52.Visible = isCredit;
        tdCredit61.Visible = isCredit;
        tdCredit62.Visible = isCredit;
        tdCredit71.Visible = isCredit;
        tdCredit72.Visible = isCredit;
        tdCredit81.Visible = isCredit;
        tdCredit82.Visible = isCredit;
        tdCredit91.Visible = isCredit;
        tdCredit92.Visible = isCredit;
        tdCredit101.Visible = isCredit;
        tdCredit102.Visible = isCredit;
        tdOthers01.Visible = isOthers;
        tdOthers02.Visible = isOthers;
        tdOthers03.Visible = isOthers;
        tdOthers04.Visible = isOthers;
        tdOthers05.Visible = isOthers;
        tdOthers06.Visible = isOthers;
        tdOthers07.Visible = isOthers;
        tdOthers08.Visible = isOthers;
        tdOthers09.Visible = isOthers;
        tdOthers10.Visible = isOthers;
        tdOthers11.Visible = isOthers;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        dsPayFlag.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditMethod.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsPaymentPeriod.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditBase.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsConsider.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCreditAdaptive.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsConclOrgan.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsVCimConclusion.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsBorgReason.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        if (!IsPostBack)
        {
            var cimMgr = new CimManager(true);
            if (Session[Constants.StateKeys.AccessFlag] == "1")
                throw new ApplicationException("Заборонено перегляд стану контрактів по даному ТВБВ");
        }

        Contract contract = new Contract(Convert.ToDecimal(Request["contr_id"]));

        odsVCimInBoundPayments.SelectParameters["CONTR_TYPE"].DefaultValue = contract.ContrType.ToString();
        odsVCimOutBoundPayments.SelectParameters["CONTR_TYPE"].DefaultValue = contract.ContrType.ToString();

        this.Title += " #" + contract.ContrId;
        Master.SetPageTitle(this.Title, true);
        //ScriptManager.GetCurrent(this).Scripts.Add(new ScriptReference("/barsroot/cim/contracts/scripts/cim_contact_state.js?v" + CimManager.Version + Master.BuildVersion));
        Master.AddScript("/barsroot/cim/contracts/scripts/cim_contact_state.js");
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btExportGraph);
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btExp_pl);
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btExp_md);
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btExpJournalExcel);
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btExpJournalWord);

        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + Request["contr_id"] + "', '" + gvVCimCredgraphPayments.ClientID.Replace("_", "$") + "'); ", true);

        lbConractNum.Text = contract.Num;
        lbConractSubNum.Text = contract.SubNum;
        lbStatus.Text = contract.StatusName;
        lbDateOpen.Text = contract.DateOpenS;
        lbDateClose.Text = contract.DateCloseS;
        lbContrType.Text = contract.ContrTypeName;
        lbClientRnk.Text = contract.ClientInfo.Rnk.ToString();
        lbClientOkpo.Text = contract.ClientInfo.Okpo;
        lbClientNameK.Text = contract.ClientInfo.NmkK;
        lbKv.Text = contract.Kv.ToString();
        lbSum.Text = string.Format("{0:N}", contract.Sum).Replace(",", " ");

        Session[Constants.StateKeys.ContrTypeId] = Convert.ToString(contract.ContrType);
        // Експорт - 0, Импорт - 1
        btExp_pl.Visible = false;
        btExp_md.Visible = false;
        if (contract.ContrType == 0 || contract.ContrType == 1)
        {
            gvCimTradePrimPayments.Visible = (contract.ContrType == 1);
            btExp_pl.Visible = true;
            btExp_md.Visible = true;
            gvCimBoundPrimVmd.Visible = (contract.ContrType == 0);
            gvCimTradeSecondPayments.Visible = gvCimBoundPrimVmd.Visible;
            gvCimBoundSecondVmd.Visible = gvCimTradePrimPayments.Visible;
            showControls(true, false, false);
            TradeContractClass tcc = new TradeContractClass(Convert.ToDecimal(Request["contr_id"]));
            //tdTrade31.InnerText = string.Format(tdTrade31.InnerText, ((contract.ContrType == 0) ? ("платежів ") : ("МД")));
            lbTradeSPL.Text = CimManager.NumberFormat(tcc.SumPl);
            lbTradeSAfter.Text = (contract.ContrType == 0) ? (CimManager.NumberFormat(tcc.SumPLAfter)) : CimManager.NumberFormat(tcc.SumVmdAfter);
            lbTradeZPL.Text = CimManager.NumberFormat(tcc.ZPl);
            lbTradeZVMD.Text = CimManager.NumberFormat(tcc.ZVmd);
            lbTradeSVMD.Text = CimManager.NumberFormat(tcc.SumVmd);

            // прячем колонки, если не мультивалютные
            if (!tcc.HasMultiValutsPayments)
            {
                gvCimTradePrimPayments.Columns[9].Visible = false;
                gvCimTradePrimPayments.Columns[10].Visible = false;
                gvCimTradePrimPayments.Columns[13].Visible = false;

                gvCimTradeSecondPayments.Columns[7].Visible = false;
                gvCimTradeSecondPayments.Columns[8].Visible = false;
                gvCimTradeSecondPayments.Columns[11].Visible = false;
            }
            if (!tcc.HasMultiValutsDecls)
            {
                gvCimBoundSecondVmd.Columns[8].Visible = false;
                gvCimBoundSecondVmd.Columns[9].Visible = false;
                gvCimBoundSecondVmd.Columns[12].Visible = false;

                gvCimBoundPrimVmd.Columns[9].Visible = false;
                gvCimBoundPrimVmd.Columns[10].Visible = false;
                //gvCimBoundPrimVmd.Columns[13].Visible = false;
            }
        }
        else if (contract.ContrType == 2)
        {
            showControls(false, true, false);
            CreditContractClass ccc = new CreditContractClass(Convert.ToDecimal(Request["contr_id"]), true);
            lbCreditInterestPaid.Text = CimManager.NumberFormat(ccc.CreditInterestPaid);
            lbTotalRevenue.Text = CimManager.NumberFormat(ccc.TotalRevenue);
            lbCreditDueBody.Text = CimManager.NumberFormat(ccc.CreditDueBody);
            lbCreditTotalOutlay.Text = CimManager.NumberFormat(ccc.TotalOutlay);
            lbFutureRevenue.Text = CimManager.NumberFormat(ccc.FutureRevenue);
            lbAccruedInterest.Text = CimManager.NumberFormat(ccc.AccruedInterest);
            lbCalcRateNbu.Text = CimManager.NumberFormat(ccc.CalcRateNbu);
            lbAddPaymentsSum.Text = CimManager.NumberFormat(ccc.AddPaymentsSum);
            lbDelayScoreBody.Text = CimManager.NumberFormat(ccc.DelayScoreBody);
            lbDelayScoreInterest.Text = CimManager.NumberFormat(ccc.DelayScoreInterest);

            // Строим график
            gvCredGraph.DataSource = ccc.CredGraphTable;
            gvCredGraph.DataBind();
            if (gvCredGraph.Rows.Count > 1)
            {
                gvCredGraph.Rows[gvCredGraph.Rows.Count - 1].Font.Bold = true;
                gvCredGraph.Rows[gvCredGraph.Rows.Count - 1].ForeColor = System.Drawing.Color.Black;
                gvCredGraph.Rows[gvCredGraph.Rows.Count - 1].Cells[0].Text = "Всього";
            }
        }
        else if (contract.ContrType == 3 || contract.ContrType == 4)
        {
            OtherContractClass occ = new OtherContractClass(Convert.ToDecimal(Request["contr_id"]));
            lbOtherSumIn.Text = CimManager.NumberFormat(occ.SumIn);
            lbOtherSumOut.Text = CimManager.NumberFormat(occ.SumOut);
            lbOtherSumAddIn.Text = CimManager.NumberFormat(occ.SumAddIn);
            lbOtherSumAddOut.Text = CimManager.NumberFormat(occ.SumAddOut);
			  
            showControls(false, false, true);
        }
    }

    protected void gvVCimCredgraphPayments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskStr, "ri", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ROW_ID")));
            rowdata += string.Format(parMaskStr, "dat", Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "DAT")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskInt, "sum", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
            rowdata += string.Format(parMaskInt, "fi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PAY_FLAG_ID")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rowdata", rowdata);
        }
    }

    protected void gvVCimCredgraphPeriods_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskStr, "ri", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ROW_ID")));
            rowdata += string.Format(parMaskStr, "ed", Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "END_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskInt, "cmi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CR_METHOD_ID")));
            rowdata += string.Format(parMaskInt, "papi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PAYMENT_PERIOD_ID")));
            rowdata += string.Format(parMaskInt, "pad", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PAYMENT_DELAY")));
            rowdata += string.Format(parMaskInt, "z", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Z")));
            rowdata += string.Format(parMaskInt, "p", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PERCENT")));
            rowdata += string.Format(parMaskInt, "pn", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PERCENT_NBU")));
            rowdata += string.Format(parMaskInt, "pbi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PERCENT_BASE_ID")));
            rowdata += string.Format(parMaskInt, "peid", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PERCENT_PERIOD_ID")));
            rowdata += string.Format(parMaskInt, "ped", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PERCENT_DELAY")));
            rowdata += string.Format(parMaskInt, "gdi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "GET_DAY_ID")));
            rowdata += string.Format(parMaskInt, "pdi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PAY_DAY_ID")));
            rowdata += string.Format(parMaskInt, "patd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PAYMENT_DAY")));
            rowdata += string.Format(parMaskInt, "perd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PERCENT_DAY")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rowdata", rowdata);
        }
    }

    protected void gvVCimBoundPayments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "bi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID")));
            rowdata += string.Format(parMaskInt, "ti", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID")));
            rowdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            if (sender is BarsGridViewEx)
            {
                string gridId = ((BarsGridViewEx)sender).ID;
                if (gridId == "gvCimTradeSecondPayments" || gridId == "gvCimTradePrimPayments")
                {
                    int colIndex = 9;
                    if ("gvCimTradeSecondPayments" == gridId)
                        colIndex = 6;
                    //e.Row.Cells[colIndex].Text = gridId;

                    decimal totalSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_VPL"));
                    decimal boundSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ZS_VP"));
                    if (boundSum == totalSum)
                    {
                        e.Row.Cells[colIndex].Font.Bold = true;
                        e.Row.Cells[colIndex].ForeColor = Color.Maroon;
                    }
                    else if (boundSum < totalSum && boundSum > 0) // частично привязан
                    {
                        e.Row.Cells[colIndex].Font.Bold = true;
                        e.Row.Cells[colIndex].ForeColor = Color.Green;
                    }
                    else
                        e.Row.Cells[colIndex].ForeColor = Color.Black;

                    string bi = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID"));
                    string ti = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID"));
                    string di = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "REF"));
                    // borg reason 
                    if (gridId == "gvCimTradePrimPayments")
                    {
                        decimal overdue = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "OVERDUE"));

                        if (overdue > 0)
                        {
                            e.Row.Cells[e.Row.Cells.Count - 2].Text =
                                "<img src='/Common/Images/default/16/document.png' title='Редагувати причину заборгованості' onclick='curr_module.EditBorgReason(0, " +
                                bi + "," + ti + ")'></img>&nbsp;&nbsp;" + e.Row.Cells[e.Row.Cells.Count - 2].Text;
                        }
                    }
                    e.Row.Cells[e.Row.Cells.Count - 1].Text =
                                "<img src='/Common/Images/default/16/document.png' title='Змінити дату реєстрації в журналі' onclick='curr_module.EditRegDate(0, " +
                                bi + "," + ti + "," + di + ",\"" + Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "CREATE_DATE")).ToString("dd/MM/yyyy") + "\")'></img>&nbsp;&nbsp;" + e.Row.Cells[e.Row.Cells.Count - 1].Text;

                }
            }
        }
    }

    protected void gvCimBoundVmd_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskInt = "\"{0}\":{1},";
            string parMaskStr = "\"{0}\":'{1}',";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "bi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID")));
            rowdata += string.Format(parMaskInt, "ti", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID")));
            rowdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
            rowdata += string.Format(parMaskInt, "vi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "VMD_ID")));

            string dat = (DataBinder.Eval(e.Row.DataItem, "DOC_DATE") == null) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "DOC_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "dd", dat);
            dat = (DataBinder.Eval(e.Row.DataItem, "ALLOW_DATE") == null) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "ALLOW_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "ad", dat);
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            int colIndex = 7;
            string gridId = ((BarsGridViewEx)sender).ID;
            //e.Row.Cells[colIndex].Text = ((BarsGridViewEx) sender).ID;
            if ("gvCimBoundPrimVmd" == gridId)
                colIndex = 8;
            decimal totalSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_VK"));
            decimal boundSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_PL_VK"));
            if (boundSum == 0)
            {
                e.Row.Cells[colIndex].Font.Bold = true;
                e.Row.Cells[colIndex].ForeColor = Color.Maroon;
            }
            else if (boundSum < totalSum && boundSum > 0) // частично привязан
            {
                e.Row.Cells[colIndex].Font.Bold = true;
                e.Row.Cells[colIndex].ForeColor = Color.Green;
            }
            else
                e.Row.Cells[colIndex].ForeColor = Color.Black;

            string bi = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID"));
            string ti = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID"));
            string di = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "VMD_ID"));
            // borg reason 
            if (gridId == "gvCimBoundPrimVmd")
            {
                decimal overdue = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "OVERDUE"));
                if (overdue > 0)
                {

                    e.Row.Cells[e.Row.Cells.Count - 2].Text =
                        "<img src='/Common/Images/default/16/document.png' title='Редагувати причину заборгованості' onclick='curr_module.EditBorgReason(1, " +
                        bi + "," + ti + ")'></img>&nbsp;&nbsp;" + e.Row.Cells[e.Row.Cells.Count - 2].Text;
                }
            }
            e.Row.Cells[e.Row.Cells.Count - 1].Text =
                                "<img src='/Common/Images/default/16/document.png' title='Змінити дату реєстрації в журналі' onclick='curr_module.EditRegDate(1, " +
                                bi + "," + ti + "," + di + ",\"" + Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "CREATE_DATE")).ToString("dd/MM/yyyy") + "\")'></img>&nbsp;&nbsp;" + e.Row.Cells[e.Row.Cells.Count - 1].Text;
        }
    }

    protected void gvVCimConclusion_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "ri", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ID")));
            rowdata += string.Format(parMaskInt, "ori", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ORG_ID")));
            rowdata += string.Format(parMaskStr, "onm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "OUT_NUM")));
            rowdata += string.Format(parMaskStr, "bdt", Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "edt", Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "END_DATE")).ToString("dd/MM/yyyy"));
            string dat = (DataBinder.Eval(e.Row.DataItem, "OUT_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "OUT_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "odt", dat);
            rowdata += string.Format(parMaskInt, "sum", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
            rowdata += string.Format(parMaskInt, "sd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_DOC")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_DOC")) > 0)
            {
                e.Row.Cells[2].Controls[1].Visible = false;
                e.Row.Cells[1].Controls[1].Visible = false;
            }
            if (Session[Constants.StateKeys.ContrTypeId].Equals("0"))
            {
                HtmlImage img = e.Row.Cells[3].Controls[1] as HtmlImage;
                img.Src = "/barsroot/cim/style/img/row_check_d.PNG";
                img.Attributes["title"] = "Перегляд МД\\актів, пов'язаних з висновком";
                img.Attributes["onclick"] = "curr_module.LinkConclusion($(this), true)";
            }
        }
    }

    protected void gvCredGraph_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView objGridView = (GridView)sender;
            GridViewRow objgridviewrow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell objtablecell = new TableCell();
            AddMergedCells(objgridviewrow, objtablecell, 1, "Дата");
            AddMergedCells(objgridviewrow, objtablecell, 6, "Плановий графік");

            AddMergedCells(objgridviewrow, objtablecell, 8, "Реальний графік");

            objGridView.Controls[0].Controls.AddAt(0, objgridviewrow);
        }
    }

    protected void AddMergedCells(GridViewRow objgridviewrow, TableCell objtablecell, int colspan, string celltext)
    {
        objtablecell = new TableCell();
        objtablecell.Text = celltext;
        objtablecell.Font.Bold = true;
        objtablecell.ColumnSpan = colspan;

        if (colspan == 1)
            objtablecell.Style.Add("border", "none");
        else
            objtablecell.Style.Add("border", "1px dotted black");
        objtablecell.HorizontalAlign = HorizontalAlign.Center;
        objgridviewrow.Cells.Add(objtablecell);
    }

    [WebMethod(EnableSession = true)]
    public static Contract PopulateContract(decimal? contrId)
    {
        Contract contractInfo = new Contract(contrId);
        return contractInfo;
    }

    [WebMethod(EnableSession = true)]
    public static void DeletePayment(decimal? contrId, string rowid)
    {
        CreditContractClass ccc = new CreditContractClass();
        ccc.DeletePayment(contrId, rowid);
    }

    [WebMethod(EnableSession = true)]
    public static void UpdatePayment(CreditPaymentClass cpc)
    {
        CreditContractClass ccc = new CreditContractClass();
        ccc.UpdatePayment(cpc);
    }


    [WebMethod(EnableSession = true)]
    public static void DeletePeriod(decimal? contrId, string rowid)
    {
        CreditContractClass ccc = new CreditContractClass();
        ccc.DeletePeriod(contrId, rowid);
    }

    [WebMethod(EnableSession = true)]
    public static void UpdatePeriod(CreditPeriodClass cpc)
    {
        CreditContractClass ccc = new CreditContractClass();
        ccc.UpdatePeriod(cpc);
    }

    [WebMethod(EnableSession = true)]
    public static void UnboundPayment(decimal boundId, int typePayment, string comment)
    {
        Contract contractInfo = new Contract();
        contractInfo.UnboundPayment(boundId, typePayment, comment);
    }

    [WebMethod(EnableSession = true)]
    public static void UnboundDecl(decimal boundId, int typeDecl, string comment)
    {
        Contract contractInfo = new Contract();
        contractInfo.UnboundDecl(boundId, typeDecl, comment);
    }

    [WebMethod(EnableSession = true)]
    public static void DeleteConclusion(decimal ConclId)
    {
        Contract contractInfo = new Contract();
        contractInfo.DeleteConclusion(ConclId);
    }

    [WebMethod(EnableSession = true)]
    public static void UpdateConclusion(ConclusionClass cc)
    {
        Contract contractInfo = new Contract();
        contractInfo.UpdateConclusion(cc);
    }

    [WebMethod(EnableSession = true)]
    public static void DeleteApe(decimal ApeId)
    {
        Contract contractInfo = new Contract();
        contractInfo.DeleteApe(ApeId);
    }

    [WebMethod(EnableSession = true)]
    public static void UpdateApe(ApeClass ac)
    {
        Contract contractInfo = new Contract();
        contractInfo.UpdateApe(ac);
    }

    [WebMethod(EnableSession = true)]
    public static bool SetDeclPaperDate(decimal id, string date)
    {
        CimManager cm = new CimManager(false);
        return cm.SetDeclPaperDate(id, date);
    }

    [WebMethod(EnableSession = true)]
    public static void SaveBorgReason(int boundType, decimal boundId, int docType, decimal borgReason)
    {
        Contract contractInfo = new Contract();
        contractInfo.SaveBorgReason(boundType, boundId, docType, borgReason);
    }
    [WebMethod(EnableSession = true)]
    public static string SaveRegDate(int contrType, int boundType, decimal boundId, int docType, int docId, string date)
    {
        Contract contractInfo = new Contract();
        return contractInfo.SaveRegDate(contrType, boundType, boundId, docType, docId, date);
    }

    protected void btExportGraph_Click(object sender, EventArgs e)
    {
        gvCredGraph.ShowHeader = true;
        gvCredGraph.DataBind();
        //Export
        string contentType = "vnd.ms-excel";
        LiteralControl lc = new LiteralControl();

        string attachment = "attachment; filename=graph_" + Request["contr_id"] + ".xls";
        Response.ClearContent();
        Response.BufferOutput = true;
        Response.AddHeader("content-disposition", attachment);
        Response.Charset = "utf-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.ContentType = "application/" + contentType;
        Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");

        StringWriter swrt = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(swrt);
        lc.RenderControl(htw);

        gvCredGraph.RenderControl(htw);
        Response.Write("<HEAD><STYLE>");
        Response.Write(".nobot {border-bottom: 1px solid red;}");
        Response.Write("td {border: 1px solid black;}");
        Response.Write("</STYLE></HEAD>");
        Response.Write(swrt.ToString());
        Response.Flush();
        Response.End();
    }

    protected void gvCredGraph_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            int flag = Convert.ToInt32(((DataRowView)e.Row.DataItem).Row["FLAG"]);
            if (flag <= 0)
            {
                e.Row.ForeColor = System.Drawing.Color.Blue;
            }
        }
    }
    protected void gvVCimApe_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "ai", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "APE_ID")));
            rowdata += string.Format(parMaskStr, "nm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NUM")));
            rowdata += string.Format(parMaskInt, "kv", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "KV")));
            rowdata += string.Format(parMaskStr, "s", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
            rowdata += string.Format(parMaskStr, "rt", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "RATE")));
            rowdata += string.Format(parMaskStr, "svk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VK")));
            rowdata += string.Format(parMaskStr, "cm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "COMMENTS")));
            rowdata += string.Format(parMaskStr, "zvk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ZS_VK")));


            string dat = (DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "bdt", dat);
            dat = (DataBinder.Eval(e.Row.DataItem, "END_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "END_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "edt", dat);
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ZS_VK")) != Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_VK")))
            {
                e.Row.Cells[2].Controls[1].Visible = false;
                e.Row.Cells[1].Controls[1].Visible = false;
            }
        }
    }

    protected void btExp_OnClick(object sender, EventArgs e)
    {
        FrxParameters pars = new FrxParameters();
        string suffix = ((HtmlButton)sender).ID.Substring(6, 2);
        Contract contr = new Contract(Convert.ToDecimal(Request["CONTR_ID"]));
        string fileFrx = string.Empty;
        if (contr.ContrType == 1)
            fileFrx = "xls_" + suffix + "_imp_contr.frx";
        else
            fileFrx = "xls_" + ((suffix == "pl") ? ("md") : ("pl")) + "_exp_contr.frx";

        string templatePath = Path.Combine(Server.MapPath("/barsroot/cim/tools/templates"), fileFrx);
        pars.Add(new FrxParameter("p_contr_id", TypeCode.String, Request["contr_id"]));
        FrxDoc doc = new FrxDoc(templatePath, pars, null);
        string tmpFileName = doc.Export(FrxExportTypes.Excel2007);
        string fileName = string.Format("report{0}{1}", Request["contr_id"], Path.GetExtension(tmpFileName));
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.AppendHeader("content-disposition", "attachment;filename=" + fileName);
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(tmpFileName, true);
        Response.Flush();
        Response.End();
    }

    protected void btExpJournalExcel_OnServerClick(object sender, EventArgs e)
    {
        FrxParameters pars = new FrxParameters();
        string fileFrx = "contract_journal.frx";
        string templatePath = Path.Combine(Server.MapPath("/barsroot/cim/tools/templates"), fileFrx);
        pars.Add(new FrxParameter("p_contr_id", TypeCode.String, Request["contr_id"]));
        FrxDoc doc = new FrxDoc(templatePath, pars, null);
        string tmpFileName = doc.Export(FrxExportTypes.Excel2007);
        string fileName = string.Format("report{0}{1}", Request["contr_id"], Path.GetExtension(tmpFileName));
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.AppendHeader("content-disposition", "attachment;filename=" + fileName);
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(tmpFileName, true);
        Response.Flush();
        Response.End();
    }

    protected void btExpJournalWord_OnServerClick(object sender, EventArgs e)
    {
        FrxParameters pars = new FrxParameters();
        string fileFrx = "contract_journal.frx";
        string templatePath = Path.Combine(Server.MapPath("/barsroot/cim/tools/templates"), fileFrx);
        pars.Add(new FrxParameter("p_contr_id", TypeCode.String, Request["contr_id"]));
        FrxDoc doc = new FrxDoc(templatePath, pars, null);
        string tmpFileName = doc.Export(FrxExportTypes.Word2007);
        string fileName = string.Format("report{0}{1}", Request["contr_id"], Path.GetExtension(tmpFileName));
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.AppendHeader("content-disposition", "attachment;filename=" + fileName);
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(tmpFileName, true);
        Response.Flush();
        Response.End();
    }
}