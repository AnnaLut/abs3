using System;
using System.Data;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Расширения для IDataRecord
    /// </summary>
    public static class DataRecordExtensions
    {
        /// <summary>
        /// Проверить есть ли в строке колонка с заданным именем
        /// </summary>
        /// <param name="dataRecord">Строка</param>
        /// <param name="columnName">Имя колонки</param>
        /// <returns></returns>
        public static bool HasColumn(this IDataRecord dataRecord, string columnName)
        {
            for (int i = 0; i < dataRecord.FieldCount; i++)
            {
                if (dataRecord.GetName(i).Equals(columnName, StringComparison.OrdinalIgnoreCase))
                {
                    return true;
                }
            }
            return false;
        }
    }
}