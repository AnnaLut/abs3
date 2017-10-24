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

using Bars.DataComponents;

public partial class credit_constructor_wcssubproducts : Bars.BarsPage
{
    # region Приватные свойства
    private String MACsPageURL = "/barsroot/credit/constructor/wcssubproductmacs.aspx";
    private String CreditDataPageURL = "/barsroot/credit/constructor/wcssubproductcreditdata.aspx";
    private String ScanCopiesPageURL = "/barsroot/credit/constructor/wcssubproductscancopy.aspx";
    private String AuthsPageURL = "/barsroot/credit/constructor/wcssubproductauth.aspx";
    private String SurveysPageURL = "/barsroot/credit/constructor/wcssubproductsurvey.aspx";
    private String ScoringsPageURL = "/barsroot/credit/constructor/wcssubproductscoring.aspx";
    private String SolvenciesPageURL = "/barsroot/credit/constructor/wcssubproductsolvency.aspx";
    private String InfoQueriesPageURL = "/barsroot/credit/constructor/wcssubproductinfoqueries.aspx";
    private String StopsPageURL = "/barsroot/credit/constructor/wcssubproductstops.aspx";
    private String AddServicesPageURL = "/barsroot/credit/constructor/wcssubproductaddservices.aspx";
    private String PartnersPageURL = "/barsroot/credit/constructor/wcssubproductpartners.aspx";
    private String InsurancePageURL = "/barsroot/credit/constructor/wcssubproductinsurances.aspx";
    private String GaranteePageURL = "/barsroot/credit/constructor/wcssubproductgarantees.aspx";
    private String DocsPageURL = "/barsroot/credit/constructor/wcssubproducttemplates.aspx";
    private String PaymentsPageURL = "/barsroot/credit/constructor/wcssubproductpayments.aspx";
    # endregion

    # region Публичные методы
    public String SUBPRODUCT_ID
    {
        get
        {
            return (String)Session["WCS_SUBPRODUCT_ID"];
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title + " по продукту \"" + Master.PRODUCT_NAME + "\"", true);
    }
    protected void fvVWcsSubproducts_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("PRODUCT_ID", Master.PRODUCT_ID);
    }
    protected void fvVWcsSubproducts_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvVWcsSubproducts.DataBind();
    }
    protected void fvVWcsSubproducts_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvVWcsSubproducts.DataBind();
    }
    protected void fvVWcsSubproducts_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvVWcsSubproducts.DataBind();
    }
    protected void fvVWcsSubproducts_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        Master.SUBPRODUCT_ID = Convert.ToString(e.CommandArgument);
        switch (e.CommandName)
        {
            case "ShowMACs": Master.GoToPage(MACsPageURL); break;
            case "ShowCreditData": Master.GoToPage(CreditDataPageURL); break;
            case "ShowScanCopies": Master.GoToPage(ScanCopiesPageURL); break;
            case "ShowAuths": Master.GoToPage(AuthsPageURL); break;
            case "ShowSurveys": Master.GoToPage(SurveysPageURL); break;
            case "ShowScorings": Master.GoToPage(ScoringsPageURL); break;
            case "ShowSolvencies": Master.GoToPage(SolvenciesPageURL); break;
            case "ShowInfoQueries": Master.GoToPage(InfoQueriesPageURL); break;
            case "ShowStops": Master.GoToPage(StopsPageURL); break;
            case "ShowAddServices": Master.GoToPage(AddServicesPageURL); break;
            case "ShowPartners": Master.GoToPage(PartnersPageURL); break;
            case "ShowInsurance": Master.GoToPage(InsurancePageURL); break;
            case "ShowGarantee": Master.GoToPage(GaranteePageURL); break;
            case "ShowDocs": Master.GoToPage(DocsPageURL); break;
            case "ShowPayments": Master.GoToPage(PaymentsPageURL); break;
        }
    }
    # endregion

    # region Приватные методы
    private void InitGridValue()
    {
        if (!String.IsNullOrEmpty(Master.SUBPRODUCT_ID))
        {
            foreach (GridViewRow row in gvVWcsSubproducts.Rows)
                if ((row.DataItem as credit.VWcsSubproductsRecord).SUBPRODUCT_ID == Master.SUBPRODUCT_ID)
                    gvVWcsSubproducts.SelectedIndex = row.RowIndex;
        }
    }
    # endregion
}
