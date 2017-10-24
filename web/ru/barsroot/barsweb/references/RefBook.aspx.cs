using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Resources;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.DataComponents;
using Bars.Classes;

namespace barsweb.References
{
    
    //
    //прикладное исключение
    //
    public class BarsReferencesException : Exception
    {
        public BarsReferencesException(string message) : base(message) { }
    }

    public struct SortInfo
    {
        public string Column;
        public int Order;
        public string Way;
    }

    //
    //колонка таблицы метаданных
    //
    public class MetaTableColumn
    {
        public MetaTableColumn( object ColId,  object ColName,  object ColType,
             object Semantic,  object ShowWidth,  object ShowMaxChar,  object ShowPos, 
             object ShowRetVal, object InstnsSemantic,  object Extrnval, object SrcTabId, 
             object SrcColId, object SortOrder, object SortWay, object ShowFormat, object FilterTabid, 
             object FilterCondition, object FilterCode, object ShowResult) 
        {
            this.ColId = Convert.ToDecimal(ColId);
            this.ColName = Convert.ToString(ColName);
            this.ColType = Convert.ToChar(ColType);
            this.Semantic = Convert.ToString(Semantic).Replace("~", " ");
            this.ShowWidth = Convert.ToString(ShowWidth) == String.Empty ? -1 : Convert.ToDouble(ShowWidth);
            this.ShowMaxChar = Convert.ToString(ShowMaxChar) == String.Empty ? -1 : Convert.ToDecimal(ShowMaxChar);
            this.ShowPos = Convert.ToString(ShowPos) == String.Empty ? -1 : Convert.ToDecimal(ShowPos);
            this.ShowRetVal = Convert.ToString(ShowRetVal) == String.Empty ? -1 : Convert.ToDecimal(ShowRetVal);
            this.InstnsSemantic = Convert.ToString(InstnsSemantic) == String.Empty ? -1 : Convert.ToDecimal(InstnsSemantic);
            this.Extrnval = Convert.ToString(Extrnval) == String.Empty ? -1 : Convert.ToDecimal(Extrnval);
            this.SrcTabId = Convert.ToString(SrcTabId) == String.Empty ? -1 : Convert.ToDecimal(SrcTabId);
            this.SrcColId = Convert.ToString(SrcColId) == String.Empty ? -1 : Convert.ToDecimal(SrcColId);
            this.Sort.Order = DBNull.Value == SortOrder ?  -1 : Convert.ToInt32(SortOrder);
            this.Sort.Way = DBNull.Value == SortWay ? String.Empty : SortWay.ToString();
            this.Sort.Column = Convert.ToString(ColName);
            this.ShowFormat = Convert.ToString(ShowFormat);
            this.FilterTabId = Convert.ToDecimal(FilterTabid);
            this.FilterCondition = Convert.ToString(FilterCondition);
            this.FilterCode = Convert.ToString(FilterCode);
            this.ShowResult = Convert.ToString(ShowResult);
        }

        public MetaTableColumn() { }

        public SortInfo Sort;

        private decimal colId;
        public decimal ColId
        {
            get { return colId; }
            set { colId = value; }
        }

        private string colName;
        public string ColName
        {
            get { return colName; }
            set { colName = value; }
        }

        private char colType;
        public char ColType
        {
            get { return colType; }
            set { colType = value; }
        }
 
        private string semantic;
        public string Semantic
        {
            get 
            { 
                if (String.Empty == semantic) semantic = ColName;
                return semantic;
            }
            set { semantic = value; }
        }

        private double showWidth;
        public double ShowWidth
        {
            get { return showWidth; }
            set { showWidth = value; }
        }

        private string showFormat;
        public string ShowFormat
        {
            get { return showFormat; }
            set { showFormat = value; }
        }

        private decimal showMaxChar;
        public decimal ShowMaxChar
        {
            get { return showMaxChar; }
            set { showMaxChar = value; }
        }

        private decimal showPos;
        public decimal ShowPos
        {
            get { return showPos; }
            set { showPos = value; }
        }

        private decimal showRetVal;
        public decimal ShowRetVal
        {
            get { return showRetVal; }
            set { showRetVal = value; }
        }

        private decimal instnsSemantic;
        public decimal InstnsSemantic
        {
            get { return instnsSemantic; }
            set { instnsSemantic = value; }
        }

        private decimal extrnval;
        public decimal Extrnval
        {
            get { return extrnval; }
            set { extrnval = value; }
        }

        private decimal srcTabId;
        public decimal SrcTabId
        {
            get { return srcTabId; }
            set { srcTabId = value; }
        }

        private decimal srcColId;
        public decimal SrcColId
        {
            get { return srcColId; }
            set { srcColId = value; }
        }

        private decimal filterTabId;
        public decimal FilterTabId
        {
            get { return filterTabId; }
            set { filterTabId = value; }
        }

        private string filterCondition;
        public string FilterCondition
        {
            get { return filterCondition; }
            set { filterCondition = value; }
        }

