using System;
using System.IO;
using System.Net;
using System.Text;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Areas.Cash.ViewModels;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Определяет логику обработки одного МФО
    /// </summary>
    public abstract class SynchronizerBase
    {
        /// <summary>
        /// Если задано, то для SQL-команд используется данный Connection (использовать при вызове не в главном потоке)
        /// </summary>
        public OracleConnection Connection { get; set; }

        protected SynchronizerBase(IAccountRepository accountRepository, ISyncRepository syncRepository)
        {
            AccountRepository = accountRepository;
            SyncRepository = syncRepository;
        }

        protected readonly IAccountRepository AccountRepository;
        protected readonly ISyncRepository SyncRepository;

        protected virtual void AfterSync(ConnectionOption connectionOption) { }

        public SyncResult Sync(ConnectionOption connectionOption, LogBinder logBinder)
        {
            if (Connection != null)
            {
                SyncRepository.Connection = Connection;
                AccountRepository.Connection = Connection;
            }

            var syncResultBeforeSync = new SyncResult
            {
                Mfo = connectionOption.Mfo,
                URL = CombineUrl(connectionOption.Url, BasicActionMethod),
                DateStart = DateTime.Now,
                TransferType = TransferType,
                ParentId = logBinder.ParentId,
                RowLevel = logBinder.Level
            };

            SyncResult syncResult = null;

            bool syncProcessStarted = false;
            bool hasException = false;
            string exceptionMessage = string.Empty;
            try
            {
                // установим признак того, что процесс по данной настройке стартовал успешно 
                syncProcessStarted = SyncRepository.MarkConnectionOptionAsInProcess(connectionOption.Mfo);
                if (syncProcessStarted)
                {
                    syncResultBeforeSync.Status = SyncStatus.InProcess;

                    logBinder.Id = SyncRepository.WriteLog(syncResultBeforeSync, true);
                    syncResult = MakeSync(connectionOption, (LogBinder)logBinder.Clone());
                    SyncRepository.WriteLog(syncResult, true);

                    // вызываем шаблонный метод
                    AfterSync(connectionOption);
                    return syncResult;
                }
            }
            catch (Exception ex)
            {
                hasException = true;
                exceptionMessage = ex.ToString();
            }
            finally
            {
                if (hasException || !syncProcessStarted)
                {
                    syncResultBeforeSync.Message = hasException
                        ? exceptionMessage
                        : "Синхронізація по даному МФО вже виконується";
                    syncResultBeforeSync.Status = SyncStatus.Error;
                    syncResultBeforeSync.DateEnd = DateTime.Now;
                    SyncRepository.WriteLog(syncResultBeforeSync, false);

                    syncResult = syncResultBeforeSync;
                }
            }
            return syncResult;
        }

        /// <summary>
        /// Выполнить синхронизацию
        /// </summary>
        /// <param name="connectionOption">Параметры для синхронизации</param>
        /// <param name="logBinder"></param>
        /// <returns>Результат синхронизации</returns>
        /// <exception cref="Exception"></exception>
        protected abstract SyncResult MakeSync(ConnectionOption connectionOption, LogBinder logBinder);

        /// <summary>
        /// Тип синхронізації
        /// </summary>
        protected abstract string TransferType { get; }

        /// <summary>
        /// ActionMethod, который будет добавлен к URL и отображен как URL для выполненния синхронизации
        /// </summary>
        protected abstract string BasicActionMethod { get; }

        /// <summary>
        /// Выполнить http-запрос и получить ответ
        /// </summary>
        /// <param name="url">URL</param>
        /// <param name="login">Логин пользвателя</param>
        /// <param name="password">Хеш пароля</param>
        /// <returns>Ответ в строковом виде</returns>
        /// <exception cref="Exception"></exception>
        protected string MakeHttpRequest(string url, string login, string password)
        {
            try
            {
                var request = (HttpWebRequest)WebRequest.Create(url);
                var bytes = Encoding.UTF8.GetBytes(login + ":" + password);
                var base64Pass = Convert.ToBase64String(bytes);

                request.Headers[HttpRequestHeader.Authorization] = "HASHPASSWORD " + base64Pass;
                //request.Headers["UserName"] = login;
                //request.Headers["Password"] = password;
                var response = (HttpWebResponse)request.GetResponse();
                Stream resStream = response.GetResponseStream();

                using (var reader = new StreamReader(resStream))
                {
                    string responseText = reader.ReadToEnd();
                    return responseText;
                }
            }
            catch (Exception ex)
            {
                // Добавим к исключению URL
                string message = string.Format("Exception occured during making http request to '{0}'. See inner exception.", url);
                var myException = new Exception(message, ex);
                throw myException;
            }
        }

        protected static string CombineUrl(string part1, string part2)
        {
            // Формируем полный URL, пример:
            //   url - 'localhost/barsroot'
            //   ActionMethod - '/api/cash/load/accounts'
            // => 'localhost/barsroot/api/cash/load/accounts'
            return part1.TrimEnd('/') + "/" + part2.TrimStart('/');
        }
    }
}