using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Specialized;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.DataComponents;

namespace barsweb.References_Old
{
    /// <summary>
    /// Summary description for RefForm.
    /// </summary>
    public partial class RefForm_old : Bars.BarsPage
    {
        /// <summary>
        /// Обновление SCN
        /// </summary>
        protected virtual void UpdateSystemChangeNumber()
        {
            InitOraConnection();
            try
            {
                SetRole("WR_REFREAD");
                BarsSqlDataSource1.SystemChangeNumber = Convert.ToString(SQL_SELECT_scalar("select DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER() from dual"));
            }
            finally
            {
                DisposeOraConnection();
            }

        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            //BarsGridView1.NewRowStyle.InsertButtonText = Resources.barsweb.GlobalResources.vSave;
            //BarsGridView1.NewRowStyle.NewButtonText = Resources.barsweb.GlobalResources.vAdd;
            //BarsGridView1.NewRowStyle.СancelNewButtonText = Resources.barsweb.GlobalResources.vCancel;
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            // Переданные данные
            int TABID = Convert.ToInt32(Request["tabid"]);
            string MODE = Request["mode"];
            // Проверка
            if (TABID == 0 || String.IsNullOrEmpty(MODE) || (MODE != "RO" && MODE != "RW"))
            {
                throw new Exception("Были переданы некорректные параметры!");
            }

            // Соединение с БД
            BarsSqlDataSource1.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();

            OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
            if (con.State == ConnectionState.Closed) con.Open();
            try
            {
                // Доступный режим
                string __mode = string.Empty;
                // строка, содержащая имена таблиц
                string __tabName = string.Empty;
                // логическое удаление
                int __lDel = 0;
                // строка, содержащая имена столбцов
                string __columns = string.Empty;
                // строка, содержащая начальный фильтр
                string __where = string.Empty;
                // роли для работы со справочником
                string __roles = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_REFREAD");
                // для хранения имен таблиц и их синонимов
                //NameValueCollection __tables = new NameValueCollection();
                string __mainTable = string.Empty;
                // для формирования insert-конструкции
                string __insertColumns = string.Empty;
                string __insertValues = string.Empty;
                // для формирования delete-конструкции
                string __whereUpdateDelete = string.Empty;
                // для формирования update-конструкции
                string __updateNew = string.Empty;
                // счетчик таблиц
                int __tableCounter = 0;

                ArrayList __dataKeys = new ArrayList();

                OracleCommand com = new OracleCommand();
                OracleDataReader rd = null;
                com.Connection = con;

                // проверим доступность
                com.Parameters.Clear();
                com.Parameters.Add("TABID", OracleDbType.Int32, TABID, ParameterDirection.Input);
                com.CommandText = @"SELECT TRIM(r.acode) FROM applist_staff a, refapp r 
                                    WHERE a.ID = user_id
                                    AND r.codeapp = a.codeapp
                                    AND r.tabid = :TABID
                                    AND ROWNUM < 2
                                    AND TRIM(r.acode) = 'RW'";
                __mode = Convert.ToString(com.ExecuteScalar());
                if (string.IsNullOrEmpty(__mode))
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("TABID", OracleDbType.Int32, TABID, ParameterDirection.Input);
                    com.CommandText = @"SELECT TRIM(r.acode)
                                         FROM applist_staff a, refapp r
                                         WHERE a.ID = user_id
                                         AND r.codeapp = a.codeapp
                                         AND r.tabid = :TABID
                                         AND ROWNUM < 2";
                    __mode = Convert.ToString(com.ExecuteScalar());
                    if (string.IsNullOrEmpty(__mode)) __mode = "NA";
                }

                if ("NA" == __mode)
                {
                    throw new Exception("Недостаточно прав для работы со справочником!!!");
                }
                else if (__mode == "RO" && MODE == "RW")
                {
                    throw new Exception("Недостаточно прав для редактирования справочника!!!");
                }

                // Настройки для редактирования
                if (MODE == "RW")
                {
                    // ========== BarsGridView ===============
                    // Для редактирования и удаления

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
                    cf.ShowEditButton = true;
                    cf.ShowCancelButton = true;
                    cf.ShowDeleteButton = true;
                    //cf.HeaderStyle.Width = new Unit(1.5, UnitType.Inch);
                    BarsGridView1.Columns.Add(cf);

                    // Для вставки
                    BarsGridView1.AutoGenerateNewButton = true;
                }

                // таблица
                com.Parameters.Clear();
                com.Parameters.Add("TABID", OracleDbType.Int32, TABID, ParameterDirection.Input);
                com.CommandText = "SELECT TABNAME, SEMANTIC, TABLDEL FROM META_TABLES WHERE TABID=:TABID AND ROWNUM<2";
                rd = com.ExecuteReader();
                if (rd.Read())
                {
                    __tabName = Convert.ToString(rd["TABNAME"]) + " t0";
                    //__tables.Add(Convert.ToString(rd["TABNAME"]), "t0");
                    if (rd["TABLDEL"] != DBNull.Value)
                    {
                        __lDel = Convert.ToInt16(rd["TABLDEL"]);
                    }
                    Label1.Text = Convert.ToString(rd["SEMANTIC"]);
                    if (MODE == "RW")
                    {
                        __mainTable = Convert.ToString(rd["TABNAME"]);
                    }
                }
                else
                    throw new Exception("Неверный Id таблицы!!!");
                rd.Close();

                // Роль
                if (MODE == "RW")
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("TABID", OracleDbType.Int32, TABID, ParameterDirection.Input);
                    com.CommandText = "SELECT ROLE2EDIT FROM REFERENCES WHERE TABID=:TABID";
                    string Role = Convert.ToString(com.ExecuteScalar());
                    if (__roles.IndexOf(Role) == -1)
                    {
                        if (__roles.ToLower().StartsWith("begin"))
                        {
                            string newRole = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(Role).ToLower().Replace("begin", "");
                            __roles = __roles.Replace("end;", newRole);
                        }
                        else
                            __roles += ", " + Role;
                    }
                }

