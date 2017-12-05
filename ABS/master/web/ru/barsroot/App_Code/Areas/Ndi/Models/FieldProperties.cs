using System;

namespace BarsWeb.Areas.Ndi.Models
{

    /// <summary>
    /// Основные свойства поля таблицы
    /// </summary>
    public class FieldProperties : ICloneable
    {
        public string Name { get; set; }
        /// <summary>
        /// Тип из META_COLTYPES
        /// </summary>
        public string Type { get; set; }
        /// <summary>
        /// Значение в строковом виде, так как передается json-ом с клиента на сервер, конвертится к нужному типу на основе Type 
        /// </summary>
        public string Value { get; set; }

        /// <summary>
        /// Значение знака сопоставления <= / = / => / < / >
        /// </summary>
        public string Sign { get; set; }
        public object Clone()
        {
            FieldProperties clon = new FieldProperties
            {
                Value = this.Value,
                Name = this.Name,
                Type = this.Type,
                Sign = this.Sign
            };
            return clon;
        }
    }

}