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
    public partial class ByteImage : System.Web.UI.UserControl
    {
        # region Константы
        private const String SessionIDKey = "IMAGE_DATA_SESSION_ID";
        public String SessionIDPattern = "IMAGE_DATA_{0}";
        private const String ShowViewKey = "SHOW_ZOOM";
        private const String ShowLabelKey = "SHOW_LABEL";
        private const String ShowPagerKey = "SHOW_PAGER";
        private const String TypeKey = "TYPE";

        public String InitScriptPattern = "InitByteImage('{0}', '{1}', '{2}', {3}, '{4}'); ";
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
                return img.Width;
            }
            set
            {
                img.Width = value;
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
                return img.Height;
            }
            set
            {
                img.Height = value;
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
                return this.ViewState[ShowViewKey] == null ? true : (Boolean)this.ViewState[ShowViewKey];
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
                return this.ViewState[ShowLabelKey] == null ? true : (Boolean)this.ViewState[ShowLabelKey];
            }
            set
            {
                this.ViewState[ShowLabelKey] = value;
            }
        }
        /// <summary>
        /// Отображать или нет стрелки пейджера
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(false)]
        public Boolean ShowPager
        {
            get
            {
                return this.ViewState[ShowPagerKey] == null ? false : (Boolean)this.ViewState[ShowPagerKey];
            }
            set
            {
                this.ViewState[ShowPagerKey] = value;
            }
        }
        /// <summary>
        /// Режим отображения картинок
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(false)]
        public Types Type
        {
            get
            {
                return this.ViewState[TypeKey] == null ? Types.Thumbnail : (Types)this.ViewState[TypeKey];
            }
            set
            {
                this.ViewState[TypeKey] = value;
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
                return img.ClientID;
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
        /// Структура хранения побайтового представление картинки
        /// </summary>
        [Category("Data")]
        public ByteData BDValue
        {
            get
            {
                if (this.Session[this.ImageDataSessionID] == null)
                    this.Session[ImageDataSessionID] = new ByteData();

                return (ByteData)this.Session[this.ImageDataSessionID];
            }
            set
            {
                if (value == null)
                    this.Session.Remove(ImageDataSessionID);
                else
                    this.Session[ImageDataSessionID] = value;
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
                if (!BDValue.HasData) return null;
                return BDValue.Data;
            }
            set
            {
                if (value == null && BDValue != null)
                {
                    BDValue.Dispose();
                    BDValue = null;
                }

                if (value != null)
                {
                    BDValue = new ByteData(value);
                }
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
                return !(this.Value == null || this.Value.Length == 0);
            }
        }
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected override void OnPreRender(EventArgs e)
        {
            // регистрация скриптов
            ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery", "/Common/jquery/jquery.js");
            ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery-ui", "/Common/jquery/jquery-ui.js");

            ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "ScriptInclude_ByteImage", "/barsroot/credit/usercontrols/scripts/ByteImage.js");

            // убираем рядок кнопок если он не нужен
            trButtonContainer.Visible = this.ShowView || this.ShowLabel;

            // кнопка просмотра
            dvViewContainer.Visible = this.ShowView;
            ibView.OnClientClick = String.Format("ViewClick('{0}'); return false;", this.BaseClientID);

            // подпись о кол-ве изображений
            dvPagerContainer.Visible = this.ShowLabel;
            ibPrev.OnClientClick = String.Format("ShowPrevImage('{0}'); return false;", this.BaseClientID);
            ibNext.OnClientClick = String.Format("ShowNextImage('{0}'); return false;", this.BaseClientID);
            ibPrev.Visible = this.ShowPager;
            ibNext.Visible = this.ShowPager;

            // инициализация
            ScriptManager.RegisterStartupScript(this, typeof(UserControl), "InitByteImage_Script_" + this.ClientID, String.Format(InitScriptPattern, this.BaseClientID, this.ImageDataSessionID, lbPageCount.ClientID, BDValue.PageCount, Type), true);

            base.OnPreRender(e);
        }
        # endregion
    }
}