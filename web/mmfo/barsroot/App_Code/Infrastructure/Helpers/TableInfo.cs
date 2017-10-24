using System;

namespace BarsWeb.Infrastructure.Helpers
{
    public class TableInfo
    {
        public string ColumnName { get; set; }
        public int ColumnSize { get; set; }
        public string DataType { get; set; }
        public bool AllowDBNull { get; set; }

        public TableInfo(string ColumnName, int ColumnSize, string DataType, bool AllowDBNull)
        {
            this.ColumnName = ColumnName;
            this.ColumnSize = ColumnSize;
            this.DataType = DataType;
            this.AllowDBNull = AllowDBNull;
        }
    }

}

