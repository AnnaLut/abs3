using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using UnityBars.XmlForms.Engine;
using UnityBars.XmlForms.Classes;

public partial class barsweb_dynform : System.Web.UI.Page
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        object form = Request["form"];
        if (form == null) return;
        String cs = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String providerName = "barsroot.core";
        XmlFormBuilder.ModalFormSrc = XmlModalFormSrc.AppRoot;
        holder.Controls.Add(XmlFormBuilder.BuildForm(form.ToString(), Page, cs, XmlFormPlaces.AppData, providerName));
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
