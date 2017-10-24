using System;
using System.Text;
using System.Collections.Generic;
using System.Collections;
using System.Web;

using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class swi_default : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tabCstList.Rows.Clear();
            try
            {
                InitOraConnection();
                SQL_Reader_Exec("select id, name, cts_url, cts_img, params, SYS_CONTEXT('bars_context', 'user_branch'), docsign.getidoper, (select nvl(val,'00') from params where par='REGNCODE') from swi_cts_list order by id");
                int ctsCount = 0;
                TableRow row = new TableRow();

                while (SQL_Reader_Read())
                {
                    TableCell cell = new TableCell();
                    if (ctsCount % 5 == 0)
                    {
                        row = new TableRow();
                    }
                    cell.Controls.Add(DrawCTSInfo(SQL_Reader_GetValues()));
                    row.Cells.Add(cell);

                    tabCstList.Rows.Add(row);
                    ctsCount++;
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }

    private Table DrawCTSInfo(ArrayList reader)
    {
        string Id = Convert.ToString(reader[0]);
        string Name = Convert.ToString(reader[1]);
        string Url = Convert.ToString(reader[2]);
        string ImgSrc = Convert.ToString(reader[3]);
        string Params = Convert.ToString(reader[4]);
        string Branch = Convert.ToString(reader[5]);
        string KeyID = Convert.ToString(reader[6]);
        string RegnCode = Convert.ToString(reader[7]);

        Table tab = new Table();
        tab.Width = Unit.Pixel(100);
        tab.Height = Unit.Pixel(200);
        tab.CssClass = "barsGridView";
        tab.Style["text-align"] = "center";
        TableRow row = new TableRow();
        TableCell cell = new TableCell();
        cell.Text = Name;
        cell.CssClass = "titledText";
        cell.Height = Unit.Pixel(20);
        row.Cells.Add(cell);
        tab.Rows.Add(row);

        row = new TableRow();
        cell = new TableCell();
        Image img = new Image();
        img.Width = Unit.Pixel(150);
        //img.Height = Unit.Pixel(180);
        img.ImageUrl = ImgSrc;
        cell.Controls.Add(img);

        row.Cells.Add(cell);
        tab.Rows.Add(row);

        row = new TableRow();
        cell = new TableCell();
        //LinkButton lb = new LinkButton();
        //lb.Text = "Виконати платіж";
        StringBuilder url = new StringBuilder(Url);
        if (!Url.EndsWith("?"))
        {
            if (Url.Contains("?"))
                url.Append("&");
            else
                url.Append("?");
        }
        //url.Append("SessionData=" + Session.SessionID);
        url.Append("Branch=" + HttpUtility.UrlEncode(Branch));
        string retUrl = Request.Url.AbsoluteUri.ToLower().Replace("swi", "docinput").Replace("default", "docinput");
        string homeUrl = Request.Url.AbsoluteUri;
        // Проверка порта (для шлюза)
        if (Request.UrlReferrer != null && Request.UrlReferrer.Port != Request.Url.Port)
        {
            string absUrl = Request.UrlReferrer.AbsoluteUri.ToLower();
            retUrl = absUrl.Substring(0, absUrl.IndexOf("barsroot") + 8) + "/docinput/docinput.aspx";
            homeUrl = absUrl.Substring(0, absUrl.IndexOf("barsroot") + 8) + "/swi/default.aspx";
        }
 
        //retUrl += "?swi=1";
        if (!string.IsNullOrEmpty(Params))
            retUrl += "&" + Params;
        url.Append("&BackURL=" + HttpUtility.UrlEncode(retUrl));
        url.Append("&HomeURL=" + HttpUtility.UrlEncode(homeUrl));

        if (KeyID.Length == 6 && RegnCode.Length == 2)
            KeyID = RegnCode + KeyID; 
        url = url.Replace("{KEYID}", KeyID);

        //lb.PostBackUrl = url.ToString();
        HtmlAnchor a = new HtmlAnchor();
        a.HRef = url.ToString();
        a.InnerText = "Виконати платіж";
        cell.Height = Unit.Pixel(20);
        //cell.Controls.Add(lb);
        cell.Controls.Add(a);
        row.Cells.Add(cell);
        tab.Rows.Add(row);

        return tab;
    }

    protected void lnLaunch_GB_Click(object sender, EventArgs e)
    {
        StringBuilder url = new StringBuilder("http://global-money.dev.masterlogic.net/bars-enter.php?");
        string baseParams = "SessionData=" + Session.SessionID;
        baseParams += "&Branch=/333368/";
        url.Append(baseParams);
        //url.Append("&ReturnUrl=" + HttpUtility.UrlEncode(Request.Url.AbsoluteUri.Replace("default.aspx", "payment.aspx?") + baseParams));
        //strinf
        //url.Append("&ReturnUrl=" + HttpUtility.UrlEncode(Request.Url.AbsoluteUri.ToLower("swi","docinput"). "/docinput.aspx?tt=CG1" + baseParams));
        url.Append("&HomeUrl=" + HttpUtility.UrlEncode(Request.Url.AbsoluteUri));
        Response.Redirect(url.ToString());
        /*Response.Clear();
		StringBuilder sb = new StringBuilder();
		sb.Append("<html>");
		sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
		sb.AppendFormat("<form name='form' action='{0}' method='post'>", "http://global-money.dev.masterlogic.net/bars-enter.php");
		sb.AppendFormat("<input type='hidden' name='SessionData' value='{0}'>", Session.SessionID);
		sb.AppendFormat("<input type='hidden' name='Branch' value='{0}'>", "/333368/");
		sb.AppendFormat("<input type='hidden' name='ReturnUrl' value='{0}'>", Request.Url.AbsoluteUri.Replace("default.aspx", "payment.aspx"));
		sb.Append("</form>");
		sb.Append("</body>");
		sb.Append("</html>");

		Response.Write(sb.ToString());
		Response.End();*/
    }
    protected void lnLaunch_WU_Click(object sender, EventArgs e)
    {
        //Response.Redirect("http://localhost/swi/default.aspx?Branch=/333368/&SessionData=" + Session.SessionID + "&returnUrl=" + "http://localhost/barsroot/swi/default.aspx");
    }
}