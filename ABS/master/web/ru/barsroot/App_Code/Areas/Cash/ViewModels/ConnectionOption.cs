using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using BarsWeb.Areas.Cash.Infrastructure;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Параметры подключения к региональной базе
    /// </summary>
    public class ConnectionOption : ICloneable
    {
        [DisplayName("Код МФО")]
        [Required(ErrorMessage = "Задайте код МФО")]
        public string Mfo { get; set; }

        [DisplayName("Опис")]
        public string Name { get; set; }

        [DisplayName("URL")]
        [Required(ErrorMessage = "Задайте URL")]
        public string Url { get; set; }

        [DisplayName("Логін")]
        public string Login { get; set; }

        [DisplayName("Пароль")]
        public string Password { get; set; }

        [DisplayName("Дата останньої синхронізації")]
        [DataType(DataType.DateTime)]
        public DateTime? LastSyncDate { get; set; }

        [DisplayName("Статус останньої синхронізації")]
        public string LastSyncStatus { get; set; }

        [DisplayName("Виконувати синхронізацію")]
        public bool SyncEnabled { get; set; }

        public object Clone()
        {
            var obj = MemberwiseClone();
            return obj;
        }

        public ConnectionOption CloneMe()
        {
            var obj = (ConnectionOption)MemberwiseClone();
            return obj;
        }
        
        public string StatusName
        {
            get
            {
                if (string.IsNullOrEmpty(LastSyncStatus))
                {
                    return string.Empty;
                }

                if (LastSyncStatus == SyncStatus.Success)
                {
                    return "Успішно";
                }

                if (LastSyncStatus == SyncStatus.Error)
                {
                    return "Помилка";
                }

                if (LastSyncStatus == SyncStatus.InProcess)
                {
                    return "Відбувається процес синхронізації";
                }

                return "Синхронізація не відбувалась";
            }
        }
    }
}

