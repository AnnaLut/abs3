using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Exception;

public partial class safe_deposit_dialog_binddocuments : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["nd"] == null)
            throw new SafeDepositException("Страница вызвана с неверными параметрами!");

        if (!IsPostBack)
        {
            ND.Text = Convert.ToString(Request["nd"]);
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btSave_Click(object sender, EventArgs e)
    {
        safe_deposit sdpt = new safe_deposit();
        Decimal m_nd = Convert.ToDecimal(ND.Text);
        String[] m_refs = REF.Text.Split(',');

        if (rbBind.Checked)
        {
            foreach (String mref in m_refs)
            {
                sdpt.BindUnbindDoc(m_nd, Convert.ToDecimal(mref), true);
            }

            Response.Write("<script>alert('Документы успешно привязаны!');</script>");
            Response.Flush();
        }
        else if (rbUnbind.Checked)
        {
            foreach (String mref in m_refs)
            {
                sdpt.BindUnbindDoc(m_nd, Convert.ToDecimal(mref), false);
            }
            Response.Write("<script>alert('Документы успешно отвязаны!');</script>");
            Response.Flush();
        }
    }
}
