using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Bars.UserControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using credit;
using ibank.core;
using System.Collections.Generic;

public partial class credit_constructor_wcssbpmacvalues : Bars.BarsPage
{
    # region Приватные свойства
    private String MACsPageURL = "/barsroot/credit/constructor/wcssubproductmacs.aspx";
    private VWcsSubproductsRecord _SubproductsRecord;
    private VWcsSubproductMacsRecord _SubproductMacsRecord;
    # endregion

    # region Публичные методы
    public String SUBPRODUCT_ID
    {
        get
        {
            return Request.Params.Get("subproduct_id");
        }
    }
    public VWcsSubproductsRecord SubproductsRecord
    {
        get
        {
            if (_SubproductsRecord == null)
            {
                VWcsSubproductsRecord Item = new VWcsSubproductsRecord();
                Item.SUBPRODUCT_ID = SUBPRODUCT_ID;

                _SubproductsRecord = (new VWcsSubproducts()).Select(Item)[0];
            }
            return _SubproductsRecord;
        }
    }
    public String MAC_ID
    {
        get
        {
            return Request.Params.Get("mac_id");
        }
    }
    public VWcsSubproductMacsRecord SubproductMacsRecord
    {
        get
        {
            if (_SubproductMacsRecord == null)
                _SubproductMacsRecord = (new VWcsSubproductMacs()).SelectSubproductMac(SUBPRODUCT_ID, MAC_ID)[0];
            return _SubproductMacsRecord;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        // Значения МАКа {0} ({1}) для субпродукта {2} ({3})
        Master.SetPageTitle(String.Format(this.Title, SubproductMacsRecord.MAC_ID, SubproductMacsRecord.MAC_NAME, SubproductMacsRecord.SUBPRODUCT_ID, SubproductsRecord.SUBPRODUCT_NAME), true);

        Master.SUBPRODUCT_ID = SUBPRODUCT_ID;
        Master.SetPageTitleUrl(MACsPageURL, true);

        if (!IsPostBack)
        {
            // наполняем дерево
            InitTreeView();
        }

        // создаем контролы добавления записи
        InitValueControls();
    }
    protected void tv_SelectedNodeChanged(object sender, EventArgs e)
    {
        gv.DataBind();
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        Common cmn = new Common(new BbConnection());
        
        // берем контролы
        UserControl uc = (ph.FindControl("uc") as UserControl);
        DateTime? ApplyDate = APPLY_DATE.Value;

        # region Switch TYPE_ID
        switch (SubproductMacsRecord.TYPE_ID)
        {
            case "TEXT":
                # region TEXT
                TextBoxString TEXT = (TextBoxString)uc;
                cmn.wp.SBPROD_MAC_TEXT_SET(SubproductMacsRecord.SUBPRODUCT_ID, SubproductMacsRecord.MAC_ID, TEXT.Value, tv.SelectedValue, ApplyDate);
                # endregion

                break;
            case "NUMB":
                # region NUMB
                TextBoxNumb NUMB = (TextBoxNumb)uc;
                cmn.wp.SBPROD_MAC_NUMB_SET(SubproductMacsRecord.SUBPRODUCT_ID, SubproductMacsRecord.MAC_ID, NUMB.Value, tv.SelectedValue, ApplyDate);
                # endregion

                break;
            case "DECIMAL":
                # region DECIMAL
                TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                cmn.wp.SBPROD_MAC_DEC_SET(SubproductMacsRecord.SUBPRODUCT_ID, SubproductMacsRecord.MAC_ID, DECIMAL.Value, tv.SelectedValue, ApplyDate);
                # endregion

                break;
            case "DATE":
                # region DATE
                TextBoxDate DATE = (TextBoxDate)uc;
                cmn.wp.SBPROD_MAC_DAT_SET(SubproductMacsRecord.SUBPRODUCT_ID, SubproductMacsRecord.MAC_ID, DATE.Value, tv.SelectedValue, ApplyDate);
                # endregion

                break;
            case "LIST":
                # region LIST
                DDLList LIST = (DDLList)uc;
                cmn.wp.SBPROD_MAC_LIST_SET(SubproductMacsRecord.SUBPRODUCT_ID, SubproductMacsRecord.MAC_ID, LIST.Value, tv.SelectedValue, ApplyDate);
                # endregion

                break;
            case "REFER":
                # region REFER
                TextBoxRefer REFER = (TextBoxRefer)uc;
                cmn.wp.SBPROD_MAC_REF_SET(SubproductMacsRecord.SUBPRODUCT_ID, SubproductMacsRecord.MAC_ID, REFER.Value, tv.SelectedValue, ApplyDate);
                # endregion

                break;
            case "BOOL":
                # region BOOL
                RBLFlag BOOL = (RBLFlag)uc;
                cmn.wp.SBPROD_MAC_BOOL_SET(SubproductMacsRecord.SUBPRODUCT_ID, SubproductMacsRecord.MAC_ID, BOOL.Value, tv.SelectedValue, ApplyDate);
                # endregion

                break;
        }
        # endregion

        // Обновляем грид и отчищаем контрол
        gv.DataBind();

        APPLY_DATE.Value = (DateTime?)null;
        # region Switch TYPE_ID
        switch (SubproductMacsRecord.TYPE_ID)
        {
            case "TEXT":
                # region TEXT
                TextBoxString TEXT = (TextBoxString)uc;
                TEXT.Value = (String)null;
                # endregion

                break;
            case "NUMB":
                # region NUMB
                TextBoxNumb NUMB = (TextBoxNumb)uc;
                NUMB.Value = (Decimal?)null;
                # endregion

                break;
            case "DECIMAL":
                # region DECIMAL
                TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                DECIMAL.Value = (Decimal?)null;
                # endregion

                break;
            case "DATE":
                # region DATE
                TextBoxDate DATE = (TextBoxDate)uc;
                DATE.Value = (DateTime?)null;
                # endregion

                break;
            case "LIST":
                # region LIST
                DDLList LIST = (DDLList)uc;
                LIST.Value = (Decimal?)null;
                # endregion

                break;
            case "REFER":
                # region REFER
                TextBoxRefer REFER = (TextBoxRefer)uc;
                REFER.Value = (String)null;
                # endregion

                break;
            case "BOOL":
                # region BOOL
                RBLFlag BOOL = (RBLFlag)uc;
                BOOL.Value = (Decimal?)null;
                # endregion

                break;
        }
        # endregion
    }
    # endregion

    # region Приватные методы
    private void InitValueControls()
    {
        // создаем контрол
        UserControl uc = new UserControl();

        # region Switch TYPE_ID
        switch (SubproductMacsRecord.TYPE_ID)
        {
            case "TEXT":
                # region TEXT
                uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxString.ascx");

                TextBoxString TEXT = (TextBoxString)uc;
                TEXT.ID = "uc";
                TEXT.IsRequired = true;
                TEXT.ValidationGroup = "NewDate";
                # endregion

                break;
            case "NUMB":
                # region NUMB
                uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxNumb.ascx");

                TextBoxNumb NUMB = (TextBoxNumb)uc;
                NUMB.ID = "uc";
                NUMB.IsRequired = true;
                NUMB.ValidationGroup = "NewDate";
                # endregion

                break;
            case "DECIMAL":
                # region DECIMAL
                uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDecimal.ascx");

                TextBoxDecimal DECIMAL = (TextBoxDecimal)uc;
                DECIMAL.ID = "uc";
                DECIMAL.IsRequired = true;
                DECIMAL.ValidationGroup = "NewDate";
                # endregion

                break;
            case "DATE":
                # region DATE
                uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDate.ascx");

                TextBoxDate DATE = (TextBoxDate)uc;
                DATE.ID = "uc";
                DATE.IsRequired = true;
                DATE.ValidationGroup = "NewDate";
                # endregion

                break;
            case "LIST":
                # region LIST
                uc = (UserControl)Page.LoadControl("~/credit/usercontrols/DDLList.ascx");

                DDLList LIST = (DDLList)uc;
                LIST.ID = "uc";
                LIST.IsRequired = true;
                LIST.ValidationGroup = "NewDate";

                LIST.DataValueField = "ORD";
                LIST.DataTextField = "TEXT";

                List<WcsMacListItemsRecord> qliRecords = (new WcsMacListItems(new BbConnection())).Select(SubproductMacsRecord.MAC_ID);
                LIST.DataSource = qliRecords;
                LIST.DataBind();
                # endregion

                break;
            case "REFER":
                # region REFER
                uc = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxRefer.ascx");

                TextBoxRefer REFER = (TextBoxRefer)uc;
                REFER.ID = "uc";
                REFER.MAC_ID = SubproductMacsRecord.MAC_ID;
                REFER.IsRequired = true;
                REFER.ValidationGroup = "NewDate";
                # endregion

                break;
            case "BOOL":
                # region BOOL
                uc = (UserControl)Page.LoadControl("~/credit/usercontrols/RBLFlag.ascx");

                RBLFlag BOOL = (RBLFlag)uc;
                BOOL.ID = "uc";
                BOOL.IsRequired = true;
                # endregion

                break;
        }
        # endregion

        ph.Controls.Add(uc);
    }
    private void InitTreeView()
    {
        List<VWcsSbpMacBranchesRecord> branches = (ods.Select() as List<VWcsSbpMacBranchesRecord>);

        VWcsSbpMacBranchesRecord Root = branches.Find(delegate(VWcsSbpMacBranchesRecord branch) { return branch.BRANCH == "/"; });
        TreeNode ndRoot = new TreeNode(Root.BRANCH_NAME, Root.BRANCH);
        tv.Nodes.Add(ndRoot);

        FillTreeView(ndRoot, branches.FindAll(delegate(VWcsSbpMacBranchesRecord branch) { return branch.BRANCH != "/"; }), 1);

        tv.CollapseAll();
        tv.Nodes[0].Select();
    }
    private void FillTreeView(TreeNode nd, List<VWcsSbpMacBranchesRecord> branches, Int32 lev)
    {
        List<VWcsSbpMacBranchesRecord> levBranches = branches.FindAll(delegate(VWcsSbpMacBranchesRecord branch) { return (branch.BRANCH.Length - 1) / 7 == lev; });
        foreach (VWcsSbpMacBranchesRecord branch in levBranches)
        {
            TreeNode ndBranch = new TreeNode(branch.BRANCH_NAME, branch.BRANCH);
            nd.ChildNodes.Add(ndBranch);

            // Наполняем след уровень
            List<VWcsSbpMacBranchesRecord> sublevBranches = branches.FindAll(delegate(VWcsSbpMacBranchesRecord subbranch) { return subbranch.BRANCH.StartsWith(branch.BRANCH) && (subbranch.BRANCH.Length - 1) / 7 > lev; });
            if (sublevBranches.Count > 0) FillTreeView(ndBranch, sublevBranches, lev + 1);
        }
    }
    # endregion
}
