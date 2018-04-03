using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.ComponentModel;
using System.Drawing;

namespace Bars.UserControls
{
    public partial class LabelTooltip : System.Web.UI.UserControl
    {
        # region Константы
        private const String ContSymbol = "...";
        # endregion

        # region Публичные свойства
        /// <summary>
        /// Отображаемый текст
        /// </summary>
        [Category("Appearance")]
        [Bindable(true, BindingDirection.OneWay)]
        [DefaultValue("")]
        [Localizable(true)]
        public String Text
        {
            get
            {
                return (String)ViewState["Text"];
            }
            set
            {
                ViewState["Text"] = value;
            }
        }
        /// <summary>
        /// Кол-во символов для отображения в тексте (0 - все)
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(0)]
        public Int32 TextLength
        {
            get
            {
                if (ViewState["TextLength"] == null)
                    ViewState["TextLength"] = 0;
                return (Int32)ViewState["TextLength"];
            }
            set
            {
                ViewState["TextLength"] = value;
            }
        }
        /// <summary>
        /// Tooltip контрола
        /// </summary>
        [Category("Behavior")]
        [DefaultValue("")]
        [Localizable(true)]
        public String ToolTip
        {
            get
            {
                return (String)ViewState["ToolTip"];
            }
            set
            {
                ViewState["ToolTip"] = value;
            }
        }
        /// <summary>
        /// Использовать текст для Tooltip
        /// </summary>
        [Category("Appearance")]
        [DefaultValue(false)]
        public Boolean UseTextForTooltip
        {
            get
            {
                if (ViewState["UseTextForTooltip"] == null)
                    ViewState["UseTextForTooltip"] = false;
                return (Boolean)ViewState["UseTextForTooltip"];
            }
            set
            {
                ViewState["UseTextForTooltip"] = value;
            }
        }
        # endregion

        # region События
        protected override void OnInit(EventArgs e)
        {
            // добавляем стиль
            HtmlLink CSSLink = new HtmlLink();
            CSSLink.Href = "/barsroot/UserControls/style/jquerytools_tooltip.css";
            CSSLink.Attributes.Add("rel", "stylesheet");
            CSSLink.Attributes.Add("type", "text/css");
            Page.Header.Controls.Add(CSSLink);

            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected override void OnPreRender(EventArgs e)
        {
            // наполняем текст и тултип контрола значениями 
            if (this.TextLength > 0)
                lb.Text = this.Text.Length > this.TextLength ? this.Text.Substring(0, this.TextLength) + ContSymbol : this.Text;
            else
                lb.Text = this.Text;

            if (this.TextLength > 0 && this.Text.Length > this.TextLength && this.UseTextForTooltip)
                dvBody.InnerText = this.Text;
            else
                dvBody.InnerText = this.ToolTip;

            // в зависимости от наличия тултипа инициализируем его
            dvTooltip.Visible = !String.IsNullOrEmpty(dvBody.InnerText);
            if (!String.IsNullOrEmpty(dvBody.InnerText))
            {
                ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery_script", "/Common/jquery/jquery.js");
                ScriptManager.RegisterClientScriptInclude(this, this.GetType(), "jquery_tools_script", "/Common/jquery/jquery.tools.min.js");

                ScriptManager.RegisterStartupScript(this, this.GetType(), "init_labeltooltip_" + lb.UniqueID, String.Format("$('#{0}').tooltip(); ", lb.ClientID), true);
            }

            // регистрируем скрипт для копирования тултипа
            String Copy2cbScript = @"
            function copy2cb(obj_id)
            {
                var obj = $get(obj_id);
                window.clipboardData.setData('Text', obj.innerText);
                alert('Текст скопійовано у буфер');
            }";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "copy2cb_script", Copy2cbScript, true);
            imgCopy2cb.Attributes.Add("onclick", String.Format("copy2cb('{0}'); ", dvBody.ClientID));
        }
        # endregion
    }
}