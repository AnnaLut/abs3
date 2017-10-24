using System;
using System.ComponentModel;

namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// Заявка
    /// </summary>
    public class ClaimDetailsCloseDeal
    {
        private string _dealNumber;
        private string _allegroComment;
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

        [DisplayName("Дата закриття угоди")]
        public DateTime? CloseDate { get; set; }

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
