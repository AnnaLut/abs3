using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using BarsWeb.Areas.CreditFactory.Infrastructure;

namespace BarsWeb.Areas.CreditFactory.ViewModels
{
    /// <summary>
    /// Параметры подключения к региональной базе
    /// </summary>
    public class SyncParams : ICloneable
    {
        [DisplayName("Номер відділення")]
        [Required(ErrorMessage = "Задайте код МФО")]
        public string Mfo { get; set; }

        [DisplayName("URL адреса РУ")]
        [Required(ErrorMessage = "Задайте URL")]
        public string Url_Service { get; set; }

        [DisplayName("Ім`я користувача")]
        public string Username { get; set; }

        [DisplayName("Пароль")]
        public string Password { get; set; }

        [DisplayName("Статус синхронізації")]
        public string Conn_States { get; set; }

        [DisplayName("Повідомлення статусу")]
        public string Conn_Err_Msg { get; set; }

        [DisplayName("Статус")]
        public int Is_Active { get; set; }

        public object Clone()
        {
            var obj = MemberwiseClone();
            return obj;
        }

        public SyncParams CloneMe()
        {
            var obj = (SyncParams)MemberwiseClone();
            return obj;
        }
    }
}

