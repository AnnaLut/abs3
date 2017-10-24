using System.Collections.Generic;
using System.Linq;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Ndi.Models;
using Areas.Ndi.Models;
using System;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Конвертирует набор данных класса OracleDataReader в таблицу вида [ключ,значенне]. Удобно использовать для сериализации полученного набора в json.
    /// </summary>
    public static class AllRecordReader
    {
        public static IEnumerable<Dictionary<string, object>> ReadAll(OracleDataReader reader)
        {
            var cols = new List<string>();
            for (var i = 0; i < reader.FieldCount; i++)
                cols.Add(reader.GetName(i));
            while (reader.Read())
            {
                var row = cols.ToDictionary(col => col, col => reader[col]);
                yield return row;
            }
        }

        public static IEnumerable<Dictionary<string, object>> ReadAllWithDivesion(OracleDataReader reader, List<ColumnMetaInfo> columns)
        {

            List<Dictionary<string, object>> dicts = new List<Dictionary<string, object>>();
            int itemDev;
            decimal valueForDiv;
            Dictionary<string, string> divDictString = columns.Select(x => x.COLNAME).Where(x => x.Contains("/")).ToDictionary(c => c.Replace(c.Substring(c.IndexOf("/")), ""), (c => c.Substring(c.IndexOf('/') + 1)));
            Dictionary<string, int> divDictInt = new Dictionary<string, int>();
            foreach (var item in divDictString)
            {

                if (int.TryParse(item.Value, out itemDev))
                    divDictInt.Add(item.Key, itemDev);
            }
            var cols = new List<string>();
            for (var i = 0; i < reader.FieldCount; i++)
                cols.Add(reader.GetName(i));

            while (reader.Read())
            {

                var row = cols.ToDictionary(col => col, col => reader[col]);

                Dictionary<string, object> resRow = new Dictionary<string, object>(row);
                foreach (var item in row)
                {

                    if (divDictInt.Keys.Contains(item.Key) && item.Value is decimal?)
                    {
                        valueForDiv = (decimal)item.Value;
                        itemDev = divDictInt[item.Key];
                        valueForDiv = valueForDiv / itemDev;
                        resRow[item.Key] = (object)valueForDiv;
                    }
                }
                dicts.Add(resRow);

            }
            return dicts;
        }

        public static IEnumerable<Dictionary<string, object>> ReplaceResult(IEnumerable<Dictionary<string, object>> oldResult, string columnName, string oldVAlue, string newValue)
        {
            List<Dictionary<string, object>> newListDict = new List<Dictionary<string, object>>();
            Dictionary<string, object> newDict;
            foreach (var dict in oldResult.ToList())
            {
                newDict = dict.ToDictionary(x => x.Key, v => Replase(v.Value, oldVAlue, newValue));
                newListDict.Add(newDict);
            }
            return newListDict;
        }
        public static object Replase(object value, string oldValue, string newValue)
        {
            string newVal;
            if (value is string)
            {
                newVal = (string)value;
                newVal = newVal.Replace(oldValue, newValue);
                return newVal;
            }
            else
                return value;

        }
        //public IEnumerable<Dictionary<string, object>> GetFirst(OracleDataReader reader)
        //{
        //    List<Dictionary<string, object>> dicts = new List<Dictionary<string, object>>();

        //    var cols = new List<string>();
        //    for (var i = 0; i < reader.FieldCount; i++)
        //        cols.Add(reader.GetName(i));
        //    if (reader.Read())
        //    {
        //        var row = cols.ToDictionary(col => col, col => reader[col]);
        //        Dictionary<string, object> resRow = new Dictionary<string, object>(row);
        //        dicts.Add(resRow);
        //    }
        //    return dicts;

        //}

        public static GetDataResultInfo GetComplexResult(OracleDataReader reader, SelectBuilder selectBuilder, bool hasDivision, GetDataStartInfo startInfo)
        {
            IEnumerable<Dictionary<string, object>> allData;
            int getCount = selectBuilder.RecordsCount;
            List<ColumnMetaInfo> columnsForDiv = startInfo.NativeMetaColumns;
            List<ColumnMetaInfo> resultRowColumns = selectBuilder.TotalColumns;
            bool hasTotalColumns = selectBuilder.TotalColumns.Any();
            int startRowNum = selectBuilder.StartRecord;

            if (hasDivision && columnsForDiv != null && columnsForDiv.Count > 0)
                allData = ReadAllWithDivesion(reader, columnsForDiv);
            else
                allData = ReadAll(reader);
            if (selectBuilder.TableName == "DYN_FILTER")
                allData = ReplaceResult(allData, "WHERE_CLAUSE", "$~~ALIAS~~$", selectBuilder.NativeTableNameForFilter);
            int rowsCount = 0;
            List<Dictionary<string, object>> resultData = allData.ToList();
            if (resultData.Count <= 0)
                return new GetDataResultInfo()
                {
                    DataRecords = resultData.Take(startInfo.RecordsCount),
                    RecordsCount = 0,
                    TotalRecord = null
                };
                //rowsCount = Convert.ToInt32(resultData.First().Where(x => x.Key == "COUNT_ROWS").Select(s => s.Value).FirstOrDefault());
            Dictionary<string, object> summaryData = new Dictionary<string, object>();
            // Dictionary<string, object> resData;
          
            List<Dictionary<string, object>> listDictData = new List<Dictionary<string, object>>();
            if (resultRowColumns == null || resultRowColumns.Count <= 0)
                return new GetDataResultInfo()
                {
                    DataRecords = resultData.Take(startInfo.RecordsCount),
                    RecordsCount = selectBuilder.StartRecord + resultData.Count(),
                    TotalRecord = null
                };
            if(selectBuilder.SummaryForRecordsOnScrean)
            foreach (var item in resultData.FirstOrDefault())
            {
                if (resultRowColumns.Select(c => c.COLNAME + "_SUMMARY").Contains(item.Key))
                    summaryData.Add(item.Key.Replace("_SUMMARY", ""), item.Value);

            }

            foreach (Dictionary<string, object> item in resultData)
            {
                var resDat = item.Where(x => !resultRowColumns.Select(c => c.COLNAME + "_SUMMARY").Contains(x.Key) && x.Key != "COUNT_ROWS").ToDictionary(x => x.Key, x => x.Value);
                listDictData.Add(resDat);
            }
            return new GetDataResultInfo()
            {
                DataRecords = resultData.Take(startInfo.RecordsCount),
                RecordsCount = selectBuilder.StartRecord + resultData.Count(),
                TotalRecord = summaryData
            };

        }

        public static IEnumerable<Dictionary<string, object>> GetRsultRecords(IEnumerable<Dictionary<string, object>> data, List<ColumnMetaInfo> columns)
        {
            List<Dictionary<string, object>> newData = new List<Dictionary<string, object>>();
            Dictionary<string, object> tempDict;
                foreach (Dictionary<string, object> item in data)
                {
                    tempDict = item.Where(x => columns.Select(v => v.COLNAME).Contains(x.Key)).ToDictionary(x => x.Key, x => x.Value);
                    newData.Add(tempDict);
                }
                return newData;
        }
    }
}