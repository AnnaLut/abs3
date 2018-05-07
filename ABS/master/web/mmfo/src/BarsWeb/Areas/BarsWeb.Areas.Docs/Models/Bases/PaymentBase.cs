using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Docs.Models.Bases
{
    public abstract class PaymentBase
    {

        [Required]
        [Display(Name = "Референс документа")]
        public decimal? Id { get; set; }

        [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Номер документа")]
        public string Number { get; set; }

        [Display(Name = "Ід користувача")]
        public decimal? UserId { get; set; }

        [Display(Name = "Код валюти")]
        public decimal? CurrencyId { get; set; }

        [Display(Name = "Сума")]
        public decimal? Summa { get; set; }

        [Display(Name = "Сума в еквіваленті")]
        public decimal? SummaEquivalent { get; set; }

        [Display(Name = "Статус")]
        public decimal? Status { get; set; }

        [Display(Name = "Дата документа")]
        public DateTime? Date { get; set; }

        [Display(Name = "Дата поступлення")]
        public DateTime? DateReceipt { get; set; }

        [Display(Name = "Дата системна")]
        public DateTime? DateSystem { get; set; }

        [Display(Name = "Дата валютування")]
        public DateTime? DateCurrency { get; set; }

        [Display(Name = "Призначення")]
        public string Purpose { get; set; }

        [Display(Name = "Тип транзакції")]
        public string TransactionType { get; set; }

        [Display(Name = "Вид документа")]
        public decimal? DocumentType { get; set; }


        
        [Display(Name = "Рахунок відправника")]
        public string SenderAccount { get; set; }

        [Display(Name = "МФО відправника")]
        public string SenderMfo { get; set; }

        [Display(Name = "Назва відправника")]
        public string SenderName { get; set; }

        [Display(Name = "ЄДРПО відправника")]
        public string SenderCode { get; set; }



        [Display(Name = "Код валюти отримувача")]
        public decimal? RecipientCurrencyId { get; set; }

        [Display(Name = "Сума отримувача")]
        public decimal? RecipientSumma { get; set; }

        [Display(Name = "Рахунок отримувача")]
        public string RecipientAccount { get; set; }

        [Display(Name = "МФО отримувача")]
        public string RecipientMfo { get; set; }

        [Display(Name = "Назва отримувача")]
        public string RecipientName { get; set; }

        [Display(Name = "ЄДРПО отримувача")]
        public string RecipientCode { get; set; }

        [Display(Name = "Дебет/Кредит")]
        public decimal? DebitKredit { get; set; }


        [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Бранч")]
        public string Branch { get; set; }

        [Display(Name = "Код філії")]
        public string FilialCode { get; set; }


    }
}
