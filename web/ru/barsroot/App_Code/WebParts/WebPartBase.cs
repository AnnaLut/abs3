using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// Базовый клас для всех WebParts
/// </summary>
public class BarsWebPart : UserControl, IWebPart
{
    protected string _title = "[Generic Title]";
    public string Title
    {
        get { return _title; }
        set { _title = value; }
    }
    //  Subtitle
    protected string _subTitle = "";
    public string Subtitle
    {
        get { return _subTitle; }
        set { _subTitle = value; }
    }
    //  Caption
    protected string _caption = "[Generic Caption]";
    public string Caption
    {
        get { return _caption; }
        set { _caption = value; }
    }
    //  Description
    private string _description = "[Generic Description]";
    public string Description
    {
        get { return _description; }
        set { _description = value; }
    }
    //  TitleUrl
    private string _titleUrl = "";
    public string TitleUrl
    {
        get { return _titleUrl; }
        set { _titleUrl = value; }
    }
    //  TitleIconImageUrl
    private string _titleIconImageUrl = "/Common/Images/default/16/reference.png";
    public string TitleIconImageUrl
    {
        get { return _titleIconImageUrl; }
        set { _titleIconImageUrl = value; }
    }
    //  CatalogIconImageUrl
    private string _catalogIconImageUrl = "/Common/Images/default/16/open.png";
    public string CatalogIconImageUrl
    {
        get { return _catalogIconImageUrl; }
        set { _catalogIconImageUrl = value; }
    }

}
