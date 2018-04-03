using System;
using System.Text;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class swi_payment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        foreach (string par in Request.QueryString)
        {
            tbParams.Text += par + "=" + Request.QueryString[par] + "\n";
        }
    }
    protected void btReturnData_Click(object sender, EventArgs e)
    {
        string postData = "Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%BA%D0%BE%D1%88%D1%82%D1%96%D0%B2+%D0%BD%D0%B0+%D0%B3%D0%B0%D0%BC%D0%B0%D0%BD%D0%B5%D1%86%D1%8C+%D0%93%D0%BB%D0%BE%D0%B1%D0%B0%D0%BB%D0%9C%D0%B0%D0%BD%D1%96+oschad.bars@test.com&SumC=15.08&reqv_SUM_COM_BANK=3.00&reqv_SUM_COM_ALL=3.08&TransactionId=178&WalletId=21884487517107&Signature=02000000B479CD0F82EFA833BF42B5420000000000000000A2BC3C4D060A9337B289F310F468D716A7EBFBC4D47B2E0EEA29142F3F25AF76CD4EBC9E7941E39B0B28D2709F155BF620A908D2B71B3A1AFBD5BA2595FD3B4E87E7&SignKeyId=289YID02";
        //Response.Redirect(Request.QueryString["ReturnUrl"] + "&SumC=" + tbSum.Text + "&Nazn=" + tbNazn.Text + "&reqv_FIO=" + tbReqvFIO.Text);
        Response.Clear();
        StringBuilder sb = new StringBuilder();
        sb.Append("<html>");
        sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
        sb.AppendFormat("<form name='form' action='{0}' method='post'>", Request.QueryString["BackURL"] + "?swi=gm5");
        /*sb.AppendFormat("<input type='hidden' name='SumC' value='{0}'>", "1 000%2E0000");
        sb.AppendFormat("<input type='hidden' name='Nazn' value='{0}'>", tbNazn.Text);
        sb.AppendFormat("<input type='hidden' name='reqv_FIO' value='{0}'>", tbReqvFIO.Text);
        sb.AppendFormat("<input type='hidden' name='reqv_FIO2' value='{0}'>", "Пупкін");
        sb.AppendFormat("<input type='hidden' name='Kv_A' value='{0}'>", 840);
        sb.AppendFormat("<input type='hidden' name='Kv_B' value='{0}'>", 840);
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_ALL' value='{0}'>", "3.01");
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_BANK' value='{0}'>", "3.00");

        sb.AppendFormat("<input type='hidden' name='SumC' value='{0}'>", "1.01");
        sb.AppendFormat("<input type='hidden' name='Nazn' value='{0}'>", "%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%BA%D0%BE%D1%88%D1%82%D1%96%D0%B2+%D0%BD%D0%B0+%D0%B3%D0%B0%D0%BC%D0%B0%D0%BD%D0%B5%D1%86%D1%8C+%D0%93%D0%BB%D0%BE%D0%B1%D0%B0%D0%BB%D0%9C%D0%B0%D0%BD%D1%96+oschad.bars@test.com");
        sb.AppendFormat("<input type='hidden' name='Signature' value='{0}'>", "02000000B479CD0FC7A7A433BF42B542000000000000000003E3C2B3F62CD9286B1FD618EAF8C4483BDACC5BD2FA413DA0AA45EE1397EB252ABE42D85E400215534136CA8E9839AF802CBDFD534B5F2C7C475DDFCE87B0809F30");
        sb.AppendFormat("<input type='hidden' name='SignKeyId' value='{0}'>", "289YID00");
        sb.AppendFormat("<input type='hidden' name='WalletId' value='{0}'>", "21884487517107");
        sb.AppendFormat("<input type='hidden' name='TransactionId' value='{0}'>", 175);
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_ALL' value='{0}'>", "10.447200000");
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_BANK' value='{0}'>", "0");*/

        string[] blocks = postData.Split('&');
        foreach (string block in blocks)
        {
            string[] vals = block.Split('=');
            sb.AppendFormat("<input type='hidden' name='{0}' value='{1}'>", vals[0], vals[1]);
        }

        sb.Append("</form>");
        sb.Append("</body>");
        sb.Append("</html>");
        Response.Write(sb.ToString());
        Response.End();

        //Nazn=&SumC=1.01&reqv_SUM_COM_BANK=3.00&reqv_SUM_COM_ALL=3.01&TransactionId=175&WalletId=21884487517107&Signature=02000000B479CD0FC7A7A433BF42B542000000000000000003E3C2B3F62CD9286B1FD618EAF8C4483BDACC5BD2FA413DA0AA45EE1397EB252ABE42D85E400215534136CA8E9839AF802CBDFD534B5F2C7C475DDFCE87B0809F30&SignKeyId=289YID00
    }
    protected void btReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.QueryString["HomeURL"]);
    }
}

