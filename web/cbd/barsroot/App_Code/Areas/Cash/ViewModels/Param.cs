using System.ComponentModel;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Параметр
    /// </summary>
    public class Param
    {
        [DisplayName("Назва")]
        public string Name { get; set; }

        [DisplayName("Значення")]
        public string Value { get; set; }

        [DisplayName("Опис")]
        public string Comment { get; set; }
    }
}