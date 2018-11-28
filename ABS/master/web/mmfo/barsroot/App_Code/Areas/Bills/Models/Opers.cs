using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Summary description for Opers
    /// </summary>
    public class Opers
    {
        public Int32? ID { get; set; }         //ID операції
        public DateTime? OPER_DT { get; set; } //Дата операції
        public String DBT { get; set; }       //Рахунок дебета
        public String CRD { get; set; }       //Рахунок кредита
        public Decimal? AMOUNT { get; set; }   //Сума операції
        public String STATE { get; set; }     //Статус операції
        public Decimal? DOC_REF { get; set; }   //Посилання на документ в АБС
        public String CUR_CODE { get; set; }  //Валюта операції
        public String PURPOSE { get; set; }   //Призначення платежу
        public Decimal? MFO { get; set; }     //МФО
        public String MESSAGE { get; set; }   //Повідомлення про обробку
        public String USER_REF { get; set; }  //Користувач, який виконав операцію
        public DateTime? LAST_DT { get; set; } //Дата+час останньої зміни
        public DateTime? VDAT { get; set; }    //Банківська дата проведення
        public String KF { get; set; }        //МФО банку
        public String BRANCH { get; set; }    //Відділення
    }
}