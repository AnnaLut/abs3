using System;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    /// <summary>
    /// Определяет родительскую строку протокола для новых строк
    /// </summary>
    public class LogBinder : ICloneable
    {
        /// <summary>
        /// Id
        /// </summary>
        public decimal? Id { get; set; }
        
        /// <summary>
        /// Id родительской строки протокола
        /// </summary>
        public decimal? ParentId { get; set; }
        
        /// <summary>
        /// Уровень строки протокола
        /// </summary>
        public int Level { get; set; }

        public object Clone()
        {
            return MemberwiseClone();
        }
    }
}