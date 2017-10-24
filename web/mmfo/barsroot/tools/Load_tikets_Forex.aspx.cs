using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class tools_Load_tikets_Forex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        Int64  p_ref = 0;
        Int64  p_deal_tag = 0;
        String p_Temolate ="";

        if (!string.IsNullOrEmpty(Request["p_template"])) p_Temolate = Request["p_template"];
        if (!string.IsNullOrEmpty(Request["p_ref"]))      p_ref = Convert.ToInt64( Request["p_ref"]);
        if (!string.IsNullOrEmpty(Request["p_deal_tag"])) p_deal_tag = Convert.ToInt64(Request["p_deal_tag"]);

        
        FRX_RTD(p_Temolate, p_ref, p_deal_tag);

    }


    private void FRX_RTD(String p_Temolate, Int64 p_ref, Int64 p_deal_tag)
    {

        String TemplateId = p_Temolate + ".frx";
        
        FrxParameters pars = new FrxParameters();
        pars.Add(new FrxParameter("p_ref",      TypeCode.Int64, p_ref));
        pars.Add(new FrxParameter("p_deal_tag", TypeCode.Int64, p_deal_tag));
        



        FrxDoc doc = new FrxDoc(
            FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateId)) + TemplateId,
                  pars,
                this.Page);

        doc.Print(FrxExportTypes.Rtf);

         
    }

}