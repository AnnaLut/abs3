using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.RegPayments.Models
{
    public class SBON_ORDER
    {
        public Decimal payer_account_id;
        public DateTime start_date;
        public DateTime stop_date;
        public Int16 payment_frequency;
        public Int16 holiday_shift;
        public Int16 provider_id;
        public String personal_account;
        public Decimal regular_amount;
        public Decimal? ceiling_amount;
        public String extra_attributes;
        public String sendsms;
    }
    public class SbonOrderRequest
    {
        public Decimal TransactionId;   //унікальний код транзакції
        public String UserLogin;        //логін користувача АД
        public Int16 OperationType;     //тип операції сервіса (9-регулярні платежі)
        public String KF;               //код філії (МФО)
        public string Branch;           //відділення, де виконується операція
        public Int16 SbonType;          //0- без контракта, 1 - с контрактом                    
        public SBON_ORDER SbonOrderReq; //реквізити платежу СБОН 
    }
    public class SbonOrderResult
    {
        public decimal OrderId;
        //public byte[] Doc;
        public string Doc;
        public int ResultCode;                  //загальний код виконання операції 0-Ок, -1-помилка
        public string ResultMessage;
    }

    public class FREE_SBON_ORDER
    {
        public decimal payer_account_id;
        public DateTime start_date;
        public DateTime stop_date;
        public Int16 payment_frequency;
        public Int16 holiday_shift;
        public Int16 provider_id;
        public Decimal regular_amount;
        public String receiver_mfo;
        public String reciever_account;
        public String reciever_name;
        public String receiver_edrpou;
        public String purpose;
        public String extra_attributes;
        public String sendsms;
    }
    public class SbonFreeOrderRequest
    {
        public Decimal TransactionId;   //унікальний код транзакції
        public String UserLogin;        //логін користувача АД
        public Int16 OperationType;     //тип операції сервіса (9-регулярні платежі)
        public String KF;               //код філії (МФО)
        public string Branch;           //відділення, де виконується операція  
        public FREE_SBON_ORDER SbonFreeOrderReq; //реквізити платежу СБОН 
    }
    public class SbonFreeOrderResult
    {
        public decimal OrderId;
        //public byte[] Doc;
        public string Doc;
        public int ResultCode;           //загальний код виконання операції 0-Ок, -1-помилка
        public string ResultMessage;
    }
}