using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.ComponentModel;
using credit;
using ibank.core;

public partial class credit_usercontrols_MACReferEditor : System.Web.UI.UserControl
{
    # region Публичные свойства
    [Bindable(true, BindingDirection.OneWay)]
    public String MAC_ID
    {
        get
        {
            return (String)ViewState["MAC_ID"];
        }
        set
        {
            ViewState["MAC_ID"] = value;
        }
    }
    # endregion

    # region Методы
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        WcsPack wp = new WcsPack(new BbConnection());
        wp.MAC_REFER_PARAM_SET(MAC_ID, tbTAB_ID.Value, tbKEY_FIELD.Value, tbSEMANTIC_FIELD.Value, tbSHOW_FIELDS.Value, tbWHERE_CLAUSE.Value);
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        List<WcsMacReferParamsRecord> lst = (new WcsMacReferParams()).Select(MAC_ID);
        if (lst.Count > 0)
        {
            WcsMacReferParamsRecord rec = lst[0];

            tbTAB_ID.Value = rec.TAB_ID;
            tbKEY_FIELD.Value = rec.KEY_FIELD;
            tbSEMANTIC_FIELD.Value = rec.SEMANTIC_FIELD;
            tbSHOW_FIELDS.Value = rec.SHOW_FIELDS;
            tbWHERE_CLAUSE.Value = rec.WHERE_CLAUSE;
        }
    }
    # endregion
}