using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_ScanIdDocs : System.Web.UI.UserControl
{
    # region Публичные свойства
    public Int64? RNK
    {
        get
        {
            if (this.ViewState["RNK"] == null) this.ViewState["RNK"] = (Int64?)null;
            return (Int64?)this.ViewState["RNK"];
        }
        set
        {
            this.ViewState["RNK"] = value;
        }
    }
    public Boolean Enabled
    {
        get { return btn.Enabled; }
        set { btn.Enabled = value; }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.ScanIdDocsDone != null)
        {
            btn.Click += btn_Click;
        }
    }
    protected void btn_Click(object sender, EventArgs e)
    {
        if (this.ScanIdDocsDone != null)
        {
            this.ScanIdDocsDone(this, new EventArgs());
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        if (this.RNK.HasValue)
            btn.OnClientClick = String.Format("return ShowDialog({0}); ", this.RNK.Value);

        base.OnPreRender(e);
    }

    public event EventHandler ScanIdDocsDone;
    # endregion
}