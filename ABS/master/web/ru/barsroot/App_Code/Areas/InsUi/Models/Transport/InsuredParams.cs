using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    /// <summary>
    /// Параметри запиту на пошук клієнта
    /// </summary>
    public class InsuredParams
    {
        /// <summary>
        /// Код клієнта (ІПН, ОКПО)
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// Список типів документів (Паспорт, права і т.д.)
        /// По клієнту в єдиній базі зберігається інформація тільки по паспорту
        /// </summary>
        public string DocumentTypes { get; set; }
        /// <summary>
        /// Дата на яку здійснюється пошук(не обов`язково поточна)
        /// </summary>
        public DateTime? date { get; set; }
        /// <summary>
        /// Тип клієнта. true - юридична особа, false - фізична особа
        /// </summary>
        public bool isLegal { get; set; }
        /// <summary>
        /// Максимальна кількість записів які повертаються(по замовчуваню 10)
        /// </summary>
        public string limit { get; set; }

    }
}