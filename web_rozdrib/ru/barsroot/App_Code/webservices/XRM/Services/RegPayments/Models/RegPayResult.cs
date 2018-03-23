using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.RegPayments.Models
{
    public class XRMRegPayResult
    {
        public decimal? IDD;                 //ідентифікатор регулярного платежу
        public int ResultCode;              //статус створення 0-Ок, -1 помилк
        public string ResultMessage;        //опис помилки створення рег.платежу
                                            //public byte[] Doc;
        public string Doc;

    }
    public class XRMDPTRegPayResult
    {
        public XRMRegPayResult XRMRegPayResult; //масив даних щодо операції створення рег.платежу
        public int ResultCode;                  //загальний код виконання операції 0-Ок, -1-помилка
        public string ResultMessage;            //опис помилки створення ДУ 25 по рег.платежу
        public Decimal AgrId;                   //ідентифікатор додаткової угоди до депозиту               
    }
    public class XRMCCKRegPayResult
    {
        public XRMRegPayResult XRMRegPayResult; //масив даних щодо операції створення рег.платежу
        public int ResultCode;                  //загальний код виконання операції 0-Ок, -1-помилка
        public string ResultMessage;            //опис помилки створення регулярного платежу                     
    }
}