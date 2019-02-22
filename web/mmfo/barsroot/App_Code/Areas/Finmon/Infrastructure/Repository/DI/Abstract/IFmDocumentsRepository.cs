using Areas.Finmom.Models;
using System.Collections.Generic;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract
{
    public interface IFmDocumentsRepository
    {
        /// <summary>
        /// Отримати документи
        /// </summary>
        KendoGridDs<Document> GetDocuments(DataSourceRequest request, DocsGridFilter filter);
        /// <summary>
        /// Кількість документів за встановленими фільтрами
        /// </summary>
        int GetDocumentsCount(DocsGridFilter filter);
        /// <summary>
        /// Довідник правил фінансового моніторингу
        /// </summary>
        KendoGridDs<Filter<decimal>> GetRules(DataSourceRequest request);
        /// <summary>
        /// Встановити фільтр по правилам фм
        /// </summary>
        void SetRules(DocsGridFilter model);
        /// <summary>
        /// Довідник статусів документів
        /// </summary>
        KendoGridDs<Filter<string>> GetDocumentStatuses(DataSourceRequest request);
        /// <summary>
        /// Довідник "терористів" по документу
        /// </summary>
        KendoGridDs<FmTerrorist> GetTerroristsList(DataSourceRequest request, int otm);
        /// <summary>
        ///  Отримання попередньої банківської дати
        /// </summary>
        string GetPreviousBankDate();
        /// <summary>
        /// Встановлення документам статусу "Відправлено"
        /// </summary>
        int SendDocuments(List<Document> documents);
        /// <summary>
        /// Встановлення пачці документів статусу "Відправлено"
        /// </summary>
        /// <param name="documents"></param>
        void SendDocumentsBulk(List<Document> documents);
        /// <summary>
        /// Встановлення документам статусу "Повідомлено"
        /// </summary>
        void StatusReported(List<Document> documents, string comment);
        /// <summary>
        /// Встановлення документам статусу "Вилучено"
        /// </summary>
        void Exclude(List<Document> documents);
        /// <summary>
        /// Встановлення документам статусу "Відкладено"
        /// </summary>
        void SetASide(List<Document> documents);
        /// <summary>
        /// Розблокувати документи
        /// </summary>
        int Unblock(List<Document> documents);
        /// <summary>
        /// Вивантаження даних в ексель по встановленим фільтрам
        /// </summary>
        byte[] ExportToExcel(DocsGridFilter filter);
        /// <summary>
        /// Отримати параметри фінансового моніторингу по документу
        /// </summary>
        DocumentFmRules GetDocumentFmRules(decimal _ref);
        /// <summary>
        /// Отримати параметри фінансового моніторингу по документам
        /// </summary>
        DocumentFmRules GetDocumentsFmRules(List<decimal> _refs);
        /// <summary>
        /// Отримання даних з довідників типу k_dfm*
        /// <para> якщо передати параметр code, буде фільтрація по ньому, в іншому випадку вибірка усіх даних</para>
        /// </summary>
        KendoGridDs<DictRow> GetDict(DataSourceRequest request, string dictName, string code);
        /// <summary>
        /// Довідник клієнтів
        /// </summary>
        KendoGridDs<ClientData> GetClientsDict(DataSourceRequest request, long? rnk, string okpo, string name);
        /// <summary>
        /// Історія змін по документу
        /// </summary>
        KendoGridDs<HistoryRow> GetHistory(DataSourceRequest request, string id);
        /// <summary>
        /// Збереження правил фінансового моніторингу для документу
        /// </summary>
        void SaveDocumentFmRules(FmRulesSaveModel model);
        /// <summary>
        /// Збереження правил фінансового моніторингу для документів
        /// </summary>
        void SaveDocumentsFmRules(FmRulesSaveModel model);
        /// <summary>
        /// Метод перевірки існування кодів фінансового моніторингу
        /// <para>Повертає список не існуючих кодів</para>
        /// </summary>
        List<string> CheckDictCodes(List<string> codes, string dictName);
    }
}