using System;
using System.Web;
using Bars.Requests;
using BarsWeb.Core.Logger;

public partial class deposit_DptClientTerminate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Session != null)
        {
            if (Session["AccessRights"] != null)
            {
                Int64 cust_id = (Session["AccessRights"] as ClientAccessRights).Cust_ID;

                if (cust_id > 0)
                {
                    DepositRequest.Close(cust_id, 1);

                    DbLoggerConstruct.NewDbLogger().Info("Користувач завершив роботу з клієнтом РНК=" + Convert.ToString(cust_id), "deposit");
                }
            }
            
            Session.Remove("OnBeneficiary");
            Session.Remove("AccessRights");
            Session.Remove("DepositInfo");            

            Response.Write(@"<script>alert('Роботу з клієнтом завершено!'); location.replace('..//barsweb/Welcome.aspx');</script>");
            Response.Flush();
        }

    }
}