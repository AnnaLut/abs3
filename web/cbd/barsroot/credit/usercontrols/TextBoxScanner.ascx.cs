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
using Bars.Logger;
using Microsoft.Ajax.Utilities;

namespace Bars.UserControls
{
    public partial class TextBoxScanner : System.Web.UI.UserControl
    {
        # region Константы
        private const String SessionIDKey = "IMAGE_DATA_SESSION_ID";
        private const String SessionIDPattern = "IMAGE_DATA_{0}";
        # endregion

        # region Публичные свойства
        /// <summary>
        /// Обязательность заполнения
        /// </summary>
        [Category("Validation")]
        [DefaultValue(false)]
        [Bindable(true, BindingDirection.OneWay)]
        public Boolean IsRequired
        {
            get
            {
                return tb.IsRequired;
            }
            set
            {
                tb.IsRequired = value;
            }
        }

        
        [DefaultValue("")]
        [Category("Data")]
        [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
        public string ImageWidth
        {
            get
            {
                return (ViewState["IMAGECROPWIDTH"] == null ? "0" : (String)ViewState["IMAGECROPWIDTH"]);
            }
            set
            {
                ViewState["IMAGECROPWIDTH"] = value;
            }
        }

        [DefaultValue("")]
        [Category("Data")]
        [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
        public string ImageHeight
        {
            get
            {
                return (ViewState["IMAGECROPHEIGHT"] == null ? "0": (String)ViewState["IMAGECROPHEIGHT"]);
            }
            set
            {
                ViewState["IMAGECROPHEIGHT"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the group of controls for which the System.Web.UI.WebControls.TextBox
        /// control causes validation when it posts back to the server.
        /// </summary>
        [DefaultValue("")]
        public String ValidationGroup
        {
            get
            {
                return tb.ValidationGroup;
            }
            set
            {
                tb.ValidationGroup = value;
            }
        }

        /// <summary>
        /// Идентификатор данных в сессии
        /// </summary>
        [Category("Data")]
        public String ImageDataSessionID
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
        /// <summary>
        /// Байтовое представление загруженого файла
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
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
                if (this.Session[ImageDataSessionID] != null)
                {
                    (this.Session[ImageDataSessionID] as ByteData).Dispose();
                    this.Session[ImageDataSessionID] = null;
                }
                
                this.Session[ImageDataSessionID] = new ByteData(value);
            }
        }
        /// <summary>
        /// Загружен ли файл
        /// </summary>
        [Category("Data")]
        public Boolean HasValue
        {
            get
            {
                return this.Session[this.ImageDataSessionID] != null && ((ByteData)this.Session[this.ImageDataSessionID]).HasData;
            }
        }
        /// <summary>
        /// Предполагаемый идентификатор вопроса
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
        public String SupposedQuestionID
        {
            get
            {
                return (ViewState["SUPPOSEDQUESTIONID"] == null ? String.Empty : (String)ViewState["SUPPOSEDQUESTIONID"]);
            }
            set
            {
                ViewState["SUPPOSEDQUESTIONID"] = value;
            }
        }
        /// <summary>
        /// Рабочее пространство
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
        public String WS_ID
        {
            get
            {
                return (ViewState["WS_ID"] == null ? String.Empty : (String)ViewState["WS_ID"]);
            }
            set
            {
                ViewState["WS_ID"] = value;
            }
        }
        /// <summary>
        /// Номер рабочего пространства
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        [Bindable(BindableSupport.Yes, BindingDirection.TwoWay)]
        public Decimal? WS_NUM
        {
            get
            {
                return (ViewState["WS_NUM"] == null ? (Decimal?)null : (Decimal?)ViewState["WS_NUM"]);
            }
            set
            {
                ViewState["WS_NUM"] = value;
            }
        }

        /// <summary>
        /// Только чтение
        /// </summary>
        [Category("Appearance")]
        public Boolean ReadOnly
        {
            get
            {
                return !ibScan.Enabled;
            }
            set
            {
                ibScan.Enabled = !value;
            }
        }
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected override void OnPreRender(EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(UserControl), "InitScan_Block", 
@"function ScanerViewClick(sid) {
    var DialogOptions = 'width=600, height=620, toolbar=no, location=no, directories=no, menubar=no, scrollbars=yes, resizable=yes, status=no';
    var result = window.open('/barsroot/credit/usercontrols/dialogs/byteimage_show.aspx?sid=' + sid + '&rnd=' + Math.random(), 'view_window', DialogOptions);
} 
function ScanerShow(sid)
{
    var DialogOptions = 'dialogHeight:650px; dialogWidth:824px; scroll: no';
    var rnd = Math.random();

    var result = window.showModalDialog('/barsroot/credit/usercontrols/dialogs/textboxscanner_scan.aspx?sid=' + sid + '&imageHeight=" + ImageHeight + @"&ImageWidth=" + ImageWidth + @"&rnd=' + rnd, window, DialogOptions);    

    //var result = window.open('/barsroot/credit/usercontrols/dialogs/textboxscanner_scan.aspx?sid=' + sid + '&rnd=' + rnd, 'window');    

    if (result == null) return false;
    return true;
}", true);

            // кнопка просмотра
            ibView.Visible = this.HasValue;
            ibView.OnClientClick = String.Format("ScanerViewClick('{0}'); return false;", this.ImageDataSessionID);

            // устанавливаем идентификатор
            ibScan.OnClientClick = String.Format("return ScanerShow('{0}');", this.ImageDataSessionID);

            // текст контрола
            tb.Value = (this.HasValue ? Resources.credit.StringConstants.text_loaded : String.Empty);

            base.OnPreRender(e);
        }

        public event System.EventHandler DocumentScaned;
        protected void ibScan_Click(object sender, ImageClickEventArgs e)
        {
            if (this.DocumentScaned != null)
                this.DocumentScaned(this, new EventArgs());
        }
        # endregion
    }
}