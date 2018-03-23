using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class PaymentsResponse
    {
        /// <summary>
        /// Статус виконання
        /// </summary>
        public bool success { get; set; }
        /// <summary>
        /// Текст повідомлення
        /// </summary>
        public string message { get; set; }
        /// <summary>
        /// Номер документа(при успішному виконанні)
        /// </summary>
        public Int64? externalId { get; set; }
    }
}