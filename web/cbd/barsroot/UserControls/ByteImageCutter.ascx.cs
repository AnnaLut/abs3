using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.ComponentModel;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.UserControls
{
    public partial class ByteImageCutter : System.Web.UI.UserControl
    {
        # region Константы
        private const String SessionIDKey = "IMAGE_DATA_SESSION_ID";
        public String SessionIDPattern = "IMAGE_DATA_{0}";

        public String InitScriptPattern = "InitByteImage('{0}', '{1}', '{2}', '{3}'); ";
        # endregion

        # region Приватные свойства
        /// <summary>
        /// Идентификатор данных в сессии
        /// </summary>
        [Category("Data")]
        private String ImageDataSessionID
        {
            get
            {
                if (this.ViewState[SessionIDKey] == null)
                {
                    this.ViewState[SessionIDKey] = String.Format(SessionIDPattern, Guid.NewGuid());
                }

                return (String)this.ViewState[SessionIDKey];
            }
        }
        # endregion

        # region Публичные свойства
        /// <summary>
        /// Gets or sets the width of the Web server control.
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(typeof(Unit), "")]
        public Unit Width
        {
            get
            {
                if (this.ViewState["IMAGE_WIDTH"] == null)
                    this.ViewState["IMAGE_WIDTH"] = new Unit(200);
                
                return (Unit)this.ViewState["IMAGE_WIDTH"];
            }
            set
            {
                this.ViewState["IMAGE_WIDTH"] = value;
            }
        }
        /// <summary>
        /// Gets or sets the height of the Web server control.
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(typeof(Unit), "")]
        public Unit Height
        {
            get
            {
                if (this.ViewState["IMAGE_HEIGHT"] == null)
                    this.ViewState["IMAGE_HEIGHT"] = new Unit(200);
                
                return (Unit)this.ViewState["IMAGE_HEIGHT"];
            }
            set
            {
                this.ViewState["IMAGE_HEIGHT"] = value;
            }
        }

        /// <summary>
        /// Побайтовое представление картинки
        /// </summary>
        [Category("Data")]
        [Bindable(BindableSupport.Yes, BindingDirection.OneWay)]
        public Byte[] Value
        {
            get
            {
                if (this.Session[this.ImageDataSessionID] == null) return null;

                ByteData bd = (ByteData)this.Session[this.ImageDataSessionID];
                return bd.Data;
            }
            set
            {
                if (value == null) { return; }

                if (this.Session[ImageDataSessionID] != null)
                {
                    (this.Session[ImageDataSessionID] as ByteData).Dispose();
                    this.Session[ImageDataSessionID] = null;
                }

                this.Session[ImageDataSessionID] = new ByteData(value);
            }
        }
        /// <summary>
        /// Есть ли данные картинки
        /// </summary>
        [Category("Data")]
        public Boolean HasValue
        {
            get
            {
                return !(this.Value == null);
            }
        }
        /// <summary>
        /// Клиентский идентификатор базового контрола
        /// </summary>
        [Category("Data")]
        [Browsable(false)]
        public String BaseClientID
        {
            get
            {
                return String.Format("{0}_obj", this.ClientID);
            }
        }
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected override void OnPreRender(EventArgs e)
        {
            // формируем объект cxImage на странице
            String ObjectPattern = "<object classid=\"clsid:5220cb21-c88d-11cf-b347-00aa00a28331\"><param name=\"LPKPath\" value=\"csximage.lpk\"></object><object id=\"{0}\" classid=\"clsid:62E57FC5-1CCD-11D7-8344-00C1261173F0\" codebase=\"csximage.cab\" width=\"{1}\" height=\"{2}\" sid=\"{3}\" pcount_id=\"{4}\" prev_id='{5}' next_id='{6}' dwnldUrl='null'></object>";
            ph.InnerHtml = String.Format(ObjectPattern, this.BaseClientID, this.Width, this.Height, this.ImageDataSessionID, lbPageCount.ClientID, ibPrev.ClientID, ibNext.ClientID);

            // регистрация скриптов
			ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery", "/Common/jquery/jquery.js");
            
            ibPrev.OnClientClick = String.Format("ShowPrevImage('{0}'); return false;", this.BaseClientID);
            ibNext.OnClientClick = String.Format("ShowNextImage('{0}'); return false;", this.BaseClientID);
            ibCrop.OnClientClick = String.Format("Crop('{0}'); return false;", this.BaseClientID);
            ibSave.OnClientClick = String.Format("return SaveClick('{0}');", this.BaseClientID);

            // инициализация
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                ScriptManager.RegisterStartupScript(this, typeof(UserControl), "InitByteImageCutter_Script_" + this.ClientID, String.Format(InitScriptPattern, this.BaseClientID, this.ImageDataSessionID, lbPageCount.ClientID, new ByteData(Value).PageCount), true);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            base.OnPreRender(e);
        }

        public event System.EventHandler DocumentSaved;
        protected void ibSave_Click(object sender, ImageClickEventArgs e)
        {
            if (this.DocumentSaved != null)
                this.DocumentSaved(this, new EventArgs());
        }
        # endregion
    }
}