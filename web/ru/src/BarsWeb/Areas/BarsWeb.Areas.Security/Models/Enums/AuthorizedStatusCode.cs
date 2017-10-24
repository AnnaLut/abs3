namespace BarsWeb.Areas.Security.Models.Enums
{
    /// <summary>
    /// Статуси авторизації користувача 
    /// 0 - успішно
    /// 1 - успішно (дозволено вибір дати)
    /// 2 - термін дії пароля минув
    /// 3 - помилтка 
    /// </summary>
    public enum AuthorizedStatusCode
    {
        Ok, SelectDate, PasswordExpire, Error
    }
}