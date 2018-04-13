using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Collections.Generic;
using Bars.Exception;
using credit;

public partial class constructorMaster : System.Web.UI.MasterPage
{
    # region Приватные свойства
    # endregion

    # region Публичные свойства
    public String PRODUCT_ID
    {
        get
        {
            return (String)Session["WCS_PRODUCT_ID"];
        }
        set
        {
            Session["WCS_PRODUCT_ID"] = value;
        }
    }
    public String PRODUCT_NAME
    {
        get
        {
            VWcsProductsRecord pr = (new VWcsProducts()).SelectProduct(PRODUCT_ID)[0];
            return pr.PRODUCT_NAME;
        }
    }

    public String SUBPRODUCT_ID
    {
        get
        {
            return (String)Session["WCS_SUBPRODUCT_ID"];
        }
        set
        {
            Session["WCS_SUBPRODUCT_ID"] = value;
        }
    }
    public String SUBPRODUCT_NAME
    {
        get
        {
            VWcsSubproductsRecord sbpr = (new VWcsSubproducts()).SelectSubproduct(PRODUCT_ID, SUBPRODUCT_ID)[0];
            return sbpr.SUBPRODUCT_NAME;
        }
    }

    public String SCOPY_ID
    {
        get
        {
            return (String)Session["WCS_SCOPY_ID"];
        }
        set
        {
            Session["WCS_SCOPY_ID"] = value;
        }
    }    
    public String AUTH_ID
    {
        get
        {
            return (String)Session["WCS_AUTH_ID"];
        }
        set
        {
            Session["WCS_AUTH_ID"] = value;
        }
    }        
    public String SURVEY_ID
    {
        get
        {
            return (String)Session["WCS_SURVEY_ID"];
        }
        set
        {
            Session["WCS_SURVEY_ID"] = value;
        }
    }
    public String GROUP_ID
    {
        get
        {
            return (String)Session["WCS_GROUP_ID"];
        }
        set
        {
            Session["WCS_GROUP_ID"] = value;
        }
    }        
    public String SCORING_ID
    {
        get
        {
            return (String)Session["WCS_SCORING_ID"];
        }
        set
        {
            Session["WCS_SCORING_ID"] = value;
        }
    }
    public String SOLVENCY_ID
    {
        get
        {
            return (String)Session["WCS_SOLVENCY_ID"];
        }
        set
        {
            Session["WCS_SOLVENCY_ID"] = value;
        }
    }
    public String QUESTION_ID
    {
        get
        {
            return (String)Session["WCS_QUESTION_ID"];
        }
        set
        {
            Session["WCS_QUESTION_ID"] = value;
        }
    }
    public String IQUERY_ID
    {
        get
        {
            return (String)Session["WCS_IQUERY_ID"];
        }
        set
        {
            Session["WCS_IQUERY_ID"] = value;
        }
    }

    public String TitleFormat = "{0} - {1}";
    # endregion

    # region Публичные методы
    public void ShowError(String ErrorText)
    {
        dvErrorBlock.Style.Add(HtmlTextWriterStyle.Display, "block");
        lbErrorText.Text = ErrorText;
    }
    public void HideError()
    {
        dvErrorBlock.Style.Add(HtmlTextWriterStyle.Display, "none");
        lbErrorText.Text = "";
    }
    public void CheckSessionParams(List<String> SessionParams)
    {
        foreach (String SessionParam in SessionParams)
        {
            if (Session[SessionParam] == null) throw new BarsException("Не заданы необходимые параметры");
        }
    }
    public void GoToPage(String url)
    {
        Response.Redirect(url, true);
    }
    public void SetPageTitle(String Title, Boolean OverWrite)
    {
        if (String.IsNullOrEmpty(lbPageTitle.Text) || OverWrite)
            lbPageTitle.Text = Title;
    }
    public void SetPageTitle(String Title)
    {
        SetPageTitle(Title, false);
    }
    public void SetPageTitleUrl(String Url, Boolean OverWrite)
    {
        if (String.IsNullOrEmpty(lbPageTitle.NavigateUrl) || OverWrite)
            lbPageTitle.NavigateUrl = Url;
    }
    public void SetPageTitleUrl(String Url)
    {
        SetPageTitleUrl(Url, false);
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected override void OnPreRender(EventArgs e)
    {
        // устанавливаем заголовок
        SetPageTitle(Page.Header.Title);

        base.OnPreRender(e);
    }
    # endregion
}
