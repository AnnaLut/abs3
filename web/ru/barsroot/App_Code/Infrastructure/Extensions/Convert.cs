using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;

namespace BarsWeb.Infrastructure.Extensions
{
    /// <summary>
    /// Summary description for Utils
    /// </summary>
    public static class Convert
    {
        /// <summary>
        /// конвертація Object в Dictionary
        /// </summary>
        /// <param name="obj">об"єкт для конвертації</param>
        /// <returns></returns>
        public static Dictionary<string, string> ObjectToDictionary(this object obj)
        {
            try
            {
                return (from x in obj.GetType().GetProperties() select x)
                    .Select(x => new
                    {
                        key = x.Name.Replace("_", "-"),
                        val = (x.GetGetMethod().Invoke(obj, null) ?? string.Empty).ToString()
                    })
                    .ToDictionary(x => x.key, x => x.val);
            }
            catch
            {
                return new Dictionary<string, string>();
            }
        }

        /*Converts DataTable To List*/

        public static List<TSource> ToList<TSource>(this DataTable dataTable) where TSource : new()
        {
            var dataList = new List<TSource>();

            const BindingFlags flags = BindingFlags.Public | BindingFlags.Instance | BindingFlags.NonPublic;
            var objFieldNames = (from PropertyInfo aProp in typeof (TSource).GetProperties(flags)
                select new
                {
                    Name = aProp.Name,
                    Type = Nullable.GetUnderlyingType(aProp.PropertyType) ??
                           aProp.PropertyType
                }).ToList();
            var dataTblFieldNames = (from DataColumn aHeader in dataTable.Columns
                select new
                {
                    Name = aHeader.ColumnName,
                    Type = aHeader.DataType
                }).ToList();
            var commonFields = objFieldNames.Intersect(dataTblFieldNames).ToList();

            foreach (DataRow dataRow in dataTable.AsEnumerable().ToList())
            {
                var aTSource = new TSource();
                foreach (var aField in commonFields)
                {
                    PropertyInfo propertyInfos = aTSource.GetType().GetProperty(aField.Name);
                    var value = (dataRow[aField.Name] == DBNull.Value)
                        ? null
                        : dataRow[aField.Name]; //if database field is nullable
                    propertyInfos.SetValue(aTSource, value, null);
                }
                dataList.Add(aTSource);
            }
            return dataList;
        }

        public static string DataTableToString(this DataTable dataTable)
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer =
                new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dataTable.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dataTable.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);

        }
    }
}
