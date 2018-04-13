using System;
using System.ComponentModel;
using BarsWeb.Areas.Cash.Infrastructure;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Результат синхронизации по одному региону
    /// </summary>
    public class SyncResult
    {
        private string _message;

        [DisplayName("ID")]
        public decimal? ID { get; set; }

        [DisplayName("ParentID")]
        public decimal? ParentId { get; set; }

        [DisplayName("MФО")]
        public string Mfo { get; set; }

        [DisplayName("URL")]
        public string URL { get; set; }

        [DisplayName("Тип синхронізації")]
        public string TransferType { get; set; }

        [DisplayName("Банківська дата")]
        public DateTime? BankDate { get; set; }

        [DisplayName("Початок")]
        public DateTime? DateStart { get; set; }

        [DisplayName("Кінець")]
        public DateTime? DateEnd { get; set; }

        [DisplayName("Тривалість")]
        public double Duration
        {
            get
            {
                if (DateStart == null || DateEnd == null)
                {
                    return 0;
                }
                var startSpan = new TimeSpan(DateStart.Value.Ticks);
                var endSpan = new TimeSpan(DateEnd.Value.Ticks);
                return endSpan.Subtract(startSpan).TotalSeconds;
            }
        }

        [DisplayName("Статус")]
        public string Status { get; set; }

        [DisplayName("Опис")]
        public string Message
        {
            get { return _message ?? ""; }
            set { _message = value; }
        }

        [DisplayName("Кількість отриманих рахунків")]
        public decimal RowsTotal { get; set; }

        [DisplayName("Кількість успішно оброблених рахунків")]
        public decimal RowsSucceed { get; set; }

        public decimal RowLevel { get; set; }

        public string TransferTypeName
        {
            get
            {
                if (string.IsNullOrEmpty(TransferType))
                {
                    return string.Empty;
                }

                if (TransferType == SyncType.Accounts)
                {
                    return "Синхронізація рахунків";
                }
                if (TransferType == SyncType.AccountsRest)
                {
                    return "Синхронізація залишків по рахункам";
                }
                if (TransferType == SyncType.Transactions)
                {
                    return "Синхронізація транзакцій";
                }
                return "Синхронізація відділень (бранчів)";
            }
        }

        public string StatusName
        {
            get
            {
                if (string.IsNullOrEmpty(Status))
                {
                    return string.Empty;
                }

                if (Status == SyncStatus.Success)
                {
                    return "Успішно";
                }

                if (Status == SyncStatus.Error)
                {
                    return "Помилка";
                }

                if (Status == SyncStatus.InProcess)
                {
                    return "Відбувається процес синхронізації";
                }

                return "Синхронізація не відбувалась";
            }
        }
    }
}