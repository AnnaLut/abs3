using System;
using System.ComponentModel;

namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// Заявка
    /// </summary>
    public class ClaimDetailsNewDeal
    {
        private string _allegroComment;
        private string _dealNumber;
        private string _lenderCode;
        private string _lenderName;
        private string _borrowerCode;
        private string _borrowerName;
        private string _interestCalendar;
        private string _allegroId;
        private string _claimState;

        [DisplayName("ID заявки")]
        public int Id { get; set; }

        [DisplayName("Номер угоди")]
        public string DealNumber
        {
            get { return _dealNumber ?? ""; }
            set { _dealNumber = value; }
        }

        [DisplayName("Дата укладення угоди")]
        public DateTime? StartDate { get; set; }

        [DisplayName("Дата погашення угоди")]
        public DateTime? EndDate { get; set; }

        [DisplayName("Код (МФО) кредитора")]
        public string LenderCode
        {
            get { return _lenderCode ?? ""; }
            set { _lenderCode = value; }
        }

        [DisplayName("Назва кредитора")]
        public string LenderName
        {
            get { return _lenderName ?? ""; }
            set { _lenderName = value; }
        }

        [DisplayName("Код (МФО) позичальника")]
        public string BorrowerCode
        {
            get { return _borrowerCode ?? ""; }
            set { _borrowerCode = value; }
        }

        [DisplayName("Назва позичальника")]
        public string BorrowerName
        {
            get { return _borrowerName ?? ""; }
            set { _borrowerName = value; }
        }

        [DisplayName("Сума угоди")]
        public decimal? Sum { get; set; }

        [DisplayName("Валюта угоди")]
        public int? Currency { get; set; }

        [DisplayName("Відсоткова ставка")]
        public decimal? InterestRate { get; set; }

        [DisplayName("Тип календаря відсотків")]
        public string InterestCalendar
        {
            get { return _interestCalendar ?? ""; }
            set { _interestCalendar = value; }
        }

        [DisplayName("Коментар Аллегро")]
        public string AllegroComment
        {
            get { return _allegroComment ?? ""; }
            set { _allegroComment = value; }
        }

        [DisplayName("Ідентифікатор заявки в системі Аллегро")]
        public string AllegroId
        {
            get { return _allegroId ?? ""; }
            set { _allegroId = value; }
        }

        [DisplayName("Системний час створення заявки")]
        public DateTime SysTime { get; set; }

        [DisplayName("Статус обробки заявки")]
        public string ClaimState
        {
            get { return _claimState ?? ""; }
            set { _claimState = value; }
        }
    }
}
