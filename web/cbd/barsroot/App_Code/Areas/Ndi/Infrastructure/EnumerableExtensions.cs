using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Расширения для IEnumarable
    /// </summary>
    public static class EnumerableExtensions
    {
        /// <summary>
        /// Определяет явлеется ли источник пустым
        /// </summary>
        /// <typeparam name="TSource">Тип данных в источнике</typeparam>
        /// <param name="source">Источник данных</param>
        /// <returns></returns>
        public static bool IsNullOrEmpty<TSource>(this IEnumerable<TSource> source)
        {
            return source == null || !source.Any();
        }
    }
}