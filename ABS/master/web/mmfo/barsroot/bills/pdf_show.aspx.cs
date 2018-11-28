using System;
using credit;
using ibank.core;

public partial class credit_usercontrols_dialogs_pdf_show : System.Web.UI.Page
{
    /// <summary>
    /// Идентификатор данных в сессии
    /// </summary>
    private decimal? bidID
    {
        get
        {
            return String.IsNullOrEmpty(Request.Params.Get("bidId")) ? (decimal?)null : Convert.ToDecimal(Request.Params.Get("bidId"));
        }
    }

    private String questionID
    {
        get
        {
            return String.IsNullOrEmpty(Request.Params.Get("questionId")) ? null : Request.Params.Get("questionId");
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
            BbConnection con = new BbConnection();
            Common cmn = new Common(con);

            try
            {
                Response.ClearContent();
                Response.ClearHeaders();
                Response.AppendHeader("content-disposition", "attachment;filename=test.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(cmn.wu.GET_ANSW_BLOB(bidID, questionID));
                Response.Flush();
                Response.End();
            }
            finally
            {
                con.CloseConnection();
            }
    }
}