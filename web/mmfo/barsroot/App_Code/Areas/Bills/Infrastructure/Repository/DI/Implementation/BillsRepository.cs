using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Linq;
using System.Web;
using Bars.Oracle;
using BarsWeb.Areas.Bills.Model;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using Dapper;
using Kendo.Mvc.Extensions;
using Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// Репозиторий для получения, изменения, удаления, добавления данных!
    /// </summary>
    public class BillsRepository: IBillsRepository
    {
        private EntitiesBars _entities; // Сущность для обработки запросов к БД
        private IOraConnection connect; // Переменная хранящая данные для соединения к БД
        private static Dictionary<String, BillsLongConnectionModel> longConnectionModel;
        private IKendoBillsSqlTransformer _sqlTransformer;
        private IKendoBillsSqlCounter _kendoSqlCounter;

        public BillsRepository(IAppModel model, IKendoBillsSqlTransformer sqlTransformer, IKendoBillsSqlCounter kendoSqlCounter)
        {
            this._kendoSqlCounter = kendoSqlCounter;
            this._sqlTransformer = sqlTransformer;
            _entities = model.Entities;
            connect = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
        }

        /// <summary>
        /// Общий метод для выполнения операций с БД
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        private OracleParameterCollection ExecuteOracleRequest(String sql, List<OracleParameter> parameters)
        {
            using (OracleConnection con = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = sql;
                    cmd.BindByName = true;
                    cmd.Parameters.AddRange(parameters.ToArray());
                    cmd.ExecuteNonQuery();
                    return cmd.Parameters;
                }
            }
        }

        /// <summary>
        /// Общий метод для получения текстового ответа от БД
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        private String ExecuteAndGetString(String sql, List<OracleParameter> parameters)
        {
            try
            {
                OracleParameterCollection collection = ExecuteOracleRequest(sql, parameters);
                OracleString oracleString = (OracleString)collection["p_err_text"].Value;
                return oracleString.IsNull? "" : oracleString.Value;
            }
            catch (Exception e)
            {
                return e.Message;
                //return "Виникла помилка при виконанні!";
            }
        }

        /// <summary>
        /// Получение документа по его ИД в виде массива байт
        /// </summary>
        /// <param name="docId"></param>
        /// <returns></returns>
        public Byte[] GetPrintDoc(Int32 docId)
        {
            String sql = "bills.bill_api.GetPrintDoc";
            List<OracleParameter> parameters = new List<OracleParameter> {
                new OracleParameter("p_doc_id", OracleDbType.Int32, docId, ParameterDirection.Input),
                new OracleParameter("result", OracleDbType.Clob, ParameterDirection.ReturnValue)
            };
            Byte[] bytes;
            using (OracleConnection con = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = sql;
                    cmd.BindByName = true;
                    cmd.Parameters.AddRange(parameters.ToArray());
                    cmd.ExecuteNonQuery();
                    using (OracleClob oracleClob = (OracleClob)cmd.Parameters["result"].Value)
                        bytes = oracleClob.IsNull || oracleClob.Value.StartsWith("Не знайдено запит") ? new Byte[0] : Convert.FromBase64String(oracleClob.Value);
                }
            }
            return bytes;
        }
        
        /// <summary>
        /// Обработка запросов для Kendo grid с передаваемыми параметрами
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="request">Объект Kendo для фильтрации</param>
        /// <param name="sql">Объект хранящий строку запроса и передаваемые параметры</param>
        /// <returns></returns>
        public Kendo.Mvc.UI.DataSourceResult GetKendoData<T>(Kendo.Mvc.UI.DataSourceRequest request, BillsSql sql)
        {
            return _entities.ExecuteStoreQuery<T>(sql.SqlText, sql.Parameters.ToArray()).ToList().ToDataSourceResult(request);
        }

        /// <summary>
        /// Обработка запросов для Kendo grid с передаваемыми параметрами (для больших объемов данных)
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="request">Объект Kendo для фильтрации</param>
        /// <param name="sql">Объект хранящий строку запроса и передаваемые параметры</param>
        /// <returns></returns>
        public List<T> GetTransformedKendoData<T>(Kendo.Mvc.UI.DataSourceRequest request, BillsSql sql)
        {
            BillsSql transformedSql = _sqlTransformer.TransformSql(sql, request);
            return _entities.ExecuteStoreQuery<T>(transformedSql.SqlText, transformedSql.Parameters.ToArray()).ToList();
        }

        /// <summary>
        /// Обработка запросов для Kendo grid без передаваемых параметров
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="request">Объект Kendo для фильтрации</param>
        /// <param name="sql">Строка запроса</param>
        /// <returns></returns>
        public Kendo.Mvc.UI.DataSourceResult GetKendoData<T>(Kendo.Mvc.UI.DataSourceRequest request, String sql)
        {
            return _entities.ExecuteStoreQuery<T>(sql).ToList().ToDataSourceResult(request);
        }        

        /// <summary>
        /// Обработка запроса с возвращаемой строкой как результат обработки
        /// </summary>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        public String ExecuteRequestAndGetTextResponse(BillsSql sql)
        {
            try
            {
                OracleParameterCollection collection = ExecuteOracleRequest(sql.SqlText, sql.Parameters);
                OracleString oracleString = (OracleString)collection["p_err_text"].Value;
                return oracleString.IsNull ? "" : oracleString.Value;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        /// <summary>
        /// Получение первого елемента по результату поика
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        public T GetElement<T>(BillsSql sql)
        {
            return _entities.ExecuteStoreQuery<T>(sql.SqlText, sql.Parameters.ToArray()).FirstOrDefault();
        }

        /// <summary>
        /// Получение елементов по результату поиска с параметрами
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        public List<T> GetElements<T>(BillsSql sql)
        {
            return _entities.ExecuteStoreQuery<T>(sql.SqlText, sql.Parameters.ToArray()).ToList();
        }

        /// <summary>
        /// Получение елементов по результату поиска по строке поиска
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Строка поиска</param>
        /// <returns></returns>
        public List<T> GetElements<T>(String sql)
        {
            return _entities.ExecuteStoreQuery<T>(sql).ToList();
        }

        /// <summary>
        /// Получение количексва елементов по результату поиска
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <returns></returns>
        public Int32 GetCount<T>(BillsSql sql)
        {
            return _entities.ExecuteStoreQuery<T>(sql.SqlText, sql.Parameters.ToArray()).AsQueryable().Count();
        }

        /// <summary>
        /// получение елементов и отбор среди них необходимых с помощью предиката
        /// </summary>
        /// <typeparam name="T">Шаблонный тип</typeparam>
        /// <param name="sql">Объект с даннми для запроса</param>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public List<T> GetElements<T>(String sql, Func<T, Boolean> predicate)
        {
            return _entities.ExecuteStoreQuery<T>(sql).Where(predicate).ToList();
        }

        /// <summary>
        /// Обработка запроса с открытым соединением
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="toClose"></param>
        /// <returns></returns>
        public OracleParameterCollection ExecuteProcedureAndKeepOpen(BillsSql sql, Boolean toClose, String userName)
        {
            if (String.IsNullOrEmpty(userName))
                throw new Exception("Not Authorized");
            OracleParameterCollection parameterCollection = null;
            if (longConnectionModel == null)
                longConnectionModel = new Dictionary<string, BillsLongConnectionModel>();
            if (!longConnectionModel.ContainsKey(userName))
                longConnectionModel.Add(userName, new BillsLongConnectionModel());
            if (longConnectionModel[userName].connection == null)
                longConnectionModel[userName].OpenConnection(connect, true);

            longConnectionModel[userName].command.CommandText = sql.SqlText;
            longConnectionModel[userName].command.Parameters.Clear();
            longConnectionModel[userName].command.Parameters.AddRange(sql.Parameters.ToArray());
            try
            {
                longConnectionModel[userName].command.ExecuteNonQuery();
                parameterCollection = longConnectionModel[userName].command.Parameters;
            }
            catch (Exception e)
            {
                longConnectionModel[userName].RollbackTransaction();
                longConnectionModel[userName].Dispose();
                return null;
            }
            if (toClose)
            {
                longConnectionModel[userName].transaction.Commit();
                longConnectionModel[userName].CloseConnection();
                longConnectionModel.Remove(userName);
            }
            return parameterCollection;
        }

        /// <summary>
        /// Откат транзакции (в случае ошибки)
        /// </summary>
        /// <param name="userName"></param>
        public void RollbackTransaction(String userName)
        {
            if(longConnectionModel != null && longConnectionModel.ContainsKey(userName) && longConnectionModel[userName].connection != null)
            {
                longConnectionModel[userName].RollbackTransaction();
                //longConnectionModel[userName].Dispose();
                longConnectionModel.Remove(userName);
            }
        }

        /// <summary>
        /// Получение статуса для подписи
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public int GetStatusToSign(BillsSql sql)
        {
            try
            {
                OracleParameterCollection collection = ExecuteOracleRequest(sql.SqlText, sql.Parameters);
                OracleDecimal oraDecimal = (OracleDecimal)collection["p_result"].Value;
                return oraDecimal.IsNull ? 0 : Convert.ToInt32(oraDecimal.Value);
            }
            catch(Exception e)
            {
                return 1;
            }
        }

        /// <summary>
        /// Проведение проводки
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public String Entry(BillsSql sql)
        {
            return ExecuteAndGetString(sql.SqlText, sql.Parameters);
        }

        /// <summary>
        /// Загрузка файла "Расчета суммы реструтуризированной задолжности" из ДКСУ и получение его ИД
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public AmountOfRestructuredDeptDowloadResult DownloadAmountOfRestructuredDept(BillsSql sql)
        {
            OracleParameterCollection collection = ExecuteOracleRequest(sql.SqlText, sql.Parameters);
            OracleString textResult = (OracleString)collection["p_err_text"].Value;
            OracleDecimal oracleDecimal = (OracleDecimal)collection["p_request_id"].Value;
            return new AmountOfRestructuredDeptDowloadResult
            {
                ID = oracleDecimal.IsNull ? 0 : oracleDecimal.ToInt32(),
                TextResult = textResult.IsNull ? "" : textResult.Value
            };
        }

        /// <summary>
        /// Получение текущего МФО
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public String GetCurrentUserMfo(String sql)
        {
            using (OracleConnection con = connect.GetUserConnection(HttpContext.Current))
            {
                try
                {
                    return con.Query<Int32>(sql).FirstOrDefault().ToString();
                }
                catch
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// Обработка процедуры и возвращение параметра (output) типа int по его имени
        /// </summary>
        /// <param name="sql">строка запроса и передаваемые параметры</param>
        /// <param name="paramName">имя возвращаемого параметра</param>
        /// <returns></returns>
        public Int32 ExecuteAndGetInputOutputId(BillsSql sql, String paramName)
        {
            OracleParameterCollection collection = ExecuteOracleRequest(sql.SqlText, sql.Parameters);
            OracleDecimal oraData = (OracleDecimal)collection[paramName].Value;
            if(oraData.IsNull)
                return 0;
            return Convert.ToInt32(oraData.Value);
        }

        /// <summary>
        /// Выполнение процедуры без возвращаемых параметров
        /// </summary>
        /// <param name="sql">строка запроса и передаваемые параметры</param>
        public void ExecuteProcedure(BillsSql sql)
        {
            ExecuteOracleRequest(sql.SqlText, sql.Parameters);
        }
    }
}