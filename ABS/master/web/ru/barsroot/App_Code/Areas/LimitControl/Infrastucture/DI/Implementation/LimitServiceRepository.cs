using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using BarsWeb.Areas.LimitControl.Infrastucture.DI.Abstract;
using LcsServices;
using Oracle.DataAccess.Client;
using ConformationResponse = BarsWeb.Areas.LimitControl.ViewModels.ConformationResponse;
using LimitSearchInfo = BarsWeb.Areas.LimitControl.ViewModels.LimitSearchInfo;
using Transfer = BarsWeb.Areas.LimitControl.ViewModels.Transfer;
using TransferSearchInfo = BarsWeb.Areas.LimitControl.ViewModels.TransferSearchInfo;

namespace BarsWeb.Areas.LimitControl.Infrastucture.DI.Implementation
{
    /// <summary>
    /// Контроль лимитов (доступ к БД через сервис)
    /// </summary>
    public class LimitServiceRepository : ILimitRepository
    {
        public LimitServiceRepository()
        {
            var serviceUrl = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Url"];
            var header = new LcsServices.WsHeader();
            _service = new LcsServices.LcsService
            {
                WsHeaderValue = header,
                Url = serviceUrl
            };
        }
        private readonly LcsServices.LcsService _service;

        /// <summary>
        /// Получить статус лимита по документу
        /// </summary>
        /// <param name="searchInfo">Информация для поиска лимита</param>
        /// <returns>Текстовое сообщение о статусе лимита</returns>
        /// <exception cref="Exception"></exception>
        public LcsServices.LimitStatus GetLimitStatus(LimitSearchInfo searchInfo)
        {
            var limitStatus = _service.GetLimitStatus(new LcsServices.LimitSearchInfo
            {
                Number = searchInfo.Number,
                Series = searchInfo.Series,
            });

            BindEquivalentList(limitStatus.OperationCollection);

            return limitStatus;
        }

        private void BindEquivalentList(OperationCollection collection)
        {
            if (collection != null && collection.Operations != null)
            {
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = @"select
                                        T.KV as currency, 
                                        --gl.p_ncurval(T.KV, :p_sum, gl.bd ) as sum
                                        gl.p_ncurval(T.KV, :p_sum, gl.bd )/100 as sum
                                    from 
                                        tabval t 
                                    where 
                                        t.d_close is null
                                        and exists (
                                            select 
                                                1 
                                            from 
                                                cur_rates cr 
                                            where 
                                                cr.kv = t.kv 
                                                and cr.vdate=gl.bd)";
                try
                {
                    foreach (var item in collection.Operations)
                    {
                        item.EquivalentList = GetEquivalentList(cmd,item.Sum * 100);
                    }
                }
                finally
                {
                    if (cmd.Connection.State == ConnectionState.Open)
                        cmd.Connection.Close();
                    cmd.Dispose();
                    if (con.State == ConnectionState.Open)
                        con.Close();
                    con.Dispose();
                }

            }
            return;
        }

        private List<Equivalent> GetEquivalentList(OracleCommand cmd, decimal? sum)
        {
            var result = new List<Equivalent>();
            if (sum != null)
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_sum", OracleDbType.Decimal, sum, ParameterDirection.Input);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    result.Add(new Equivalent
                    {
                        Сurrency = Convert.ToInt32(reader["currency"]),
                        Sum = reader["sum"] == null ? (decimal?)null : Convert.ToDecimal(reader["sum"])
                    });
                }
            }
            return result;
        }

        /// <summary>
        /// Получить список переводов
        /// </summary>
        /// <param name="searchInfo">Информация для поиска переводов</param>
        /// <returns>Текстовое сообщение о статусе лимита</returns>
        /// <exception cref="Exception"></exception>
        public List<Transfer> GetTransfers(TransferSearchInfo searchInfo)
        {
            var serviceSearchInfo = new LcsServices.TransferSearchInfo()
            {
                Number = searchInfo.Number,
                Series = searchInfo.Series
            };
            LcsServices.Transfer[] sTransfers = _service.GetTransfers(serviceSearchInfo);
            return sTransfers.Select(s => new Transfer
            {
                Number = s.Number,
                Selected = s.Selected,
                Editable = s.Editable,
                Series = s.Series,
                System = s.System,
                Id = s.Id,
                Name = s.Name,
                Sum = s.Sum,
                BirthDate = s.BirthDate
            }).ToList();
        }

        /// <summary>
        /// Подтвердить список переводов
        /// </summary>
        /// <param name="transfers">Список идентификаторов переводов</param>
        /// <param name="searchInfo">Информация, которую пользователь указал при поиске</param>
        /// <param name="userName">Пользователь, который авторизирован в web-е</param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public ConformationResponse ConfirmTransfers(TransferSearchInfo searchInfo, List<string> transfers, string userName)
        {
            var serviceSearchInfo = new LcsServices.TransferSearchInfo
            {
                Number = searchInfo.Number,
                Series = searchInfo.Series
            };
            LcsServices.ConformationResponse sResponse = _service.ConfirmTransfers(serviceSearchInfo, transfers.ToArray(), userName);
            return new ConformationResponse
            {
                ErrorMessage = sResponse.ErrorMessage,
                Message = sResponse.Message,
                Success = sResponse.Success
            };
        }
    }
}