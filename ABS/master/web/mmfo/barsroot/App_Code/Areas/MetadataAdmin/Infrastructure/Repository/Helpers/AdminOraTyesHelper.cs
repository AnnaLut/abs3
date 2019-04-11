using Bars.Oracle;
using BarsWeb.Areas.MetaDataAdmin.Infrastructure;
using BarsWeb.Areas.MetaDataAdmin.Models;
using BarsWeb.Areas.MetaDataAdmin.Models.DbModels;
using BarsWeb.Areas.MetaDataAdmin.Models.DbTabelsInfoModels;
using BarsWeb.Areas.MetaDataAdmin.Models.ViewModels;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using BarsWeb.Areas.MetaDataAdmin.Infrastructure.Constants.AdminConstants;
/// <summary>
/// Summary description for AdminOraTyesHelper
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Infrastructure.Repository.Helpers
{
    
    public class AdminOraTyesHelper
    {
        private   OracleCommand _command;
        public AdminOraTyesHelper(OracleCommand comm)
        {
            this._command = comm;
            this._command.BindByName = true;
        }

       
        public MetaColumnsDbModel ConvertDbColumnInfoToSyncCol(DataTable schemaTable, DataRow row, UserColComments commentModel, decimal tabId)
        {

            ColumnDbInfo metaColInfo = GetColumnInfoGyShema(schemaTable, row);
            MetaColumnsDbModel metaColDb = new MetaColumnsDbModel();
            metaColDb.COLNAME = metaColInfo.ColumnName;
            metaColDb.COLID = metaColInfo.ColumnOrdinal;
            metaColDb.SHOWMAXCHAR = metaColInfo.ColumnSize;
            metaColDb.SHOWPOS = (short)metaColInfo.ColumnOrdinal;
            metaColDb.SEMANTIC = commentModel != null ? commentModel.COMMENTS : "" ;
            metaColDb.COLTYPE = SqlStatementParamsParser.GetMetaTypeTypeName(metaColInfo.DataType);
            metaColDb.SHOWWIDTH = 1;
            metaColDb.TABID = tabId;
            return metaColDb;
        }

        public ColumnDbInfo GetColumnInfoGyShema(DataTable schemaTable, DataRow row)
        {

            ColumnDbInfo metaColDb = new ColumnDbInfo();
            metaColDb.ColumnName = row[schemaTable.Columns["ColumnName"]].ToString();
            metaColDb.ColumnSize = Convert.ToInt32(row[schemaTable.Columns["ColumnSize"]]);
            metaColDb.DataType = row[schemaTable.Columns["DataType"]].ToString();
            metaColDb.ColumnOrdinal = Convert.ToInt32(row[schemaTable.Columns["ColumnOrdinal"]]);
            metaColDb.AllowDBNull = (Boolean)row[schemaTable.Columns["AllowDBNull"]];
            return metaColDb;

        }




        public void AddParamsToAddcolumnProc(MetaColumnsDbModel columns)
        {
            if (this._command.Parameters.Count > 0)
                this._command.Parameters.Clear();

            
            OracleParameterCollection paramCols = this._command.Parameters;
            paramCols.Add(new OracleParameter(":p_tabid", OracleDbType.Decimal, columns.TABID, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_colid", OracleDbType.Decimal, ++columns.COLID, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_colname", OracleDbType.Varchar2, columns.COLNAME, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_coltype", OracleDbType.Varchar2, columns.COLTYPE, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_semantic", OracleDbType.Varchar2, columns.SEMANTIC, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showwidth", OracleDbType.Decimal, 1, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showmaxchar", OracleDbType.Decimal, null, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showpos", OracleDbType.Decimal, columns.COLID, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showin_ro", OracleDbType.Decimal, 0, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showretval", OracleDbType.Decimal, 0, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_instnssemantic", OracleDbType.Varchar2, 0, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_extrnval", OracleDbType.Decimal, 0, ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showrel_ctype", OracleDbType.Varchar2, "", ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showformat", OracleDbType.Varchar2, "", ParameterDirection.Input));
            paramCols.Add(new OracleParameter("p_showin_fltr", OracleDbType.Decimal, 0, ParameterDirection.Input));

        }


        public string ExexuteAddSyncColProc(List<MetaColumnsDbModel> metaColumns, List<MetaColumnsDbModel> dbInfoCoumnsBySchema)
        {
            
            //Dictionary<string, bool> isColumnInMetaColumns = columnsToSynchron.Where(x => x.)
            this._command.BindByName = true;
            List<MetaColumnsDbModel> columnsToDelete = metaColumns.Where(x => !dbInfoCoumnsBySchema.Select(v => v.COLNAME).Contains(x.COLNAME)).ToList();
            List<MetaColumnsDbModel> columnsAfterDelete = metaColumns.Count > 0 && columnsToDelete.Count > 0 ?
                metaColumns.Where(x => !columnsToDelete.Select(v => v.COLNAME).Contains(x.COLNAME)).ToList() : metaColumns;
            List <MetaColumnsDbModel> columnsToSync = dbInfoCoumnsBySchema.Where(x => metaColumns.FirstOrDefault(m => m.COLNAME == x.COLNAME && (m.COLTYPE != x.COLTYPE ||
            m.SHOWMAXCHAR != x.SHOWMAXCHAR || (string.IsNullOrEmpty(m.SEMANTIC) && !string.IsNullOrEmpty(x.SEMANTIC)))) != null).ToList();
            if (columnsToDelete.Count > 0)
                DeleteNonExistentColums(metaColumns, columnsToDelete);
            if(columnsToSync.Count > 0)
                SyncColumns(metaColumns, columnsToSync);
            List<MetaColumnsDbModel> columnsToAdd = dbInfoCoumnsBySchema.Where(x => !metaColumns.Select(v => v.COLNAME).Contains(x.COLNAME)).ToList();
            if(columnsToAdd.Count > 0)
            {
                decimal startColumns = columnsAfterDelete.Count > 0 ? columnsAfterDelete.OrderByDescending(x => x.COLID).FirstOrDefault().COLID : 0;
                AddNewColumns(metaColumns, columnsToAdd, startColumns++);
            }
            


            //"bars_metabase.add_column(:p_tabid,:p_colid,:p_colname, :p_coltype, :p_semantic, ; p_showwidth, :p_showmaxchar, :p_showpos, :p_showin_ro, :p_showretval,:p_instnssemantic, :p_extrnval, :p_showrel_ctype, :p_showformat, :p_showin_fltr);";


            return "поля  синхронізовано";

        }

        public void AddNewColumns(List<MetaColumnsDbModel> metaColumns, List<MetaColumnsDbModel> columnsToAdd, decimal startIdColumns)
        {

            this._command.CommandText = AdminProceduresText.addColProcText;
            if (columnsToAdd.Count() > 0)
                foreach (var item in columnsToAdd)
                {
                    item.COLID = startIdColumns;
                    AddParamsToAddcolumnProc(item);
                    this._command.ExecuteNonQuery();
                    startIdColumns++;
                }
        }

        public void DeleteNonExistentColums(List<MetaColumnsDbModel> metaColumns, List<MetaColumnsDbModel> columnsToDelete)
        {
        
            if(columnsToDelete.Count > 0)
            {
                this._command.CommandText = AdminProceduresText.deletColProcText;
                foreach (var item in columnsToDelete)
                {
                    DeleteColumn(item);
                }
            }

        }

        public void DeleteColumn(MetaColumnsDbModel clumnToDelete)
        {
            if (_command.Parameters.Count > 0)
                _command.Parameters.Clear();
            OracleParameterCollection paramCols = _command.Parameters;
            paramCols.Add(new OracleParameter(":p_tabid", OracleDbType.Decimal, clumnToDelete.TABID, ParameterDirection.Input));
            paramCols.Add(new OracleParameter(":p_colid", OracleDbType.Decimal, clumnToDelete.COLID, ParameterDirection.Input));
            int res = _command.ExecuteNonQuery();
            if(res == 0)
                throw new Exception(string.Format("Виникла помилка при видаленні опису стовбца {0}.\r\n З таблиці TABNAME ={1}\r\n"  +
                    "Можливо цей рядок заблокований для редагування або інший користувач змінив дані цього рядка", clumnToDelete.COLID, clumnToDelete.TABID));

        }
        public void SyncColumns(List<MetaColumnsDbModel> metaColumns, List<MetaColumnsDbModel> columnsToSynchron)
        {
            
            if (columnsToSynchron.Count > 0)
            {
                this._command.CommandText = AdminProceduresText.syncColProcText;
                foreach (var item in columnsToSynchron)
                {
                    SyncColumn(item);
                }
               
            }
        }

        public void SyncColumn( MetaColumnsDbModel columnsToSynchron)
        {
            if (_command.Parameters.Count > 0)
                _command.Parameters.Clear();
            OracleParameterCollection paramCols = _command.Parameters;
            paramCols.Add(new OracleParameter(":p_tabid", OracleDbType.Decimal, columnsToSynchron.TABID, ParameterDirection.Input));
            paramCols.Add(new OracleParameter(":p_colname", OracleDbType.Varchar2, columnsToSynchron.COLNAME, ParameterDirection.Input));
            paramCols.Add(new OracleParameter(":p_coltype", OracleDbType.Varchar2, columnsToSynchron.COLTYPE, ParameterDirection.Input));
            paramCols.Add(new OracleParameter(":p_semantic", OracleDbType.Varchar2, columnsToSynchron.SEMANTIC, ParameterDirection.Input));
            paramCols.Add(new OracleParameter(":p_showmaxchar", OracleDbType.Varchar2, columnsToSynchron.SHOWMAXCHAR, ParameterDirection.Input));
            int res = _command.ExecuteNonQuery();
            if (res == 0)
                throw new Exception(string.Format("Виникла помилка при синхронізацією опису стовбца {0}.\r\n З таблиці TABNAME ={1}\r\n" +
                    "Можливо цей рядок заблокований для редагування або інший користувач змінив дані цього рядка", columnsToSynchron.COLNAME, columnsToSynchron.TABID));

        }
        public List<MetaColumnsDbModel> GetColumnsInfo(DataTable schemaTable, IEnumerable<UserColComments> columnsWithComments, decimal tabid)
        {
            List<MetaColumnsDbModel> columnsToSynchron = new List<MetaColumnsDbModel>();
            foreach (DataRow row in schemaTable.Rows)
            {
                DataColumn columnForName = schemaTable.Columns["ColumnName"];
                string colname = row[columnForName].ToString();
                UserColComments semanticColumnModel = columnsWithComments.FirstOrDefault(x => x.COLUMN_NAME == colname);
                MetaColumnsDbModel column = ConvertDbColumnInfoToSyncCol(schemaTable, row, semanticColumnModel, tabid);

                columnsToSynchron.Add(column);
            }
            return columnsToSynchron;
        }
    }
}