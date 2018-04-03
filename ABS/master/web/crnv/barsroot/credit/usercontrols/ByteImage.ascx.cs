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

namespace Bars.UserControls
{
    public partial class ByteImage : System.Web.UI.UserControl
    {
        # region Константы
        private const String SessionIDKey = "IMAGE_DATA_SESSION_ID";
        public String SessionIDPattern = "IMAGE_DATA_{0}";
        private const String WidthKey = "IMAGE_WIDTH";
        private const String HeightKey = "IMAGE_HEIGHT";
        private const String ShowViewKey = "SHOW_ZOOM";
        private const String ShowLabelKey = "SHOW_LABEL";

        private const Int16 DefaultWidth = 200;
        private const Int16 DefaultHeight = 200;

        public String InitScriptPattern = "InitByteImage('{0}', '{1}', '{2}', '{3}', '{4}'); ";
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
                if (this.ViewState[WidthKey] == null)
                    return new Unit(DefaultWidth);
                else
                    return (Unit)this.ViewState[WidthKey];
            }
            set
            {
                this.ViewState[WidthKey] = value;
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
                if (this.ViewState[HeightKey] == null)
                    return new Unit(DefaultHeight);
                else
                    return (Unit)this.ViewState[HeightKey];
            }
            set
            {
                this.ViewState[HeightKey] = value;
            }
        }
        /// <summary>
        /// Отображать или нет кнопку зума
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(true)]
        public Boolean ShowView
        {
            get
            {
                if (this.ViewState[ShowViewKey] == null)
                    return true;
                else
                    return (Boolean)this.ViewState[ShowViewKey];
            }
            set
            {
                this.ViewState[ShowViewKey] = value;
            }
        }
        /// <summary>
        /// Отображать или нет подпись о кол-ве изображений
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(true)]
        public Boolean ShowLabel
        {
            get
            {
                if (this.ViewState[ShowLabelKey] == null)
                    return true;
                else
                    return (Boolean)this.ViewState[ShowLabelKey];
            }
            set
            {
                this.ViewState[ShowLabelKey] = value;
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
        /// <summary>
        /// Клиентский идентификатор контрола заголовка
        /// </summary>
        [Category("Data")]
        [Browsable(false)]
        public String PCountClientID
        {
            get
            {
                return lbPageCount.ClientID;
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
                return (Byte[])this.Session[this.ImageDataSessionID];
            }
            set
            {
                if (this.Session[this.ImageDataSessionID] != null)
                    this.Session.Remove(this.ImageDataSessionID);
                this.Session[this.ImageDataSessionID] = value;
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
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected override void OnPreRender(EventArgs e)
        {
            // формируем объект cxImage на странице
            String ObjectPattern = "<object classid=\"clsid:5220cb21-c88d-11cf-b347-00aa00a28331\"><param name=\"LPKPath\" value=\"csximage.lpk\"></object><object id=\"{0}\" classid=\"clsid:62E57FC5-1CCD-11D7-8344-00C1261173F0\" codebase=\"csximage.cab\" width=\"{1}\" height=\"{2}\" sid='{3}' pcount_id='{4}' prev_id='null' next_id='null' imgcount='0' curimg='0' dwnldUrl='null'></object>";
            ph.InnerHtml = String.Format(ObjectPattern, this.BaseClientID, this.Width, this.Height, this.ImageDataSessionID, lbPageCount.ClientID);

            // блок инициализации
            ScriptManager.RegisterClientScriptBlock(this, typeof(UserControl), "InitByteImage_Block",
@"  
                function InitByteImage(csxi_id, sid, pcount_id, prev_id, next_id) {
                    var csxi_obj = $get(csxi_id);

                    // ид. сессии
                    csxi_obj.sid = sid;
                    csxi_obj.dwnldUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/byteimage_tiffile.ashx?sid=' + sid + '&rnd=' + Math.random();

                    // контролы пейджера
                    csxi_obj.pcount_id = pcount_id;
                    csxi_obj.prev_id = prev_id;
                    csxi_obj.next_id = next_id;

                    // значения пейджера
                    csxi_obj.imgcount = 0;
                    csxi_obj.curimg = 0;

                    // инициализация
                    csxi_obj.AutoZoom = true;

                    // получаем кол-во картинок и загружаем первую если есть
                    try {
                        csxi_obj.imgcount = csxi_obj.ImageCount(csxi_obj.dwnldUrl);
                        csxi_obj.curimg = 1;

                        ShowCurrentImage(csxi_id);
                    } catch (e) {
                        csxi_obj.imgcount = 0;
                        csxi_obj.curimg = 0;
                    }

                    // отображем подпись
                    RedrawPagerTitle(csxi_id);
                }
                function ViewClick(csxi_id) {
                    var csxi_obj = $get(csxi_id);

                    var DialogOptions = 'width=600, height=620, toolbar=no, location=no, directories=no, menubar=no, scrollbars=yes, resizable=yes, status=no';
                    var result = window.open('/barsroot/credit/usercontrols/dialogs/byteimage_show.aspx?sid=' + csxi_obj.sid + '&rnd=' + Math.random(), 'view_window', DialogOptions);
                }
                // удалить все картинки
                function DeleteAllFromMemory(csxi_id) {
                    var csxi_obj = $get(csxi_id);

                    // отчищаем контрол
                    csxi_obj.Clear();

                    // чистим ид. сессии
                    csxi_obj.sid = 'none';
                    csxi_obj.dwnldUrl = 'none';

                    // чистим значения пейджера
                    csxi_obj.imgcount = 0;
                    csxi_obj.curimg = 0;

                    RedrawPagerTitle(csxi_id);
                }
                // пейджинг
                function ShowCurrentImage(csxi_id) {
                    var csxi_obj = $get(csxi_id);

                    csxi_obj.ReadImageNumber = csxi_obj.curimg;
                    csxi_obj.LoadFromURL(csxi_obj.dwnldUrl);
                }
                function RedrawPagerTitle(csxi_id) {
                    var csxi_obj = $get(csxi_id);

                    // если нет контрола для отображенияы пейджера то выходим
                    if (csxi_obj.pcount_id == null || $get(csxi_obj.pcount_id) == null) return;

                    var pcount_obj = $get(csxi_obj.pcount_id);
                    pcount_obj.innerHTML = String.Format('" + Resources.credit.StringConstants.text_pagecount + @"', csxi_obj.curimg, csxi_obj.imgcount);
                }
", true);

            // кнопка просмотра
            ibView.Visible = this.ShowView;
            ibView.OnClientClick = String.Format("ViewClick('{0}'); return false;", this.BaseClientID);

            // подпись о кол-ве изображений
            lbPageCount.Visible = this.ShowLabel;

            // инициализация
            ScriptManager.RegisterStartupScript(this, typeof(UserControl), "InitByteImage_Script_" + this.ClientID, String.Format(InitScriptPattern, this.BaseClientID, this.ImageDataSessionID, lbPageCount.ClientID, String.Empty, String.Empty), true);

            base.OnPreRender(e);
        }
        # endregion
    }
}