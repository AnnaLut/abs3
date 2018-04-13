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

using System.Collections.Generic;
using System.Xml;

using Bars.Exception;
using Bars.ObjLayer.CbiRep;
using Bars.UserControls;
using Bars.Classes;

using ibank.core;

public partial class cbirep_rep_query : Bars.BarsPage
{
    # region Константы
    public const String XMLVersion = "1.0";
    public const String XMLEncoding = "UTF-8";
    public const String DateFormat = "dd.MM.yyyy";
    public const String DateTimeFormat = "dd.MM.yyyy HH:mm:ss";
    public const String NumberFormat = "######################0.00##";
    public const String DecimalSeparator = ".";
    # endregion

    # region Приватные свойства
    private VCbirepReplistRecord _CbirepRep;
    private VCbirepRepparamsRecord _CbirepRepParams;
    private ParsedReport _Report;
    private Decimal? _RepID = (Decimal?)null;
    # endregion

    # region Публичные свойства
    public Decimal RepID
    {
        get
        {
            if (_RepID.HasValue) return _RepID.Value;

            // обязательный парамет
            if (Request.Params.Get("repid") == null)
            {
                throw new BarsException("НЕ задано обов`язковий параметр repid");
            }
            else
            {
                _RepID = Convert.ToDecimal(Request.Params.Get("repid"));
                if (!(new VCbirepReplist()).CheckAccess(_RepID.Value))
                {
                    String ExceptionTest = String.Format("Звіт {0} НЕ виданий вашому користувачу", _RepID.ToString());
                    _RepID = (Decimal?)null;

                    throw new BarsException(ExceptionTest);
                }
                else
                {
                    return _RepID.Value;
                }
            }
        }
    }
    public VCbirepReplistRecord CbirepRep
    {
        get
        {
            if (_CbirepRep == null)
            {
                VCbirepReplist tab = new VCbirepReplist();
                tab.Filter.REP_ID.Equal(RepID);

                _CbirepRep = tab.Select()[0];
            }

            return _CbirepRep;
        }
    }
    public VCbirepRepparamsRecord CbirepRepParams
    {
        get
        {
            if (_CbirepRepParams == null)
                _CbirepRepParams = (new VCbirepRepparams()).FindRepByRepID(RepID);

            return _CbirepRepParams;
        }
    }
    public ParsedReport Report
    {
        get
        {
            if (_Report == null)
                _Report = new ParsedReport(CbirepRepParams);

            return _Report;
        }
    }
    # endregion

    # region События
    protected override void OnInit(EventArgs e)
    {
        // наполняем данными
        rParams.DataSource = Report.Params;
        rParams.DataBind();

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Params.Get("codeapp") != null)
                ViewState["PrevUrl"] = "rep_list.aspx?codeapp=" + Request.Params.Get("codeapp");
            else
                ViewState["PrevUrl"] = Request.UrlReferrer.ToString();

