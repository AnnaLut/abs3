using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.RegPayments.Models
{
    public class XRMRegPayReq
    {
        public Decimal TransactionId;   //унікальний код транзакції
        public String UserLogin;        //логін користувача АД
        public Int16 OperationType;     //тип операції сервіса (9-регулярні платежі)
        public String KF;               //код філії (МФО)
        public string Branch;           //відділення, де виконується операція
        public Int64 Rnk;               //РНК клієнта, якому створюється регулярний платіж
        public DateTime StartDate;      //дата початку дії регулярного платежу (має бути більша за наступну банківську дату)
        public DateTime FinishDate;     //дата завершення дії регулярного платежу (для депозитного ДУ має бути меньшою або дорівнювати даті закінчення депозитного договору)
        public Int16 Frequency;         //періодичність виконання - довідник FREQ
        public Int16 KV;                //валюта платежів
        public String NLSA;             //рахунок платника - має належити клієнту, рахунок, відкритий в Банку
        public String OKPOB;            //ЗКПО отримувача регулярного платежу
        public String NAMEB;            //назва отримувача регулярного платежу
        public String MFOB;             //МФО установи, де відкрито рахунок отримувача регулярного платежу
        public String NLSB;             //рахунок отримувача регулярного платежу
        public Int16 Holyday;           //врахування вихідних днів при припаданні дати платежа на вихідний день(-1 - перенести платіж на попередню банківську дату, 1 - на наступну)
        public String Sum;              //сума (формула суми) регулярного платежу
        public String Purpose;          //призначення платежу (не більше 160 сімволів, не менше 5, не має містити спеціальніх символів і не кірилічну кодировку)
    }
    public class XRMDPTRegPayReq
    {
        public XRMRegPayReq XRMRegPayReq;   //масив даних про створюваний рег.платіж
        public Decimal? Dpt_id;             //номер депозитного договору, для якого створюється регулярний платіж
    }
    public class XRMCCKRegPayReq
    {
        public XRMRegPayReq XRMRegPayReq;   //масив даних про створюваний рег.платіж
        public Decimal ND;                   //номер кредитного договору, для якого створюється регулярний платіж
    }
}