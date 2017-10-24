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
    public partial class TextBoxNumb : System.Web.UI.UserControl, IBarsUserControl, IHasRelControls
    {
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
        [DefaultValue(0)]
        [Bindable(true, BindingDirection.OneWay)]
        public Int32 MinValue
        {
            get
            {
                Int32 MinValue = (ViewState["MINVALUE"] == null ? 0 : (Int32)ViewState["MINVALUE"]);
                return MinValue;
            }
            set
            {
                ViewState["MINVALUE"] = value;

                // ограничения на MinMax
                rv.MinimumValue = value.ToString();
            }
        }
        /// <summary>
        /// Максимальное значение
        /// </summary>
        [Category("Validation")]
        [DefaultValue(2147483646)]
        [Bindable(true, BindingDirection.OneWay)]
        public Int32 MaxValue
        {
            get
            {
                Int32 MaxValue = (ViewState["MAXVALUE"] == null ? 2147483646 : (Int32)ViewState["MAXVALUE"]);
                return MaxValue;
            }
            set
            {
                ViewState["MAXVALUE"] = value;

                // ограничения на MinMax
                rv.MaximumValue = value.ToString();
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
                String MinMaxValueErrorText = (ViewState["MINMAXVALUEERRORTEXT"] == null ? Resources.usercontrols.textboxnumb_minmaxvalueerrortext : (String)ViewState["MINMAXVALUEERRORTEXT"]);
                return String.Format(MinMaxValueErrorText, this.MinValue.ToString(), this.MaxValue.ToString());
            }
            set
            {
                ViewState["MINMAXVALUEERRORTEXT"] = value;
            }
        }
        /// <summary>
        /// Gets or sets a value indicating whether validation is performed when the
        /// System.Web.UI.WebControls.TextBox control is set to validate when a postback
        /// occurs.
        /// </summary>
        [DefaultValue(false)]
        [Themeable(false)]
        [Category("Validation")]
        [Bindable(true, BindingDirection.OneWay)]
        public Boolean CausesValidation
        {
            get
            {
                return tb.CausesValidation;
            }
            set
            {
                tb.CausesValidation = value;
            }
        }
        /// <summary>
        /// Gets or sets the group of controls for which the System.Web.UI.WebControls.TextBox
        /// control causes validation when it posts back to the server.
        /// </summary>
        [Themeable(false)]
        [DefaultValue("")]
        [Category("Validation")]
        [Bindable(true, BindingDirection.OneWay)]
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
        public Decimal? Value
        {
            get
            {
                return (tb.Text == string.Empty ? (Decimal?)null : (Decimal?)Convert.ToDecimal(tb.Text));
            }
            set
            {
                if (!HasPrevValue) PrevValue = value;
                else PrevValue = (tb.Text == string.Empty ? (Decimal?)null : (Decimal?)Convert.ToDecimal(tb.Text));

                tb.Text = (!value.HasValue ? string.Empty : value.Value.ToString());
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
        /// Клиентский идентификатор базового контрола
        /// </summary>
        [Category("Data")]
        [Browsable(false)]
        public String BaseClientID
        {
            get
            {
                return tb.ClientID;
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

        # region Приватные свойства
        /// <summary>
        /// Предидущее значение контрола
        /// </summary>
        private Boolean HasPrevValue
        {
            get
            {
                if (ViewState["HASPREVVALUE"] == null) return false;
                else return (Boolean)ViewState["HASPREVVALUE"];
            }
            set
            {
                ViewState["HASPREVVALUE"] = value;
            }
        }
        private Decimal? PrevValue
        {
            get
            {
                return (Decimal?)this.ViewState["PREV_VALUE"];
            }
            set
            {
                this.ViewState["PREV_VALUE"] = value;
            }
        }
        # endregion

        # region События
        /// <summary>
        /// Изменение значения контрола
        /// </summary>
        public event EventHandler ValueChanged;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.ValueChanged != null)
            {
                tb.TextChanged += new EventHandler(tb_TextChanged);
                tb.AutoPostBack = true;
            }
        }
        void tb_TextChanged(object sender, EventArgs e)
        {
            if (this.ValueChanged != null && this.Value != this.PrevValue)
                this.ValueChanged(this, new EventArgs());
        }
        protected override void OnPreRender(EventArgs e)
        {
            // ограничения на MinMax
            rv.MinimumValue = this.MinValue.ToString();
            rv.MaximumValue = this.MaxValue.ToString();

            // привязка данных
            rfv.DataBind();
            rv.DataBind();

            // допускает нажатие только цифровых клавиш (скрипт берет из файла JScript.js)
            tb.Attributes.Add("onkeydown", "return doNumOnly(event);");

            base.OnPreRender(e);
        }
        # endregion
    }
}