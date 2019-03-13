using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OracleExtentions
/// </summary>
namespace Bars.Oracle
{ 
public static class OracleExtentions
{
    
        public static IEnumerable<Dictionary<string, object>> ReadAllLazy(this OracleDataReader reader)
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