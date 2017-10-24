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
using System.Drawing;

namespace Bars.UserControls
{
    public partial class TextBoxDate : System.Web.UI.UserControl, IBarsUserControl
    {
        # region Публичные свойства
        /// <summary>
        /// Gets or sets the tab index of the Web server control.
        /// </summary>
        [DefaultValue(0)]
        public short TabIndex
        {
            get { return tb.TabIndex; }
            set { tb.TabIndex = value; }
        }

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
                return rfv.Enabled;
            }
            set
            {
                rfv.Enabled = value;
                vceRFV.Enabled = value;

                if (value) tb.BackColor = this.RequiredBackColor;
                else tb.BackColor = Color.White;
            }
        }
        /// <summary>
        /// Текст ошибки валидации
        /// </summary>
        [Category("Validation")]
        [Bindable(true, BindingDirection.OneWay)]
        public String RequiredErrorText
        {
            get
            {
                String RequiredErrorText = (ViewState["REQUIREDERRORTEXT"] == null ? Resources.usercontrols.requirederrortext : (String)ViewState["REQUIREDERRORTEXT"]);
                return String.Format(RequiredErrorText);
            }
            set
            {
                ViewState["REQUIREDERRORTEXT"] = value;
            }
        }
        /// <summary>
        /// Минимальное значение
        /// </summary>
        [Category("Validation")]
        [DefaultValue(typeof(DateTime), "01/01/1900")]
        [Bindable(true, BindingDirection.OneWay)]
        public DateTime MinValue
        {
            get
            {
                DateTime MinValue = (ViewState["MINVALUE"] == null ? new DateTime(1900, 1, 1) : (DateTime)ViewState["MINVALUE"]);
                return MinValue;
            }
            set
            {
                ViewState["MINVALUE"] = value;
                rv.MinimumValue = value.ToShortDateString();
            }
        }
        /// <summary>
        /// Максимальное значение
        /// </summary>
        [Category("Validation")]
        [DefaultValue(typeof(DateTime), "01/01/2999")]
        [Bindable(true, BindingDirection.OneWay)]
        public DateTime MaxValue
        {
            get
            {
                DateTime MaxValue = (ViewState["MAXVALUE"] == null ? new DateTime(2999, 1, 1) : (DateTime)ViewState["MAXVALUE"]);
                return MaxValue;
            }
            set
            {
                ViewState["MAXVALUE"] = value;
                rv.MaximumValue = value.ToShortDateString();
            }
        }
        /// <summary>
        /// Текст ошибки валидации (MinMax значение)
        /// </summary>
        [Category("Validation")]
        [Bindable(true, BindingDirection.OneWay)]
        public String MinMaxValueErrorText
        {
            get
            {
                String MinMaxValueErrorText = (ViewState["MINMAXVALUEERRORTEXT"] == null ? Resources.usercontrols.textboxdate_minmaxvalueerrortext : (String)ViewState["MINMAXVALUEERRORTEXT"]);
                return String.Format(MinMaxValueErrorText, this.MinValue.ToShortDateString(), this.MaxValue.ToShortDateString());
            }
            set
            {
                ViewState["MINMAXVALUEERRORTEXT"] = value;
            }
        }
        /// <summary>
        /// Текст ошибки валидации (корректность строки)
        /// </summary>
        [Category("Validation")]
        [Bindable(true, BindingDirection.OneWay)]
        public String InvalidValueErrorText
        {
            get
            {
                String InvalidValueErrorText = (ViewState["INVALIDVALUEERRORTEXT"] == null ? Resources.usercontrols.textboxdate_invalidvalueerrortext : (String)ViewState["INVALIDVALUEERRORTEXT"]);
                return String.Format(InvalidValueErrorText);
            }
            set
            {
                ViewState["INVALIDVALUEERRORTEXT"] = value;
            }
        }
        /// <summary>
        /// Gets or sets the group of controls for which the System.Web.UI.WebControls.TextBox
        /// control causes validation when it posts back to the server.
        /// </summary>
        [Category("Validation")]
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
                rfv.ValidationGroup = value;
                rv.ValidationGroup = value;
            }
        }

        /// <summary>
        /// Значение контрола
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public DateTime? Value
        {
            get
            {
                // учитываем пустую маску
                if (tb.Text == "__/__/____") tb.Text = string.Empty;

                return (tb.Text == string.Empty ? (DateTime?)null : (DateTime?)Convert.ToDateTime(tb.Text));
            }
            set
            {
                tb.Text = (!value.HasValue ? string.Empty : value.Value.ToShortDateString());
            }
        }
        /// <summary>
        /// Gets the collection of arbitrary attributes (for rendering only) that do 
        /// not correspond to properties on the control.
        /// </summary>
        [Category("Data")]
        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public System.Web.UI.AttributeCollection BaseAttributes
        {
            get
            {
                return tb.Attributes;
            }
        }


        /// <summary>
        /// Класс стиля
        /// </summary>
        [Category("Appearance")]
        [CssClassProperty]
        [DefaultValue("cssTextBoxDate")]
        [Bindable(true, BindingDirection.OneWay)]
        public String CssClass
        {
            get
            {
                return (tb.CssClass == "" ? "cssTextBoxDate" : tb.CssClass);
            }
            set
            {
                tb.CssClass = value;
            }
        }
        /// <summary>
        /// Цвет подсветки обязательных контролов
        /// </summary>
        [Category("Appearance")]
        public Color RequiredBackColor
        {
            get
            {
                Color RequiredBackColor = (ViewState["REQUIREDBACKCOLOR"] == null ? Color.FromArgb(255, 235, 255) : (Color)ViewState["REQUIREDBACKCOLOR"]);
                return RequiredBackColor;
            }
            set
            {
                ViewState["REQUIREDBACKCOLOR"] = value;
            }
        }
        /// <summary>
        /// Ширина контрола
        /// </summary>
        [Category("Appearance")]
        public Unit Width
        {
            get
            {
                return tb.Width;
            }
            set
            {
                tb.Width = value;
            }
        }
        /// <summary>
        /// Показывать или нет календарь
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(true)]
        [Bindable(true, BindingDirection.OneWay)]
        public Boolean ShowCalendar
        {
            get
            {
                return ce.Enabled;
            }
            set
            {
                ce.Enabled = value;
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
                return tb.ReadOnly;
            }
            set
            {
                tb.ReadOnly = value;
                mee.Enabled = !value;
            }
        }
        /// <summary>
        /// Включает контрол
        /// </summary>
        [Category("Appearance")]
        public Boolean Enabled
        {
            get
            {
                return tb.Enabled;
            }
            set
            {
                tb.Enabled = value;

                rfv.Enabled = value;
                rv.Enabled = value;
            }
        }
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected override void OnPreRender(EventArgs e)
        {
            // ограничения на MinMax
            rv.MinimumValue = this.MinValue.ToShortDateString();
            rv.MaximumValue = this.MaxValue.ToShortDateString();

            // привязка данных
            mev.DataBind();
            rfv.DataBind();
            rv.DataBind();
            ce.DataBind();

            // прячем календарь если в режиме только чтение
            if (this.ReadOnly) this.ShowCalendar = false;

            base.OnPreRender(e);
        }
        # endregion
    }
}