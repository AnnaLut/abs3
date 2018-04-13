using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_EADocsView : System.Web.UI.UserControl
{
    # region Публичные свойства
    /// <summary>
    /// Текст заголовка
    /// </summary>
    public String TitleText
    {
        get
        {
            return btn.Text;
        }
        set
        {
            btn.Text = value;
        }
    }
    /// <summary>
    /// Отображать в модальном режиме
    /// </summary>
    public Boolean Modal
    {
        get
        {
            if (ViewState["Modal"] == null)
                ViewState["Modal"] = false;

            return (Boolean)ViewState["Modal"];
        }
        set
        {
            ViewState["Modal"] = value;
        }
    }
    /// <summary>
    /// Код структуры документа
    /// </summary>
    public Int32? EAStructID
    {
        get
        {
            return (Int32?)ViewState["EAStructID"];
        }
        set
        {
            ViewState["EAStructID"] = value;
        }
    }
    /// <summary>
    /// РНК клиента
    /// </summary>
    public Int64? RNK
    {
        get
        {
            return (Int64?)ViewState["RNK"];
        }
        set
        {
            ViewState["RNK"] = value;
        }
    }
    /// <summary>
    /// Ид. сделки
    /// </summary>
    public Int64? AgrID
    {
        get
        {
            return (Int64?)ViewState["AgrID"];
        }
        set
        {
            ViewState["AgrID"] = value;
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
    }
    protected void btn_Click(object sender, EventArgs e)
    {
        if (this.DocsViewed != null)
        {
            this.DocsViewed(this, new EventArgs());
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        btn.OnClientClick = String.Format("return EADocsView_ShowDialog('{0}', '{1}', '{2}', {3}); ", this.EAStructID, this.RNK, this.AgrID, this.Modal ? "true" : "false");
        base.OnPreRender(e);
    }

    public event EventHandler DocsViewed;
    # endregion
}