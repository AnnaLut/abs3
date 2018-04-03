using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.ComponentModel;
using credit;
using ibank.core;

public partial class credit_usercontrols_MACListEditor : System.Web.UI.UserControl
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
        if (!IsPostBack)
            lb.DataBind();
    }
    protected void ibNew_Click(object sender, ImageClickEventArgs e)
    {
        lb.SelectedIndex = -1;

        ORDLabel.Text = (String)null;
        TEXTTextBox.Value = (String)null;
        
        TEXTTextBox.Focus();
    }
    protected void idDelete_Click(object sender, ImageClickEventArgs e)
    {
        if (lb.SelectedIndex != -1)
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.MAC_LIST_ITEM_DEL(MAC_ID, Convert.ToDecimal(lb.SelectedItem.Value));

            lb.DataBind();
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        int Idx = lb.SelectedIndex;
        if (Idx != -1)
        {
            // обновляем
            WcsPack wp = new WcsPack(new BbConnection());
            wp.MAC_LIST_ITEM_SET(MAC_ID, Convert.ToDecimal(lb.SelectedItem.Value), TEXTTextBox.Value);

            lb.DataBind();
            lb.SelectedIndex = Idx;
            lb_DataBound(lb, null);
        }
        else
        {
            // создаем
            WcsPack wp = new WcsPack(new BbConnection());
            wp.MAC_LIST_ITEM_SET(MAC_ID, (Decimal?)null, TEXTTextBox.Value);

            lb.DataBind();
            lb.SelectedIndex = lb.Items.Count-1;
            lb_DataBound(lb, null);
        }
    }
    protected void ibUp_Click(object sender, ImageClickEventArgs e)
    {
        int Idx = lb.SelectedIndex;
        if (Idx != -1 && Idx != 0)
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.MAC_LIST_ITEM_MOVE(MAC_ID, Convert.ToDecimal(lb.Items[lb.SelectedIndex].Value), Convert.ToDecimal(lb.Items[lb.SelectedIndex - 1].Value));

            lb.DataBind();
            lb.SelectedIndex = Idx - 1;
            lb_DataBound(sender, null);
        }
    }
    protected void ibDown_Click(object sender, ImageClickEventArgs e)
    {
        int Idx = lb.SelectedIndex;
        if (Idx != -1 && Idx != lb.Items.Count - 1)
        {
            WcsPack wp = new WcsPack(new BbConnection());
            wp.MAC_LIST_ITEM_MOVE(MAC_ID, Convert.ToDecimal(lb.Items[lb.SelectedIndex].Value), Convert.ToDecimal(lb.Items[lb.SelectedIndex + 1].Value));

            lb.DataBind();
            lb.SelectedIndex = Idx + 1;
            lb_DataBound(sender, null);
        }
    }
    protected void lb_DataBound(object sender, EventArgs e)
    {
        if (lb.Items.Count > 0 && lb.SelectedIndex == -1)
            lb.SelectedIndex = 0;

        if (lb.SelectedIndex != -1)
        {
            ORDLabel.Text = lb.SelectedItem.Value;
            TEXTTextBox.Value = lb.SelectedItem.Text;
        }
        else
        {
            ORDLabel.Text = (String)null;
            TEXTTextBox.Value = (String)null;
        }
    }
    protected void lb_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_DataBound(null, null);
    }
    protected void ods_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["MAC_ID"] = MAC_ID;
    }
    # endregion
}