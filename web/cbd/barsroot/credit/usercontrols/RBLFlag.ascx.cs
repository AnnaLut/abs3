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
    public partial class RBLFlag : System.Web.UI.UserControl, IBarsUserControl, IHasRelControls
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
                if (ViewState["IS_REQUIRED"] == null) ViewState["IS_REQUIRED"] = false;
                return (Boolean)ViewState["IS_REQUIRED"];
            }
            set { ViewState["IS_REQUIRED"] = value; }
        }

        /// <summary>
        /// Место для хранения параметра
        /// </summary>
        [Category("Data")]
        [DefaultValue("")]
        [Bindable(true, BindingDirection.OneWay)]
        public String Parameter
        {
            get
            {
                if (ViewState["PARAMETER"] == null) 
                    ViewState["PARAMETER"] = "";

                return (String)ViewState["PARAMETER"];
            }
            set 
            { 
                ViewState["PARAMETER"] = value; 
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
                if (!this.ValueBool.HasValue) return (Decimal?)null;
                else return ((Boolean)this.ValueBool ? 1 : 0);
            }
            set
            {
                if (!value.HasValue) this.ValueBool = (Boolean?)null;
                else if (value == 0) this.ValueBool = false;
                else this.ValueBool = true;
            }
        }
        /// <summary>
        /// Значение контрола
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public Boolean? ValueBool
        {
            get
            {
                switch (this.rbl.SelectedValue)
                {
                    case "0": return (Boolean?)false;
                    case "1": return (Boolean?)true;
                }
                return (Boolean?)null;
            }
            set
            {
                if (!value.HasValue) this.rbl.SelectedIndex = -1;
                else
                {
                    this.rbl.SelectedValue = ((Boolean)value ? "1" : "0");
                }
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
                return rbl.Attributes;
            }
        }

        /// <summary>
        /// Дефолтное значение
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(false)]
        [Bindable(true, BindingDirection.OneWay)]
        public Boolean DefaultValue
        {
            get
            {
                if (ViewState["DEFAULT_VALUE"] == null) ViewState["DEFAULT_VALUE"] = false;
                return (Boolean)ViewState["DEFAULT_VALUE"];
            }
            set { ViewState["DEFAULT_VALUE"] = value; }
        }
        /// <summary>
        /// Только чтение
        /// </summary>
        [Category("Appearance")]
        [Bindable(true, BindingDirection.OneWay)]
        public bool ReadOnly
        {
            get { return !this.rbl.Enabled; }
            set { this.rbl.Enabled = !value; }
        }
        /// <summary>
        /// Включает контрол
        /// </summary>
        [Category("Appearance")]
        public Boolean Enabled
        {
            get
            {
                return rbl.Enabled;
            }
            set
            {
                rbl.Enabled = value;
            }
        }
        # endregion

        # region События контрола
        /// <summary>
        /// Изменение значения контрола
        /// </summary>
        public event EventHandler ValueChanged;

        protected void Page_Load(object sender, EventArgs e)
        {
            // если определено событие на изменение то отрабатываем его
            if (this.ValueChanged != null)
            {
                rbl.SelectedIndexChanged += new EventHandler(rbl_SelectedIndexChanged);
                rbl.AutoPostBack = true;
            }
        }
        protected override void OnPreRender(EventArgs e)
        {
            // дефолтное значение
            if (!ValueBool.HasValue && IsRequired) ValueBool = DefaultValue;

            base.OnPreRender(e);
        }
        void rbl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.ValueChanged != null)
                this.ValueChanged(this, new EventArgs());
        }
        # endregion
    }
}