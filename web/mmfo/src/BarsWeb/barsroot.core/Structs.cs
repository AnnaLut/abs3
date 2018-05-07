using System;

namespace barsroot.core
{
    public struct UserMap
    {
        public string webuser;      //Пользователь Windows(логин)
        public string dbuser;       // Пользователь Oracle
        public string errormode;    // Режим отобоажени ошибок  
        public string webpass;      // Пароль пользователя
        public string adminpass;    // Пароль администратора (первичный)
        public string chgdate;      // Дата последнего изменения пароля
        public string blocked;      // Флаг блокировки 
        public string comm;         // Комментарий
        public string attemps;      // Попытки вводо неверного пароля
        public string user_id;      // id идетификатор
        public string shared_user;  // схема пользователя
        public string log_level;    // уровень детализации логерра
        public string change_date;  // право работы в нескольких банковских днях
        public DateTime bank_date;   // глобальная банковская дата
    }
}
