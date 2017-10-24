﻿using System;
using System.Linq;
using Areas.CRSOUR.Models;

namespace BarsWeb.Areas.CRSOUR.Infrastructure.Repository.DI.Abstract
{
    public interface IDealsRepository
    {
        /// <summary>
        /// Получить простой список заявок
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CDB_CLAIM_DATA_TO_ACCEPT> GetSimpleClaims();

        /// <summary>
        /// Подтвердить обработку заявки
        /// </summary>
        /// <exception cref="Exception"></exception>
        bool SubmitClaim(int claimId, out string message);

        /// <summary>
        /// Получить список заявок
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CDB_CLAIM> GetComplexClaims();

        /// <summary>
        /// Отменить обработку заявки
        /// </summary>
        /// <exception cref="Exception"></exception>
        bool CancelClaim(int claimId, string comment, out string message);

        /// <summary>
        /// Повторно выполнить заявку
        /// </summary>
        /// <exception cref="Exception"></exception>
        bool RepeatClaim(int claimId, out string message);

        /// <summary>
        /// Получить детали заявки типа Новая сделка
        /// </summary>
        IQueryable<V_CDB_NEW_DEAL_CLAIM> GetClaimDetailsNewDeal();

        /// <summary>
        /// Получить детали заявки типа Изменение даты погашения
        /// </summary>
        IQueryable<V_CDB_SET_EXPIRY_DATE_CLAIM> GetClaimDetailsChangeExpireDate();

        /// <summary>
        /// Получить детали заявки типа Изменение процентной ставки
        /// </summary>
        IQueryable<V_CDB_SET_INT_RATE_CLAIM> GetClaimDetailsChangeRate();

        /// <summary>
        /// Получить детали заявки типа Изменение суммы
        /// </summary>
        IQueryable<V_CDB_CHANGE_AMOUNT_CLAIM> GetClaimDetailsChangeSum();

        /// <summary>
        /// Получить детали заявки типа Закрытие сделки
        /// </summary>
        IQueryable<V_CDB_CLOSE_DEAL_CLAIM> GetClaimDetailsCloseDeal();

        /// <summary>
        /// Отменить обработку транзакции
        /// </summary>
        /// <exception cref="Exception"></exception>
        bool CancelTransaction(int transactionId, string comment, out string message);

        /// <summary>
        /// Повторно отправить транзакцию в АБС
        /// </summary>
        /// <exception cref="Exception"></exception>
        bool RepeatTransactionSending(int transactionId, out string message);

        /// <summary>
        /// Получить историю обработки заявки
        /// </summary>
        IQueryable<V_CDB_CLAIM_TRACK> GetClaimHistory();

        /// <summary>
        /// Получить историю обработки транзакции
        /// </summary>
        IQueryable<V_CDB_TRANSACTION_TRACK> GetTransactionHistory();

        /// <summary>
        /// Получить список транзакций
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CDB_BARS_TRANSACTION> GetTransactions();

        /// <summary>
        /// Список видів угоди
        /// </summary>
        /// <returns></returns>
        IQueryable<ViddList> GetVidd();
        /// <summary>
        /// Список кодів валюти
        /// </summary>
        /// <returns></returns>
        IQueryable<CurrencyList> GetCurrency();
        /// <summary>
        /// Список бази відсотків
        /// </summary>
        /// <returns></returns>
        IQueryable<BaseyList> GetBasey();
        /// <summary>
        /// Отримання рахунків
        /// </summary>
        /// <param name="productId"></param>
        /// <param name="currencyId"></param>
        /// <returns></returns>
        DealNls GetDealNls(decimal productId, decimal currencyId);
        /// <summary>
        /// Отримання суми відсотків
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        decimal GetRateSum(RateParams param);
        /// <summary>
        /// Отримання імені МФО
        /// </summary>
        /// <returns></returns>
        MfoName GetMfoName(string mfo);
        /// <summary>
        /// Отримання кода МФО по РНК
        /// </summary>
        /// <param name="rnk"></param>
        /// <returns></returns>
        string GetMfo(decimal rnk);
        /// <summary>
        /// Отримання даних угоди
        /// </summary>
        /// <param name="nd"></param>
        /// <returns></returns>
        DealParams GetDeal(decimal nd);
        /// <summary>
        /// Зберегти угоду
        /// </summary>
        /// <param name="param"></param>
        string SaveDeal(SaveDeal param);
        /// <summary>
        /// Зберегти оновлення
        /// </summary>
        /// <param name="dealId"></param>
        /// <param name="expiryDate"></param>
        /// <param name="dealAmount"></param>
        /// <param name="interestRate"></param>
        /// <param name="partnerMainAccount"></param>
        /// <param name="partnerInterestAccount"></param>
        /// <returns></returns>
        string UpdateDeal(decimal dealId, DateTime expiryDate, decimal dealAmount, decimal interestRate, string partnerMainAccount, string partnerInterestAccount);
    }
}
