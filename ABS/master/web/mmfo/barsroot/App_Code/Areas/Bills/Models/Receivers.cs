using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Информация о векселе держателе!
    /// </summary>
    public class Receivers
    {
        public Int32 ID { get; set; }

        //ІД очікуваного отримувача, отриманий з ДКСУ
        public Int32 EXP_ID { get; set; }

        //ІД судового рішення, отримане з ДКСУ
        public Int32 RESOLUTION_ID { get; set; }

        //ПІБ/Найменування отримувача
        [Required]
        public String NAME { get; set; }

        //ІНН/ЄДРПОУ отримувача
        public String INN { get; set; }

        //Номер документа отримувача
        public String DOC_NO { get; set; }

        //Дата видачі документа
        public DateTime DOC_DATE { get; set; }

        //Ким виданий документ
        public String DOC_WHO { get; set; }

        //Тип клієнта (юр/фіз)
        public Int32? CL_TYPE { get; set; }

        //Валюта
        public String CURRENCY { get; set; }

        //Курс конвертації суми
        public Double? CUR_RATE { get; set; }

        //Сума для отримання в грн
        public Double? AMOUNT { get; set; }

        //Поточний статус рішення
        public String STATUS { get; set; }

        //Контактний телефон
        public String PHONE { get; set; }

        //Відділення, яке проводить роботу с отримувачем
        public String BRANCH { get; set; }

        //Рахунок для перерахування коштів
        public String ACCOUNT { get; set; }

        //ІД запиту (отримується з ДКСУ)
        public Int32? REQ_ID { get; set; }

        //Коментарі по запиту
        public Byte?[] COMMENTS { get; set; }

        //Посилання на клієнта АБС
        public Int64? RNK { get; set; }
    }
}