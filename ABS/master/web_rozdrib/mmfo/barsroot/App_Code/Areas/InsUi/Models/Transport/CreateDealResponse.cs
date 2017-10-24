using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class CreateDealResponse
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
        /// Номер договору(при успішному виконанні)
        /// </summary>
        public Int64? externalId { get; set; }
    }
}