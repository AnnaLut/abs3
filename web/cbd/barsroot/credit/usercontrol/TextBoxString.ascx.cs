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
using System.Text;

using System.ComponentModel;
using System.Drawing;

namespace Bars.UserControls
{
    public partial class TextBoxString : System.Web.UI.UserControl, IBarsUserControl, IHasRelControls
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
        public string RequiredErrorText
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
        /// Минимальная длина строки
        /// </summary>
        [Category("Validation")]
        [DefaultValue(0)]
        [Bindable(true, BindingDirection.OneWay)]
        public int MinLength
        {
            get
            {
                int MinLength = (ViewState["MINLENGTH"] == null ? 0 : (int)ViewState["MINLENGTH"]);
                return MinLength;
            }
            set
            {
                ViewState["MINLENGTH"] = value;
            }
        }
        /// <summary>
        /// Максимальная длина строки
        /// </summary>
        [Category("Validation")]
        [DefaultValue(4000)]
        [Bindable(true, BindingDirection.OneWay)]
        public int MaxLength
        {
            get
            {
                int MaxLength = (tb.MaxLength == 0 ? 4000 : tb.MaxLength);
                return MaxLength;
            }
            set
            {
                tb.MaxLength = value;
            }
        }
        /// <summary>
        /// Проверка максимальной длины строки
        /// </summary>
        [Category("Validation")]
        [DefaultValue(false)]
        public Boolean CheckMaxLength
        {
            get;
            set;
        }
        /// <summary>
        /// Текст ошибки валидации
        /// </summary>
        [Category("Validation")]
        [Bindable(true, BindingDirection.OneWay)]
        public String MinMaxLengthErrorText
        {
            get
            {
                String MinMaxLengthErrorText = (ViewState["MINMAXLENGTHERRORTEXT"] == null ? Resources.usercontrols.textboxstring_minmaxlengtherrortext : (String)ViewState["MINMAXLENGTHERRORTEXT"]);
                return String.Format(MinMaxLengthErrorText, this.MinLength.ToString(), this.MaxLength.ToString());
            }
            set
            {
                ViewState["MINMAXLENGTHERRORTEXT"] = value;
            }
        }
        /// <summary>
        /// Установка фокуса на контрол при ошибке
        /// </summary>
        [Category("Validation")]
        [DefaultValue(true)]
        [Bindable(true, BindingDirection.OneWay)]
        public Boolean SetFocusOnError
        {
            get
            {
                return rfv.SetFocusOnError && rev.SetFocusOnError;
            }
            set
            {
                rfv.SetFocusOnError = value;
                rev.SetFocusOnError = value;
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
                rfv.ValidationGroup = value;
                rev.ValidationGroup = value;
            }
        }

        /// <summary>
        /// Значение контрола
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        [Localizable(false)]
        public String Value
        {
            get
            {
                return (tb.Text == string.Empty ? (String)null : tb.Text);
            }
            set
            {
                tb.Text = (value == null ? string.Empty : value);
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
        [DefaultValue("cssTextBoxString")]
        [Bindable(true, BindingDirection.OneWay)]
        public string CssClass
        {
            get
            {
                return (tb.CssClass == "" ? "cssTextBoxString" : tb.CssClass);
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
                rfv.Enabled = IsRequired && value;
            }
        }
        /// <summary>
        /// Рядков в контроле
        /// </summary>
        [Category("Appearance")]
        [Bindable(true, BindingDirection.OneWay)]
        public int Rows
        {
            get
            {
                return tb.Rows;
            }
            set
            {
                tb.Rows = value;

                if (value > 1) tb.TextMode = TextBoxMode.MultiLine;
                else tb.TextMode = TextBoxMode.SingleLine;
            }
        }
        /// <summary>
        /// Тип текстбокса
        /// </summary>
        [Category("Appearance")]
        public TextBoxMode TextMode
        {
            get
            {
                return tb.TextMode;
            }
            set
            {
                tb.TextMode = value;
            }
        }
        /// <summary>
        /// Тултип
        /// </summary>
        [DefaultValue("")]
        [Localizable(true)]
        public string ToolTip
        {
            get
            {
                return tb.ToolTip;
            }
            set
            {
                tb.ToolTip = value;
            }
        }
        # endregion


        # region События
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
            this.ValueChanged(this, new EventArgs());
        }

        protected override void OnPreRender(EventArgs e)
        {
            if (CheckMaxLength == true)
            {
                ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery", "/Common/jquery/jquery.js");
                ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery-ui", "/Common/jquery/jquery-ui.js");

                StringBuilder sb = new StringBuilder();
                sb.Append("    $('#" + tb.ClientID + "').on('input keyup keydown change', function () {");
                sb.Append("        var max = " + MaxLength + ";");
                sb.Append("        var v = $(this).val();");
                sb.Append("        if (v.length >= max) $(this).val(v.substring(0, max));");
                sb.Append("    });");
            
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "checkConstraint_" + tb.ClientID, sb.ToString(), true);
            }
            
            // ограничения на размер
            rev.ValidationExpression = @"^[\W\S]{" + this.MinLength.ToString() + "," + this.MaxLength.ToString() + "}$";

            // Привязка данных
            rev.DataBind();
            rfv.DataBind();

            base.OnPreRender(e);
        }
        # endregion
    }
}