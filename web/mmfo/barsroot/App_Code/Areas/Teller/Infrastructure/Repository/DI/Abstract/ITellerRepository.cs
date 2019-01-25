using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Teller.Enums;
using BarsWeb.Areas.Teller.Model;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Teller.Infrastructure.DI.Abstract
{
    public interface ITellerRepository
    {
        /// <summary>
        /// Активация, деактивация Теллера
        /// </summary>
        /// <param name="isTeller"></param>
        void SetTeller(bool isTeller);

        /// <summary>
        /// Проверка суммы
        /// </summary>
        /// <param name="sum"></param>
        /// <returns></returns>
        int CheckSmall(decimal sum);

        /// <summary>
        /// выполнение запросов связанных с получением статуса окна или с его изменением
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        TellerWindowStatusModel ExecuteGetStatus(ATMModel data);

        /// <summary>
        /// выполнение отправки сообщений TechnicalButtonSubmit, CheckVisaDocs, CheckStornoDocs
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        TellerResponseModel DocsAndTechnical(TellerRequestModel data);

        /// <summary>
        /// получение списка технических кнопок и sql строк запросов
        /// </summary>
        /// <returns></returns>
        List<ATMTechnicalButtonsModel> GetTechnicalButtons();

        /// <summary>
        /// Получение состояния Теллера
        /// </summary>
        /// <returns></returns>
        TellerStatus GetTellerStatus();

        /// <summary>
        /// Получение статаса для отображения или скрытия кнопки теллера (пока зреализовано в Documents.aspx, Docinput.aspx)
        /// </summary>
        /// <returns></returns>
        Int32 IsButtonVisible();

        TellerResponseModel ChangeRequest(TellerWindowStatusModel data);

        /// <summary>
        /// Запросы инкассации
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        TellerResponseModel Encashment(EncashmentModel data);

        /// <summary>
        /// получение списка валют
        /// </summary>
        /// <returns></returns>
        IEnumerable<TellerCurrency> GetCurrencyList();

        /// <summary>
        /// получение номиналов и их количества определенной валюты
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        IEnumerable<ATMCurrencyListModel> GetAtmCurrencyList(String code);

        /// <summary>
        /// передача списка номиналов и их количества для дальнейшего проведения операции инкассирования
        /// </summary>
        /// <param name="xml"></param>
        /// <param name="currency"></param>
        /// <returns></returns>
        TellerResponseModel CollectPartial(String xml, String currency);

        /// <summary>
        /// получения статуса АТМ для отображения уведомления об необходимости забрать сдачу из АТМ
        /// </summary>
        /// <returns></returns>
        TellerStatusModel TellerStatus(Boolean http);

        /// <summary>
        /// получение списка необходимых для проведения операций инкассации черех ТОХ
        /// </summary>
        /// <returns></returns>
        List<TellerEncashmentList> EncashmentList();

        /// <summary>
        /// подтверждение проведения операции черех ТОХ
        /// </summary>
        /// <param name="docRef"></param>
        /// <returns></returns>
        Int32 ConfirmTox(ConfirmTox tox);

        /// <summary>
        /// Получение типа роли Теллера:
        ///     Темпокасса
        ///     Теллер
        ///     Без роли
        /// </summary>
        /// <returns></returns>
        TellerCurrentRole GetRole();

        /// <summary>
        /// Получение наличия денег в темпокассе
        /// </summary>
        /// <returns></returns>
        String GetEncashmentNonAmount(String cur_code);

        /// <summary>
        /// Получение кода валюты по значению
        /// </summary>
        /// <param name="currency"></param>
        /// <returns></returns>
        String GetCurrencyCode(String currency);

        /// <summary>
        /// Получение списка валют и их количества в темпокассе
        /// используется для полного изъятия
        /// </summary>
        /// <returns></returns>
        List<NonAtmAmount> nonAtmAmount();

        /// <summary>
        /// Проверка на незавершенные операции (для доступа на проведение инкассации)
        /// </summary>
        /// <param name="operation">
        /// I - незавершённые операции по принятию наличных
        /// O - незавершенные операции по выдаче наличных
        /// </param>
        /// <returns></returns>
        Boolean IfAllowedEncashment(String operation);

        void CreateCollectOpper();

        /// <summary>
        /// Удаление операции проведения через ТОХ (только для пользователей в роли темпокассы)
        /// </summary>
        /// <param name="id">Ид операции</param>
        /// <returns></returns>
        TellerResponseModel RemoveOper(Int32 id);

        /// <summary>
        /// Сторнирование операции
        /// </summary>
        /// <param name="docRef"></param>
        /// <returns></returns>
        TellerResponseModel Storno(Decimal docRef);

        /// <summary>
        /// Получение статуса при деактивации теллера
        /// </summary>
        /// <returns></returns>
        TellerResponseModel CheckTellerStatus();

        /// <summary>
        /// Получение банковской даты
        /// </summary>
        /// <returns></returns>
        String GetBankDate();

        /// <summary>
        /// Получение значения для отображения кнопки "внести" на форме инкасации
        /// 1 - показывать
        /// 0 - скрыть
        /// </summary>
        /// <returns></returns>
        Int32 GetToxFlag();   
    }
}