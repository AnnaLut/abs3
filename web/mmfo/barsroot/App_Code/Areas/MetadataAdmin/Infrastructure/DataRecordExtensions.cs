using System;
using System.Collections.Generic;
using System.Data;
using System.Collections;

namespace BarsWeb.Areas.MetaDataAdmin.Infrastructure
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

        public static List<T> Clone<T>(this List<T> listToClone) where T : ICloneable
        {
            List<T> newList = new List<T>(listToClone.Count);

            listToClone.ForEach((item) =>
            {
                newList.Add((T)item.Clone());
            });
            return newList;
        }
    }
}