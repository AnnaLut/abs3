using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class XRMEarlyCloseReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public String KF;
        public String Branch;
        public decimal RNK;             // РНК клієнта, що звернувся за достроковим закриттям депозиту
        public decimal DPT_ID;          // номер депозитного договору
        public string CUST_TYPE;        // тип клієнта, що звернувся (V - власник, T - довірена особа, H - спадкоємець)
        public Int16 FullPay;           // ознака 1 - повного повернення, 0 - часткового повернення
        public Decimal? Sum;            // запрошена сума
        public Int16 UseCash;           // ознака виплати готівкою 1, 0 - безготівково
    }
    public class XrmDepositTTS
    {
        public string tt;               // код операції
        public string name;               // найменування операції
    }
    public class XRMEarlyCloseRes
    {
        public decimal Currency;            // Валюта вкладу
        public decimal DepositSum;          // Сума на депозитному рахунку
        public decimal PercentSum;          // Сума на рахунку нарахованих відсотків
        public decimal Rate;                // Номінальна %% ставка
        public decimal PenaltyRate;         // Штрафна %% ставка
        public decimal AllPercentSum;       // Загальна сума нарахованих відсотків до штрафування
        public decimal PenaltyPercentSum;   // Загальна сума нарахованих відсотків з урахуванням штрафної ставки
        public decimal PenaltySum;          // Сума штрафа
        public decimal ComissionSum;        // Сума комісії за дострокове розторгнення
        public decimal DenomSum;            // Сума комісії за прийом на вклад зношених купюр
        public decimal DepositSumToPay;     // Сума до виплати депозита
        public decimal PercentSumToPay;     // Сума до виплати відсотків
        public XrmDepositTTS[] XrmDepositTTS; // перелік доступних операцій для виплати достроково
        public XrmDepositTTS[] XrmPercentTTS; // перелік доступних операцій для виплати достроково
        public decimal Status;
        public string ErrMessage;
    }
    public class XRMEarlyCloseRunRes
    {
        public decimal DepositSumToPay;     // Сума до виплати депозита
        public decimal PercentSumToPay;     // Сума до виплати відсотків
        public decimal Status;
        public string ErrMessage;
    }
}