            // заголовок страницы
            this.Title = String.Format(this.Title, CbirepRep.REP_ID, CbirepRep.REP_DESC);
            lbPageTitle.Text = String.Format(lbPageTitle.Text, CbirepRep.REP_ID, CbirepRep.REP_DESC);
        }
    }
    protected void rParams_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.DataItem != null && (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            ReportParam Param = (e.Item.DataItem as ReportParam);
            PlaceHolder phControl = (e.Item.FindControl("phControl") as PlaceHolder);
            UserControl Ctrl = null;

            switch (Param.Type)
            {
                case ParamTypes.String:
                    # region String
                    Ctrl = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxString.ascx");

                    TextBoxString TEXT = (TextBoxString)Ctrl;
                    TEXT.ID = Param.ID;
                    TEXT.IsRequired = true;
                    TEXT.Value = Param.DefaultValueString;

                    TEXT.ValidationGroup = "ReportParams";

                    # endregion

                    break;
                case ParamTypes.Date:
                    # region Date
                    Ctrl = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxDate.ascx");

                    TextBoxDate DATE = (TextBoxDate)Ctrl;
                    DATE.ID = Param.ID;
                    DATE.IsRequired = true;
                    DATE.Value = Param.DefaultValueDate;

                    DATE.MaxValue = DateTime.Now.AddYears(1);
                    DATE.MinValue = DateTime.Now.AddYears(-3);

                    DATE.ValidationGroup = "ReportParams";

                    # endregion

                    break;
                case ParamTypes.Reference:
                    # region Reference
                    Ctrl = (UserControl)Page.LoadControl("~/credit/usercontrols/TextBoxRefer.ascx");

                    TextBoxRefer REFER = (TextBoxRefer)Ctrl;
                    REFER.ID = Param.ID;

                    ReferenceParams rp = Param.Reference;
                    REFER.TAB_ID = rp.TAB_ID;
                    REFER.KEY_FIELD = rp.KEY_FIELD;
                    REFER.SEMANTIC_FIELD = rp.SEMANTIC_FIELD;
                    REFER.SHOW_FIELDS = rp.SHOW_FIELDS;
                    REFER.WHERE_CLAUSE = rp.WHERE_CLAUSE.Replace("\"", "'");

                    REFER.IsRequired = true;
                    REFER.Value = Param.DefaultValueString;
                    REFER.Enabled = true;

                    REFER.ValidationGroup = "ReportParams";

                    # endregion

                    break;
            }

            phControl.Controls.Add(Ctrl);
        }
    }
    protected void btSend_Click(object sender, EventArgs e)
    {
        Rs rs = new Rs(new BbConnection());
        XmlDocument XML_PARAMS = PrepareXmlParams();
        Decimal? QUERY_ID;

        try
        {
            QUERY_ID = rs.CREATE_REPORT_QUERY(RepID, XML_PARAMS.OuterXml);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "success_alert", "alert('Заявка на формування звіту відправлена (" + Convert.ToString(QUERY_ID) + ")'); ", true);
            Object PrevUrl = ViewState["PrevUrl"];
            if (PrevUrl != null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "return_redirect", "location.replace('" + (String)PrevUrl + "'); ", true);
            }
        }
        catch (Exception ex)
        {
            // Обрабатываем повторное формирование отчета
            if (ex.Message.Contains("OTC-00005"))
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error_alert", "alert('Повторне формування звіту з такими ж параметрами заборонене'); ", true);
            else throw ex;
        }
    }
    protected void btBack_Click(object sender, EventArgs e)
    {
        Object PrevUrl = ViewState["PrevUrl"];
        if (PrevUrl != null)
            Response.Redirect((String)PrevUrl);
    }
    # endregion

    # region Приватные методы
    private XmlDocument PrepareXmlParams()
    {
        XmlDocument doc = new XmlDocument();
        doc.CreateXmlDeclaration(XMLVersion, XMLEncoding, String.Empty);

        XmlElement body = doc.CreateElement("ReportParams");
        doc.AppendChild(body);

        foreach (RepeaterItem item in rParams.Items)
        {
            ReportParam Param = Report.Params[item.ItemIndex];

            //Param
            XmlElement param = doc.CreateElement("Param");
            body.AppendChild(param);

            //@ID
            XmlAttribute ID = doc.CreateAttribute("ID");
            ID.Value = ":" + Param.ID;
            param.Attributes.Append(ID);

            //@Value
            XmlAttribute Value = doc.CreateAttribute("Value");
            switch (Param.Type)
            {
                case ParamTypes.String:
                    # region String
                    TextBoxString TEXT = (TextBoxString)item.FindControl(Param.ID);
                    Value.Value = TEXT.Value;
                    # endregion

                    break;
                case ParamTypes.Date:
                    # region Date
                    TextBoxDate DATE = (TextBoxDate)item.FindControl(Param.ID);
                    Value.Value = (DATE.Value.HasValue ? DATE.Value.Value.ToString(DateFormat) : String.Empty);
                    # endregion

                    break;
                case ParamTypes.Reference:
                    # region Reference
                    TextBoxRefer REFER = (TextBoxRefer)item.FindControl(Param.ID);
                    Value.Value = REFER.Value;
                    # endregion

                    break;
            }
            param.Attributes.Append(Value);
        }

        return doc;
    }
    # endregion
}

