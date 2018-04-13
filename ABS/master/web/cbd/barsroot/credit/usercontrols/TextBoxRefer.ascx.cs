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

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;

using credit;

namespace Bars.UserControls
{
    public partial class TextBoxRefer : System.Web.UI.UserControl, IBarsUserControl, IHasRelControls
    {
        # region Приватные методы
        private ReferQueryObject GenerateQueryObject()
        {
            // берем настройки из МАКа
            if (this.MAC_ID != null)
            {
                List<WcsMacReferParamsRecord> mrpRecords = (new WcsMacReferParams()).Select(this.MAC_ID);
                if (mrpRecords.Count > 0)
                {
                    WcsMacReferParamsRecord mrpRecord = mrpRecords[0];
                    this.TAB_ID = mrpRecord.TAB_ID;
                    this.KEY_FIELD = mrpRecord.KEY_FIELD;
                    this.SEMANTIC_FIELD = mrpRecord.SEMANTIC_FIELD;
                    this.SHOW_FIELDS = mrpRecord.SHOW_FIELDS;
                    this.WHERE_CLAUSE = mrpRecord.WHERE_CLAUSE;
                }
            }

            // берем настройки из вопроса
            if (this.QUESTION_ID != null)
            {
                List<VWcsQuestionParamsRecord> qrpRecords = (new VWcsQuestionParams()).SelectQuestion(this.QUESTION_ID);
                if (qrpRecords.Count > 0)
                {
                    VWcsQuestionParamsRecord qrpRecord = qrpRecords[0];
                    this.TAB_ID = qrpRecord.TAB_ID;
                    this.KEY_FIELD = qrpRecord.KEY_FIELD;
                    this.SEMANTIC_FIELD = qrpRecord.SEMANTIC_FIELD;
                    this.SHOW_FIELDS = qrpRecord.SHOW_FIELDS;
                    this.WHERE_CLAUSE = qrpRecord.WHERE_CLAUSE;
                }
            }

            // параметры выборки
            if (this.TAB_ID.HasValue && this.KEY_FIELD != null)
            {
                // необходимые переменные
                string TAB_NAME = "";
                string TAB_SEMANTIC = "";
                string KEY_SEMANTIC = "";
                string SEMANTIC_SEMANTIC = "";

                // выборки
                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();

                if (con.State == ConnectionState.Closed) con.Open();
                try
                {
                    // создаем объект
                    ReferQueryObject rqo = new ReferQueryObject();

                    // номер заявки
                    rqo.BID_ID = this.BID_ID;
                    rqo.WS_ID = this.WS_ID;
                    rqo.WS_NUM = this.WS_NUM;

                    // параметры таблицы
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("tabid", OracleDbType.Decimal, this.TAB_ID.Value, ParameterDirection.Input);
                    cmd.CommandText = "select t.tabname, t.semantic from meta_tables t where t.tabid = :tabid";
                    OracleDataReader rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        TAB_NAME = (String)rdr["TABNAME"];
                        TAB_SEMANTIC = (String)rdr["SEMANTIC"];
                    }
                    rqo.TableSemantic = TAB_SEMANTIC.Replace("~", "\n");

                    // параметры ключевого поля
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("tabid", OracleDbType.Decimal, this.TAB_ID.Value, ParameterDirection.Input);
                    cmd.Parameters.Add("colname", OracleDbType.Varchar2, this.KEY_FIELD, ParameterDirection.Input);
                    cmd.CommandText = "select t.semantic from meta_columns t where t.tabid = :tabid and t.colname = :colname";
                    KEY_SEMANTIC = (String)cmd.ExecuteScalar();
                    rqo.Columns.Add("KEY", KEY_SEMANTIC.Replace("~", "\n"));

                    // параметры поля семантики
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("tabid", OracleDbType.Decimal, this.TAB_ID.Value, ParameterDirection.Input);
                    cmd.Parameters.Add("colname", OracleDbType.Varchar2, this.SEMANTIC_FIELD, ParameterDirection.Input);
                    cmd.CommandText = "select t.semantic from meta_columns t where t.tabid = :tabid and t.colname = :colname";
                    SEMANTIC_SEMANTIC = (String)cmd.ExecuteScalar();

                    if (this.SEMANTIC_FIELD != null)
                        rqo.Columns.Add("SEMANTIC", SEMANTIC_SEMANTIC.Replace("~", "\n"));

                    // параметры отображаемых полей
                    if (this.SHOW_FIELDS != null)
                    {
                        foreach (String Col in this.SHOW_FIELDS.Split(','))
                        {
                            // семантика поля
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("tabid", OracleDbType.Decimal, this.TAB_ID.Value, ParameterDirection.Input);
                            cmd.Parameters.Add("colname", OracleDbType.Varchar2, Col.Trim().ToUpper(), ParameterDirection.Input);
                            cmd.CommandText = "select t.semantic from meta_columns t where t.tabid = :tabid and t.colname = :colname";
                            String colSemantic = (String)cmd.ExecuteScalar();

                            rqo.Columns.Add(Col.Trim().ToUpper(), String.IsNullOrEmpty(colSemantic) ? colSemantic : colSemantic.Replace("~", "\n"));
                        }
                    }

                    rqo.QuerySTMT = "select ";
                    rqo.QuerySTMT += this.KEY_FIELD + " as KEY ";
                    rqo.QuerySTMT += (this.SEMANTIC_FIELD == null ? "" : ", " + this.SEMANTIC_FIELD + " as SEMANTIC");
                    rqo.QuerySTMT += (this.SHOW_FIELDS == null ? "" : ", " + this.SHOW_FIELDS);
                    rqo.QuerySTMT += " from " + TAB_NAME + " " + this.WHERE_CLAUSE;
                    rqo.QuerySTMT += " " + this.ORDERBY_CLAUSE;

                    return rqo;
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }

            return null;
        }
        private String GetSemantic(String Val)
        {
            if (String.IsNullOrEmpty(Val)) return String.Empty;

            ReferQueryObject Ref = this.GenerateQueryObject();

            // выборка по ключевому полю
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = new OracleCommand(String.Format("select semantic from ({0}) where key = :p_key and rownum = 1", Ref.QuerySTMT), con);
            cmd.Parameters.Add("p_key", OracleDbType.Varchar2, Val, ParameterDirection.Input);

            if (con.State == ConnectionState.Closed) con.Open();
            try
            {
                Object res = cmd.ExecuteScalar();
                return (String)res;
            }
            catch
            {
                return String.Empty;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
        # endregion

        # region Приватные свойства
        # endregion

        # region Публичные свойства
        /// <summary>
        /// Gets or sets the tab index of the Web server control.
        /// </summary>
        [DefaultValue(0)]
        public short TabIndex
        {
            get { return ib.TabIndex; }
            set { ib.TabIndex = value; }
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
            }
        }

        /// <summary>
        /// Номер заявки
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public Decimal? BID_ID
        {
            get
            {
                Decimal? BID_ID = (ViewState["BID_ID"] == null ? (Decimal?)null : (Decimal)ViewState["BID_ID"]);
                return BID_ID;
            }
            set
            {
                ViewState["BID_ID"] = value;
            }
        }
        /// <summary>
        /// Идентификатор рабочего пространства
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public String WS_ID
        {
            get
            {
                String WS_ID = (ViewState["WS_ID"] == null ? (String)null : (String)ViewState["WS_ID"]);
                return WS_ID;
            }
            set
            {
                ViewState["WS_ID"] = value;
            }
        }
        /// <summary>
        /// Номер рабочего пространства
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public Decimal? WS_NUM
        {
            get
            {
                Decimal? WS_NUM = (ViewState["WS_NUM"] == null ? (Decimal?)null : (Decimal)ViewState["WS_NUM"]);
                return WS_NUM;
            }
            set
            {
                ViewState["WS_NUM"] = value;
            }
        }
        /// <summary>
        /// Значение контрола
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.TwoWay)]
        public String Value
        {
            get
            {
                return (h.Value == string.Empty ? (String)null : h.Value);
            }
            set
            {
                h.Value = value;
                this.Semantic = this.GetSemantic(value);

                tb.Text = value + (this.ShowSemantic ? String.Format(" - {0}", this.Semantic) : String.Empty);
            }
        }
        /// <summary>
        /// Семантика значения контрола
        /// </summary>
        [Category("Data")]
        public String Semantic
        {
            get
            {
                ViewState["Semantic"] = this.GetSemantic(this.Value);
                return (String)ViewState["Semantic"];
            }
            set
            {
                ViewState["Semantic"] = value;
            }
        }
        /// <summary>
        /// Идентификатор таблицы справочника
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public Decimal? TAB_ID
        {
            get
            {
                if (ViewState["TABID"] == null && !String.IsNullOrEmpty(TAB_NAME))
                {
                    OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                    OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("BASIC_INFO"), con);

                    if (con.State == ConnectionState.Closed) con.Open();
                    try
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_tabname", OracleDbType.Varchar2, this.TAB_NAME, ParameterDirection.Input);
                        cmd.CommandText = "select mt.tabid from meta_tables mt where mt.tabname = :p_tabname";
                        Object obj = cmd.ExecuteScalar();
                        if (obj != null)
                            ViewState["TABID"] = Convert.ToDecimal(obj);
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
                }

                return (Decimal?)ViewState["TABID"];
            }
            set
            {
                ViewState["TABID"] = value;
            }
        }
        /// <summary>
        /// Имя таблицы справочника
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public String TAB_NAME
        {
            get
            {
                return (String)ViewState["TAB_NAME"];
            }
            set
            {
                ViewState["TAB_NAME"] = value;
            }
        }
        /// <summary>
        /// Ключевое поле
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public String KEY_FIELD
        {
            get
            {
                return (String)ViewState["KEYFIELD"];
            }
            set
            {
                ViewState["KEYFIELD"] = value;
            }
        }
        /// <summary>
        /// Поле семантики
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public String SEMANTIC_FIELD
        {
            get
            {
                return (String)ViewState["SEMANTICFIELD"];
            }
            set
            {
                ViewState["SEMANTICFIELD"] = value;
            }
        }
        /// <summary>
        /// Поля для отображения (перечисление через запятую)
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public String SHOW_FIELDS
        {
            get
            {
                return (String)ViewState["SHOWFIELDS"];
            }
            set
            {
                ViewState["SHOWFIELDS"] = value;
            }
        }
        /// <summary>
        /// Условие отбора (включая слово where)
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public String WHERE_CLAUSE
        {
            get
            {
                return (String)ViewState["WHERECLAUSE"];
            }
            set
            {
                ViewState["WHERECLAUSE"] = value;
            }
        }
        /// <summary>
        /// Выражение сортировки (включая слово order by )
        /// </summary>
        [Category("Data")]
        [Bindable(true, BindingDirection.OneWay)]
        public String ORDERBY_CLAUSE
        {
            get
            {
                return (String)ViewState["ORDERBYCLAUSE"];
            }
            set
            {
                ViewState["ORDERBYCLAUSE"] = value;
            }
        }
        /// <summary>
        /// Идентификатор данных в сессии
        /// </summary>
        [Category("Data")]
        public String ReferDataSessionID
        {
            get
            {
                if (this.ViewState["REFERDATASESSIONID"] == null)
                {
                    this.ViewState["REFERDATASESSIONID"] = "REFER_DATA_" + Guid.NewGuid();
                }

                return (this.ViewState["REFERDATASESSIONID"] as string);
            }
        }

        /// <summary>
        /// Идентификатор МАКа
        /// </summary>
        [Category("Data")]
        public String MAC_ID
        {
            get
            {
                return (String)ViewState["MAC_ID"];
            }
            set
            {
                ViewState["MAC_ID"] = value;
            }
        }
        /// <summary>
        /// Идентификатор вопроса
        /// </summary>
        [Category("Data")]
        public String QUESTION_ID
        {
            get
            {
                return (String)ViewState["QUESTION_ID"];
            }
            set
            {
                ViewState["QUESTION_ID"] = value;
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
        [DefaultValue("cssTextBoxRefer")]
        [Bindable(true, BindingDirection.OneWay)]
        public String CssClass
        {
            get
            {
                return (tb.CssClass == "" ? "cssTextBoxRefer" : tb.CssClass);
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
                return !ib.Enabled;
            }
            set
            {
                ib.Enabled = !value;
                tb.Attributes.Add("readOnly", (value ? "true" : "false"));
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
                return tb.Enabled && ib.Enabled;
            }
            set
            {
                tb.Enabled = value;
                ib.Enabled = value;
                rfv.Enabled = value;
            }
        }
        /// <summary>
        /// Отабражать ли семантикузначения
        /// </summary>
        [Category("Appearance")]
        public Boolean ShowSemantic
        {
            get
            {
                return ViewState["ShowSemantic"] == null ? false : (Boolean)ViewState["ShowSemantic"];
            }
            set
            {
                ViewState["ShowSemantic"] = value;
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
                ib.Click += new ImageClickEventHandler(ib_Click);
            }
        }
        protected override void OnPreRender(EventArgs e)
        {
            // биндинг контролов
            Session[this.ReferDataSessionID] = this.GenerateQueryObject();

            ib.OnClientClick = String.Format("return referenceOpen('{0}', '{1}', '{2}', {3}, {4});", tb.ClientID, h.ClientID, ReferDataSessionID, (this.ValueChanged == null ? "false" : "true"), (this.ShowSemantic ? "true" : "false"));
            rfv.DataBind();

            // скрипт
            String ReferenceOpenScript = @"function referenceOpen(resultCtrlID, resultCtrlIDH, referDataSessionID, needPostBack, showSenamtic)
                                        {
                                            var rnd = Math.random();
                                            var result = window.showModalDialog('/barsroot/credit/usercontrols/dialogs/textboxrefer_show.aspx?refdatasid=' + referDataSessionID + '&rnd=' + rnd, window, 'dialogHeight:600px; dialogWidth:600px; resizable:yes');
                                            if (result != null && result.key != null) 
                                            {
                                                document.getElementById(resultCtrlID).value = result.key + (showSenamtic && result.semantic ? ' - ' + result.semantic : '');
                                                document.getElementById(resultCtrlIDH).value = result.key;
                                            }
                                            else return false;
                                            
                                            return needPostBack;
                                        }";
            ScriptManager.RegisterStartupScript(this, typeof(String), "ReferenceOpenScript", ReferenceOpenScript, true);

            // ручной ввод значения
            String ManualInputScript = @"function manualInput(CtrlID, CtrlIDH)
                                        {
                                            var rnd = Math.random();
                                            $get(CtrlIDH).value = $get(CtrlID).value;
                                        }";
            ScriptManager.RegisterStartupScript(this, typeof(String), "ManualInputScript", ManualInputScript, true);
            tb.Attributes.Add("onblur", String.Format("manualInput('{0}', '{1}'); ", tb.ClientID, h.ClientID));

            // добавляем семантику
            tb.Text = this.Value + (this.ShowSemantic && !String.IsNullOrEmpty(this.Semantic) ? String.Format(" - {0}", this.Semantic) : String.Empty);

            base.OnPreRender(e);
        }
        protected void ib_Click(object sender, ImageClickEventArgs e)
        {
            if (this.ValueChanged != null)
                this.ValueChanged(this, new EventArgs());
        }
        # endregion
    }
}