        private string filterCode;
        public string FilterCode
        {
            get { return filterCode; }
            set { filterCode = value; }
        }
        private string showResult;
        public string ShowResult
        {
            get { return showResult; }
            set { showResult = value; }
        }
    }

    //
    //таблица метаданных
    //
    public class MetaTable
    {
        public MetaTable() {}

        private decimal id;
        public decimal Id
        {
            get { return id; }
            set { id = value; }
        }

        private string name;
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private string semantic;
        public string Semantic
        {
            get { return semantic; }
            set { semantic = value; }
        }

        private bool logicDelete;
        public bool LogicDelete
        {
            get { return logicDelete; }
            set { logicDelete = value; }
        }

        private bool processed;
        public bool Processed
        {
            get { return processed; }
            set { processed = value; }
        }

        public List<MetaTableColumn> Columns;

    }

    public enum CommandTypes {Select, Insert, Update, Delete}

    //
    //класс страницы
    //
    public partial class RefForm : Bars.BarsPage
    {
        public const string CURRENT_VERSION = "version 2.8";
        private decimal curTabId = -1;
        private string curMode = String.Empty;
        private string curForce = String.Empty;
        private string curFlag = String.Empty;
        private string mainTableAlias = "t";
        private bool isResultsShow = false;
        private MetaTable mainTable = null;
        private string totalsCommand = String.Empty;
        private bool commandOverrided = false;

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
        }

        //
        //генерирует исключение с текстом из локальных ресурсов
        //
        private void throwRefException(string localResourceName, params object[] args)
        {
            divMsg.Visible = true;
            divMsg.InnerText = String.Format(getResourceStr(localResourceName), args);
        }

        private string getResourceStr(string localResourceName)
        {
            string ui_culture = System.Threading.Thread.CurrentThread.CurrentCulture.Name.Substring(0, 2);
            return (string)GetLocalResourceObject(ui_culture.ToLower() + "_" + localResourceName);
        }

        //
        //проверяет параметры url и заполняет в случае корректности приватные переменные
        //
        private void parseRequestParams()
        {

            if ((null == Request["tabid"] && null == Request["tabname"]) || null == Request["mode"])
                throwRefException("InvalidArguments");

            try
            {
                string tid = Request["tabid"];
                if (null != Request["tabname"] && !String.IsNullOrEmpty(Request["tabname"]))
                {
                    tid = getTabIdByTabName(Request["tabname"]);
                }
                curTabId = Int32.Parse(tid);
                curMode = Request["mode"];
            }
            catch (FormatException)
            {
                throwRefException("InvalidArguments");
            }

            if (curTabId <= 0 || String.IsNullOrEmpty(curMode) || (curMode != "RO" && curMode != "RW"))
            {
                throwRefException("InvalidArguments");
            }

            curForce = Request["force"];
            curFlag = Request["rwflag"];

        }

        private string getTabIdByTabName(string tabName)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand command = connection.CreateCommand();
            
