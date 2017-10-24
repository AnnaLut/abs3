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

using System.Globalization;
using credit;

public partial class credit_documents : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // если параметры передали в урл то наполняем
        if (!IsPostBack && Request.Params.Get("ccid") != null && Request.Params.Get("dat1") != null)
        {
            String CC_ID = Request.Params.Get("ccid");

            DateTimeFormatInfo dtfi = new DateTimeFormatInfo();
            dtfi.ShortDatePattern = "yyyyMMdd";
            dtfi.FullDateTimePattern = "yyyyMMdd HH:mm:ss";
            DateTime DAT1 = DateTime.ParseExact(Request.Params.Get("dat1"), "yyyyMMdd", dtfi);

            tbsCC_ID.Value = CC_ID;
            tbdDAT1.Value = DAT1;

            ibSearch_Click(sender, null);
        }
    }
    protected void ibSearch_Click(object sender, ImageClickEventArgs e)
    {
        gvDocs.DataBind();
    }
    protected void gvDocs_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Print":
                // параметры
                String[] CommandArguments = (e.CommandArgument as String).Split(';');
                Decimal? ND = Convert.ToDecimal(CommandArguments[0]);
                String SCHEME_ID = CommandArguments[1];

                // текст документа
                String DocText = (new VCcDocs()).SelectVCcDoc(ND, SCHEME_ID).TEXT;

                // формат файла
                Response.ClearContent();
                Response.ClearHeaders();
                Response.Charset = "windows-1251";
                Response.AppendHeader("content-disposition", "attachment;filename=" + SCHEME_ID.ToLower() + ".rtf");
                Response.ContentType = "application/octet-stream";
                Response.Write(DocText);
                Response.Flush();
                Response.Close();

                break;
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        dvGrid.DataBind();
        
        base.OnPreRender(e);
    }
}