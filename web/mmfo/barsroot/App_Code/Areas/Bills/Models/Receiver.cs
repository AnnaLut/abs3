using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Информация о векселе держателе!
    /// </summary>
    public class Receiver
    {
        //ІД очікуваного отримувача, отриманий з ДКСУ
        public Int32 EXP_ID { get; set; }

        //ІД судового рішення, отримане з ДКСУ
        public Int32 RESOLUTION_ID { get; set; }

        //ПІБ/Найменування отримувача
        public String NAME { get; set; }

        //ІНН/ЄДРПОУ отримувача
        public String INN { get; set; }

        //Номер документа отримувача
        public String DOC_NO { get; set; }

        //Дата видачі документа
        public DateTime? DOC_DATE { get; set; }

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

        public Double? EXPECTED_AMOUNT { get; set; }

        //Код поточного статусу
        public String STATUS { get; set; }

        public String EXPECTEDNAME { get; set; }

        //Поточний статус рішення
        public String STATUS_NAME { get; set; }

        //Контактний телефон
        public String PHONE { get; set; }

        //Відділення, яке проводить роботу с отримувачем
        public String BRANCH { get; set; }

        //Відділення поточного користувача
        public String USER_BRANCH { get; set; }

        //Рахунок для перерахування коштів
        public String ACCOUNT { get; set; }

        //ІД запиту (отримується з ДКСУ)
        public Int32? REQ_ID { get; set; }

        //Коментарі по запиту
        public Byte?[] COMMENTS { get; set; }

        //Посилання на клієнта АБС
        public Int64? RNK { get; set; }

        //Наявность документа
        public Int32 APPLREADY { get; set; }

        //Адрес взыскателя
        [StringLength(maximumLength: 250)]
        public String ADDRESS { get; set; }

        //Тип документа
        public Int32 SNDDOC { get; set; }

        //
        public String LCV { get; set; }

        public String CUR_NAME { get; set; }

        public DateTime? LAST_DT { get; set; }
        public String LAST_USER { get; set; }
        public Int32 IMPORTANT_FLAG { get; set; }
        public String IMPORTANT_TXT { get; set; }
        public Int32? EXT_STATUS { get; set; }

        public String EXT_STATUS_NAME { get; set; }
        public List<ReceiverAccounts> ACCOUNTS { get; set; }
    }
}