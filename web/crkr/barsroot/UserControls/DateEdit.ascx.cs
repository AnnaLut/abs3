using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UnityBars.WebControls;

using System.ComponentModel;
using AjaxControlToolkit;

public partial class controls_DateEdit : System.Web.UI.UserControl
{
    public bool Required
    {
        get { return dateValidator.Enabled; }
        set { dateValidator.Enabled = value; }
    }

    public BarsDateInput DateInput { get { return dateInput; } }

    public RequiredFieldValidator rValidator { get { return dateValidator; } }

    public ValidatorCalloutExtender rExtender { get { return dateValidator_ValidatorCalloutExtender; } }

    public String validationMessage { get { return dateValidator.ErrorMessage; } set { dateValidator.ErrorMessage = value; } }

    [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
    public DateTime? SelectedDate
    {
        get
        {
            return DateInput.SelectedDate;
        }
        set
        {
            dateInput.SelectedDate = value;
        }
    }

    public Boolean ReadOnly
    {
        get
        {
            return DateInput.ReadOnly;
        }
        set
        {
            DateInput.ReadOnly = value;
            btnShow.Disabled = value;
        }
    }

    public String validationGroup
    {
        get
        {
            return DateInput.ValidationGroup;
        }
        set
        {
            DateInput.ValidationGroup = value;
        }
    }
    /// <summary>
    /// Изменение значения контрола
    /// </summary>
    public event EventHandler ValueChanged;
    void DateInput_TextChanged(object sender, EventArgs e)
    {
        if (this.ValueChanged != null)
            this.ValueChanged(this, new EventArgs());
    }
    [NotifyParentProperty(true)]
    [Category("Client")]
    [PersistenceMode(PersistenceMode.InnerProperty)]
    [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
    public InputClientEvents ClientEvents
    {
        get { return dateInput.ClientEvents; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {                
        ScriptManager.RegisterClientScriptInclude(this.Page, this.Page.GetType(), "jscal2", "/barsroot/UserControls/script/jscal2.js");
        ScriptManager.RegisterClientScriptInclude(this.Page, this.Page.GetType(), "jscal2_ua", "/barsroot/UserControls/script/jscal2_ua.js");
        /*
        string css = @"<link href=""" + this.ResolveUrl("/barsroot/UserControls/style/jscal2.css") +
                @""" type=""text/css"" rel=""stylesheet"" />";

        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "_calcss"+DateTime.Now.ToString(), css, false);
        */
        // Изменение значения контрола
        if (this.ValueChanged != null)
        {
            DateInput.TextChanged += new EventHandler(DateInput_TextChanged);
            DateInput.AutoPostBack = true;
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        string script = @"
            //<![CDATA[
                if (document.getElementById('" + dateInput.ClientID + @"') != null 
                    && document.getElementById('" + btnShow.ClientID + @"'))
                {
                    var cal = Calendar.setup({ animation: false,
                    onSelect: function(cal) {
                        document.getElementById('" + dateInput.ClientID + @"').value = Calendar.intToDate(this.selection.get()).format('yyyy-MM-dd') + '-00-00-00';  cal.hide() 
                        " + OnCalendarSelected + @"
                      } 
                    });
                    cal.manageFields('" + btnShow.ClientID + @"', '" + dateInput.ClientID + "_text" + @"', '%d.%m.%Y');
                }
            //]]>
        ";
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "calendar_" + this.ClientID, script, true);
        base.OnPreRender(e);

        dateInput.Attributes.Add("onchange", ClientTextChanged);
    }
    public string ClientTextChanged { get; set; }
    public string OnCalendarSelected { get; set; }
}