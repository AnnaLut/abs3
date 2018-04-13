using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.UserControls
{
    public class ClientIdentifiedEventArgs : EventArgs
    {
        public string MFO { get; set; }
        public Int64 RNK { get; set; }
    }

    public partial class UserControls_BPKIdentification : System.Web.UI.UserControl
    {
        # region Константы
        # endregion

        # region Приватные свойства
        # endregion

        # region Публичные свойства
        public string Text
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
        public bool Enabled
        {
            get
            {
                return btn.Enabled;
            }
            set
            {
                btn.Enabled = value;
            }
        }
        public short TabIndex
        {
            get
            {
                return btn.TabIndex;
            }
            set
            {
                btn.TabIndex = value;
            }
        }
        public string ToolTip
        {
            get
            {
                return btn.ToolTip;
            }
            set
            {
                btn.ToolTip = value;
            }
        }
        public Unit Width
        {
            get
            {
                return btn.Width;
            }
            set
            {
                btn.Width = value;
            }
        }

        public String BeforeIdentifyJS
        {
            get
            {
                return (String)ViewState["BeforeIdentifyJS"];
            }
            set
            {
                ViewState["BeforeIdentifyJS"] = value;
            }
        }
        public String ClientIdentifiedJS
        {
            get
            {
                return (String)ViewState["ClientIdentifiedJS"];
            }
            set
            {
                ViewState["ClientIdentifiedJS"] = value;
            }
        }

        public Boolean IsIdentified
        {
            get
            {
                return !String.IsNullOrEmpty(hResult.Value);
            }
        }
        public String MFO
        {
            get
            {
                return IsIdentified ? hResult.Value.Split(';')[0] : (String)null;
            }
        }
        public Int64? RNK
        {
            get
            {
                return IsIdentified ? Convert.ToInt64(hResult.Value.Split(';')[1]) : (Int64?)null;
            }
        }
        # endregion

        # region События
        public delegate void ClientIdentifiedEventHandler(object sender, ClientIdentifiedEventArgs e);
        public event ClientIdentifiedEventHandler ClientIdentified;

        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnOk_Click(object sender, EventArgs e)
        {
            if (this.ClientIdentified != null)
            {
                ClientIdentifiedEventArgs args = new ClientIdentifiedEventArgs();

                if (this.IsIdentified)
                {
                    args.MFO = this.MFO;
                    args.RNK = this.RNK.Value;
                }

                this.ClientIdentified(this, args);
            }
        }
        protected override void OnPreRender(EventArgs e)
        {
            // регистрируем веб-сервис
            Boolean HasService = false;
	    if (ScriptManager.GetCurrent(this.Page) != null)
	    {
	            for (Int32 i = 0; i < ScriptManager.GetCurrent(this.Page).Services.Count; i++)
        	        if (ScriptManager.GetCurrent(this.Page).Services[i].Path == "/barsroot/UserControls/webservices/BPKIdentification.asmx")
                	{
	                    HasService = true;
        	            break;
                	}
	            if (!HasService)
        	        ScriptManager.GetCurrent(this.Page).Services.Add(new ServiceReference("/barsroot/UserControls/webservices/BPKIdentification.asmx"));
	    }

            // регистрируем CSS
            System.Web.UI.HtmlControls.HtmlLink link = new System.Web.UI.HtmlControls.HtmlLink();
            link.Href = "/Common/CSS/jquery/jquery.css";
            link.Attributes.Add("rel", "stylesheet");
            link.Attributes.Add("type", "text/css");
            this.Page.Header.Controls.Add(link);

            // регистрируем скрипты
            ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery", "/Common/jquery/jquery.js");
            ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery-ui", "/Common/jquery/jquery-ui.js");
            ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "BPKIdentification", "/barsroot/usercontrols/script/BPKIdentification.js");

            ScriptManager.RegisterStartupScript(this, this.GetType(), "init_clientIDs", String.Format("hResultClientID = '{0}'; ", hResult.ClientID), true);

            // регистрируем JS события
            btn.OnClientClick = String.Format("{0} IdentClient(); return false;", !String.IsNullOrEmpty(BeforeIdentifyJS) ? BeforeIdentifyJS : String.Empty);

            if (!String.IsNullOrEmpty(ClientIdentifiedJS))
                btnOk.OnClientClick = ClientIdentifiedJS;

            base.OnPreRender(e);
        }
        # endregion
    }
}