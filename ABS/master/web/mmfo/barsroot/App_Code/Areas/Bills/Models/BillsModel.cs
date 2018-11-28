using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных векселя!
    /// </summary>
    public class BillsModel
    {
        //Ід очікуваного отримувача з ДКСУ
        public Int32? EXP_ID { get; set; }
        //Номер векселя
        public String BILL_NO { get; set; }
        //Дата випуску векселя
        public DateTime? DT_ISSUE { get; set; }
        //Дата погашення векселя
        public DateTime DT_PAYMENT { get; set; }
        //Номінал векселя
        public Decimal AMOUNT { get; set; }
        //Код статусу векселя
        public String STATUS { get; set; }
        //Поточний статус векселя
        public String STATUS_NAME { get; set; }
        //Дата зміни поточного стану
        public DateTime? LAST_DT { get; set; }
        //Користувач, якив вносив останню зміну
        public String LAST_USER { get; set; }
        //МФО
        public Int32? KF { get; set; }
        //ПІБ/Найменування отримувача
        public String NAME { get; set; }
        //ІПН/ЄДРПО отримувача
        public String INN { get; set; }
        //Номер документа отримувача (для фізосіб)
        public String DOC_NO { get; set; }
        //Дата документа отримувача (для фізосіб)
        public DateTime? DOC_DATE { get; set; }
        //Ким виданий документ отримувача (для фізосіб)
        public String DOC_WHO { get; set; }
        //Тип отримувача(юр, фіз)
        public Int32? CL_TYPE { get; set; }
        //Код валюти рішення
        public String CURRENCY { get; set; }
        //зафіксований курс для запиту на виплату рішення 
        public Decimal? CUR_RATE { get; set; }
        //Сума для виплати
        public Decimal? EXPECTED_AMOUNT { get; set; }
        //Контактний телефон отримувача
        public String PHONE { get; set; }
        //Номер рахунка отримувача
        public String ACCOUNT { get; set; }
        //Номер запиту (в ДКСУ)
        public Int32? REQ_ID { get; set; }
        //Код відділення
        public String BRANCH { get; set; }
        //Коментарі по запиту
        public String COMMENTS { get; set; }
        //RNK клієнта банку
        public Int64? RNK { get; set; }
        //Номер витягу
        public Int32? EXTRACT_NUMBER_ID { get; set; }
        //Дата видачі векселю
        public DateTime? HANDOUT_DATE { get; set; }
    }
}