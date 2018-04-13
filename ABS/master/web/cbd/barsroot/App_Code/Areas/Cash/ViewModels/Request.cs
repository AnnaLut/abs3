using System;
using System.Collections.Generic;
using System.ComponentModel;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Заявка на изменение лимита
    /// </summary>
    public class Request
    {
        private static List<CLIM_MFO> _mfoList;

        [DisplayName("ID")]
        public decimal ID { get; set; }

        [DisplayName("ID рахунку")]
        public decimal AccountId { get; set; }

        /// <summary>
        /// Текущий лимит в единицах (не в копейках)
        /// </summary>
        [DisplayName("Поточний ліміт")]
        public decimal? CurrentLimit { get; set; }

        /// <summary>
        /// Максимальный лимит в единицах (не в копейках)
        /// </summary>
        [DisplayName("Максимальний ліміт")]
        public decimal? MaxLimit { get; set; }

        /// <summary>
        /// Максимальный лимит завантаження (для банкомату) в единицах (не в копейках)
        /// </summary>
        [DisplayName("Максимальний ліміт завантаження")]
        public decimal? MaxLoadLimit { get; set; }
        [DisplayName("Дата заявки")]
        public DateTime? RequestDate { get; set; }

        [DisplayName("Запросив")]
        public decimal? RequestStaffId { get; set; }

        [DisplayName("Запросив")]
        public string RequestStaffName { get; set; }

        [DisplayName("Статус заявки")]
        public string RequestStatus { get; set; }

        [DisplayName("Дата обробки")]
        public DateTime? ApproveDate { get; set; }

        [DisplayName("Обробив")]
        public decimal? ApproveStaffId { get; set; }

        [DisplayName("Обробив")]
        public string ApproveStaffName { get; set; }

        [DisplayName("Відділення")]
        public string Branch { get; set; }

        [DisplayName("Особовий рахунок")]
        public string PrivateAccount { get; set; }

        [DisplayName("Код валюти")]
        public short CurrencyCode { get; set; }

        [DisplayName("Тип ліміту")]
        public string LimitType { get; set; }

        [DisplayName("МФО")]
        public string Mfo { get; set; }

        [DisplayName("Назва РУ")]
        public string MfoName { get; set; }

        public bool Editable
        {
            get
            {
                return !string.IsNullOrEmpty(RequestStatus) && RequestStatus == "NEW";
            }
        }
        public bool Deletable
        {
            get
            {
                return !string.IsNullOrEmpty(RequestStatus) && RequestStatus == "NEW";
            }
        }
        public bool Submitable
        {
            get
            {
                return !string.IsNullOrEmpty(RequestStatus) && RequestStatus == "NEW";
            }
        }
        [DisplayName("Статус заявки")]
        public string RequestStatusName { get; set; }

       
    }
}