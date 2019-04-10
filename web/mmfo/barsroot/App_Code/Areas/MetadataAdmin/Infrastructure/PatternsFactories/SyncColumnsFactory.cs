using BarsWeb.Areas.MetaDataAdmin.Models;
using BarsWeb.Areas.MetaDataAdmin.Models.DbModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.MetaDataAdmin.Models;
/// <summary>
/// Summary description for SyncColumnsFactory
/// </summary>
public class SyncColumnsFactory : BasePatternFactory<SyncColumnsPatternModel, BasePatternGridModel>
{

    public SyncColumnsFactory()
    {

    }

    public override BasePatternGridModel GetFullGridMdel(SyncColumnsPatternModel model)
    {

        this.OutPutModel = new BasePatternGridModel();
        this.OutPutModel.MetaColumns = GetMetaColumns;
        this.InputModel = model;
        List<MetaColumnsDbModel> metaColumns = InputModel.MetaColumns;
        List<MetaColumnsDbModel> dbInfoCoumnsBySchema = InputModel.DbInfoCoumnsBySchema;
        List<MetaColumnsDbModel> columnsToDelete = metaColumns.Where(x => !dbInfoCoumnsBySchema.Select(v => v.COLNAME).Contains(x.COLNAME)).ToList();
        List<MetaColumnsDbModel> columnsAfterDelete = metaColumns.Count > 0 && columnsToDelete.Count > 0 ?
            metaColumns.Where(x => !columnsToDelete.Select(v => v.COLNAME).Contains(x.COLNAME)).ToList() : metaColumns;
        List<MetaColumnsDbModel> columnsToSync = dbInfoCoumnsBySchema.Where(x => metaColumns.FirstOrDefault(m => m.COLNAME == x.COLNAME && (m.COLTYPE != x.COLTYPE ||
                         m.SHOWMAXCHAR != x.SHOWMAXCHAR || m.SEMANTIC != x.SEMANTIC)) != null).ToList();
        List<MetaColumnsDbModel> metaColumnsToSync = metaColumns.Where(x => !columnsToSync.Select(v => v.COLNAME).Contains(x.COLNAME)).ToList();
        List<MetaColumnsDbModel> equelColumns = dbInfoCoumnsBySchema.Where(x => metaColumns.FirstOrDefault(m => m.COLNAME == x.COLNAME && m.COLTYPE == x.COLTYPE &&
                    m.SHOWMAXCHAR == x.SHOWMAXCHAR && m.SEMANTIC == x.SEMANTIC) != null).ToList();
        if (columnsToDelete.Count > 0)
            AddModelsForDelete(columnsToDelete);
        //if (columnsToSync.Count > 0)
        //    SyncColumns(metaColumns, columnsToSync);
        //List<MetaColumnsDbModel> columnsToAdd = dbInfoCoumnsBySchema.Where(x => !metaColumns.Select(v => v.COLNAME).Contains(x.COLNAME)).ToList();
        //if (columnsToAdd.Count > 0)
        //{
        //    decimal startColumns = columnsAfterDelete.Count > 0 ? columnsAfterDelete.OrderByDescending(x => x.COLID).FirstOrDefault().COLID : 0;
        //    AddNewColumns(metaColumns, columnsToAdd, startColumns++);
        //}
        throw new NotImplementedException();
    }

    private void AddModelsForDelete(List<MetaColumnsDbModel> columnsToDelete)
    {
        List<Dictionary<string, object>> data = new List<Dictionary<string, object>>();
        foreach (var item in columnsToDelete)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            row.Add("TO_DELETE", 1);
            row.Add("META_COL_NAME", item.COLNAME);
            row.Add("TYPE", item.COLTYPE);
            row.Add("MAX_LENGTH", item.SHOWMAXCHAR);
            row.Add("META_COL_SEMANTIC", item.SEMANTIC);
            data.Add(row);

        }
        this.OutPutModel.Data.AddRange(data);

    }

    private void AddModelsForSync(List<MetaColumnsDbModel> columnsToSync)
    {
        List<Dictionary<string, object>> data = new List<Dictionary<string, object>>();
        foreach (var item in columnsToSync)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();
            row.Add("TO_DELETE", 0);
            row.Add("META_COL_NAME", item.COLNAME);
            row.Add("TYPE", item.COLTYPE);
            row.Add("MAX_LENGTH", item.SHOWMAXCHAR);
            row.Add("META_COL_SEMANTIC", item.SEMANTIC);
            row.Add("TO_SYNC_OR_ADD", 1);
            row.Add("META_COL_NAME", item.COLNAME);
            row.Add("SYS_COLE_TYPE", item.COLNAME);
        }

    }


    public override List<ColumnMetaInfo> GetMetaColumns
    {
        get
        {
            List<ColumnMetaInfo> columns = new List<ColumnMetaInfo>();
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 1,
                SEMANTIC = "Видалити",
                COLNAME = "TO_DELETE",
                SHOWPOS = 1,
                SHOWWIDTH = 1,
                COLTYPE = "B"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 2,
                SEMANTIC = "Імя колонки",
                COLNAME = "META_COL_NAME",
                SHOWPOS = 2,
                SHOWWIDTH = 2,
                COLTYPE = "C"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 3,
                SEMANTIC = "Тип",
                COLNAME = "TYPE",
                SHOWPOS = 3,
                SHOWWIDTH = 1,
                COLTYPE = "C"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 4,
                SEMANTIC = "Довжина",
                COLNAME = "MAX_LENGTH",
                SHOWPOS = 4,
                SHOWWIDTH = 1,
                COLTYPE = "N"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 5,
                SEMANTIC = "Семантика поля",
                COLNAME = "META_COL_SEMANTIC",
                SHOWPOS = 5,
                SHOWWIDTH = 3,
                COLTYPE = "C"
            });

            columns.Add(new ColumnMetaInfo()
            {
                COLID = 6,
                SEMANTIC = "Синхронізувати ~ або додади",
                COLNAME = "TO_SYNC_OR_ADD",
                SHOWPOS = 6,
                SHOWWIDTH = 6,
                COLTYPE = "B"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 7,
                SEMANTIC = "Імя  ~ системного поля",
                COLNAME = "META_COL_NAME",
                SHOWPOS = 7,
                SHOWWIDTH = 2,
                COLTYPE = "C"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 8,
                SEMANTIC = "Тип ~ системного поля ",
                COLNAME = "SYS_COLE_TYPE",
                SHOWPOS = 8,
                SHOWWIDTH = 1,
                COLTYPE = "C"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 9,
                SEMANTIC = "Довжина ~ системного поля ",
                COLNAME = "TYPE",
                SHOWPOS = 9,
                SHOWWIDTH = 1,
                COLTYPE = "N"
            });
            columns.Add(new ColumnMetaInfo()
            {
                COLID = 10,
                SEMANTIC = "Семантика ~ системного поля",
                COLNAME = "META_COL_SEMANTIC",
                SHOWPOS = 10,
                SHOWWIDTH = 3,
                COLTYPE = "C"
            });
            return columns;
        }


    }
}