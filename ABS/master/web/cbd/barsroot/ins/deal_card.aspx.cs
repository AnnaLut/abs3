using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Bars.DataComponents;
using Bars.UserControls;
using Bars.Ins;
using ibank.core;
using System.Drawing;

public partial class ins_deal_card : System.Web.UI.Page
{
    # region Приватные свойства
    private VInsDealsRecord _Deal;
    # endregion

    # region Публичные свойства
    public Decimal DEAL_ID
    {
        get
        {
            if (Request.Params.Get("deal_id") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр Url deal_id");
            return Convert.ToDecimal(Request.Params.Get("DEAL_ID"));
        }
    }
    public VInsDealsRecord Deal
    {
        get
        {
            if (_Deal == null)
                _Deal = (new VInsDeals()).SelectDeal(DEAL_ID);

            return _Deal;
        }
    }
    public String Type
    {
        get
        {
            if (Request.Params.Get("type") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр Url type");
            return Request.Params.Get("type").ToUpper();
        }
    }
    public AccessTypes AccessType
    {
        get
        {
            switch (Type)
            {
                case "USER":
                    return AccessTypes.User;
                case "MGR":
                    return AccessTypes.Manager;
                case "CONTR":
                    return AccessTypes.Controller;
                case "HEAD":
                    return AccessTypes.Head;
                default:
                    return AccessTypes.User;
            }
        }
    }
    public String Mode
    {
        get
        {
            if (Request.Params.Get("mode") == null) throw new Bars.Exception.BarsException("Не задано обов`язковий параметр Url mode");
            return Request.Params.Get("mode").ToUpper();
        }
    }
    public AccessModes AccessMode
    {
        get
        {
            switch (AccessType)
            {
                case AccessTypes.User:
                    return AccessModes.View;
                case AccessTypes.Manager:
                    switch (Mode)
                    {
                        case "VIEW":
                            return AccessModes.View;
                        case "EDIT":
                            return AccessModes.Edit;
                        case "ADDAGR":
                            return AccessModes.AddAgr;
                        default:
                            return AccessModes.View;
                    }
                case AccessTypes.Controller:
                    return AccessModes.View;
                case AccessTypes.Head:
                    switch (Mode)
                    {
                        case "VIEW":
                            return AccessModes.View;
                        case "EDIT":
                            return AccessModes.Edit;
                        case "ADDAGR":
                            return AccessModes.AddAgr;
                        default:
                            return AccessModes.View;
                    }
                default:
                    return AccessModes.View;
            }
        }
    }
    public String BackPageUrl
    {
        get
        {
            return Convert.ToString(ViewState["BackPageUrl"]);
        }
        set
        {
            ViewState.Add("BackPageUrl", value);
        }
    }
    public Decimal? CustType
    {
        get
        { 
            VInsDealsRecord rec = (new VInsDeals()).SelectDeal(Convert.ToDecimal(Request.Params.Get("deal_id")));
            return rec.CUSTID;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(String.Format(this.Title, CustType == 2 ? "ЮО" : "ФО"), true);
        //br.moduleId = "INS";
        //br.objId = DEAL_ID;
        if (!IsPostBack)
        {
            TextBoxRefer INS_RNK = (pnlInsParams.FindControl("INS_RNK") as TextBoxRefer);
            TextBoxRefer CL_RNK = (pnlCL.FindControl("CL_RNK") as TextBoxRefer);
            TextBoxRefer GRT_ID = (pnlGRT.FindControl("GRT_ID") as TextBoxRefer);
            TextBoxRefer ND = (pnlNd.FindControl("ND") as TextBoxRefer);
            INS_RNK.WHERE_CLAUSE = String.Format("WHERE DATE_OFF IS NULL AND CUSTTYPE = {0}", CustType);
            CL_RNK.WHERE_CLAUSE = String.Format("WHERE DATE_OFF IS NULL AND CUSTTYPE = {0}", CustType);
            GRT_ID.WHERE_CLAUSE = String.Format("WHERE CTYPE = {0}", CustType);
            ND.WHERE_CLAUSE = String.Format("WHERE CTYPE = {0}", CustType);
            odsUserPartnerTypes.SelectParameters.Add("partner_id", System.Data.DbType.Decimal, Deal.PARTNER_ID.ToString());
                        
            if (Request.UrlReferrer != null)
                BackPageUrl = Request.UrlReferrer.PathAndQuery;
            FillControls();
        }

    }

    protected void INS_RNK_ValueChanged(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(INS_RNK.Value))
        {
            VInsCustomersRecord Customer = (new VInsCustomers()).SelectCustomer(Convert.ToDecimal(INS_RNK.Value));

            INS_FIO.Text = Customer.NMK;
            INS_FIO.NavigateUrl = String.Format("/barsroot/clientregister/registration.aspx?readonly=1&rnk={0}", Convert.ToDecimal(INS_RNK.Value));
            INS_DOC.Text = String.Format("{0}{1}", Customer.DOC_SER, Customer.DOC_NUM) + (String.IsNullOrEmpty(Customer.DOC_ISSUER) ? "" : " виданий " + Customer.DOC_ISSUER.Trim()) + (Customer.DOC_DATE.HasValue ? String.Format(" {0:d}", Customer.DOC_DATE) : "");
            INS_INN.Text = Customer.OKPO;
        }
        else
        {
            INS_FIO.Text = String.Empty;
            INS_FIO.NavigateUrl = String.Empty;
            INS_DOC.Text = String.Empty;
            INS_INN.Text = String.Empty;
        }
    }
    protected void CL_RNK_ValueChanged(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(CL_RNK.Value))
        {
            VInsCustomersRecord Customer = (new VInsCustomers()).SelectCustomer(Convert.ToDecimal(CL_RNK.Value));

            CL_FIO.Text = Customer.NMK;
            CL_FIO.NavigateUrl = String.Format("/barsroot/clientregister/registration.aspx?readonly=1&rnk={0}", Convert.ToDecimal(CL_RNK.Value));
            CL_DOC.Text = String.Format("{0}{1}", Customer.DOC_SER, Customer.DOC_NUM) + (String.IsNullOrEmpty(Customer.DOC_ISSUER) ? "" : " виданий " + Customer.DOC_ISSUER.Trim()) + (Customer.DOC_DATE.HasValue ? String.Format(" {0:d}", Customer.DOC_DATE) : "");
            CL_INN.Text = Customer.OKPO;
        }
        else
        {
            CL_FIO.Text = String.Empty;
            CL_FIO.NavigateUrl = String.Empty;
            CL_DOC.Text = String.Empty;
            CL_INN.Text = String.Empty;
        }
    }
    protected void GRT_ID_ValueChanged(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(GRT_ID.Value))
        {
            VInsGrtDealsRecord GrtDeal = (new VInsGrtDeals()).SelectGrtDeal(Convert.ToDecimal(GRT_ID.Value));

            GRT_TYPE.Text = String.Format("{0} - {1}", GrtDeal.TYPE_ID, GrtDeal.TYPE_NAME);
            GRT_TYPE.NavigateUrl = String.Format("/barsroot/barsweb/dynform.aspx?form=frm_grt_dual&deal_id={0}", Convert.ToDecimal(GRT_ID.Value));
            GRT_DEAL_NUM.Text = GrtDeal.DEAL_NUM;
            GRT_DEAL_DATE.Text = String.Format("{0:d}", GrtDeal.DEAL_DATE);
            GRT_GRT_NAME.Text = GrtDeal.GRT_NAME;
        }
        else
        {
            GRT_TYPE.Text = String.Empty;
            GRT_TYPE.NavigateUrl = String.Empty;
            GRT_DEAL_NUM.Text = String.Empty;
            GRT_DEAL_DATE.Text = String.Empty;
            GRT_GRT_NAME.Text = String.Empty;
        }
    }
    protected void ND_ValueChanged(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(ND.Value))
        {
            VInsCcDealsRecord CcDeal = (new VInsCcDeals()).SelectCcDeal(Convert.ToDecimal(ND.Value));

            ND_NUM.Text = CcDeal.NUM;
            ND_NUM.NavigateUrl = String.Empty; // !!! пока нет ссылки
            ND_SDATE.Text = String.Format("{0:d}", CcDeal.SDATE);
        }
        else
        {
            ND_NUM.Text = String.Empty;
            ND_NUM.NavigateUrl = String.Empty;
            ND_SDATE.Text = String.Empty;
        }
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
    protected void lvPaymentsSchedule_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        // Доступ
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            VInsPaymentsScheduleRecord rec = (e.Item as ListViewDataItem).DataItem as VInsPaymentsScheduleRecord;

