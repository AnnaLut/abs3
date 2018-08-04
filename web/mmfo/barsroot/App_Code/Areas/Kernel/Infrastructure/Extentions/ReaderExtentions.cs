using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReaderExtentions
/// </summary>
namespace BarsWeb.Areas.Kernel.Infrastructure.Extentions
{
    public static class ReaderExtentions
    {
        public static IEnumerable<Dictionary<string, object>> ReadAllLazy(OracleDataReader reader)
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