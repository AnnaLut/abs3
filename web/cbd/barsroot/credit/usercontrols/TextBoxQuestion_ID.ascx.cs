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
using System.Collections.Generic;
using credit;

namespace Bars.UserControls
{
    public partial class TextBoxQuestion_ID : System.Web.UI.UserControl
    {
        # region Приватные свойства
        VWcsQuestionsRecord _QuestionRecord;
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
        /// Идентификатор вопроса
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public String QUESTION_ID
        {
            get
            {
                return tb.Value;
            }
            set
            {
                InitQuestion(value);
                tb.Value = value;
            }
        }
        /// <summary>
        /// Доступные типы для выбора
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
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
        [Bindable(true, BindingDirection.OneWay)]
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
        /// Данные вопроса
        /// </summary>
        [Category("Data")]
        public VWcsQuestionsRecord QuestionRecord
        {
            get
            {
                if (!String.IsNullOrEmpty(QUESTION_ID))
                {
                    InitQuestion(QUESTION_ID);
                    return _QuestionRecord;
                }
                else
                    return null;
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
                if (ViewState["READONLY"] == null)
                    ViewState["READONLY"] = false;

                return (ViewState["READONLY"] as Boolean?).Value;
            }
            set
            {
                ViewState["READONLY"] = value;
            }
        }
        /// <summary>
        /// Разрешено ли создавать новый
        /// </summary>
        [Category("Appearance")]
        public Boolean AllowNew
        {
            get
            {
                if (ViewState["ALLOWNEW"] == null)
                    ViewState["ALLOWNEW"] = true;

                return (ViewState["ALLOWNEW"] as Boolean?).Value;
            }
            set
            {
                ViewState["ALLOWNEW"] = value;
            }
        }
        /// <summary>
        /// Разрешено ли добавлять новый из справочника
        /// </summary>
        [Category("Appearance")]
        public Boolean AllowNewFromRef
        {
            get
            {
                if (ViewState["ALLOWNEWFROMREF"] == null)
                    ViewState["ALLOWNEWFROMREF"] = true;

                return (ViewState["ALLOWNEWFROMREF"] as Boolean?).Value;
            }
            set
            {
                ViewState["ALLOWNEWFROMREF"] = value;
            }
        }
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(QUESTION_ID))
                InitQuestion(QUESTION_ID);
        }
        protected void ibNew_Click(object sender, ImageClickEventArgs e)
        {
            Trace.Write("hDialogResult.Value = " + hDialogResult.Value);
            if (!String.IsNullOrEmpty(hDialogResult.Value))
            {
                QUESTION_ID = hDialogResult.Value;
                hDialogResult.Value = "";
            }
        }
        protected void ibNewFromRef_Click(object sender, ImageClickEventArgs e)
        {
            Trace.Write("hDialogResult.Value = " + hDialogResult.Value);
            if (!String.IsNullOrEmpty(hDialogResult.Value))
            {
                QUESTION_ID = hDialogResult.Value;
                hDialogResult.Value = "";
            }
        }
        protected override void OnPreRender(EventArgs e)
        {
            Trace.Write("this.ReadOnly = " + this.ReadOnly);
            ibParams.OnClientClick = String.Format("return ShowQuestion('{0}', '{1}', '{2}', '{3}');", hDialogResult.ClientID, this.QUESTION_ID, (this.ReadOnly ? "readonly" : "edit"), this.TYPES);
            ibNew.OnClientClick = String.Format("return ShowQuestion('{0}', '', 'new', '{1}');", hDialogResult.ClientID, this.TYPES);
            ibNewFromRef.OnClientClick = String.Format("return ShowRef('{0}', '{1}', '{2}')", hDialogResult.ClientID, this.SECTIONS, this.TYPES);
            Trace.Write("ibNewFromRef.OnClientClick = " + ibNewFromRef.OnClientClick);

            ibParams.Visible = !String.IsNullOrEmpty(QUESTION_ID);

            ibNew.Visible = !ReadOnly && AllowNew;
            ibNewFromRef.Visible = !ReadOnly && AllowNewFromRef;

            base.OnPreRender(e);
        }
        # endregion

        # region Приватные методы
        private void InitQuestion(String QUESTION_ID)
        {
            List<VWcsQuestionsRecord> lst = (new VWcsQuestions()).SelectQuestion(QUESTION_ID);
            if (lst.Count > 0)
            {
                _QuestionRecord = lst[0];
            }
        }
        # endregion
    }
}