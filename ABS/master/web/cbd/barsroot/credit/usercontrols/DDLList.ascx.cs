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
using System.Drawing.Design;

namespace Bars.UserControls
{
    public partial class DDLList : System.Web.UI.UserControl, IBarsUserControl, IHasRelControls
    {
        # region Публичные свойства
        /// <summary>
        /// Gets or sets the tab index of the Web server control.
        /// </summary>
        [DefaultValue(0)]
        public short TabIndex
        {
            get { return ddl.TabIndex; }
            set { ddl.TabIndex = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether validation is performed when a control
        /// that is derived from the System.Web.UI.WebControls.ListControl class is clicked.
        /// </summary>
        [DefaultValue(false)]
        [Category("Validation")]
        public Boolean CausesValidation
        {
            get
            {
                return ddl.CausesValidation;
            }
            set
            {
                ddl.CausesValidation = value;
            }
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

                if (value) ddl.BackColor = this.RequiredBackColor;
                else ddl.BackColor = Color.White;
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
        /// Gets or sets the group of controls for which the System.Web.UI.WebControls.TextBox
        /// control causes validation when it posts back to the server.
        /// </summary>
        [DefaultValue("")]
        public String ValidationGroup
        {
            get
            {
                return ddl.ValidationGroup;
            }
            set
            {
                ddl.ValidationGroup = value;
                rfv.ValidationGroup = value;
            }
        }


        /// <summary>
        /// Класс стиля
        /// </summary>
        [Category("Appearance")]
        [CssClassProperty]
        [DefaultValue("cssDDLList")]
        [Bindable(true, BindingDirection.OneWay)]
        public String CssClass
        {
            get
            {
                return (ddl.CssClass == "" ? "cssDDLList" : ddl.CssClass);
            }
            set
            {
                ddl.CssClass = value;
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
                return ddl.Width;
            }
            set
            {
                ddl.Width = value;
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
                return ddl.Enabled;
            }
            set
            {
                ddl.Enabled = value;

                rfv.Enabled = (value && this.IsRequired);
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
                return !this.Enabled;
            }
            set
            {
                this.Enabled = !value;
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
        /// Значение контрола
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public Decimal? Value
        {
            get
            {
                if (this.SelectedValue == "") return (Decimal?)null;
                else
                {
                    try
                    {
                        Decimal res = Convert.ToDecimal(this.SelectedValue);
                        return res;
                    }
                    catch
                    {
                        return (Decimal?)null;
                    }
                }
            }
            set
            {
                if (!value.HasValue) this.SelectedValue = "";
                else this.SelectedValue = Convert.ToString(value);
            }
        }
        /// <summary>
        /// Gets or sets the ID of the control from which the data-bound control retrieves
        /// its list of data items.
        /// </summary>
        [Category("Data")]
        [IDReferenceProperty(typeof(DataSourceControl))]
        public String DataSourceID
        {
            get
            {
                return ddl.DataSourceID;
            }
            set
            {
                ddl.DataSourceID = value;
            }
        }
        /// <summary>
        /// Gets or sets the object from which the data-bound control retrieves its list
        /// of data items.
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [Bindable(true)]
        [Themeable(false)]
        public object DataSource
        {
            get
            {
                return ddl.DataSource;
            }
            set
            {
                ddl.DataSource = value;
            }
        }
        /// <summary>
        /// Добавлять значение SelectedValue в данные
        /// </summary>
        [Category("Data")]
        [DefaultValue(false)]
        [Bindable(true, BindingDirection.OneWay)]
        public Boolean AppendSelectedValue
        {
            get
            {
                Boolean AppendSelectedValue = (ViewState["APPENDSELECTEDVALUE"] == null ? false : (Boolean)ViewState["APPENDSELECTEDVALUE"]);
                return AppendSelectedValue;
            }
            set
            {
                ViewState["APPENDSELECTEDVALUE"] = value;

                if (value == true) ddl.AppendDataBoundItems = true;
            }
        }


        /// <summary>
        /// Gets or sets the field of the data source that provides the text content
        /// of the list items.
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        public String DataTextField
        {
            get
            {
                return ddl.DataTextField;
            }
            set
            {
                ddl.DataTextField = value;
            }
        }
        /// <summary>
        /// Gets or sets the field of the data source that provides the value of each
        /// list item.
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        public String DataValueField
        {
            get
            {
                return ddl.DataValueField;
            }
            set
            {
                ddl.DataValueField = value;
            }
        }
        /// <summary>
        /// Gets the collection of items in the list control.
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        [MergableProperty(false)]
        [PersistenceMode(PersistenceMode.InnerDefaultProperty)]
        [Editor("System.Web.UI.Design.WebControls.ListItemsCollectionEditor,System.Design, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", typeof(UITypeEditor))]
        public ListItemCollection Items
        {
            get
            {
                return ddl.Items;
            }
        }
        /// <summary>
        /// Gets or sets the lowest ordinal index of the selected items in the list.
        /// </summary>
        [DefaultValue(0)]
        [Category("Data")]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [Bindable(true)]
        public Int32 SelectedIndex
        {
            get
            {
                return ddl.SelectedIndex;
            }
            set
            {
                ddl.SelectedIndex = value;
            }
        }
        /// <summary>
        /// Gets the selected item with the lowest index in the list control.
        /// </summary>
        [DefaultValue("")]
        [Category("Data")]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [Browsable(false)]
        public ListItem SelectedItem
        {
            get
            {
                return ddl.SelectedItem;
            }
        }
        /// <summary>
        /// Gets the value of the selected item in the list control, or selects the item
        /// in the list control that contains the specified value.
        /// </summary>
        [Browsable(false)]
        [Bindable(true, BindingDirection.TwoWay)]
        [DefaultValue("")]
        [Category("Data")]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [Themeable(false)]
        public String SelectedValue
        {
            get
            {
                return ddl.SelectedValue;
            }
            set
            {
                Trace.Write("value = " + value);

                ddl.SelectedValue = value;

                // если разрешено добавлять значение до добавляем его в список
                if (this.AppendSelectedValue)
                    this.Items.Add(new ListItem(value, value));
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
                return ddl.Attributes;
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
                ddl.SelectedIndexChanged += new EventHandler(ddl_SelectedIndexChanged);
                ddl.AutoPostBack = true;
            }
        }
        void ddl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.ValueChanged != null)
                this.ValueChanged(this, new EventArgs());
        }

        protected override void OnPreRender(EventArgs e)
        {
            // привязка данных
            rfv.DataBind();

            base.OnPreRender(e);
        }
        # endregion
        
        # region Публичные методы
        public void DataBind()
        {
            ddl.DataBind();
        }
        # endregion

    }
}