            try
            {
                //роль для доступа к схеме метаданных
                command.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_METATAB");
                command.ExecuteNonQuery();

                //получить tabid по tabname
                command.CommandText = "select tabid from meta_tables where tabname=:tname";
                command.Parameters.Add(new OracleParameter("tname", OracleDbType.Varchar2, tabName.ToUpper(), ParameterDirection.Input));
                

                OracleDataReader rdr = command.ExecuteReader();
                object obj = null;
                if (rdr.Read())
                    obj = rdr[0];
                if (obj != null)
                {
                    return obj.ToString();
                }
                else
                {
                    throw new Exception("Таблица " + tabName + " не найдена");
                }
            }
            finally
            {
                connection.Close();
                connection.Dispose();
                connection = null;
            }
        }

        //
        //проверяет доступность справочника для пользователя
        //если доступа нет, сгенерируется исключение
        //
        private void checkRefAccess(OracleCommand command)
        {
            command.Parameters.Clear();
            command.Parameters.Add("tabid", OracleDbType.Int32, curTabId, ParameterDirection.Input);
            command.CommandText = @"
                select trim(upper(r.acode)) as acode
                  from applist_staff a, refapp  r
                 where r.codeapp = a.codeapp
                   and r.tabid = :tabid
                   and a.id = user_id
                   and rownum < 2
                 order by r.acode desc nulls last
            ";
            object res = command.ExecuteScalar();
            string mode = Convert.ToString(res);
            if (String.IsNullOrEmpty(mode) && curForce != "1")
            {
                throwRefException("NotEnoughPrivsForView");
            }
            else if (mode == "RO" && curMode == "RW")
            {
                throwRefException("NotEnoughPrivsForEdit");
            }
        }

        //
        //добавляет контролы для редактирования справочника
        //
        private void addEditControls()
        {

            //колонка с кнопками редактирования/удаления    
            CommandField cf = new CommandField();

            cf.DeleteText = Resources.barsweb.GlobalResources.vDelete;
            cf.EditText = Resources.barsweb.GlobalResources.vEdit;
            cf.UpdateText = Resources.barsweb.GlobalResources.vSave;
            cf.CancelText = Resources.barsweb.GlobalResources.vCancel;
            cf.ButtonType = ButtonType.Image;
            cf.UpdateImageUrl = "/common/images/default/16/save.png";
            cf.CancelImageUrl = "/common/images/default/16/cancel_blue.png";
            cf.EditImageUrl = "/common/images/default/16/open_blue.png";
            cf.DeleteImageUrl = "/common/images/default/16/cancel_blue.png";
            cf.HeaderStyle.Width = 35;
            gv.Columns.Add(cf);

            //кнопки вставки данных
            gv.NewRowStyle.InsertButtonText = Resources.barsweb.GlobalResources.vSave;
            gv.NewRowStyle.NewButtonText = Resources.barsweb.GlobalResources.vAdd;
            gv.NewRowStyle.СancelNewButtonText = Resources.barsweb.GlobalResources.vCancel;



            /*
                0 - Режим "позволено все" + фильтр при старте.
                1 - Режим "просмотр" + фильтр при старте
                2 - Режим "просмтор" + Update
                3 - Режим "просмтор" + Insert
                4 - Режим "просмтор" + Delete
                5 - Режим "просмтор" + Update + Insert
                6 - Режим "просмтор" + Update + Delete
                7 - Режим "просмтор" + Insert + Delete            
            */

            if (curFlag != String.Empty && curFlag != null)
            {
                cf.ShowEditButton = curFlag == "0" || curFlag == "2" || curFlag == "5" || curFlag == "6";
                cf.ShowCancelButton = curFlag == "0";
                cf.ShowDeleteButton = curFlag == "0" || curFlag == "4" || curFlag == "6" || curFlag == "7";
                gv.AutoGenerateNewButton = curFlag == "0" || curFlag == "3" || curFlag == "5" || curFlag == "7";
            }
            else
            {
                cf.ShowEditButton = true;
                cf.ShowCancelButton = true;
                cf.ShowDeleteButton = true;
                gv.AutoGenerateNewButton = true;
            }
            
        }

        //
        //получает параметры таблицы по id
        //
        private MetaTable initMetaTable(OracleConnection connection, decimal tabId)
        {
            MetaTable mt = new MetaTable();

            #region основные параметры таблицы

            OracleCommand command1 = connection.CreateCommand();
            command1.Parameters.Add("tabid", OracleDbType.Int32, tabId, ParameterDirection.Input);
            command1.CommandText = @"
                select 
                    tabname, 
                    semantic, 
                    tabldel 
                from meta_tables 
                where tabid=:tabid";
            OracleDataReader rdr1 = command1.ExecuteReader();
            try
            {
                if (rdr1.Read())
                {
                    mt.Id = tabId;
                    mt.Name = Convert.ToString(rdr1["tabname"]);
                    mt.Semantic = Convert.ToString(rdr1["semantic"]);
                    if (String.IsNullOrEmpty(Convert.ToString(rdr1["tabldel"])))
                        mt.LogicDelete = false;
                    else
                        mt.LogicDelete = 1 == Convert.ToInt16(rdr1["tabldel"]);
                }
                else
                {
                    throwRefException("TableNotFound", tabId);
                }
            }
            finally
            {
                rdr1.Close();
            }

            #endregion

            #region колонки таблицы

            mt.Columns = new List<MetaTableColumn>();

            command1.CommandText = @"
                select c.colid f0, c.colname f1, c.coltype f2, c.semantic f3, 
                       c.showwidth f4, c.showmaxchar f5, c.showpos f6,
                       c.showretval f7, c.instnssemantic f8, c.extrnval f9, 
                       o.sortorder f10, o.sortway f11, c.showformat f12, c.showresult f13
                from meta_columns c, meta_sortorder o 
                where c.tabid= :tabid  
                  and c.tabid = o.tabid (+) 
                  and c.colid = o.colid (+)
                order by c.showpos";

            rdr1 = command1.ExecuteReader();
            try
            {
                while (rdr1.Read())
                {
                    object srcTabId = null;
                    object srcColId = null;

                    //если поле - FK, получить ID внешней таблицы и колонки 
                    if (Convert.ToString(rdr1[9]) == "1")
                    {
                        OracleCommand command2 = connection.CreateCommand();
                        command2.Parameters.Add("tabid", OracleDbType.Decimal, tabId, ParameterDirection.Input);
                        command2.Parameters.Add("colid", OracleDbType.Decimal, rdr1[0], ParameterDirection.Input);
                        command2.CommandText = @"
                                select 
                                     srctabid, 
                                     srccolid 
                                from meta_extrnval 
                               where tabid=:tabid 
                                 and colid=:colid";
                        OracleDataReader rdr2 = command2.ExecuteReader();
                        try
                        {
                            if (rdr2.Read())
                            {
                                srcTabId = rdr2["srctabid"];
                                srcColId = rdr2["srccolid"];
                            }
                            else
                            {
                                throwRefException("FKTableNotFound",
                                    Convert.ToString(rdr1[1]), mt.Name);
                            }

                        }
                        finally
                        {
                            rdr2.Close();
                        }

                    }

                    OracleCommand command3 = connection.CreateCommand();
                    command3.Parameters.Add("tabid", OracleDbType.Decimal, tabId, ParameterDirection.Input);
                    command3.Parameters.Add("colid", OracleDbType.Decimal, rdr1[0], ParameterDirection.Input);
                    command3.CommandText = @"
                            select 
                              t.tabid, 
                              t.colid, 
                              t.filter_tabid, 
                              t.filter_code,
                              c.condition,
                              mt.tabname as filter_tabname
                            from 
                              meta_filtertbl t, 
                              meta_filtercodes c,
                              meta_tables mt
                            where t.filter_code = c.code
                              and mt.tabid = t.filter_tabid
                              and t.tabid=:tabid
                              and t.colid=:colid
                    ";
                    string filterCondition = String.Empty;
                    decimal filterTabId = -1;
                    string filterCode = String.Empty;
                    OracleDataReader rdr3 = command3.ExecuteReader();
                    try
                    {
                        if (rdr3.Read())
                        {
                            filterCondition = Convert.ToString(rdr3["condition"]);
                            filterTabId = Convert.ToDecimal(rdr3["filter_tabid"]);
                            filterCode = Convert.ToString(rdr3["filter_code"]);
                        }
                    }
                    finally
                    {
                        rdr3.Close();
                    }


                    MetaTableColumn column = new MetaTableColumn(
                        rdr1[0], rdr1[1], rdr1[2], rdr1[3], rdr1[4],
                        rdr1[5], rdr1[6], rdr1[7], rdr1[8], rdr1[9],
                        srcTabId, srcColId, rdr1[10], rdr1[11], rdr1[12],
                        filterTabId, filterCondition, filterCode, rdr1[13]);
                    mt.Columns.Add(column);
                }

                //если поля для таблицы не найдены - исключение
                if (0 == mt.Columns.Count)
                {
                    throwRefException("MetaColumnsNotFound", mt.Name);
                }
            }
            finally
            {
                rdr1.Close();
            }

            #endregion

            return mt;
        }

        //
        //получает выражение для установки роли на редактирование
        //
        private string getEditRole(OracleCommand command, decimal tabId)
        {
            command.Parameters.Clear();
            command.Parameters.Add("tabid", OracleDbType.Int32, tabId, ParameterDirection.Input);
            command.CommandText = "select role2edit from references where tabid=:tabid";

            //роль для редактирования
            string res = Convert.ToString(command.ExecuteScalar());

            //если переданный режим - RW а роли нет, генерируем исключение
            if (String.IsNullOrEmpty(res) && curMode == "RW")
            {
                throwRefException("EditRoleNotFound", tabId);
            }
            return OraConnector.Handler.IOraConnection.GetSetRoleCommand(res);
        }

        //
        //устанавливает свойства колонки
        //
        private void setupColumn(MetaTableColumn mtColumn, BarsBoundFieldEx gvColumn)
        {
            gvColumn.HeaderText = mtColumn.Semantic;
            gvColumn.SortExpression = gvColumn.DataField;

            //ширина колонки
            if (-1 != mtColumn.ShowWidth)
            {
                double sizeInches = mtColumn.ShowWidth / 1.5;
                if (sizeInches < 1.15) sizeInches = 1.15;
                gvColumn.HeaderStyle.Width = new Unit(sizeInches, UnitType.Inch);
            }
            else
            {
                gvColumn.HeaderStyle.Width = new Unit(1.15, UnitType.Inch);
            }

            //максимальная ширина
            if (-1 != mtColumn.ShowMaxChar)
            {
                gvColumn.MaxLength = (int)mtColumn.ShowMaxChar;
            }
            else
            {
                gvColumn.MaxLength = -1;
            }
        }


        //
        //загрузка страницы
        //
        protected void Page_Load(object sender, EventArgs e)
        {
            divMsg.Visible = false;
            divVer.InnerText = CURRENT_VERSION;
        }


        //
        //инициализация страницы
        //
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            //разобрать параметры url в приватные поля
            parseRequestParams();

            //строка соединения для грида
            ds.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            ds.Selecting += new SqlDataSourceSelectingEventHandler(ds_Selecting);
            ds.Updating += new SqlDataSourceCommandEventHandler(ds_Updating);
            ds.Inserting += new SqlDataSourceCommandEventHandler(ds_Inserting);
            ds.Deleting += new SqlDataSourceCommandEventHandler(ds_Deleting);


            //подключение к БД
            OracleConnection connection = OraConnector.Handler.UserConnection; //new OracleConnection(ds.ConnectionString);

            try
            {
                //роль для справочников
                OracleCommand command = connection.CreateCommand();
                command.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_REFREAD");
                command.ExecuteNonQuery();

                //роль для просмотра справочников
                ds.PreliminaryStatement = command.CommandText;

                //роль для доступа к схеме метаданных
                command.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_METATAB");
                command.ExecuteNonQuery();

                //проверить права на справочник
                checkRefAccess(command);

                //обработка режима редактирования
                if ("RW" == curMode)
                {
                    addEditControls();

                    //роль для редактирования
                    command.Parameters.Clear();
                    command.CommandText = getEditRole(command, curTabId);
                    command.ExecuteNonQuery();
                    //используем роль для редактирования справочника
                    ds.PreliminaryStatement = command.CommandText;

                }

                //красивые кнопочкпи пейджера
                gv.PagerSettings.NextPageImageUrl = "/common/images/default/16/arrow_right.png";
                gv.PagerSettings.PreviousPageImageUrl = "/common/images/default/16/arrow_left.png";
                gv.PagerSettings.PreviousPageText = getResourceStr("Previous");
                gv.PagerSettings.NextPageText = getResourceStr("Next");

                //коллекция внешних таблиц
                List<MetaTable> fkTables = new List<MetaTable>();

                //загрузить таблицу в объект
                mainTable = initMetaTable(connection, curTabId);

                //установить заголовок справочника 
                Label1.Text = mainTable.Semantic;

                //генерация колонок
                generateColumns(connection, fkTables, mainTable);

                //генерация SQL-конструкций
                generateSqlStmts(fkTables, mainTable);
            }
            finally
            {
                connection.Close();
            }
        }

        private List<String> GetParameterNames(string commandText)
        {
            MatchCollection matches = Regex.Matches(commandText, @":\S([A-Za-z0-9_-]*)");
            List<string> res = new List<string>(matches.Count);
            foreach (Match m in matches)
            {
                res.Add(m.Value.ToUpper().Substring(1));
            }
            return res;
        }

        private OracleDbType getOracleDbType(char ColType)
        {
            switch (ColType)
            {
                case 'N':
                    return OracleDbType.Decimal;
                case 'C':
                    return OracleDbType.Varchar2;
                case 'D':
                    return OracleDbType.Date;
                case 'B':
                    return OracleDbType.Decimal;
                case 'S':
                case 'U':
                case 'A':
                default:
                    return OracleDbType.Varchar2;

            }
        }

        private List<OracleParameter> GetActionParameters(ref OracleCommand command)
        {
            String name = String.Empty;
            List<String> parNames = GetParameterNames(command.CommandText);
            List<OracleParameter> res = new List<OracleParameter>();
            foreach (OracleParameter p in command.Parameters)
            {
                name = parNames.Find(delegate(string s) { return s == p.ParameterName; });
                if (!String.IsNullOrEmpty(name))
                {
                    OracleParameter n = (OracleParameter)p.Clone();
                    res.Add(n);
                }
            }
            return res;
        }

        private bool OverrideCommand(CommandTypes type, OracleCommand command)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand c = connection.CreateCommand();
            c.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_METATAB");
            c.ExecuteNonQuery();
            c.CommandText = "select action_proc from META_ACTIONTBL where tabid = :tabid and action_code = :acode";
            c.Parameters.Add(new OracleParameter("tabid", OracleDbType.Decimal, curTabId, ParameterDirection.Input));
            c.Parameters.Add(new OracleParameter("acode", OracleDbType.Varchar2, type.ToString().ToUpper(), ParameterDirection.Input));
            object obj = c.ExecuteScalar();
            connection.Close();
            connection.Dispose();
            if (null != obj)
            {
                command.CommandText = String.Format("begin {0}; end;", obj.ToString());
                command.CommandType = CommandType.Text;
                command.BindByName = true;
                List<OracleParameter> pars = GetActionParameters(ref command);
                command.Parameters.Clear();
                command.Parameters.AddRange(pars.ToArray());
                command.Connection.Open();
                try
                {
                    command.CommandText = 
                        command.CommandText.ToLower().
                            Replace("string_null", "null").
                            Replace("number_null", "null").
                            Replace("datetime_null", "null");

                    command.ExecuteNonQuery();
                    commandOverrided = true;
                }
                finally
                {
                    command.Connection.Close();
                }
                return true;
            }
            return false;
        }

        void ds_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            OracleCommand command = (OracleCommand)e.Command;
            e.Cancel =  OverrideCommand(CommandTypes.Delete, command);
        }

        void ds_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            OracleCommand command = (OracleCommand)e.Command;
            e.Cancel = OverrideCommand(CommandTypes.Insert, command);            
        }

        void ds_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            OracleCommand command = (OracleCommand)e.Command;
            OverrideCommand(CommandTypes.Update, command);       
            
        }

        void ds_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //((OracleCommand)e.Command).BindByName = false;
            string FilterCondition = getFilterStmt(Request["code"]);
            if (String.Empty != FilterCondition)
            {
                foreach (object obj in Request.Params)
                {
                    if (null == obj) continue;
                    if (obj.ToString().ToLower().StartsWith("mtpar_"))
                    {
                        string t = obj.ToString().ToLower().Substring(6, 1);
                        if (t == "d")
                        {
                            DateTime val = DateTime.ParseExact(Request[obj.ToString()], "ddMMyyyy",  new CultureInfo("en-US"));
                            ((OracleCommand)e.Command).Parameters.Add(obj.ToString().Substring(8), OracleDbType.Date, val, ParameterDirection.Input);
                        }
                        else
                        {
                            ((OracleCommand)e.Command).Parameters.Add(obj.ToString().Substring(8), Request[obj.ToString()]);
                        }
                    }
                }
            }
        }

        //
        //создает колонки грида
        //
        private void generateColumns(OracleConnection connection, List<MetaTable> fkTables, MetaTable mainTable)
        {
            //gv.Columns.Clear();

            //список колонок основной таблицы
            foreach (MetaTableColumn column in mainTable.Columns)
            {
                BarsBoundFieldEx gvColumn = new BarsBoundFieldEx(gv); ;

                //отображение линка для перехода вглубь
                if (String.Empty != column.FilterCode)
                {
                    //добавить TemplateField для 
                    TemplateField col = new TemplateField();
                    col.HeaderText = column.Semantic;

                    string filterCode = column.FilterCode;
                    string colName = column.ColName;
                    string filterCondition = column.FilterCondition;
                    string filterTabId = column.FilterTabId.ToString();
                    col.ItemTemplate = new CompiledTemplateBuilder(delegate(Control item)
                    {

                        HtmlAnchor a = new HtmlAnchor();
                        item.Controls.Add(a);
                        a.DataBinding += delegate
                        {
                            int pos = 0;
                            string pars = "&code=" + filterCode;
                            foreach (MetaTableColumn c in mainTable.Columns)
                            {
                                if (filterCondition.ToUpper().Contains(":" + c.ColName.ToUpper()))
                                {
                                    object obj = DataBinder.Eval(a.BindingContainer, "DataItem." + c.ColName);
                                    if (null == obj) continue;
                                    string val = String.Empty;
                                    if (c.ColType == 'D')
                                    {
                                        val = ((DateTime)obj).ToString("ddMMyyyy");
                                    }
                                    else
                                    {
                                        val = obj.ToString();
                                    }
                                    pars += "&mtpar_" + c.ColType + "_" +  c.ColName.ToLower() + "=" + val;
                                    pos++;
                                }
                            }
                            a.InnerText = DataBinder.Eval(a.BindingContainer, "DataItem." + colName).ToString();
                            a.HRef = "/barsroot/barsweb/References/RefBook.aspx?tabid=" + filterTabId +
                                "&mode=" + "RO&force=1" + pars;
                        };
                    });
                    gv.Columns.Add(col);

                    if (1 != column.Extrnval)  continue;
                }

                gvColumn.DataField = column.ColName;

                //параметры визуального отображения
                setupColumn(column, gvColumn);

                //признаки ключей
                gvColumn.IsPrimaryKey = 1 == column.ShowRetVal;
                gvColumn.IsForeignKey = 1 == column.Extrnval;

                //отображать html если нужно
                gvColumn.HtmlEncode = false;

                if (column.ColType == 'D' && !String.IsNullOrEmpty(column.ShowFormat))
                    gv.DateMask = column.ShowFormat;
                gvColumn.DataFormatString = "{0:" + column.ShowFormat + "}";

                //добавить в грид
                gv.Columns.Add(gvColumn);

                //добавить в грид ключевые поля (нужны для генерации параметров SQL)
                if (gvColumn.IsPrimaryKey)
                {
                    string[] dk = new string[gv.DataKeyNames.Length + 1];
                    for (int i = 0; i < gv.DataKeyNames.Length; i++)
                        dk[i] = gv.DataKeyNames[i];
                    dk[gv.DataKeyNames.Length] = column.ColName;
                    gv.DataKeyNames = dk;
                    gvColumn.ReadOnly = true;
                }

                //добавить колонку с семантикой
                if (gvColumn.IsForeignKey)
                {

                    //загрузить таблицу в объект
                    MetaTable fkTable = initMetaTable(connection, column.SrcTabId);

                    //найти поле семантики во внешней таблице
                    MetaTableColumn semanticColumn = fkTable.Columns.Find(
                        delegate(MetaTableColumn c) { return c.InstnsSemantic == 1; });

                    //колонка с семантикой внешней таблицы
                    BarsBoundFieldEx gvColumnFk = new BarsBoundFieldEx(gv);

                    //установить свойства колонки грида для поля семантики
                    if (null != semanticColumn)
                    {
                        //имя колонки семантики в формате 
                        //"алиас основной таблицы + номер по счету таблицы семантики + _ + имя колонки семантики
                        gvColumnFk.DataField = mainTableAlias + fkTables.Count.ToString() + "_" + semanticColumn.ColName;
                        setupColumn(semanticColumn, gvColumnFk);
                    }
                    else
                        throwRefException("SemanticFieldNotFound", column.SrcColId, fkTable.Name);

                    //для основной колонки установить параметры открытия модального окна для выбора значения из внешней таблицы
                    gvColumn.ModalDialogPath = "dialog.aspx?type=metatab&tail=''&role=&tabname=" + fkTable.Name;
                    gvColumn.SemanticField = gvColumnFk;
                    gvColumnFk.IsForeignSemantic = true;

                    //добавить текущую таблицу в коллекцию внешних таблиц
                    fkTables.Add(fkTable);

                    //добавить в грид
                    gv.Columns.Add(gvColumnFk);

                }
            }
            //признак последней колонки (нужно для корректной работы кнопочек выбора из справочников)
            if (gv.Columns.Count > 0)
                ((BarsBoundFieldEx)gv.Columns[gv.Columns.Count - 1]).IsLast = true;
        }

        //
        // создает выражения для delete, update, insert, select
        //
        private void generateSqlStmts(List<MetaTable> fkTables, MetaTable mainTable)
        {
            string selectColumnsList = String.Empty;
            string resultColumnsList = String.Empty;
            string insertColumnsList = String.Empty;
            string insertValuesList = String.Empty;
            string updateColumnsList = String.Empty;
            string updateColumnsWhere = String.Empty;
            string deleteColumnsWhere = String.Empty;

            string tableList = String.Format("{0} {1}, ", mainTable.Name, mainTableAlias);
            string whereList = String.Empty;
            List<SortInfo> orderList = new List<SortInfo>();

            //список полей - поля основной таблицы
            foreach (MetaTableColumn column in mainTable.Columns)
            {

                if (!isResultsShow)
                    isResultsShow = !String.IsNullOrEmpty(column.ShowResult);

                string oldColName = String.Format(ds.OldValuesParameterFormatString, column.ColName);

                selectColumnsList += String.Format("{0}.{1}, ", mainTableAlias, column.ColName);
                insertColumnsList += String.Format("{0}, ", column.ColName);
                insertValuesList += String.Format(":{0}, ", column.ColName);
                resultColumnsList += !String.IsNullOrEmpty(column.ShowResult) ?
                    column.ShowResult.ToUpper().Replace(mainTable.Name + ".", String.Empty) + ", " :
                    "null as " + column.ColName + ", ";

                //primary key
                if (1 == column.ShowRetVal)
                {
                    string str = String.Format("{0} = :{1} and ", column.ColName, oldColName);
                    updateColumnsWhere += str;
                    deleteColumnsWhere += str;
                }
                //остальные поля
                else
                {
                    //условие update выражения (оптимистическая блокировка)
                    updateColumnsWhere +=
                        String.Format("( ( :{0} is null and {1} is null) or ( {1} = :{0}) ) and ", oldColName, column.ColName);

                    //условие delete 
                    deleteColumnsWhere += updateColumnsWhere;
                        //String.Format("( ( {0} is null and :{1} is null) or ( {1} = :{0}) ) and ", column.ColName, oldColName);

                    //список полей update выражения
                    updateColumnsList +=
                        String.Format("{0} = :{0}, ",
                        column.ColName);

                }

                //добавить информацию о сортировке
                if (-1 != column.Sort.Order)
                    orderList.Add(column.Sort);

                //внешние поля
                if (1 == column.Extrnval)
                {
                    //поиск внешней таблицы
                    MetaTable fkTable = fkTables.Find(delegate(MetaTable t) { return t.Id == column.SrcTabId && !t.Processed; });

                    //таблица найдена
                    if (null != fkTable)
                    {

                        //найти ключевое поле во внешней таблице
                        MetaTableColumn keyColumn = fkTable.Columns.Find(
                            delegate(MetaTableColumn c) { return c.ColId == column.SrcColId; });

                        //найти поле семантики внешней таблице
                        MetaTableColumn semanticColumn = fkTable.Columns.Find(
                            delegate(MetaTableColumn c) { return c.InstnsSemantic == 1; });

                        int tabIndex = fkTables.IndexOf(fkTable);

                        //добавить поле семантики к списку колонок
                        selectColumnsList += String.Format("{0}.{1} as {2}, ",
                            mainTableAlias + tabIndex.ToString(),
                            semanticColumn.ColName,
                            mainTableAlias + tabIndex.ToString() + "_" + semanticColumn.ColName);

                        if (!isResultsShow)
                            isResultsShow = !String.IsNullOrEmpty(column.ShowResult);

                        resultColumnsList += !String.IsNullOrEmpty(semanticColumn.ShowResult) ?
                            semanticColumn.ShowResult.ToUpper().Replace(fkTable.Name + "." + semanticColumn.ColName,
                                mainTableAlias + tabIndex.ToString() + "_" + semanticColumn.ColName) + ", " :
                            "null as " + mainTableAlias + tabIndex.ToString() + "_" + semanticColumn.ColName + ", ";

                        whereList += String.Format("{0}.{1} = {2}.{3} (+) and ",
                            mainTableAlias,
                            column.ColName,
                            mainTableAlias + tabIndex.ToString(),
                            keyColumn.ColName);
                    }
                    else
                        throw new BarsReferencesException("ExtrnValFoundButTableNotDefined");

                    //пометить таблицу как обработанную
                    fkTable.Processed = true;
                }

            }

            //список таблиц
            for (int i = 0; i < fkTables.Count; i++)
                tableList += String.Format("{0} {1}, ", fkTables[i].Name, mainTableAlias + (i).ToString());

            /*//пройтись по всем полям основной таблицы 
            foreach (MetaTableColumn column in mainTable.Columns)
            {
                
            }*/

            //убрать последние запятые и and
            selectColumnsList = selectColumnsList.Length > 0 ? selectColumnsList.Substring(0, selectColumnsList.Length - 2) : String.Empty;
            resultColumnsList = resultColumnsList.Length > 0 ? resultColumnsList.Substring(0, resultColumnsList.Length - 2) : String.Empty;
            insertColumnsList = insertColumnsList.Length > 0 ? insertColumnsList.Substring(0, insertColumnsList.Length - 2) : String.Empty;
            insertValuesList = insertValuesList.Length > 0 ? insertValuesList.Substring(0, insertValuesList.Length - 2) : String.Empty;
            updateColumnsList = updateColumnsList.Length > 0 ? updateColumnsList.Substring(0, updateColumnsList.Length - 2) : String.Empty;
            updateColumnsWhere = updateColumnsWhere.Length > 0 ? updateColumnsWhere.Substring(0, updateColumnsWhere.Length - 4) : String.Empty;
            deleteColumnsWhere = deleteColumnsWhere.Length > 0 ? deleteColumnsWhere.Substring(0, deleteColumnsWhere.Length - 4) : String.Empty;
            tableList = tableList.Length > 0 ? tableList.Substring(0, tableList.Length - 2) : String.Empty;

            string FilterCondition = getFilterStmt(Request["code"]);
            whereList += FilterCondition.Length == 0 ? String.Empty : FilterCondition + "and ";
            whereList = whereList.Length > 0 ? whereList.Substring(0, whereList.Length - 4) : String.Empty;

            //выражение для сортировки
            string orderString = String.Empty;
            orderList.Sort(compareSortInfo);
            foreach (SortInfo item in orderList)
                orderString += String.Format("t.{0} {1}, ", item.Column, item.Way);
            orderString = orderString.TrimEnd(',', ' ');

            if (isResultsShow)
            {
                //select
                totalsCommand = "select " + resultColumnsList + " from ({0}) ";
                if (ds is ITotals)
                    (ds as ITotals).TotalsCommand = totalsCommand;
            }

            //select
            string selectStmt = String.Format("select {0} from {1} {2} {3}",
                selectColumnsList,
                tableList,
                whereList.Length > 0 ? "where " + whereList : String.Empty,
                orderList.Count > 0 ? "order by " + orderString : String.Empty);

            //update
            string updateStmt = String.Format("update {0} set {1} where {2}",
                mainTable.Name, updateColumnsList, updateColumnsWhere);

            //insert
            string insertStmt = String.Format("insert into {0} ({1}) values ({2})",
                mainTable.Name, insertColumnsList, insertValuesList);

            //delete 
            string deleteStmt = String.Format("delete from {0} where {1}", mainTable.Name, deleteColumnsWhere);

            //setup datasource
            ds.SelectCommand = selectStmt;
            ds.UpdateCommand = updateStmt;
            ds.InsertCommand = insertStmt;
            ds.DeleteCommand = deleteStmt;
        }
        private string getFilterStmt(object code)
        {
            if (null == code)
                return String.Empty;

            OracleConnection connection = OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                OracleCommand command = connection.CreateCommand();
                command.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_REFREAD");
                command.Parameters.Add("code", OracleDbType.Varchar2, code, ParameterDirection.Input);
                command.CommandText = @"select condition from meta_filtercodes where code=:code";
                object res = command.ExecuteScalar();
                if (null != res)
                    return Convert.ToString(res).Replace("$~~ALIAS~~$", mainTableAlias);
                else
                    return String.Empty;
            }
            finally
            {
                connection.Close();
            }
        }
        private static int compareSortInfo(SortInfo i1, SortInfo i2)
        {
            return i1.Order.CompareTo(i2.Order);
        }
        protected void gv_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
        }
        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        protected void gv_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.AffectedRows<1 && !commandOverrided)
                throwRefException("RecordAlreadyModified");
        }
}
}
