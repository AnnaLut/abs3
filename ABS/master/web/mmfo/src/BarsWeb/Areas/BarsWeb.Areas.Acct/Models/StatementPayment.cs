using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Acct.Models
{
    public class StatementPayment
    {
        [Key]
        [Display(Name = "Ід транзакції")]
        public decimal? Id { get; set; }
        [Display(Name = "Референс документа")]
        public decimal? DocumentId { get; set; }
        [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Номер документа")]
        public string Number { get; set; }
        [Display(Name = "Номер документа")]
        public string TransactionType { get; set; }
        [Display(Name = "Ід рахунку")]
        public decimal? AccountId { get; set; }
        [Display(Name = "Статус")]
        public decimal? StatusCode { get; set; }
        [Display(Name = "Код банка кореспондента")]
        public string CorrespBankId { get; set; }
        [Display(Name = "Валюта кореспондента")]
        public decimal? CorrespCurrencyId { get; set; }
        [Display(Name = "Рахунок кореспондента")]
        public string CorrespAccountNumber { get; set; }
        [Display(Name = "Назва рахунку кореспондента")]
        public string CorrespAccountName { get; set; }
        [Display(Name = "Дебет")]
        public decimal? Debit { get; set; }
        [Display(Name = "Кредит")]
        public decimal? Kredit { get; set; }
        [Display(Name = "Призначення")]
        public string Purpose { get; set; }
        [Display(Name = "Дата докамента")]
        public DateTime? Date { get; set; }
        [Display(Name = "Дата оплати")]
        public DateTime? FactDate { get; set; }
    }
}
