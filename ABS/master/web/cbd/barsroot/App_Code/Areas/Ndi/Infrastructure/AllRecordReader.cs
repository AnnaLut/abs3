using System.Collections.Generic;
using System.Linq;
using Oracle.DataAccess.Client;

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
    }
}