                // колонки
                com.Parameters.Clear();
                com.Parameters.Add("TABID", OracleDbType.Int32, TABID, ParameterDirection.Input);
                com.CommandText = @"SELECT COLID, COLNAME, COLTYPE, SEMANTIC, SHOWWIDTH, SHOWMAXCHAR, SHOWPOS,
                                    SHOWRETVAL, INSTNSSEMANTIC, EXTRNVAL
                                    FROM META_COLUMNS WHERE TABID=:TABID ORDER BY SHOWPOS";


                rd = com.ExecuteReader();
                BarsBoundField lastCol = new BarsBoundField(BarsGridView1);
                while (rd.Read())
                {
                    // колонка спец типа
                    BarsBoundField col = new BarsBoundField(BarsGridView1);
                    // пока она последняя
                    lastCol = col;
                    int colid = 0;
                    colid = Convert.ToInt32(rd["COLID"]);
                    col.DataField = "F_" + BarsGridView1.Columns.Count.ToString();
                    col.SortExpression = col.DataField;
                    if (rd["SEMANTIC"] != DBNull.Value)
                        col.HeaderText = Convert.ToString(rd["SEMANTIC"]).Replace("~", " ");
                    if (string.IsNullOrEmpty(col.HeaderText))
                        col.HeaderText = Convert.ToString(rd["COLNAME"]);
                    if (rd["SHOWWIDTH"] != DBNull.Value)
                    {
                        double sizeInches = Convert.ToDouble(rd["SHOWWIDTH"]) / 1.5;
                        if (sizeInches < 1.15) sizeInches = 1.15;
                        col.HeaderStyle.Width = new Unit(sizeInches, UnitType.Inch);
                    }
                    else
                    {
                        col.HeaderStyle.Width = new Unit(1.15, UnitType.Inch);
                    }
                    if (rd["SHOWMAXCHAR"] != DBNull.Value)
                    {
                        col.MaxLength = Convert.ToInt32(rd["SHOWMAXCHAR"]);
                    }
                    else
                    {
                        col.MaxLength = -1;
                    }
                    // определим первичный ключ или нет
                    int PK = 0;
                    if (rd["SHOWRETVAL"] != DBNull.Value)
                        PK = Convert.ToInt32(rd["SHOWRETVAL"]);
                    if (1 == PK) col.IsPrimaryKey = true;
                    // определим внешний ключ или нет
                    int FK = 0;
                    if (rd["EXTRNVAL"] != DBNull.Value)
                        FK = Convert.ToInt32(rd["EXTRNVAL"]);
                    if (1 == FK) col.IsForeignKey = true;
                    // Добавим колонку в список
                    if (string.IsNullOrEmpty(__columns))
                        __columns = "t0." + Convert.ToString(rd["COLNAME"]) + " F_" + BarsGridView1.Columns.Count.ToString();
                    else
                        __columns += ", t0." + Convert.ToString(rd["COLNAME"]) + " F_" + BarsGridView1.Columns.Count.ToString();
                    BarsGridView1.Columns.Add(col);
                    // Сохраним первичный ключ
                    if (col.IsPrimaryKey)
                    {
                        __dataKeys.Add(col.DataField);
                    }
                    // Вычитаем семантику для внешнего ключа
                    if (col.IsForeignKey)
                    {
                        // ============= SELECT ==================
                        BarsBoundField col2 = new BarsBoundField(BarsGridView1);
                        lastCol = col2;

                        OracleCommand com2 = new OracleCommand();
                        com2.Connection = con;
                        com2.Parameters.Clear();
                        com2.Parameters.Add("TABID", OracleDbType.Int32, TABID, ParameterDirection.Input);
                        com2.Parameters.Add("COLID", OracleDbType.Int32, colid, ParameterDirection.Input);
                        com2.CommandText = @"SELECT SRCTABID, SRCCOLID FROM META_EXTRNVAL 
                                            where tabid=:tabid and colid=:colid";
                        int srctabid = 0; int srccolid = 0;
                        OracleDataReader rd2 = null;
                        rd2 = com2.ExecuteReader();
                        if (rd2.Read())
                        {
                            if (rd2["SRCTABID"] != DBNull.Value)
                                srctabid = Convert.ToInt32(rd2["SRCTABID"]);
                            if (rd2["SRCCOLID"] != DBNull.Value)
                                srccolid = Convert.ToInt32(rd2["SRCCOLID"]);
                        }
                        rd2.Close();

                        // имя таблицы
                        com2.Parameters.Clear();
                        com2.Parameters.Add("TABID", OracleDbType.Int32, srctabid, ParameterDirection.Input);
                        com2.CommandText = "SELECT TABNAME FROM META_TABLES WHERE TABID=:TABID AND ROWNUM<2";
                        string scrTabName = Convert.ToString(com2.ExecuteScalar());

                        // для модального окна
                        col.ModalDialogPath = "dialog.aspx?type=metatab&tail=''&role=&tabname=" + scrTabName;
                        col.SemanticField = col2;

                        //if (__tabName.IndexOf(AddTable(__tables, scrTabName))==-1)
                        __tabName += ", " + scrTabName + " t" + (++__tableCounter).ToString();  //AddTable(__tables, scrTabName);

                        // колонка семантика
                        com2.Parameters.Clear();
                        com2.Parameters.Add("TABID", OracleDbType.Int32, srctabid, ParameterDirection.Input);
                        com2.CommandText = "SELECT colname, semantic, showwidth FROM meta_columns where tabid=:tabid and instnssemantic=1";
                        rd2 = com2.ExecuteReader();
                        if (rd2.Read())
                        {
                            col2.DataField = "F_" + BarsGridView1.Columns.Count.ToString(); ;
                            col2.SortExpression = col2.DataField;
                            if (rd2["semantic"] != DBNull.Value)
                                col2.HeaderText = Convert.ToString(rd2["semantic"]).Replace("~", " ");
                            if (rd2["SHOWWIDTH"] != DBNull.Value)
                            {
                                double sizeInches = Convert.ToDouble(rd2["SHOWWIDTH"]) / 1.5;
                                if (sizeInches < 1.15) sizeInches = 1.15;
                                col2.HeaderStyle.Width = new Unit(sizeInches, UnitType.Inch);
                            }
                            if (string.IsNullOrEmpty(col2.HeaderText))
                                col2.HeaderText = Convert.ToString(rd2["COLNAME"]);
                            col2.IsForeignSemantic = true;
                            if (string.IsNullOrEmpty(__columns))
                                __columns = "t" + __tableCounter.ToString() + "." + Convert.ToString(rd2["COLNAME"]) + " f_" + BarsGridView1.Columns.Count.ToString();
                            else
                                __columns += ", t" + __tableCounter.ToString() + "." + Convert.ToString(rd2["COLNAME"]) + " f_" + BarsGridView1.Columns.Count.ToString();

                            BarsGridView1.Columns.Add(col2);
                        }
                        // поле id
                        com2.Parameters.Clear();
                        com2.Parameters.Add("TABID", OracleDbType.Int32, srctabid, ParameterDirection.Input);
                        com2.Parameters.Add("COLID", OracleDbType.Int32, srccolid, ParameterDirection.Input);
                        com2.CommandText = "SELECT colname FROM meta_columns WHERE tabid=:TABID AND colid=:COLID";
                        string srcColName = Convert.ToString(com2.ExecuteScalar());
                        if (string.IsNullOrEmpty(__where))
                            __where = "t0." + Convert.ToString(rd["COLNAME"]) + "=t" + __tableCounter.ToString() + "." + srcColName + " (+)";
                        else
                            __where += " AND t0." + Convert.ToString(rd["COLNAME"]) + "=t" + __tableCounter.ToString() + "." + srcColName + " (+)";
                        // роль
                        if (MODE == "RW")
                        {
                            com2.Parameters.Clear();
                            com2.Parameters.Add("TABID", OracleDbType.Int32, srctabid, ParameterDirection.Input);
                            com2.CommandText = "SELECT ROLE2EDIT FROM REFERENCES WHERE TABID=:TABID";

                            string curRole = Convert.ToString(com2.ExecuteScalar());
                            if (__roles.IndexOf(curRole) == -1)
                            {
                                if (__roles.ToLower().StartsWith("begin"))
                                {
                                    string newRole = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(curRole).ToLower().Replace("begin", "");
                                    __roles = __roles.Replace("end;", newRole);
                                }
                                else
                                    __roles += ", " + curRole;
                            }
                        }

                    }
                    if (MODE == "RW")
                    {

                        TypeCode type = TypeCode.String;
                        string t = string.Empty;

                        if (rd["COLTYPE"] != DBNull.Value)
                            t = Convert.ToString(rd["COLTYPE"]);

                        if (!string.IsNullOrEmpty(t))
                        {
                            switch (t)
                            {
                                case "N":
                                    type = TypeCode.Decimal;
                                    break;
                                case "D":
                                    type = TypeCode.DateTime;
                                    break;
                                case "B":
                                    type = TypeCode.Boolean;
                                    break;
                                default:
                                    type = TypeCode.String;
                                    break;
                            }
                        }
                        // =========== insert ==================
                        if (string.IsNullOrEmpty(__insertColumns))
                            __insertColumns = Convert.ToString(rd["COLNAME"]);
                        else
                            __insertColumns += ", " + Convert.ToString(rd["COLNAME"]);

                        if (string.IsNullOrEmpty(__insertValues))
                            __insertValues = ":" + col.DataField;
                        else
                            __insertValues += ", :" + col.DataField;

                        Parameter par = new Parameter(col.DataField);

                        par.Type = type;

                        if (rd["SHOWMAXCHAR"] != DBNull.Value || type == TypeCode.String)
                            par.Size = Convert.ToInt32(rd["SHOWMAXCHAR"]);

                        BarsSqlDataSource1.InsertParameters.Add(par);

                        // =========== update ==================

                        if (!col.IsPrimaryKey)
                        {
                            if (string.IsNullOrEmpty(__updateNew))
                                __updateNew = Convert.ToString(rd["COLNAME"]) + "=:" + col.DataField;
                            else
                                __updateNew += ", " + Convert.ToString(rd["COLNAME"]) + "=:" + col.DataField;

                            par = new Parameter(col.DataField);
                            par.Type = type;
                            if (rd["SHOWMAXCHAR"] != DBNull.Value || type == TypeCode.String)
                                par.Size = Convert.ToInt32(rd["SHOWMAXCHAR"]);
                            //BarsSqlDataSource1.UpdateParameters.Add(par);
                        }

                        // =========== delete ==================
                        if (string.IsNullOrEmpty(__whereUpdateDelete))
                            __whereUpdateDelete = "(" + Convert.ToString(rd["COLNAME"]) + " IS NULL AND :" +
                                string.Format(BarsSqlDataSource1.OldValuesParameterFormatString, col.DataField) +
                                " IS NULL OR " + Convert.ToString(rd["COLNAME"]) + "=:" +
                                string.Format(BarsSqlDataSource1.OldValuesParameterFormatString, col.DataField) + "_2)";
                        else
                            __whereUpdateDelete += " AND (" + Convert.ToString(rd["COLNAME"]) + " IS NULL AND :" +
                                string.Format(BarsSqlDataSource1.OldValuesParameterFormatString, col.DataField) +
                                " IS NULL OR " + Convert.ToString(rd["COLNAME"]) + "=:" +
                                string.Format(BarsSqlDataSource1.OldValuesParameterFormatString, col.DataField) + "_2)";

                        Parameter par1 = new Parameter(string.Format(BarsSqlDataSource1.OldValuesParameterFormatString, col.DataField));
                        Parameter par2 = new Parameter(string.Format(BarsSqlDataSource1.OldValuesParameterFormatString, col.DataField) + "_2");
                        par1.Type = type;
                        par2.Type = type;
                        if (rd["SHOWMAXCHAR"] != DBNull.Value || type == TypeCode.String)
                        {
                            par1.Size = Convert.ToInt32(rd["SHOWMAXCHAR"]);
                            par2.Size = Convert.ToInt32(rd["SHOWMAXCHAR"]);
                        }
                        BarsSqlDataSource1.DeleteParameters.Add(par1);
                        BarsSqlDataSource1.DeleteParameters.Add(par2);
                    }
                }
                rd.Close();
                lastCol.IsLast = true;
                string[] strTmp = new string[__dataKeys.Count];
                __dataKeys.CopyTo(strTmp);
                BarsGridView1.DataKeyNames = strTmp;
                BarsSqlDataSource1.SelectCommand = "SELECT " + __columns + " FROM " + __tabName;
                if (!string.IsNullOrEmpty(__where))
                    BarsSqlDataSource1.SelectCommand += " WHERE " + __where;

