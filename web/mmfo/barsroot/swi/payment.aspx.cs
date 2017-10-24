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

    private void doPostRedirect(string swiCode, string postData)
    {
        Response.Clear();
        StringBuilder sb = new StringBuilder();
        sb.Append("<html>");
        sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
        sb.AppendFormat("<form name='form' action='{0}' method='post'>", Request.QueryString["BackURL"] + "?swi=" + swiCode);
        string[] blocks = postData.Split('&');
        foreach (string block in blocks)
        {
            string[] vals = block.Split('=');
            sb.AppendFormat("<input type='hidden' name='{0}' value='{1}'>", vals[0], System.Web.HttpUtility.UrlDecode(vals[1]));
        }
        sb.Append("</form>");
        sb.Append("</body>");
        sb.Append("</html>");
        Response.Write(sb.ToString());
        Response.End();
    }

    protected void btReturnData_Click(object sender, EventArgs e)
    {
        string postData = "Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%BA%D0%BE%D1%88%D1%82%D1%96%D0%B2+%D0%BD%D0%B0+%D0%B3%D0%B0%D0%BC%D0%B0%D0%BD%D0%B5%D1%86%D1%8C+%D0%93%D0%BB%D0%BE%D0%B1%D0%B0%D0%BB%D0%9C%D0%B0%D0%BD%D1%96+oschad.bars@test.com&SumC=15.08&reqv_SUM_COM_BANK=3.00&reqv_SUM_COM_ALL=3.08&TransactionId=178&WalletId=21884487517107&Signature=02000000B479CD0F82EFA833BF42B5420000000000000000A2BC3C4D060A9337B289F310F468D716A7EBFBC4D47B2E0EEA29142F3F25AF76CD4EBC9E7941E39B0B28D2709F155BF620A908D2B71B3A1AFBD5BA2595FD3B4E87E7&SignKeyId=28GM0101";
        string swiCode = "gm5";
        int test_num = 0;
        // test data 
        
        // Global Money
        if (test_num == 0)
        {
            postData = "Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%BA%D0%BE%D1%88%D1%82%D1%96%D0%B2+%D0%BD%D0%B0+%D0%B3%D0%B0%D0%BC%D0%B0%D0%BD%D0%B5%D1%86%D1%8C+%D0%93%D0%BB%D0%BE%D0%B1%D0%B0%D0%BB%D0%9C%D0%B0%D0%BD%D1%96+oschad.bars@test.com&SumC=15.08&reqv_SUM_COM_BANK=3.00&reqv_SUM_COM_ALL=3.08&TransactionId=177&WalletId=21884487517107&Signature=02000000B479CD0F82EFA833BF42B5420000000000000000A2BC3C4D060A9337B289F310F468D716A7EBFBC4D47B2E0EEA29142F3F25AF76CD4EBC9E7941E39B0B28D2709F155BF620A908D2B71B3A1AFBD5BA2595FD3B4E87E7&SignKeyId=28GM0101";
            swiCode = "gm5";
        }
        else if (test_num == 1)
        {
            postData = "SumC=1000.0000&Kv_A=643&Kv_B=643&reqv_SUM_COM_ALL=7.656900000&reqv_SUM_COM_BANK=3.062760000&Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%B3%D0%BE%D1%82%D1%96%D0%B2%D0%BA%D0%B8&reqv_FIO=%D0%A0%D0%AF%D0%91%D0%98%D0%9D%D0%98%D0%9D%D0%90+%D0%95%D0%9B%D0%95%D0%9D%D0%90+%D0%9D%D0%98%D0%9A%D0%9E%D0%9B%D0%90%D0%95%D0%92%D0%9D%D0%90&reqv_NAMED=%D0%9F%D0%90%D0%A1%D0%9F%D0%9E%D0%A0%D0%A2&reqv_PASPN=CK+500200&reqv_ATRT=%D0%A1%D0%9E%D0%9B%D0%9E%D0%9C%D0%95%D0%9D%D0%A1%D0%9A%D0%98%D0%9C+%D0%A0%D0%A3+%D0%93%D0%A3+%D0%9C%D0%92%D0%94+%D0%A3%D0%9A%D0%A0%D0%90%D0%98%D0%9D%D0%AB+%D0%92+%D0%93.%D0%9A%D0%98%D0%95%D0%92%D0%95&reqv_REZID=1&reqv_PASP2=30%2F03%2F2000&reqv_DATN=25%2F03%2F1970&reqv_ADRS=%D0%A3%D0%BA%D1%80%D0%B0%D0%B8%D0%BD%D0%B0%2C+%D0%9A%D0%98%D0%95%D0%92%2C+%D0%A3%D0%9B.%D0%A1%D0%9C%D0%95%D0%9B%D0%AF%D0%9D%D0%A1%D0%9A%D0%90%D0%AF%2C+8%2C+%D0%94%D0%9E%D0%9C+8&reqv_D6%2370=643&reqv_FIO2=%D0%9A%D0%9E%D0%92%D0%90%D0%9B%D0%95%D0%92%D0%A1%D0%9A%D0%90%D0%AF+%D0%A2%D0%90%D0%A2%D0%AC%D0%AF%D0%9D%D0%90+%D0%98%D0%93%D0%9E%D0%A0%D0%95%D0%92%D0%9D%D0%90";
            swiCode = "mi1";
        }
        else if (test_num == 2)
        {

        }
        else if (test_num == 3)
        {

        }

        //Response.Redirect(Request.QueryString["ReturnUrl"] + "&SumC=" + tbSum.Text + "&Nazn=" + tbNazn.Text + "&reqv_FIO=" + tbReqvFIO.Text);
        Response.Clear();
        StringBuilder sb = new StringBuilder();
        sb.Append("<html>");
        sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
        sb.AppendFormat("<form name='form' action='{0}' method='post'>", Request.QueryString["BackURL"] + "?swi=cn1");
        sb.AppendFormat("<input type='hidden' name='SumC' value='{0}'>", "100");
        sb.AppendFormat("<input type='hidden' name='Nazn' value='{0}'>", tbNazn.Text);
        sb.AppendFormat("<input type='hidden' name='reqv_FIO' value='{0}'>", tbReqvFIO.Text);
        sb.AppendFormat("<input type='hidden' name='reqv_FIO2' value='{0}'>", "Пупкін");
        sb.AppendFormat("<input type='hidden' name='Kv_A' value='{0}'>", 840);
        sb.AppendFormat("<input type='hidden' name='Kv_B' value='{0}'>", 840);
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_ALL' value='{0}'>", "3.01");
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_BANK' value='{0}'>", "3.00");
        sb.AppendFormat("<input type='hidden' name='Nazn' value='{0}'>", "%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%BA%D0%BE%D1%88%D1%82%D1%96%D0%B2+%D0%BD%D0%B0+%D0%B3%D0%B0%D0%BC%D0%B0%D0%BD%D0%B5%D1%86%D1%8C+%D0%93%D0%BB%D0%BE%D0%B1%D0%B0%D0%BB%D0%9C%D0%B0%D0%BD%D1%96+oschad.bars@test.com");
        sb.AppendFormat("<input type='hidden' name='Signature' value='{0}'>", "02000000B479CD0FC7A7A433BF42B542000000000000000003E3C2B3F62CD9286B1FD618EAF8C4483BDACC5BD2FA413DA0AA45EE1397EB252ABE42D85E400215534136CA8E9839AF802CBDFD534B5F2C7C475DDFCE87B0809F30");
        sb.AppendFormat("<input type='hidden' name='SignKeyId' value='{0}'>", "289YID00");
        sb.AppendFormat("<input type='hidden' name='WalletId' value='{0}'>", "21884487517107");
        sb.AppendFormat("<input type='hidden' name='TransactionId' value='{0}'>", 175);
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_ALL' value='{0}'>", "10.447200000");
        sb.AppendFormat("<input type='hidden' name='reqv_SUM_COM_BANK' value='{0}'>", "0");

        /*string[] blocks = postData.Split('&');
        foreach (string block in blocks)
        {
            string[] vals = block.Split('=');
            sb.AppendFormat("<input type='hidden' name='{0}' value='{1}'>", vals[0], vals[1]);
        }*/

        sb.Append("</form>");
        sb.Append("</body>");
        sb.Append("</html>");
        Response.Write(sb.ToString());
        Response.End();
    }
    protected void btReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.QueryString["HomeURL"]);
    }
    protected void btGM_Click(object sender, EventArgs e)
    {
        doPostRedirect("gm5", "Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%BA%D0%BE%D1%88%D1%82%D1%96%D0%B2+%D0%BD%D0%B0+%D0%B3%D0%B0%D0%BC%D0%B0%D0%BD%D0%B5%D1%86%D1%8C+%D0%93%D0%BB%D0%BE%D0%B1%D0%B0%D0%BB%D0%9C%D0%B0%D0%BD%D1%96+oschad.bars@test.com&SumC=15.08&reqv_SUM_COM_BANK=3.00&reqv_SUM_COM_ALL=3.08&TransactionId=178&WalletId=21884487517107&Signature=02000000B479CD0F82EFA833BF42B5420000000000000000A2BC3C4D060A9337B289F310F468D716A7EBFBC4D47B2E0EEA29142F3F25AF76CD4EBC9E7941E39B0B28D2709F155BF620A908D2B71B3A1AFBD5BA2595FD3B4E87E7&SignKeyId=28GM0101");
    }
    protected void btProfix1_Click(object sender, EventArgs e)
    {
        doPostRedirect("mi1", "SumC=1000.0000&Kv_A=643&Kv_B=643&reqv_SUM_COM_ALL=7.656900000&reqv_SUM_COM_BANK=3.062760000&Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%B3%D0%BE%D1%82%D1%96%D0%B2%D0%BA%D0%B8&reqv_FIO=%D0%A0%D0%AF%D0%91%D0%98%D0%9D%D0%98%D0%9D%D0%90+%D0%95%D0%9B%D0%95%D0%9D%D0%90+%D0%9D%D0%98%D0%9A%D0%9E%D0%9B%D0%90%D0%95%D0%92%D0%9D%D0%90&reqv_NAMED=%D0%9F%D0%90%D0%A1%D0%9F%D0%9E%D0%A0%D0%A2&reqv_PASPN=CK+500200&reqv_ATRT=%D0%A1%D0%9E%D0%9B%D0%9E%D0%9C%D0%95%D0%9D%D0%A1%D0%9A%D0%98%D0%9C+%D0%A0%D0%A3+%D0%93%D0%A3+%D0%9C%D0%92%D0%94+%D0%A3%D0%9A%D0%A0%D0%90%D0%98%D0%9D%D0%AB+%D0%92+%D0%93.%D0%9A%D0%98%D0%95%D0%92%D0%95&reqv_REZID=1&reqv_PASP2=30%2F03%2F2000&reqv_DATN=25%2F03%2F1970&reqv_ADRS=%D0%A3%D0%BA%D1%80%D0%B0%D0%B8%D0%BD%D0%B0%2C+%D0%9A%D0%98%D0%95%D0%92%2C+%D0%A3%D0%9B.%D0%A1%D0%9C%D0%95%D0%9B%D0%AF%D0%9D%D0%A1%D0%9A%D0%90%D0%AF%2C+8%2C+%D0%94%D0%9E%D0%9C+8&reqv_D6%2370=643&reqv_FIO2=%D0%9A%D0%9E%D0%92%D0%90%D0%9B%D0%95%D0%92%D0%A1%D0%9A%D0%90%D0%AF+%D0%A2%D0%90%D0%A2%D0%AC%D0%AF%D0%9D%D0%90+%D0%98%D0%93%D0%9E%D0%A0%D0%95%D0%92%D0%9D%D0%90");
    }
    protected void btProfix2_Click(object sender, EventArgs e)
    {
        doPostRedirect("bz2", "SumC=20.0000&Kv_A=840&Kv_B=840&reqv_SUM_COM_ALL=15.98600000&reqv_SUM_COM_BANK=6.39440000&Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%B3%D0%BE%D1%82%D1%96%D0%B2%D0%BA%D0%B8&reqv_FIO=%D0%98%D0%92%D0%A7%D0%A3%D0%9A+%D0%9D%D0%90%D0%A2%D0%90%D0%9B%D0%98%D0%AF&reqv_NAMED=%D0%9D%D0%90%D0%A6%D0%98%D0%9E%D0%9D.+%D0%9F%D0%90%D0%A1%D0%9F%D0%9E%D0%A0%D0%A2&reqv_PASPN=%D0%A1%D0%9D+269875&reqv_ATRT=%D0%A0%D0%A3%D0%93%D0%A3%D0%9C%D0%92%D0%94&reqv_REZID=1&reqv_PASP2=25%2F06%2F2000&reqv_DATN=25%2F06%2F1975&reqv_ADRS=%D0%A3%D0%BA%D1%80%D0%B0%D0%B8%D0%BD%D0%B0%2C+%D0%9A%D0%98%D0%95%D0%92%2C+%D0%9C%D0%98%D0%A0%D0%90%2C+25%2C+%D0%BA%D0%B2.+36&reqv_D6%2370=643&reqv_FIO2=%D0%98%D0%92%D0%A7%D0%A3%D0%9A+%D0%9D%D0%90%D0%A2%D0%90%D0%9B%D0%98%D0%AF");
    }
    protected void btProfix3_Click(object sender, EventArgs e)
    {
        doPostRedirect("up3", "SumC=5000&Kv_A=643&Kv_B=643&reqv_SUM_COM_ALL=0&reqv_SUM_COM_BANK=0&Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%B3%D0%BE%D1%82%D1%96%D0%B2%D0%BA%D0%B8&reqv_FIO=%D0%A0%D0%AF%D0%91%D0%98%D0%9D%D0%98%D0%9D%D0%90+%D0%95%D0%9B%D0%95%D0%9D%D0%90+%D0%9D%D0%98%D0%9A%D0%9E%D0%9B%D0%90%D0%95%D0%92%D0%9D%D0%90&reqv_NAMED=%D0%9F%D0%90%D0%A1%D0%9F%D0%9E%D0%A0%D0%A2&reqv_PASPN=%D0%A1%D0%9A+500200&reqv_ATRT=%D0%A1%D0%9E%D0%9B%D0%9E%D0%9C%D0%95%D0%9D%D0%A1%D0%9A%D0%98%D0%9C+%D0%A0%D0%A3+%D0%93%D0%A3+%D0%9C%D0%92%D0%94+%D0%A3%D0%9A%D0%A0%D0%90%D0%98%D0%9D%D0%AB+%D0%92+%D0%93.%D0%9A%D0%98%D0%95%D0%92%D0%95&reqv_REZID=1&reqv_PASP2=30%2F03%2F2000&reqv_DATN=25%2F03%2F1970&reqv_ADRS=%D0%A3%D0%BA%D1%80%D0%B0%D0%B8%D0%BD%D0%B0%2C+%D0%9A%D0%98%D0%95%D0%92%2C+%D0%A3%D0%9B.%D0%A1%D0%9C%D0%95%D0%9B%D0%AF%D0%9D%D0%A1%D0%9A%D0%90%D0%AF%2C+8%2C+%D0%94%D0%9E%D0%9C+8&reqv_D6%2370=498&reqv_FIO2=%D0%9A%D0%BE%D0%B2%D0%B0%D0%BB%D0%B5%D0%B2%D1%81%D0%BA%D0%B0%D1%8F+%D0%A2%D0%B0%D1%82%D1%8C%D1%8F%D0%BD%D0%B0+%D0%98%D0%B3%D0%BE%D1%80%D0%B5%D0%B2%D0%BD%D0%B0");
    }
    protected void btProfix4_Click(object sender, EventArgs e)
    {
        doPostRedirect("cn4", "SumC=2000.0000&Kv_A=643&Kv_B=643&reqv_SUM_COM_ALL=10.209200000&reqv_SUM_COM_BANK=3.420082000&Nazn=%D0%9F%D0%B5%D1%80%D0%B5%D0%BA%D0%B0%D0%B7+%D0%B3%D0%BE%D1%82%D1%96%D0%B2%D0%BA%D0%B8&reqv_FIO=%D0%98%D0%92%D0%90%D0%9D%D0%9E%D0%92+%D0%98%D0%92%D0%90%D0%9D+%D0%98%D0%92%D0%90%D0%9D%D0%9E%D0%92%D0%98%D0%A7&reqv_NAMED=%D0%9F%D0%90%D0%A1%D0%9F%D0%9E%D0%A0%D0%A2&reqv_PASPN=MR+221055&reqv_ATRT=%D0%A0%D0%9E%D0%A1%D0%A1%D0%98%D0%99%D0%A1%D0%9A%D0%9E%D0%99+%D0%A4%D0%95%D0%94%D0%95%D0%A0%D0%90%D0%A6%D0%98%D0%95%D0%99&reqv_REZID=1&reqv_PASP2=01%2F05%2F2000&reqv_DATN=01%2F01%2F1970&reqv_ADRS=%D0%A3%D0%BA%D1%80%D0%B0%D0%B8%D0%BD%D0%B0%2C+123654%2C+%D0%9E%D0%A5%D0%A9%D0%97%D0%AA%D0%A5%2C+%D0%A3%D0%9B.+%D0%A7%D0%90%D0%9F%D0%90%D0%95%D0%92%D0%90%2C+1+1+1+1++1&reqv_D6%2370=643&reqv_FIO2=%D0%9F%D0%95%D0%A2%D0%A0%D0%9E%D0%92+%D0%9F%D0%95%D0%A2%D0%A0");
    }
}

