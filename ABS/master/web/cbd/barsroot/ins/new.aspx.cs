using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Drawing;
using Bars.Ins;
using Bars.Classes;
using Bars.UserControls;
using Bars.Oracle;
using ibank.core;
using Bars.DataComponents;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class ins_new : System.Web.UI.Page
{
    # region Приватные свойства
    private VInsDealsRecord _Deal;
    private VInsDealsRecord _OldDeal;
    # endregion

    # region Публичные свойства
    public Decimal? DEAL_ID
    {
        get { return (Decimal?)ViewState["DEAL_ID"]; }
        set { ViewState["DEAL_ID"] = value; }
    }
    private VInsDealsRecord Deal
    {
        get
        {
            if (_Deal == null && DEAL_ID.HasValue)
                _Deal = (new VInsDeals()).SelectDeal(DEAL_ID);

            return _Deal;
        }
    }
    public Decimal? OLD_ID
    {
        get
        {
            if (Request.Params.Get("oldid") == null)
                return (Decimal?)null;

            return Convert.ToDecimal(Request.Params.Get("oldid"));
        }
    }
    private VInsDealsRecord OldDeal
    {
        get
        {
            if (_OldDeal == null && OLD_ID.HasValue)
                _OldDeal = (new VInsDeals()).SelectDeal(OLD_ID);

            return _OldDeal;
        }
    }
    public String Comment
    {
        get
        {
            if (Request.Params.Get("comm") == null)
                return String.Empty;

            return Request.Params.Get("comm");
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, Convert.ToInt16(Request.Params.Get("custtype")) == 2 ? "ЮО" : "ФО"), true);
        sdsUserPartners.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsUserPartners.SelectCommand = "select * from v_ins_user_partners where custid = :p_custid";

        if (!IsPostBack)
        {
            TextBoxRefer INS_RNK = (wzd.FindControl("INS_RNK") as TextBoxRefer);
            TextBoxRefer CL_RNK = (wzd.FindControl("CL_RNK") as TextBoxRefer);
            TextBoxRefer GRT_ID = (wzd.FindControl("GRT_ID") as TextBoxRefer);
            TextBoxRefer ND = (wzd.FindControl("ND") as TextBoxRefer);
            
            INS_RNK.Value = String.IsNullOrEmpty(Request.Params.Get("rnk")) ? "" : Request.Params.Get("rnk");

            TextBox INS_FIO = (wzd.FindControl("INS_FIO") as TextBox);
            TextBox INS_DOC = (wzd.FindControl("INS_DOC") as TextBox);
            TextBox INS_INN = (wzd.FindControl("INS_INN") as TextBox);

            if (!String.IsNullOrEmpty(INS_RNK.Value))
            {
                VInsCustomersRecord Customer = (new VInsCustomers()).SelectCustomer(Convert.ToDecimal(INS_RNK.Value));

                INS_FIO.Text = Customer.NMK;
                INS_DOC.Text = String.Format("{0}{1}", Customer.DOC_SER, Customer.DOC_NUM) + (String.IsNullOrEmpty(Customer.DOC_ISSUER) ? "" : " виданий " + Customer.DOC_ISSUER.Trim()) + (Customer.DOC_DATE.HasValue ? String.Format(" {0:d}", Customer.DOC_DATE) : "");
                INS_INN.Text = Customer.OKPO;
            }
            else
            {
                INS_FIO.Text = String.Empty;
                INS_DOC.Text = String.Empty;
                INS_INN.Text = String.Empty;
            }
            //String RNK = String.IsNullOrEmpty(Request.Params.Get("rnk")) ? "" : " AND RNK = " + Request.Params.Get("rnk");
            INS_RNK.WHERE_CLAUSE = String.Format("WHERE DATE_OFF IS NULL AND CUSTTYPE = {0}", Request.Params.Get("custtype"));
            CL_RNK.WHERE_CLAUSE = String.Format("WHERE DATE_OFF IS NULL AND CUSTTYPE = {0}", Request.Params.Get("custtype"));
            //GRT_ID.WHERE_CLAUSE = String.Format("WHERE CTYPE = {0}", Request.Params.Get("custtype"));
            //ND.WHERE_CLAUSE = String.Format("WHERE CTYPE = {0}", Request.Params.Get("custtype"));
            
            InitControls();
        }
    }
    protected void PARTNER_ID_ValueChanged(object sender, EventArgs e)
    {
        DDLList TYPE_ID = (wzd.FindControl("TYPE_ID") as DDLList);
        TYPE_ID.Items.Clear();
        TYPE_ID.DataBind();
    }
    protected void INS_RNK_ValueChanged(object sender, EventArgs e)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        TextBoxRefer INS_RNK = (sender as TextBoxRefer);

        TextBox INS_FIO = (wzd.FindControl("INS_FIO") as TextBox);
        TextBox INS_DOC = (wzd.FindControl("INS_DOC") as TextBox);
        TextBox INS_INN = (wzd.FindControl("INS_INN") as TextBox);

        if (!String.IsNullOrEmpty(INS_RNK.Value))
        {
            cmd.CommandText = "select * from v_ins_deals v where v.ins_rnk = :ins_rnk";
            cmd.Parameters.Add(":ins_rnk", OracleDbType.Decimal, INS_RNK.Value, System.Data.ParameterDirection.Input);

            OracleDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                String msg = "У кліента РНК №" + INS_RNK.Value + " присутні СД №№ ";
                while (reader.Read())
                {
                    msg += reader["deal_id"].ToString() + ",";
                }
                ScriptManager.RegisterStartupScript(this, typeof(Page), "success_alert", String.Format("alert('{0}'); ", msg), true);
            }
            VInsCustomersRecord Customer = (new VInsCustomers()).SelectCustomer(Convert.ToDecimal(INS_RNK.Value));

            INS_FIO.Text = Customer.NMK;
            INS_DOC.Text = String.Format("{0}{1}", Customer.DOC_SER, Customer.DOC_NUM) + (String.IsNullOrEmpty(Customer.DOC_ISSUER) ? "" : " виданий " + Customer.DOC_ISSUER.Trim()) + (Customer.DOC_DATE.HasValue ? String.Format(" {0:d}", Customer.DOC_DATE) : "");
            INS_INN.Text = Customer.OKPO;
        }
        else
        {
            INS_FIO.Text = String.Empty;
            INS_DOC.Text = String.Empty;
            INS_INN.Text = String.Empty;
        }
    }
    protected void wzd_ActiveStepChanged(object sender, EventArgs e)
    {
        Label lStepTitle = (wzd.FindControl("HeaderContainer").FindControl("lStepTitle") as Label);
        lStepTitle.Text = wzd.ActiveStep.Title;
    }
    protected void wsKey_Activate(object sender, EventArgs e)
    {
        TextBoxDate SDATE = (wzd.FindControl("SDATE") as TextBoxDate);
        TextBoxDate EDATE = (wzd.FindControl("EDATE") as TextBoxDate);

        if (SDATE != null && !SDATE.Value.HasValue)
            SDATE.Value = DateTime.Now.Date;
        if (EDATE != null && !EDATE.Value.HasValue)
            EDATE.Value = DateTime.Now.Date.AddYears(1);
    }
    protected void wsObject_Activate(object sender, EventArgs e)
    {
        DDLList PARTNER_ID = (wzd.FindControl("PARTNER_ID") as DDLList);
        DDLList TYPE_ID = (wzd.FindControl("TYPE_ID") as DDLList);

        VInsUserPartnerTypesRecord PartnerType = (new VInsUserPartnerTypes()).SelectPartnerType(PARTNER_ID.Value, TYPE_ID.Value);

        // в зависимости от типа объекта у типа прячем показываем разные панели
        if (PartnerType.OBJECT_TYPE == "CL")
        {
            rbgObject_CheckedChanged(true);
            rbgObject_ShowHide(true, false);
        }
        else if (PartnerType.OBJECT_TYPE == "GRT")
        {
            rbgObject_CheckedChanged(false);
            rbgObject_ShowHide(false, true);
        }
        else
        {
            rbgObject_CheckedChanged(true);
            rbgObject_ShowHide(true, true);
        }

        TextBoxRefer GRT_ID = (wzd.FindControl("GRT_ID") as TextBoxRefer);
        TextBoxRefer ND = (wzd.FindControl("ND") as TextBoxRefer);

        // умолчательные значения Обеспечения и Кредита
        VInsGrtDealsRecord recGrt = new VInsGrtDeals().SelectFirstDealByRNK(Convert.ToDecimal(INS_RNK.Value));
        if (recGrt != null)
        {
            GRT_ID.Value = Convert.ToString(recGrt.DEAL_ID);
            GRT_ID_ValueChanged(GRT_ID, null);
        }
        VInsCcDealsRecord recCC = new VInsCcDeals().SelectFirstDealByRNK(Convert.ToDecimal(INS_RNK.Value));
        if (recCC != null)
        {
            ND.Value = Convert.ToString(recCC.ND);
            ND_ValueChanged(ND, null);
        }
        
        // умолчательное значение сортировки
        GRT_ID.ORDERBY_CLAUSE = String.Format("ORDER BY DECODE(DEAL_RNK, {0}, 0, 1), DEAL_ID DESC", INS_RNK.Value);
        ND.ORDERBY_CLAUSE = String.Format("ORDER BY DECODE(DEAL_RNK, {0}, 0, 1), ND DESC", INS_RNK.Value);
    }
    protected void rbCL_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton rbCL = (sender as RadioButton);
        rbgObject_CheckedChanged(rbCL.Checked);
    }
    protected void rbGRT_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton rbGRT = (sender as RadioButton);
        rbgObject_CheckedChanged(!rbGRT.Checked);
    }
    protected void CL_RNK_ValueChanged(object sender, EventArgs e)
    {
        TextBoxRefer CL_RNK = (sender as TextBoxRefer);

        TextBox CL_FIO = (wzd.FindControl("CL_FIO") as TextBox);
        TextBox CL_DOC = (wzd.FindControl("CL_DOC") as TextBox);
        TextBox CL_INN = (wzd.FindControl("CL_INN") as TextBox);

        if (!String.IsNullOrEmpty(CL_RNK.Value))
        {
            VInsCustomersRecord Customer = (new VInsCustomers()).SelectCustomer(Convert.ToDecimal(CL_RNK.Value));

            CL_FIO.Text = Customer.NMK;
            CL_DOC.Text = String.Format("{0}{1}", Customer.DOC_SER, Customer.DOC_NUM) + (String.IsNullOrEmpty(Customer.DOC_ISSUER) ? "" : " виданий " + Customer.DOC_ISSUER.Trim()) + (Customer.DOC_DATE.HasValue ? String.Format(" {0:d}", Customer.DOC_DATE) : "");
            CL_INN.Text = Customer.OKPO;
        }
        else
        {
            CL_FIO.Text = String.Empty;
            CL_DOC.Text = String.Empty;
            CL_INN.Text = String.Empty;
        }
    }
    protected void GRT_ID_ValueChanged(object sender, EventArgs e)
    {
        TextBoxRefer GRT_ID = (sender as TextBoxRefer);

        TextBox GRT_TYPE = (wzd.FindControl("GRT_TYPE") as TextBox);
        TextBox GRT_DEAL_NUM = (wzd.FindControl("GRT_DEAL_NUM") as TextBox);
        TextBox GRT_DEAL_DATE = (wzd.FindControl("GRT_DEAL_DATE") as TextBox);
        TextBox GRT_GRT_NAME = (wzd.FindControl("GRT_GRT_NAME") as TextBox);

        if (!String.IsNullOrEmpty(GRT_ID.Value))
        {
            VInsGrtDealsRecord GrtDeal = (new VInsGrtDeals()).SelectGrtDeal(Convert.ToDecimal(GRT_ID.Value));

            GRT_TYPE.Text = String.Format("{0} - {1}", GrtDeal.TYPE_ID, GrtDeal.TYPE_NAME);
            GRT_DEAL_NUM.Text = GrtDeal.DEAL_NUM;
            GRT_DEAL_DATE.Text = String.Format("{0:d}", GrtDeal.DEAL_DATE);
            GRT_GRT_NAME.Text = GrtDeal.GRT_NAME;
        }
        else
        {
            GRT_TYPE.Text = String.Empty;
            GRT_DEAL_NUM.Text = String.Empty;
            GRT_DEAL_DATE.Text = String.Empty;
            GRT_GRT_NAME.Text = String.Empty;
        }
    }
    protected void ND_ValueChanged(object sender, EventArgs e)
    {
        TextBoxRefer ND = (sender as TextBoxRefer);

        TextBox ND_NUM = (wzd.FindControl("ND_NUM") as TextBox);
        TextBox ND_SDATE = (wzd.FindControl("ND_SDATE") as TextBox);

        if (!String.IsNullOrEmpty(ND.Value))
        {
            VInsCcDealsRecord CcDeal = (new VInsCcDeals()).SelectCcDeal(Convert.ToDecimal(ND.Value));

            ND_NUM.Text = CcDeal.NUM;
            ND_SDATE.Text = String.Format("{0:d}", CcDeal.SDATE);
        }
        else
        {
            ND_NUM.Text = String.Empty;
            ND_SDATE.Text = String.Empty;
        }
    }
    protected void wsFinance_Activate(object sender, EventArgs e)
    {
        RadioButton rbTARIFF = (wzd.FindControl("rbTARIFF") as RadioButton);
        RadioButton rbSUM = (wzd.FindControl("rbSUM") as RadioButton);

        // ограничения на тариф
        DDLList PARTNER_ID = (wzd.FindControl("PARTNER_ID") as DDLList);
        DDLList TYPE_ID = (wzd.FindControl("TYPE_ID") as DDLList);

        VInsUserPartnerTypeTariffRecord Tariff = (new VInsUserPartnerTypeTariff()).SelectPartnerTypeTariff(PARTNER_ID.Value, TYPE_ID.Value);
        if (Tariff != null)
        {
            TextBoxDecimal INSU_TARIFF = (wzd.FindControl("INSU_TARIFF") as TextBoxDecimal);
            TextBoxDecimal INSU_SUM = (wzd.FindControl("INSU_SUM") as TextBoxDecimal);

            if (Tariff.MIN_PERC.HasValue) INSU_TARIFF.MinValue = Tariff.MIN_PERC.Value;
            if (Tariff.MAX_PERC.HasValue) INSU_TARIFF.MaxValue = Tariff.MAX_PERC.Value;
            if (Tariff.MIN_VALUE.HasValue) INSU_SUM.MinValue = Tariff.MIN_VALUE.Value;
            if (Tariff.MAX_VALUE.HasValue) INSU_SUM.MaxValue = Tariff.MAX_VALUE.Value;
        }

        // омолчательно выбираем один из вариантов
        if (!rbTARIFF.Checked && !rbSUM.Checked)
            rbTARIFF.Checked = true;

        rbgFinance_CheckedChanged(rbTARIFF.Checked);
    }
    protected void rbTARIFF_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton rbTARIFF = (sender as RadioButton);
        rbgFinance_CheckedChanged(rbTARIFF.Checked);
    }
    protected void rbINSU_SUM_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton rbSUM = (sender as RadioButton);
        rbgFinance_CheckedChanged(!rbSUM.Checked);
    }
    protected void wsAttrs_Activate(object sender, EventArgs e)
    {
        if (dlPartnerTypeAttrs.Items.Count == 0)
            wzd.MoveTo(wsScans);
    }
    protected void odsPartnerTypeAttrs_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["PARTNER_ID"] = Deal.PARTNER_ID;
        e.InputParameters["TYPE_ID"] = Deal.TYPE_ID;
    }
    protected void wsScans_Activate(object sender, EventArgs e)
    {
        if (dlPartnerTypeScans.Items.Count == 0)
            wzd.MoveTo(wsPaymentsSchedule);
    }
    protected void odsPartnerTypeScans_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["PARTNER_ID"] = Deal.PARTNER_ID;
        e.InputParameters["TYPE_ID"] = Deal.TYPE_ID;
    }

    protected void wsPaymentsSchedule_Activate(object sender, EventArgs e)
    {
    }
    protected void odsPaymentsSchedule_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["DEAL_ID"] = DEAL_ID;
    }
    protected void ibAddNew_Click(object sender, EventArgs e)
    {
        lvPaymentsSchedule.InsertItemPosition = InsertItemPosition.LastItem;
    }
    protected void ibCancel_Click(object sender, EventArgs e)
    {
        lvPaymentsSchedule.InsertItemPosition = InsertItemPosition.None;
    }
    
    protected void lvPaymentsSchedule_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem && (e.Item as ListViewDataItem).DisplayIndex == lvPaymentsSchedule.EditIndex
            && e.Item.ItemType == ListViewItemType.InsertItem)
        {
            TextBoxDate PLAN_DATE = e.Item.FindControl("PLAN_DATE") as TextBoxDate;
            TextBoxDecimal PLAN_SUM = e.Item.FindControl("PLAN_SUM") as TextBoxDecimal;

            if (Deal.SDATE.HasValue) PLAN_DATE.MinValue = Deal.SDATE.Value;
            if (Deal.EDATE.HasValue) PLAN_DATE.MaxValue = Deal.EDATE.Value;
            PLAN_SUM.MinValue = 1;
            if (Deal.TOTAL_INSU_SUM.HasValue) PLAN_SUM.MaxValue = Deal.TOTAL_INSU_SUM.Value;
        }
    }
    protected void lvPaymentsSchedule_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        TextBoxDate PLAN_DATE = e.Item.FindControl("PLAN_DATE") as TextBoxDate;
        TextBoxDecimal PLAN_SUM = e.Item.FindControl("PLAN_SUM") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        Decimal? ID = ip.SET_DEAL_PMT((Decimal?)null, DEAL_ID, PLAN_DATE.Value, PLAN_SUM.Value);

        lvPaymentsSchedule.InsertItemPosition = InsertItemPosition.None;
        lvPaymentsSchedule.DataBind();
        e.Cancel = true;
    }
    protected void lvPaymentsSchedule_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
        TextBoxDate PLAN_DATE = lvPaymentsSchedule.Items[e.ItemIndex].FindControl("PLAN_DATE") as TextBoxDate;
        TextBoxDecimal PLAN_SUM = lvPaymentsSchedule.Items[e.ItemIndex].FindControl("PLAN_SUM") as TextBoxDecimal;

        Decimal? ID = (Decimal?)lvPaymentsSchedule.DataKeys[e.ItemIndex]["ID"];

        InsPack ip = new InsPack(new BbConnection());
        ID = ip.SET_DEAL_PMT(ID, DEAL_ID, PLAN_DATE.Value, PLAN_SUM.Value);

        lvPaymentsSchedule.EditIndex = -1;
        lvPaymentsSchedule.DataBind();
        e.Cancel = true;
    }
    protected void lvPaymentsSchedule_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        Decimal? ID = (Decimal?)lvPaymentsSchedule.DataKeys[e.ItemIndex]["ID"];

        InsPack ip = new InsPack(new BbConnection());
        ip.DEL_DEAL_PMT(ID);

        lvPaymentsSchedule.DataBind();
        e.Cancel = true;
    }


    protected void wzd_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        // действия в зависимости от шага
        BbConnection con = new BbConnection();
        InsPack ip = new InsPack(con);
        try
        {
            switch (wzd.WizardSteps[e.CurrentStepIndex].ID)
            {
                case "wsFinance":
                    # region wsFinance
                    DDLList PARTNER_ID = (wzd.FindControl("PARTNER_ID") as DDLList);
                    DDLList TYPE_ID = (wzd.FindControl("TYPE_ID") as DDLList);
                    TextBoxRefer INS_RNK = (wzd.FindControl("INS_RNK") as TextBoxRefer);
                    //TextBoxString SER = (wzd.FindControl("SER") as TextBoxString);
                    TextBoxString NUM = (wzd.FindControl("NUM") as TextBoxString);
                    TextBoxDate SDATE = (wzd.FindControl("SDATE") as TextBoxDate);
                    TextBoxDate EDATE = (wzd.FindControl("EDATE") as TextBoxDate);
                    RadioButton rbCL = (wzd.FindControl("rbCL") as RadioButton);
                    TextBoxRefer CL_RNK = (wzd.FindControl("CL_RNK") as TextBoxRefer);
                    RadioButton rbGRT = (wzd.FindControl("rbGRT") as RadioButton);
                    TextBoxRefer GRT_ID = (wzd.FindControl("GRT_ID") as TextBoxRefer);
                    TextBoxRefer ND = (wzd.FindControl("ND") as TextBoxRefer);
                    TextBoxDecimal SUM = (wzd.FindControl("SUM") as TextBoxDecimal);
                    DDLList SUM_KV = (wzd.FindControl("SUM_KV") as DDLList);
                    DDLList PAY_FREQ = (wzd.FindControl("PAY_FREQ") as DDLList);
                    RBLFlag RENEW_NEED = (wzd.FindControl("RENEW_NEED") as RBLFlag);
                    RadioButton rbTARIFF = (wzd.FindControl("rbTARIFF") as RadioButton);
                    RadioButton rbINSU_SUM = (wzd.FindControl("rbINSU_SUM") as RadioButton);
                    TextBoxDecimal INSU_TARIFF = (wzd.FindControl("INSU_TARIFF") as TextBoxDecimal);
                    TextBoxDecimal INSU_SUM = (wzd.FindControl("INSU_SUM") as TextBoxDecimal);

                    Decimal? P_PARTNER_ID = PARTNER_ID.Value;
                    Decimal? P_TYPE_ID = TYPE_ID.Value;
                    Decimal? P_INS_RNK = Convert.ToDecimal(INS_RNK.Value);
                    String P_SER = null;//SER.Value;
                    String P_NUM = NUM.Value;
                    DateTime? P_SDATE = SDATE.Value;
                    DateTime? P_EDATE = EDATE.Value;
                    Decimal? P_SUM = SUM.Value;
                    Decimal? P_SUM_KV = SUM_KV.Value;

                    Decimal? P_INSU_TARIFF = (Decimal?)null;
                    Decimal? P_INSU_SUM = (Decimal?)null;
                    if (rbTARIFF.Checked)
                    {
                        P_INSU_TARIFF = INSU_TARIFF.Value;
                    }
                    else
                    {
                        P_INSU_SUM = INSU_SUM.Value;
                    }

                    String P_OBJECT_TYPE = (rbCL.Checked ? "CL" : "GRT");
                    Decimal? P_RNK = (Decimal?)null;
                    Decimal? P_GRT_ID = (Decimal?)null;
                    if (rbCL.Checked)
                    {
                        P_RNK = Convert.ToDecimal(CL_RNK.Value);
                    }
                    else
                    {
                        P_GRT_ID = Convert.ToDecimal(GRT_ID.Value);
                    }

                    Decimal? P_ND = Convert.ToDecimal(ND.Value);
                    Decimal? P_PAY_FREQ = PAY_FREQ.Value;
                    Decimal? P_RENEW_NEED = RENEW_NEED.Value;

                    DEAL_ID = ip.CREATE_DEAL(P_PARTNER_ID,
                                            P_TYPE_ID,
                                            P_INS_RNK,
                                            P_SER,
                                            P_NUM,
                                            P_SDATE,
                                            P_EDATE,
                                            P_SUM,
                                            P_SUM_KV,
                                            P_INSU_TARIFF,
                                            P_INSU_SUM,
                                            P_OBJECT_TYPE,
                                            P_RNK,
                                            P_GRT_ID,
                                            P_ND,
                                            P_PAY_FREQ,
                                            P_RENEW_NEED);

                    // закрываем старый договор
                    if (OLD_ID.HasValue)
                        ip.CLOSE_DEAL(OLD_ID, DEAL_ID, Comment);

                    ScriptManager.RegisterStartupScript(this, typeof(Page), "success_alert", String.Format("alert('Договір успішно створено (№ {0})'); ", DEAL_ID), true);
                    # endregion
                    break;
                case "wsAttrs":
                    # region wsAttrs
                    DataList dlPartnerTypeAttrs = wzd.FindControl("dlPartnerTypeAttrs") as DataList;
                    foreach (DataListItem dli in dlPartnerTypeAttrs.Items)
                    {
                        String ATTR_ID = (String)dlPartnerTypeAttrs.DataKeys[dli.ItemIndex];
                        HiddenField ATTR_TYPE_ID = dli.FindControl("ATTR_TYPE_ID") as HiddenField;

                        switch (ATTR_TYPE_ID.Value)
                        {
                            case "S":
                                TextBoxString tbs = dli.FindControl("ATTR_ID_S") as TextBoxString;
                                if (!String.IsNullOrEmpty(tbs.Value))
                                    ip.SET_DEAL_ATTR_S(DEAL_ID, ATTR_ID, tbs.Value);
                                break;
                            case "N":
                                TextBoxDecimal tbn = dli.FindControl("ATTR_ID_N") as TextBoxDecimal;
                                if (tbn.Value.HasValue)
                                    ip.SET_DEAL_ATTR_N(DEAL_ID, ATTR_ID, tbn.Value);
                                break;
                            case "D":
                                TextBoxDate tbd = dli.FindControl("ATTR_ID_D") as TextBoxDate;
                                if (tbd.Value.HasValue)
                                    ip.SET_DEAL_ATTR_D(DEAL_ID, ATTR_ID, tbd.Value);
                                break;
                        }
                    }
                    # endregion
                    break;
                case "wsScans":
                    # region wsScans
                    DataList dlPartnerTypeScans = wzd.FindControl("dlPartnerTypeScans") as DataList;
                    foreach (DataListItem dli in dlPartnerTypeScans.Items)
                    {

                        String SCAN_ID = (String)dlPartnerTypeScans.DataKeys[dli.ItemIndex];
                        TextBoxScanner tbs = dli.FindControl("SCAN_ID") as TextBoxScanner;

                        if (tbs.HasValue)
                            ip.SET_DEAL_SCAN(DEAL_ID, SCAN_ID, tbs.Value);
                    }
                    # endregion
                    break;
            }
        }
        finally
        {
            con.CloseConnection();
        }
    }
    protected void wzd_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        wzd_NextButtonClick(sender, e);

        InsPack ip = new InsPack(new BbConnection());
        // ip.FINISH_DATAINPUT(DEAL_ID);

        ScriptManager.RegisterStartupScript(this, typeof(Page), "finish", String.Format("alert('{0}'); location.href = '/barsroot/ins/deal_card.aspx?deal_id={1}&type={2}&mode=view'; ", "Договір успішно заведено.", DEAL_ID, "mgr"), true);
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        // умолчательная кнопка
        Button btMoveNext = null;
        Button btMovePrevious = null;
        switch (wzd.ActiveStep.StepType)
        {
            case WizardStepType.Start:
                btMoveNext = (wzd.FindControl("StartNavigationTemplateContainerID").FindControl("btMoveNext") as Button);
                break;
            case WizardStepType.Step:
                btMovePrevious = (wzd.FindControl("StepNavigationTemplateContainerID").FindControl("btMovePrevious") as Button);
                btMoveNext = (wzd.FindControl("StepNavigationTemplateContainerID").FindControl("btMoveNext") as Button);
                break;
            case WizardStepType.Finish:
                btMovePrevious = (wzd.FindControl("FinishNavigationTemplateContainerID").FindControl("btMovePrevious") as Button);
                btMoveNext = (wzd.FindControl("FinishNavigationTemplateContainerID").FindControl("btMoveNext") as Button);
                break;
        }
        Page.Form.DefaultButton = btMoveNext.UniqueID;

        // действия в зависимости от шага
        if (btMovePrevious != null) btMovePrevious.Enabled = true;
        if (btMoveNext != null)
        {
            btMoveNext.OnClientClick = String.Empty;
            btMoveNext.ValidationGroup = "Main";
        }
        switch (wzd.ActiveStep.ID)
        {
            case "wsFinance":
                btMoveNext.OnClientClick = String.Format("if (!confirm('{0}')) {{ return false; }}", "Створити новий договір?");
                break;
            case "wsAttrs":
                btMovePrevious.Enabled = false;
                btMoveNext.ValidationGroup = "Attrs";
                break;
            case "wsScans":
                btMoveNext.ValidationGroup = "Scans";
                break;
            case "wsPaymentsSchedule":
                break;
        }
    }
    # endregion

    # region Приватные методы
    private void InitControls()
    {
        if (OLD_ID.HasValue)
        {
            DDLList PARTNER_ID = (wzd.FindControl("PARTNER_ID") as DDLList);
            DDLList TYPE_ID = (wzd.FindControl("TYPE_ID") as DDLList);
            TextBoxRefer INS_RNK = (wzd.FindControl("INS_RNK") as TextBoxRefer);
            TextBoxString SER = (wzd.FindControl("SER") as TextBoxString);
            TextBoxString NUM = (wzd.FindControl("NUM") as TextBoxString);
            TextBoxDate SDATE = (wzd.FindControl("SDATE") as TextBoxDate);
            TextBoxDate EDATE = (wzd.FindControl("EDATE") as TextBoxDate);
            RadioButton rbCL = (wzd.FindControl("rbCL") as RadioButton);
            TextBoxRefer CL_RNK = (wzd.FindControl("CL_RNK") as TextBoxRefer);
            RadioButton rbGRT = (wzd.FindControl("rbGRT") as RadioButton);
            TextBoxRefer GRT_ID = (wzd.FindControl("GRT_ID") as TextBoxRefer);
            TextBoxRefer ND = (wzd.FindControl("ND") as TextBoxRefer);
            TextBoxDecimal SUM = (wzd.FindControl("SUM") as TextBoxDecimal);
            DDLList SUM_KV = (wzd.FindControl("SUM_KV") as DDLList);
            DDLList PAY_FREQ = (wzd.FindControl("PAY_FREQ") as DDLList);
            RBLFlag RENEW_NEED = (wzd.FindControl("RENEW_NEED") as RBLFlag);
            RadioButton rbTARIFF = (wzd.FindControl("rbTARIFF") as RadioButton);
            RadioButton rbINSU_SUM = (wzd.FindControl("rbINSU_SUM") as RadioButton);
            TextBoxDecimal INSU_TARIFF = (wzd.FindControl("INSU_TARIFF") as TextBoxDecimal);
            TextBoxDecimal INSU_SUM = (wzd.FindControl("INSU_SUM") as TextBoxDecimal);

            PARTNER_ID.Value = OldDeal.PARTNER_ID;
            TYPE_ID.Value = OldDeal.TYPE_ID;
            INS_RNK.Value = Convert.ToString(OldDeal.INS_RNK);
            INS_RNK_ValueChanged(INS_RNK, null);

            CL_RNK.Value = Convert.ToString(OldDeal.CL_RNK);
            CL_RNK_ValueChanged(CL_RNK, null);
            GRT_ID.Value = Convert.ToString(OldDeal.GRT_ID);
            GRT_ID_ValueChanged(GRT_ID, null);

            ND.Value = Convert.ToString(OldDeal.ND);
            ND_ValueChanged(ND, null);

            SUM.Value = OldDeal.SUM;
            SUM_KV.DataBind();
            SUM_KV.Value = OldDeal.SUM_KV;
            PAY_FREQ.DataBind();
            PAY_FREQ.Value = OldDeal.PAY_FREQ_ID;
            RENEW_NEED.Value = OldDeal.RENEW_NEED;
            INSU_TARIFF.Value = OldDeal.INSU_TARIFF;
            INSU_SUM.Value = OldDeal.INSU_SUM;
        }
    }
    private void rbgObject_ClearData(Boolean isCl_Checked)
    {
        if (isCl_Checked)
        {
            TextBoxRefer GRT_ID = (wzd.FindControl("GRT_ID") as TextBoxRefer);
            TextBox GRT_TYPE = (wzd.FindControl("GRT_TYPE") as TextBox);
            TextBox GRT_DEAL_NUM = (wzd.FindControl("GRT_DEAL_NUM") as TextBox);
            TextBox GRT_DEAL_DATE = (wzd.FindControl("GRT_DEAL_DATE") as TextBox);
            TextBox GRT_GRT_NAME = (wzd.FindControl("GRT_GRT_NAME") as TextBox);

            GRT_ID.Value = String.Empty;
            GRT_TYPE.Text = String.Empty;
            GRT_DEAL_NUM.Text = String.Empty;
            GRT_DEAL_DATE.Text = String.Empty;
            GRT_GRT_NAME.Text = String.Empty;
        }
        else
        {
            TextBoxRefer CL_RNK = (wzd.FindControl("CL_RNK") as TextBoxRefer);
            TextBox CL_FIO = (wzd.FindControl("CL_FIO") as TextBox);
            TextBox CL_DOC = (wzd.FindControl("CL_DOC") as TextBox);
            TextBox CL_INN = (wzd.FindControl("CL_INN") as TextBox);

            CL_RNK.Value = String.Empty;
            CL_FIO.Text = String.Empty;
            CL_DOC.Text = String.Empty;
            CL_INN.Text = String.Empty;
        }
    }
    private void rbgObject_CheckedChanged(Boolean isCl_Checked)
    {
        RadioButton rbCL = (wzd.FindControl("rbCL") as RadioButton);
        TextBoxRefer CL_RNK = (wzd.FindControl("CL_RNK") as TextBoxRefer);
        Panel pnlCL = (wzd.FindControl("pnlCL") as Panel);

        RadioButton rbGRT = (wzd.FindControl("rbGRT") as RadioButton);
        TextBoxRefer GRT_ID = (wzd.FindControl("GRT_ID") as TextBoxRefer);
        Panel pnlGRT = (wzd.FindControl("pnlGRT") as Panel);

        rbCL.Checked = isCl_Checked;
        CL_RNK.Enabled = isCl_Checked;
        pnlCL.Enabled = isCl_Checked;
        rbGRT.Checked = !isCl_Checked;
        GRT_ID.Enabled = !isCl_Checked;
        pnlGRT.Enabled = !isCl_Checked;

        rbgObject_ClearData(isCl_Checked);

        // умолчательно подставляем страхователя
        if (isCl_Checked && String.IsNullOrEmpty(CL_RNK.Value))
        {
            TextBoxRefer INS_RNK = (wzd.FindControl("INS_RNK") as TextBoxRefer);
            CL_RNK.Value = INS_RNK.Value;
            CL_RNK_ValueChanged(CL_RNK, null);
        }
    }
    private void rbgObject_ShowHide(Boolean isCl_Visible, Boolean isGRT_Visible)
    {
        HtmlTableRow ObjectRowCL = (wzd.FindControl("ObjectRowCL") as HtmlTableRow);
        RadioButton rbCL = (wzd.FindControl("rbCL") as RadioButton);
        HtmlTableRow ObjectRowsSeparator = (wzd.FindControl("ObjectRowsSeparator") as HtmlTableRow);
        HtmlTableRow ObjectRowGRT = (wzd.FindControl("ObjectRowGRT") as HtmlTableRow);
        RadioButton rbGRT = (wzd.FindControl("rbGRT") as RadioButton);

        ObjectRowCL.Visible = isCl_Visible;
        rbCL.Visible = isCl_Visible && isGRT_Visible;
        ObjectRowsSeparator.Visible = isCl_Visible && isGRT_Visible;
        rbGRT.Visible = isCl_Visible && isGRT_Visible;
        ObjectRowGRT.Visible = isGRT_Visible;
    }
    private void rbgFinance_ClearData(Boolean isTARIFF_Checked)
    {
        if (isTARIFF_Checked)
        {
            TextBoxDecimal INSU_SUM = (wzd.FindControl("INSU_SUM") as TextBoxDecimal);
            INSU_SUM.Value = (Decimal?)null;
        }
        else
        {
            TextBoxDecimal INSU_TARIFF = (wzd.FindControl("INSU_TARIFF") as TextBoxDecimal);
            INSU_TARIFF.Value = (Decimal?)null;
        }
    }
    private void rbgFinance_CheckedChanged(Boolean isTARIFF_Checked)
    {
        RadioButton rbTARIFF = (wzd.FindControl("rbTARIFF") as RadioButton);
        TextBoxDecimal INSU_TARIFF = (wzd.FindControl("INSU_TARIFF") as TextBoxDecimal);
        RadioButton rbINSU_SUM = (wzd.FindControl("rbINSU_SUM") as RadioButton);
        TextBoxDecimal INSU_SUM = (wzd.FindControl("INSU_SUM") as TextBoxDecimal);

        rbTARIFF.Checked = isTARIFF_Checked;
        INSU_TARIFF.Enabled = isTARIFF_Checked;
        rbINSU_SUM.Checked = !isTARIFF_Checked;
        INSU_SUM.Enabled = !isTARIFF_Checked;

        rbgFinance_ClearData(isTARIFF_Checked);
    }
    # endregion
}