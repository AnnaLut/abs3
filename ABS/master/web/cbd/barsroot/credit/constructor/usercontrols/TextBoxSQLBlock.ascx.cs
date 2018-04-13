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
    public partial class TextBoxSQLBlock : System.Web.UI.UserControl
    {
        # region Приватные свойства
        private String _ScriptShowMacrosMACs =
        @"function ShowMacrosMACs(resControlID) 
    {
        var rnd = Math.random();
        var result = window.showModalDialog('/barsroot/credit/constructor/usercontrols/dialogs/textboxsqlblock_macs.aspx?rnd=' + rnd, window, 'dialogHeight:600px; dialogWidth:900px');

        if (result != null) 
            document.getElementById(resControlID).value = document.getElementById(resControlID).value + result;

        return false;
    }";
        private String _ShowMacrosMACsMask = "return ShowMacrosMACs('{0}')";
        # endregion

        # region Публичные свойства
        /// <summary>
        /// Клиентский идентификатор базового контрола
        /// </summary>
        [Category("Data")]
        [Browsable(false)]
        public String BaseClientID
        {
            get
            {
                return tb.BaseClientID;
            }
        }
        /// <summary>
        /// Доступные типы для выбора
        /// </summary>
        [Category("Data")]
        public String TYPES
        {
            get
            {
                return (this.ViewState["TYPES"] as String);
            }
            set
            {
                this.ViewState["TYPES"] = value;
            }
        }
        /// <summary>
        /// Доступные разделы для выбора
        /// </summary>
        [Category("Data")]
        public String SECTIONS
        {
            get
            {
                return (this.ViewState["SECTIONS"] as String);
            }
            set
            {
                this.ViewState["SECTIONS"] = value;
            }
        }

        /// <summary>
        /// Идентификатор суб-продукта
        /// </summary>
        [DefaultValue((String)null)]
        [Bindable(true, BindingDirection.OneWay)]
        public String SUBPRODUCT_ID
        {
            get
            {
                return (String)Session["WCS_SUBPRODUCT_ID"];
            }
            set
            {
                Session["WCS_SUBPRODUCT_ID"] = value;
            }
        }
        /// <summary>
        /// Значение
        /// </summary>
        [DefaultValue((String)null)]
        [Bindable(true, BindingDirection.TwoWay)]
        public String Value
        {
            get
            {
                return tb.Value;
            }
            set
            {
                tb.Value = value;
            }
        }
        /// <summary>
        /// Обязательность заполнения
        /// </summary>
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
                ibMACs.Enabled = value;
                ibQuests.Enabled = value;
                ibMACs.Visible = value;
                ibQuests.Visible = value;
            }
        }
        /// <summary>
        /// Только чтение
        /// </summary>
        [DefaultValue(false)]
        [Bindable(true, BindingDirection.OneWay)]
        public Boolean ReadOnly
        {
            get
            {
                return tb.ReadOnly;
            }
            set
            {
                tb.ReadOnly = value;
                ibQuests.Enabled = !value;
                ibMACs.Enabled = !value;
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
        /// <summary>
        /// Рядков в контроле
        /// </summary>
        public int Rows
        {
            get
            {
                return tb.Rows;
            }
            set
            {
                tb.Rows = value;
            }
        }
        /// <summary>
        /// Тип текстбокса
        /// </summary>
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
        /// Ширина
        /// </summary>
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
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
            // добавляем скрипты
            ScriptManager.RegisterStartupScript(this.Page, typeof(string), "ScriptShowMacrosMACs", _ScriptShowMacrosMACs, true);
        }
        protected override void OnPreRender(EventArgs e)
        {
            String resControlID = tb.BaseClientID;

            if (!this.ReadOnly)
            {
                ibQuests.OnClientClick = String.Format("return ShowMacrosQuestions('{0}', '{1}', '{2}')", resControlID, SECTIONS, TYPES);
                ibMACs.OnClientClick = String.Format(_ShowMacrosMACsMask, resControlID);
            }

            base.OnPreRender(e);
        }
        # endregion
    }
}