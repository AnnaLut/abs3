using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System.Collections;
using System.Collections.Generic;
using Bars.Configuration;
using Bars.DataComponents;

namespace DocInput
{
    public class SignItem
    {
        private decimal docId;
        public decimal DocId 
        {
            get { return docId; }
            set { docId = value; }
        }
        private decimal docRef;
        public decimal DocRef
        {
            get { return docRef; }
            set { docRef = value; }
        }
        private string docBuffer;
        public string DocBuffer
        {
            get { return docBuffer; }
            set { docBuffer = value; }
        }
        private string signBuffer;
        public string SignBuffer
        {
            get { return signBuffer; }
            set { signBuffer = value; }
        }        
    }
    
    public partial class DocExport : Bars.BarsPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadParams();
                //создает в таблице edocs записи для данного пользователя
                makeEdocs();
                switch (Request["type"])
                {
                    case "1": lblTitle.InnerText += Resources.docinput.GlobalResources.TitleFooterAdmin;
                        break;
                    case "2": lblTitle.InnerText += Resources.docinput.GlobalResources.TitleFooterUser;
                        break;
                }
            }
            if (SIGNS.Value != "")
            {
                storeEdocsSign();
                SIGNS.Value = "";
            }
            configureCurrentDs();
        }
        /// <summary>
        /// Загружает параметры в скрытые поля
        /// </summary>
        private void loadParams()
        {
            BARSAXVER.Value = Bars.Configuration.ConfigurationSettings.AppSettings["BarsAx.Version"];
            InitOraConnection();
            try
            {
                //wr_edocs identified using bars_role_auth
                SQL_NONQUERY( currentSetRoleCmd() );

                //вычитать и заполнить параметры
                SQL_Reader_Exec(@"
                    select 'SEPNUM' as par,  nvl( max(val),1 ) as val from params where par = 'SEPNUM'
                    union all
                    select 'SIGNTYPE' as par, nvl(max(val),'NBU') from params where par = 'SIGNTYPE'
                    union all
                    select 'DOCKEY' as par, docsign.getidOper() from dual
                    union all
                    select 'REGNCODE' as par, max(val) from params where par = 'REGNCODE'
                    union all
                    select 'BDATE' as par, to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') from dual"
                );

                if (SQL_Reader_Read()) do
                    {
                        string par = String.Empty;
                        string val = String.Empty;

                        if (null != SQL_Reader_GetValues())
                        {
                            par = SQL_Reader_GetValues()[0].ToString();
                            val = SQL_Reader_GetValues()[1].ToString();
                        }

                        switch (par)
                        {
                            case "SEPNUM": SEPNUM.Value = val;
                                break;
                            case "SIGNTYPE": SIGNTYPE.Value = val;
                                break;
                               case "DOCKEY": DOCKEY.Value = val;
                                break;
                            case "REGNCODE": REGNCODE.Value = val; 
                                break;
                            case "BDATE": BDATE.Value = val;
                                break;
                        }
                    } while (SQL_Reader_Read());
                SQL_Reader_Close();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        /// <summary>
        /// Создает набор экспортируемых проводок для пользователя
        /// по всем референсам  в очереди данного пользователя
        /// </summary>
        private void makeEdocs()
        {
            //коннект к базе и транзакия
            InitOraConnection();
            //wr_edocs identified using bars_role_auth
            SQL_NONQUERY( currentSetRoleCmd() );
            try
            {
                BeginTransaction();
                bool txCommited = false;
                try
                {
                    int count = 0;
                    string procName = "bars_edocs.make_edocs";
                    ClearParameters();
                           
                    switch (Request["type"])
                    {
                        case "1":  
                            SetParameters("p_userid", DB_TYPE.Int32, null, DIRECTION.Input);
                            procName = "bars_edocs_int.make_edocs";
                            break;
                    }
                    SetParameters("p_count", DB_TYPE.Int32, count, DIRECTION.Output);         
                    SQL_PROCEDURE(procName);
                    commitTransaction();
                    txCommited = true;
                }
                finally
                {
                    if (!txCommited) RollbackTransaction();
                }
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        /// <summary>
        /// Получает подписи из скрытого поля и сохраняет данные в базу
        /// </summary>
        private void storeEdocsSign()
        {
            //коннект к базе
            InitOraConnection();
            SQL_NONQUERY(currentSetRoleCmd());
            try
            {
                Hashtable signs = new Hashtable();
                
                //получить массив строк имя=значение
                //имя - id проводки, значение - буфер подписи
                string[] signsList = SIGNS.Value.Split(Convert.ToChar(";"));

                //коллекция подписей
                List<SignItem> items = new List<SignItem>();

                //пройтись по массиву
                for (int i = 0; i < signsList.Length; i++)
                {
                    #region Разбить строку имя=значения на составляющие

                    string[] signItem = signsList[i].Split(Convert.ToChar("="));

                    //если некорректное кол-во 
                    if (signItem.Length != 2) continue;

                    string docIdAndRef = String.Empty;
                    SignItem item = new SignItem();
                    docIdAndRef = signItem[0];
                    item.DocId = Convert.ToDecimal(docIdAndRef.Split(Convert.ToChar("|"))[0]);
                    item.DocRef = Convert.ToDecimal(docIdAndRef.Split(Convert.ToChar("|"))[1]);
                    item.SignBuffer = signItem[1];

                    #endregion

                    #region Получить буфер документа

                    object res = null;
                    ClearParameters();
                    SetParameters("p_docId", DB_TYPE.Decimal, item.DocId, DIRECTION.Input);
                    switch (Request["type"])
                    {
                        case "1":
                            res = SQL_SELECT_scalar("select rawtohex(utl_raw.cast_to_raw(bars_edocs_int.get_edoc_buf(null, :p_docId))) from dual");
                            break;
                        case "2":
                            res = SQL_SELECT_scalar("select rawtohex(utl_raw.cast_to_raw(bars_edocs.get_edoc_buf(:p_docId))) from dual");
                            break;
                    }
                    item.DocBuffer = null == res ? String.Empty : Convert.ToString(res);

                    //добавить в коллекцию
                    items.Add(item);

                    #endregion

                }

                //если нечего сохранять - выход
                if (0 == items.Count) return;

                string sourceName = String.Empty;
                switch (Request["type"])
                {
                    case "1":
                        sourceName = "v_all_edocs";
                        break;
                    case "2":
                        sourceName = "v_user_edocs";
                        break;
                }

                //коллекция содержит список документов, проводки которых подписываются
                List<SignItem> docItems = new List<SignItem>();
                foreach (SignItem item in items)
                {
                    if (!docItems.Exists(delegate(SignItem i) { return item.DocRef == i.DocRef; }))
                        docItems.Add(item);
                }

                //Здесь проверяется сколько проводок содержится в документе 
                //и сколько проводок мы подписываем. Подписывать можно 
                //только все проводки документа
                List<SignItem> notCompletedItems = new List<SignItem>();
                decimal totalCount = 0;
                foreach (SignItem item in docItems)
                {
                    ClearParameters();
                    SetParameters("p_ref", DB_TYPE.Decimal, item.DocRef, DIRECTION.Input);
                    object res = SQL_SELECT_scalar(String.Format("select count(*) from {0} where ref=:p_ref", sourceName));
                    totalCount = null == res ? -1 : Convert.ToDecimal(res);
                    if (totalCount != items.FindAll(delegate(SignItem i) { return item.DocRef == i.DocRef; }).Count)
                    {
                        notCompletedItems.Add(item);
                        items.RemoveAll(delegate(SignItem i) { return item.DocRef == i.DocRef; });
                    }
                }

                #region Выполнить процедуру сохранения подписи

                foreach (SignItem item in items)
                {
                    string procName = "";
                    ClearParameters();
                    //в зависимости от параметра QueryString выбрать нужную процедуру сохранения
                    switch (Request["type"])
                    {
                        case "1":
                            SetParameters("p_userid", DB_TYPE.Int64, null, DIRECTION.Input);
                            procName = "bars_edocs_int.store_edoc_sign";
                            break;
                        case "2":
                            procName = "bars_edocs.store_edoc_sign";
                            break;
                        default: return;
                            break;
                    }
                    SetParameters("p_docid", DB_TYPE.Int64, item.DocId, DIRECTION.Input);
                    SetParameters("p_buf", DB_TYPE.Varchar2, item.DocBuffer, DIRECTION.Input);
                    SetParameters("p_id_o", DB_TYPE.Varchar2, IDOPER.Value, DIRECTION.Input);
                    SetParameters("p_sign", DB_TYPE.Varchar2, item.SignBuffer, DIRECTION.Input);
                    SQL_PROCEDURE(procName);
                }

                //вывод сообщения об ошибках подписи проводок
                if (0 != notCompletedItems.Count)
                {
                    Label lbl = new Label();
                    lbl.Attributes.Add("class", "lblError");
                    lbl.Text = Resources.docinput.GlobalResources.ExpSignError;
                    placeHolder.Controls.Add(lbl);
                    placeHolder.Controls.Add(new LiteralControl("<br/>"));

                    foreach (SignItem item in notCompletedItems)
                    {
                        lbl = new Label();
                        lbl.Attributes.Add("class", "lblError");
                        lbl.Text += " - " + item.DocRef;
                        placeHolder.Controls.Add(lbl);
                        placeHolder.Controls.Add(new LiteralControl("<br/>"));
                    }

                    lbl = new Label();
                    lbl.Attributes.Add("class", "lblError");
                    lbl.Text = Resources.docinput.GlobalResources.ExpSignErrorDesc;
                    placeHolder.Controls.Add(lbl);
                    placeHolder.Controls.Add(new LiteralControl("<br/>"));
                }
                #endregion
            }
            finally
            {
                DisposeOraConnection();
            }            
        }

        /// <summary>
        /// Возвращает роль в зависимости от параметра в QueryString
        /// </summary>
        private string currentRoleName()
        {
            switch (Request["type"])
            {
                case "1": return "WR_EDOCS_ADM";
                    break;
                case "2": return "WR_EDOCS";
                    break;
                default: return "START1";
            }
        }
        /// <summary>
        /// Возвращает команду установки роли в зависимости от параметра в запросе
        /// </summary>
        private string currentSetRoleCmd()
        {
            //role identified using package bars_role_auth
            return String.Format(@"begin bars_role_auth.set_role('{0}'); end;", currentRoleName());
        }
        /// <summary>
        /// Возвращает текущий datasource в зависимости от параметра Type в QueryString
        /// </summary>
        private BarsSqlDataSource currentDs()
        {
            switch (Request["type"])
            {
                case "1":
                    //добавить колонку с именем пользователя
                    BoundField fld = new BoundField();
                    fld.DataField = "FIO";
                    fld.HeaderText = Resources.docinput.GlobalResources.FIO;
                    fld.ItemStyle.Wrap = false;
                    fld.ItemStyle.Width = 250;
                    gv.Columns.Insert(4, fld);
                    return dsAll;
                    break;
                case "2": return ds;
                    break;
                default: return null;
            }
        }
        /// <summary>
        /// В зависимости от параметра type в QueryString выбирает нужный DataSource
        /// </summary>
        private void configureCurrentDs()
        {
            BarsSqlDataSource currDs = currentDs();
            if (null != currDs)
            {
                gv.DataSourceID = currDs.ID;
                currDs.PreliminaryStatement = currentSetRoleCmd();
                currDs.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            }
        }
    }
}
