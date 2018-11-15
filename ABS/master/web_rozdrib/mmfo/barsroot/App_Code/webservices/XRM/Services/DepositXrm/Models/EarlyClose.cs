using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class EarlyCloseRequest
    {
        public string Kf { get; set; }
        public string Branch { get; set; }
        public decimal Rnk { get; set; }             // РНК клієнта, що звернувся за достроковим закриттям депозиту
        public decimal DepositId { get; set; }          // номер депозитного договору
        public string CustomerType { get; set; }        // тип клієнта, що звернувся (V - власник, T - довірена особа, H - спадкоємець)
        public short FullPay { get; set; }           // ознака 1 - повного повернення, 0 - часткового повернення
        public decimal? Sum { get; set; }            // запрошена сума
        public short UseCash { get; set; }           // ознака виплати готівкою 1, 0 - безготівково
    }
    public class DepositTTS
    {
        public string TT { get; set; }                 // код операції
        public string Name { get; set; }               // найменування операції
    }
    public class EarlyCloseResponse
    {
        public decimal Currency { get; set; }            // Валюта вкладу
        public decimal DepositSum { get; set; }          // Сума на депозитному рахунку
        public decimal PercentSum { get; set; }          // Сума на рахунку нарахованих відсотків
        public decimal Rate { get; set; }                // Номінальна %% ставка
        public decimal PenaltyRate { get; set; }         // Штрафна %% ставка
        public decimal AllPercentSum { get; set; }       // Загальна сума нарахованих відсотків до штрафування
        public decimal PenaltyPercentSum { get; set; }   // Загальна сума нарахованих відсотків з урахуванням штрафної ставки
        public decimal PenaltySum { get; set; }          // Сума штрафа
        public decimal ComissionSum { get; set; }        // Сума комісії за дострокове розторгнення
        public decimal DenomSum { get; set; }            // Сума комісії за прийом на вклад зношених купюр
        public decimal DepositSumToPay { get; set; }     // Сума до виплати депозита
        public decimal PercentSumToPay { get; set; }     // Сума до виплати відсотків
        public DepositTTS[] XrmDepositTTS { get; set; } // перелік доступних операцій для виплати достроково
        public DepositTTS[] XrmPercentTTS { get; set; } // перелік доступних операцій для виплати достроково
    }
    public class EarlyCloseRunResponse
    {
        public decimal DepositSumToPay { get; set; }     // Сума до виплати депозита
        public decimal PercentSumToPay { get; set; }     // Сума до виплати відсотків
    }
}