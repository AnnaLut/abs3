using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель коментариев (переписки) с ДКСУ!
    /// </summary>
    public class Comment
    {
        //Дата
        public DateTime Date { get; set; }

        //Автор комментария
        public String Author { get; set; }

        //Комментарий
        public String Text { get; set; }
    }
}