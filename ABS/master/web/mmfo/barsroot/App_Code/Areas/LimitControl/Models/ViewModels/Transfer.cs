using System;
using System.ComponentModel;

namespace BarsWeb.Areas.LimitControl.ViewModels
{
    public class Transfer
    {
        [DisplayName("Система")]
        public string System { get; set; }

        [DisplayName("Ідентифікатор переказу")]
        public string Id { get; set; }

        [DisplayName("Серія")]
        public string Series { get; set; }

        [DisplayName("Номер документа")]
        public string Number { get; set; }

        [DisplayName("ПІБ")]
        public string Name { get; set; }

        [DisplayName("Дата народження")]
        public DateTime? BirthDate { get; set; }

        [DisplayName("Сума (грн.) ")]
        public decimal? Sum { get; set; }
        public bool Selected { get; set; }
        public bool Editable { get; set; }
    }
}
//для сумісності дедьти 85

namespace Areas.LimitControl.ViewModels
{
    public class Transfer : BarsWeb.Areas.LimitControl.ViewModels.Transfer
    {
    }
}