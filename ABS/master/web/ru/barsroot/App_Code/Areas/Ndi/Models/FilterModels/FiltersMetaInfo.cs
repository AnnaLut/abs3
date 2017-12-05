using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Areas.Ndi.Models;
using barsroot.core;
using Newtonsoft.Json;
using BarsWeb.Areas.Ndi.Models.DbModels;

namespace BarsWeb.Areas.Ndi.Models.FilterModels
{
    /// <summary>
    /// Summary description for FiltersMetaInfo
    /// </summary>
    public class FiltersMetaInfo
    {
        public FiltersMetaInfo(MetaTable tableInfo, UserMap user)
        {
            this.tableInfo = tableInfo;
            this.RequiredFilterFieldNamesLis = new List<string>();
            this.RequiredFilterFieldNamesLis.Add(RequiredFilterFields.KF.ToString());
            this.RequiredFilterFieldNamesLis.Add(RequiredFilterFields.MFO.ToString());

        }
        MetaTable tableInfo;

        public string StringColumnModel;
        public string ShowFilterWindow { get; set; }
        public Dictionary<string, string> ComboboxColumsDictionary { get; set; }
        public string[,] ComboboxColumsArray { get; set; }

        public IEnumerable<FilterInfo> CustomFilters;

        public IEnumerable<FilterInfo> SystemFilters;
        public IList<ColumnMetaInfo> FiltersMetaColumns { get; set; }
        public string TableName { get; set; }
        public decimal TABID { get; set; }
        public string SEMANTIC { get; set; }
        public bool HasFilter { get; set; }
        public List<ColumnMetaInfo> FilterColumns { get; set; }
        public List<string> RequiredFilterFieldNamesLis { get; set; }
        public void BuildFilters()
        {
            if (tableInfo != null)
            {
                this.TABID = tableInfo.TABID;
                this.TableName = tableInfo.TABNAME;
                this.SEMANTIC = tableInfo.SEMANTIC;
            }
            ColumnMetaInfo IsApplyColumn = new ColumnMetaInfo
            {
                SHOWPOS = 1,
                COLTYPE = "B",
                COLNAME = "IsApplyFilter",
                SEMANTIC = "Застосувати"
            };
            
            if (this.FiltersMetaColumns != null && this.FiltersMetaColumns.Any())
            {
                this.FiltersMetaColumns.Add(IsApplyColumn);
                this.FiltersMetaColumns = this.FiltersMetaColumns.OrderBy(c => c.SHOWPOS).ToList();
                this.HasFilter = true;
            }
        }

        public void ComboboxColumnModelBuild(IEnumerable<ColumnMetaInfo> columns)
        {
            List<ColumnMetaInfo> filterColumns = columns.Where(x => x.SHOWIN_FLTR == 1).ToList();
            IList<ColumnMetaInfo> requieFilterCols = GetRequiredFilterFields(columns);
            if (filterColumns.Count() < 1)
                filterColumns = columns as List<ColumnMetaInfo>;
            else
            {
                if (requieFilterCols != null && requieFilterCols.Count() > 0)
                    filterColumns.AddRange(requieFilterCols as List<ColumnMetaInfo>);
            }
            filterColumns = filterColumns.Where(x => !string.IsNullOrEmpty(x.SEMANTIC)).ToList();
            //filterColumns.ForEach(x => x.SEMANTIC = x.SEMANTIC.Replace('~', ' '));
            this.ComboboxColumsDictionary = new Dictionary<string, string>();
            this.ComboboxColumsDictionary = filterColumns.ToDictionary(c => c.COLNAME, c => c.SEMANTIC);
            var stringArray = new string[ComboboxColumsDictionary.Count, 2];

            int i = 0;
            foreach (KeyValuePair<string, string> item in ComboboxColumsDictionary)
            {
                stringArray[i, 0] = item.Value;
                stringArray[i, 1] = item.Value.Replace('~', ' ');
                i++;
            }
            StringColumnModel = JsonConvert.SerializeObject(stringArray);
            this.ComboboxColumsArray = stringArray;
            this.FilterColumns = filterColumns;
        }

        public List<ColumnMetaInfo> GetRequiredFilterFields(IEnumerable<ColumnMetaInfo> columns)
        {
            List<ColumnMetaInfo> RequiredFilterFieldsList = new List<ColumnMetaInfo>();
            foreach (var name in RequiredFilterFieldNamesLis)
            {
                var field = columns.FirstOrDefault(x => x.COLNAME == name.ToString() && x.SHOWIN_FLTR == 0);
                if (field != null)
                    RequiredFilterFieldsList.Add(field);
            }
            return RequiredFilterFieldsList;
        }


    }

    enum RequiredFilterFields
    {
        KF,
        MFO
    }
}