            ImageButton ibEdit = e.Item.FindControl("ibEdit") as ImageButton;
            ImageButton ibDelete = e.Item.FindControl("ibDelete") as ImageButton;
            if (ibEdit != null) ibEdit.Visible = rec.PAYED != 1 && true;
            if (ibDelete != null) ibDelete.Visible = rec.PAYED != 1 && true;

            if (AccessMode == AccessModes.View)
            {
                if (ibEdit != null) ibEdit.Visible = false;
                if (ibDelete != null) ibDelete.Visible = false;
            }
        }
    }
    protected void lvPaymentsSchedule_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
        TextBoxDate PLAN_DATE = e.Item.FindControl("PLAN_DATE") as TextBoxDate;
        TextBoxDecimal PLAN_SUM = e.Item.FindControl("PLAN_SUM") as TextBoxDecimal;

        InsPack ip = new InsPack(new BbConnection());
        Decimal? ID = ip.SET_DEAL_PMT((Decimal?)null, DEAL_ID, PLAN_DATE.Value, PLAN_SUM.Value);

        if (AccessMode == AccessModes.AddAgr)
            ip.SET_ADDAGR_PMT(DEAL_ID, Convert.ToDecimal(hAddAgr.Value), (Decimal?)null, "I", PLAN_DATE.Value, PLAN_SUM.Value);

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
        if (AccessMode == AccessModes.AddAgr)
            ip.SET_ADDAGR_PMT(DEAL_ID, Convert.ToDecimal(hAddAgr.Value), ID, "U", PLAN_DATE.Value, PLAN_SUM.Value);

        ID = ip.SET_DEAL_PMT(ID, DEAL_ID, PLAN_DATE.Value, PLAN_SUM.Value);

        lvPaymentsSchedule.EditIndex = -1;
        lvPaymentsSchedule.DataBind();
        e.Cancel = true;
    }
    protected void lvPaymentsSchedule_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
        Decimal? ID = (Decimal?)lvPaymentsSchedule.DataKeys[e.ItemIndex]["ID"];

        InsPack ip = new InsPack(new BbConnection());
        if (AccessMode == AccessModes.AddAgr)
            ip.SET_ADDAGR_PMT(DEAL_ID, Convert.ToDecimal(hAddAgr.Value), ID, "D", (DateTime?)null, (Decimal?)null);

        ip.DEL_DEAL_PMT(ID);

        lvPaymentsSchedule.DataBind();
        e.Cancel = true;
    }

    protected void odsPartnerTypeAttrs_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["PARTNER_ID"] = Deal.PARTNER_ID;
        e.InputParameters["TYPE_ID"] = Deal.TYPE_ID;
    }
    protected void lvPartnerTypeAttrs_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            InsPack ip = new InsPack(new BbConnection());
            VInsPartnerTypeAttrsRecord rec = ((e.Item as ListViewDataItem).DataItem as VInsPartnerTypeAttrsRecord);

            String ATTR_ID = rec.ATTR_ID;
            String ATTR_TYPE_ID = rec.ATTR_TYPE_ID;

            TextBoxString tbs = null;
            TextBoxDecimal tbn = null;
            TextBoxDate tbd = null;

            switch (ATTR_TYPE_ID)
            {
                case "S":
                    tbs = e.Item.FindControl("ATTR_ID_S") as TextBoxString;
                    tbs.Value = ip.GET_DEAL_ATTR_S(DEAL_ID, ATTR_ID);
                    break;
                case "N":
                    tbn = e.Item.FindControl("ATTR_ID_N") as TextBoxDecimal;
                    tbn.Value = ip.GET_DEAL_ATTR_N(DEAL_ID, ATTR_ID);
                    break;
                case "D":
                    tbd = e.Item.FindControl("ATTR_ID_D") as TextBoxDate;
                    tbd.Value = ip.GET_DEAL_ATTR_D(DEAL_ID, ATTR_ID);
                    break;
            }

            // Доступ
            if (tbs != null) tbs.Enabled = true;
            if (tbn != null) tbn.Enabled = true;
            if (tbd != null) tbd.Enabled = true;

            if (AccessMode == AccessModes.View)
            {
                if (tbs != null) tbs.Enabled = false;
                if (tbn != null) tbn.Enabled = false;
                if (tbd != null) tbd.Enabled = false;
            }
        }
    }

    protected void odsPartnerTypeScans_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["PARTNER_ID"] = Deal.PARTNER_ID;
        e.InputParameters["TYPE_ID"] = Deal.TYPE_ID;
    }
    protected void lvPartnerTypeScans_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            InsPack ip = new InsPack(new BbConnection());
            VInsPartnerTypeScansRecord rec = ((e.Item as ListViewDataItem).DataItem as VInsPartnerTypeScansRecord);
            String SCAN_ID = rec.SCAN_ID;

            TextBoxScanner tbs = e.Item.FindControl("SCAN_ID") as TextBoxScanner;
            tbs.Value = ip.GET_DEAL_SCAN(DEAL_ID, SCAN_ID);

            // Доступ
            if (tbs != null) tbs.ReadOnly = !true;

            if (AccessMode == AccessModes.View)
            {
                if (tbs != null) tbs.ReadOnly = !false;
            }
        }
    }

    protected void odsPartnerTypeTemplates_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["PARTNER_ID"] = Deal.PARTNER_ID;
        e.InputParameters["TYPE_ID"] = Deal.TYPE_ID;
    }
    protected void lvPartnerTypeTemplates_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Print":
                String TEMPLATE_ID = (e.CommandArgument as String).Split(';')[0];
                String PRT_FORMAT = (e.CommandArgument as String).Split(';')[1];

                FrxParameters pars = new FrxParameters();
                pars.Add(new FrxParameter("deal_id", TypeCode.Decimal, DEAL_ID));

                FrxDoc doc = new FrxDoc(
                    FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TEMPLATE_ID)),
                    pars,
                    this.Page);

                // P - PDF, W - word, E - excel
                switch (PRT_FORMAT)
                {
                    case "P": doc.Print(FrxExportTypes.Pdf);
                        break;
                    case "W": doc.Print(FrxExportTypes.Rtf);
                        break;
                    case "E": doc.Print(FrxExportTypes.XmlExcel);
                        break;
                    default: doc.Print(FrxExportTypes.Pdf);
                        break;
                }

                break;
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (!IsPostBack)
        {
            ApplyType();
            ApplyMode();
            SetupControls();
        }
    }

    protected void ibPay_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/ins/pmts_schedule.aspx?deal_id={0}", DEAL_ID));
    }
    protected void ibRenew_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/ins/new.aspx?oldid={0}&comm={1}&custtype={2}", DEAL_ID, hComm.Value,CustType));
    }
    protected void ibEdit_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=edit", DEAL_ID, Type.ToLower()));
    }
    protected void ibAddAgr_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=addagr", DEAL_ID, Type.ToLower()));
    }
    protected void ibAccident_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("/barsroot/ins/accidents.aspx?deal_id={0}", DEAL_ID));
    }
    protected void ibSend2Visa_Click(object sender, EventArgs e)
    {
        InsPack ip = new InsPack(new BbConnection());
        ip.FINISH_DATAINPUT(DEAL_ID, hComm.Value);

        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", DEAL_ID, Type.ToLower()));
    }
    protected void ibSendBack2Mgr_Click(object sender, EventArgs e)
    {
        InsPack ip = new InsPack(new BbConnection());
        ip.BACK2MANAGER(DEAL_ID, hComm.Value);

        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", DEAL_ID, Type.ToLower()));
    }
    protected void ibVisa_Click(object sender, EventArgs e)
    {
        InsPack ip = new InsPack(new BbConnection());
        ip.VISA_DEAL(DEAL_ID);

        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", DEAL_ID, Type.ToLower()));
    }
    protected void ibStorno_Click(object sender, EventArgs e)
    {
        InsPack ip = new InsPack(new BbConnection());
        ip.STORNO_DEAL(DEAL_ID, hComm.Value);

        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", DEAL_ID, Type.ToLower()));
    }
    protected void ibOff_Click(object sender, EventArgs e)
    {
        InsPack ip = new InsPack(new BbConnection());
        ip.CLOSE_DEAL(DEAL_ID, (Decimal?)null, hComm.Value);

        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", DEAL_ID, Type.ToLower()));
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        InsPack ip = new InsPack(new BbConnection());

        if (AccessMode == AccessModes.AddAgr)
            ip.SET_ADDAGR_PARAMS(DEAL_ID, Convert.ToDecimal(hAddAgr.Value), EDATE.Value, SUM.Value, SUM_KV.Value, INSU_TARIFF.Value, INSU_SUM.Value);

        ip.UPDATE_DEAL(DEAL_ID, BRANCH_EDIT.Value, Convert.ToDecimal(PARTNER_ID_EDIT.Value), Convert.ToDecimal(TYPE_ID_EDIT.Value), Convert.ToDecimal(INS_RNK.Value), SER.Value, NUM.Value, SDATE.Value, EDATE.Value, SUM.Value, SUM_KV.Value, INSU_TARIFF.Value, INSU_SUM.Value, (String.IsNullOrEmpty(CL_RNK.Value) ? (Decimal?)null : Convert.ToDecimal(CL_RNK.Value)), (String.IsNullOrEmpty(GRT_ID.Value) ? (Decimal?)null : Convert.ToDecimal(GRT_ID.Value)), Convert.ToDecimal(ND.Value), RENEW_NEED.Value);

        Response.Redirect(String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", DEAL_ID, Type.ToLower()));
    }
    # endregion

    # region Приватные методы
    private void ApplyType()
    {
        switch (AccessType)
        {
            case AccessTypes.User:
                # region User
                ShowActionBtn("Pay", false);
                ShowActionBtn("Renew", false);
                ShowActionBtn("Edit", false);
                ShowActionBtn("AddAgr", false);
                ShowActionBtn("Accident", false);
                ShowActionBtn("Send2Visa", false);
                ShowActionBtn("SendBack2Mgr", false);
                ShowActionBtn("Visa", false);
                ShowActionBtn("Storno", false);
                ShowActionBtn("Off", false);
                break;
                # endregion
            case AccessTypes.Manager:
                # region Manager
                switch (Deal.STATUS_ID)
                {
                    case "NEW":
                    case "NEW_ADD":
                        ShowActionBtn("Pay", true);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", true);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", true);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", true);
                        ShowActionBtn("Off", false);
                        break;
                    case "VISA":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", false);
                        ShowActionBtn("Off", false);
                        break;
                    case "ON":
                        ShowActionBtn("Pay", true);
                        ShowActionBtn("Renew", true);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", true);
                        ShowActionBtn("Accident", true);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", false);
                        ShowActionBtn("Off", true);
                        break;
                    case "OFF":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", true);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", false);
                        ShowActionBtn("Off", false);
                        break;
                    case "STORNO":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", false);
                        ShowActionBtn("Off", false);
                        break;
                }
                break;
                # endregion
            case AccessTypes.Controller:
                # region Controller
                switch (Deal.STATUS_ID)
                {
                    case "NEW":
                    case "NEW_ADD":
                    case "ON":
                    case "OFF":
                    case "STORNO":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", false);
                        ShowActionBtn("Off", false);
                        break;
                    case "VISA":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", true);
                        ShowActionBtn("Visa", true);
                        ShowActionBtn("Storno", true);
                        ShowActionBtn("Off", false);
                        break;
                }
                break;
                # endregion
            case AccessTypes.Head:
                # region Head
                switch (Deal.STATUS_ID)
                {
                    case "NEW":
                    case "NEW_ADD":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", true);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", true);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", true);
                        ShowActionBtn("Off", false);
                        break;
                    case "VISA":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", true);
                        ShowActionBtn("Visa", true);
                        ShowActionBtn("Storno", true);
                        ShowActionBtn("Off", false);
                        break;
                    case "ON":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", true);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", true);
                        ShowActionBtn("Off", true);
                        break;
                    case "OFF":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", false);
                        ShowActionBtn("Off", false);
                        break;
                    case "STORNO":
                        ShowActionBtn("Pay", false);
                        ShowActionBtn("Renew", false);
                        ShowActionBtn("Edit", false);
                        ShowActionBtn("AddAgr", false);
                        ShowActionBtn("Accident", false);
                        ShowActionBtn("Send2Visa", false);
                        ShowActionBtn("SendBack2Mgr", false);
                        ShowActionBtn("Visa", false);
                        ShowActionBtn("Storno", false);
                        ShowActionBtn("Off", false);
                        break;
                }
                break;
                # endregion
        }

        // прячем панель действий
        pnlActions.Visible = (IsActionBtnVisible("Pay") || IsActionBtnVisible("Renew") || IsActionBtnVisible("Edit") || IsActionBtnVisible("AddAgr") || IsActionBtnVisible("Accident") || IsActionBtnVisible("Send2Visa") || IsActionBtnVisible("SendBack2Mgr") || IsActionBtnVisible("Visa") || IsActionBtnVisible("Storno") || IsActionBtnVisible("Off"));
    }
    private void ApplyMode()
    {
        btSave.Enabled = true;

        // Ключові параметри
        INS_RNK.Enabled = true;
        SER.Enabled = true;
        NUM.Enabled = true;
        SDATE.Enabled = true;
        EDATE.Enabled = true;
        BRANCH.Visible = false;
        BRANCH_EDIT.Visible = true;
        PARTNER_ID.Visible = false;
        PARTNER_ID_EDIT.Visible = true;
        TYPE_ID.Visible = false;
        TYPE_ID_EDIT.Visible = true;

        // Об`єкт страхування
        CL_RNK.Enabled = true;
        GRT_ID.Enabled = true;
        ND.Enabled = true;

        // Страхова сума
        SUM.Enabled = true;
        SUM_KV.Enabled = true;
        RENEW_NEED.Enabled = true;

        // Страхова премія
        INSU_TARIFF.Enabled = true;
        INSU_SUM.Enabled = true;

        // Платіжний графік
        Control tblPSFoot = lvPaymentsSchedule.FindControl("tblPSFoot");
		if (tblPSFoot != null)
			tblPSFoot.Visible = true;

        // обработывается в событии lvPaymentsSchedule_ItemDataBound

        // Додаткові реквізити
        // обработывается в событии lvPartnerTypeAttrs_ItemDataBound

        // Сканкопії
        // обработывается в событии lvPartnerTypeScans_ItemDataBound

        switch (AccessMode)
        {
            case AccessModes.View:
                # region View
                btSave.Enabled = false;

                // Ключові параметри
                INS_RNK.Enabled = false;
                SER.Enabled = false;
                NUM.Enabled = false;
                SDATE.Enabled = false;
                EDATE.Enabled = false;
                BRANCH.Visible = true;
                BRANCH_EDIT.Visible = false;
                PARTNER_ID.Visible = true;
                PARTNER_ID_EDIT.Visible = false;
                TYPE_ID.Visible = true;
                TYPE_ID_EDIT.Visible = false;

                // Об`єкт страхування
                CL_RNK.Enabled = false;
                GRT_ID.Enabled = false;
                ND.Enabled = false;

                // Страхова сума
                SUM.Enabled = false;
                SUM_KV.Enabled = false;
                RENEW_NEED.Enabled = false;

                // Страхова премія
                INSU_TARIFF.Enabled = false;
                INSU_SUM.Enabled = false;

                // Платіжний графік
				if (tblPSFoot != null)
					tblPSFoot.Visible = false;
                // обработывается в событии lvPaymentsSchedule_ItemDataBound

                // Додаткові реквізити
                // обработывается в событии lvPartnerTypeAttrs_ItemDataBound

                // Сканкопії
                // обработывается в событии lvPartnerTypeScans_ItemDataBound

                # endregion
                break;
            case AccessModes.AddAgr:
                # region AddAgr
                // показываем на старте диалог доп. соглашения
                ShowAddAgr();

                // Ключові параметри
                INS_RNK.Enabled = false;
                SER.Enabled = false;
                NUM.Enabled = false;
                SDATE.Enabled = false;

                // Об`єкт страхування
                CL_RNK.Enabled = false;
                GRT_ID.Enabled = false;
                ND.Enabled = false;

                // Страхова сума
                RENEW_NEED.Enabled = false;
                # endregion
                break;
            case AccessModes.Edit:
                break;
        }
    }
    private void FillControls()
    {
        // Дії
        if (Deal.TASK_TYPE_ID == "PAY")
        {
            ibPay.ToolTip = String.Format("{0} ({1:d} {2}дн.)", Deal.TASK_STATUS_NAME, Deal.TASK_PLAN_DATE, Deal.TASK_DAYS);
            switch (Deal.TASK_STATUS_ID)
            {
                case "WAITING":
                    ibPay.ImageUrl = "/common/images/default/48/currency_dollar_yellow.png";
                    break;
                case "NOTDONE":
                    ibPay.ImageUrl = "/common/images/default/48/currency_dollar_red.png";
                    break;
                default:
                    ibPay.ImageUrl = "/common/images/default/48/currency_dollar_green.png";
                    break;
            }
        }
        else
        {
            ibPay.ImageUrl = "/common/images/default/48/currency_dollar_green.png";
        }

        if (Deal.TASK_TYPE_ID == "RENEW")
        {
            ibRenew.ToolTip = String.Format("{0} ({1:d} {2}дн.)", Deal.TASK_STATUS_NAME, Deal.TASK_PLAN_DATE, Deal.TASK_DAYS);
            switch (Deal.TASK_STATUS_ID)
            {
                case "WAITING":
                    ibRenew.ImageUrl = "/common/images/default/48/recycle_yellow.png";
                    break;
                case "NOTDONE":
                    ibRenew.ImageUrl = "/common/images/default/48/recycle_red.png";
                    break;
                default:
                    ibRenew.ImageUrl = "/common/images/default/48/recycle_green.png";
                    break;
            }
        }
        else
        {
            ibRenew.ImageUrl = "/common/images/default/48/recycle_green.png";
        }

        // Базові параметри
        ID.Text = String.Format("{0}", Deal.DEAL_ID);
        BRANCH.Text = String.Format("{0}", Deal.BRANCH);
        BRANCH.ToolTip = String.Format("{0} ({1})", Deal.BRANCH, Deal.BRANCH_NAME);
        STAFF_ID.Text = String.Format("{0} ({1})", Deal.STAFF_ID, Deal.STAFF_LOGNAME);
        STAFF_ID.ToolTip = String.Format("{0} ({1}) - {2}", Deal.STAFF_ID, Deal.STAFF_LOGNAME, Deal.STAFF_FIO);
        CRT_DATE.Text = String.Format("{0:dd/MM/yyyy}", Deal.CRT_DATE);
        STATUS.Text = String.Format("{0} ({1}) встан. {2:dd/MM/yyyy HH:mm}", Deal.STATUS_ID, Deal.STATUS_NAME, Deal.STATUS_DATE);
        STATUS.Attributes.Add("onclick", String.Format("var result = window.showModalDialog('/barsroot/ins/states_history.aspx?deal_id={0}&rnd=' + Math.random(), window, 'dialogHeight:600px; dialogWidth:600px; resizable:yes'); ", DEAL_ID));
        STATUS_COMM.Text = String.Format("{0}", Deal.STATUS_COMM);
        RENEW.Text = String.Format("{0}", Deal.RENEW_NEWID);
        RENEW.NavigateUrl = String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", Deal.RENEW_NEWID, Type);

        // Ключові параметри
        tbDEAL_ID.Text = String.Format("{0}", Deal.DEAL_ID);
        BRANCH_EDIT.Value = Deal.BRANCH;
        PARTNER_ID.Text = Deal.PARTNER_NAME;
        PARTNER_ID_EDIT.Value = Deal.PARTNER_ID;
        TYPE_ID.Text = Deal.TYPE_NAME;
        TYPE_ID_EDIT.Value = Deal.TYPE_ID;
        INS_RNK.Value = Convert.ToString(Deal.INS_RNK);
        INS_RNK_ValueChanged(INS_RNK, null);
        SER.Value = Deal.SER;
        NUM.Value = Deal.NUM;
        SDATE.Value = Deal.SDATE;
        EDATE.Value = Deal.EDATE;

        // Об`єкт страхування
        ObjectRowCL.Visible = (Deal.OBJECT_TYPE == "CL");
        ObjectRowGRT.Visible = (Deal.OBJECT_TYPE == "GRT");

        if (Deal.OBJECT_TYPE == "CL")
        {
            CL_RNK.Value = Convert.ToString(Deal.CL_RNK);
            CL_RNK_ValueChanged(CL_RNK, null);
        }
        else if (Deal.OBJECT_TYPE == "GRT")
        {
            GRT_ID.Value = Convert.ToString(Deal.GRT_ID);
            GRT_ID_ValueChanged(GRT_ID, null);
        }

        ND.Value = Convert.ToString(Deal.ND);
        ND_ValueChanged(ND, null);

        // Фінансові параметри
        SUM.Value = Deal.SUM;
        SUM_KV.Value = Deal.SUM_KV;
        PAY_FREQ.Text = Deal.PAY_FREQ_NAME;
        RENEW_NEED.Value = Deal.RENEW_NEED;
        hlRENEW_NEWID.Text = String.Format("{0}", Deal.RENEW_NEWID);
        if (Deal.RENEW_NEWID.HasValue)
            hlRENEW_NEWID.NavigateUrl = String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}", Deal.RENEW_NEWID);

        trINSU_TARIFF.Visible = Deal.INSU_TARIFF.HasValue;
        trINSU_SUM.Visible = !Deal.INSU_TARIFF.HasValue;

        VInsUserPartnerTypeTariffRecord Tariff = (new VInsUserPartnerTypeTariff()).SelectPartnerTypeTariff(Deal.PARTNER_ID, Deal.TYPE_ID);
        if (Tariff != null)
        {
            if (Tariff.MIN_PERC.HasValue) INSU_TARIFF.MinValue = Tariff.MIN_PERC.Value;
            if (Tariff.MAX_PERC.HasValue) INSU_TARIFF.MaxValue = Tariff.MAX_PERC.Value;
            if (Tariff.MIN_VALUE.HasValue) INSU_SUM.MinValue = Tariff.MIN_VALUE.Value;
            if (Tariff.MAX_VALUE.HasValue) INSU_SUM.MaxValue = Tariff.MAX_VALUE.Value;
        }

        if (Deal.INSU_TARIFF.HasValue)
            INSU_TARIFF.Value = Deal.INSU_TARIFF;
        else
            INSU_SUM.Value = Deal.INSU_SUM;

        TOTAL_INSU_SUM.Value = Deal.TOTAL_INSU_SUM;
    }
    private void SetupControls()
    {
        ibRenew.OnClientClick = String.Format("return ShowComment('{0}', {1})", hComm.ClientID, "false");
        ibSend2Visa.OnClientClick = String.Format("return ShowComment('{0}', {1})", hComm.ClientID, "false");
        ibSendBack2Mgr.OnClientClick = String.Format("return ShowComment('{0}', {1})", hComm.ClientID, "true");
        ibStorno.OnClientClick = String.Format("return ShowComment('{0}', {1})", hComm.ClientID, "true");
        ibOff.OnClientClick = String.Format("return ShowComment('{0}', {1})", hComm.ClientID, "false");
    }
    private void ShowAddAgr()
    {
        String ErrorUrl = String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", DEAL_ID, Type.ToLower());
        ScriptManager.RegisterStartupScript(this, typeof(Page), "addsgr_dialog", String.Format("ShowAddAgr({0}, '{1}', '{2}'); ", DEAL_ID, hAddAgr.ClientID, ErrorUrl), true);
    }
    private void ShowActionBtn(String BtnID, Boolean show)
    {
        Control BtnCtrl = this.Master.FindControl("cph").FindControl(String.Format("td{0}Btn", BtnID));
        Control TxtCtrl = this.Master.FindControl("cph").FindControl(String.Format("td{0}Txt", BtnID));

        if (BtnCtrl != null) BtnCtrl.Visible = show;
        if (TxtCtrl != null) TxtCtrl.Visible = show;
    }
    private Boolean IsActionBtnVisible(String BtnID)
    {
        Control BtnCtrl = this.Master.FindControl("cph").FindControl(String.Format("td{0}Btn", BtnID));

        if (BtnCtrl != null) return BtnCtrl.Visible;
        else return false;
    }
    # endregion
}