                BarsSqlDataSource1.PreliminaryStatement = __roles;

                if (MODE == "RW")
                {
                    BarsSqlDataSource1.InsertCommand = "INSERT INTO " + __mainTable +
                        "(" + __insertColumns + ") VALUES(" + __insertValues + ")";
                    if (__lDel == 1)
                        BarsSqlDataSource1.DeleteCommand = "UPDATE " + __mainTable + " SET DELETED = SYSDATE" +
                            " WHERE " + __whereUpdateDelete;
                    else
                        BarsSqlDataSource1.DeleteCommand = "DELETE FROM " + __mainTable +
                            " WHERE " + __whereUpdateDelete;
                    BarsSqlDataSource1.UpdateCommand = "UPDATE " + __mainTable +
                        " SET " + __updateNew + " WHERE " + __whereUpdateDelete;

                    // добавляем параметры условия
                    foreach (Parameter par in BarsSqlDataSource1.DeleteParameters)
                        if (null == BarsSqlDataSource1.UpdateParameters[par.Name])
                            BarsSqlDataSource1.UpdateParameters.Add(par);
                }
                if (!IsPostBack)
                {
                    com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_REFREAD");//"SET ROLE WR_REFREAD";
                    com.ExecuteNonQuery();
                    // flashBackNumber
                    com.Parameters.Clear();
                    com.CommandText = "select DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER() from dual";
                    BarsSqlDataSource1.SystemChangeNumber = Convert.ToString(com.ExecuteScalar());
                }
            }
            finally
            {
                con.Close();
            }
        }

        // обработка постбэка
        protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
        {
            if (sourceControl.GetType() == typeof(BarsGridView) &&
                eventArgument == "REFRESH_SCN" &&
                ((BarsGridView)sourceControl).ID == "BarsGridView1")
            {
                UpdateSystemChangeNumber();
            }
            else
                base.RaisePostBackEvent(sourceControl, eventArgument);
        }
        // Следим, чтобі одна и та же таблица не указівалась более одного раза
        /*protected string AddTable(NameValueCollection tables, string table)
        {
            string ret = string.Empty;
            bool flag = true;
            for (int i = 0; i < tables.AllKeys.Length; i++)
            {
                if (table == tables.AllKeys[i])
                {
                    flag = false;
                    ret = tables.Get(table);
                    break;
                }
            }
            if (flag)
            {
                ret = "t" + tables.Count.ToString();
                tables.Add(table, ret);
            }
            return ret;
        }*/
        protected void BarsSqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            UpdateSystemChangeNumber();
        }
        protected void BarsSqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            UpdateSystemChangeNumber();
        }
        protected void BarsSqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            UpdateSystemChangeNumber();
        }
        protected void BarsGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        protected void BarsSqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            ((OracleCommand)e.Command).BindByName = true;
        }
    }
}
