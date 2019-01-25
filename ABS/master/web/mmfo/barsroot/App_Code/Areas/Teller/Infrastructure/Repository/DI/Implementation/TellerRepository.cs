using Bars.Oracle;
using BarsWeb.Areas.Teller.Enums;
using BarsWeb.Areas.Teller.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Teller.Model;
using BarsWeb.Areas.Teller.Patterns.TellerWindowStatus;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Infrastructure.Repository.DI.Implementation;
using Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Infrastructure.DI.Implementation
{
    public class TellerRepository : ITellerRepository
    {
        private EntitiesBars _entities;
        private IOraConnection connect;   
        public TellerRepository(IAppModel model)
        {
            _entities = model.Entities;
            connect = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
        }

        /// <summary>
        /// Активация, деактивация Теллера
        /// </summary>
        /// <param name="isTeller"></param>
        public void SetTeller(bool isTeller)
        {
            string command = @"begin
                                     bars.teller_tools.set_teller(:p_switch);
                                end;";
            Object[] parameters = {
                        new OracleParameter("p_switch", OracleDbType.Int32) { Value = Convert.ToInt32(isTeller) }
                    };
            _entities.ExecuteStoreCommand(command, parameters);
        }

        /// <summary>
        /// Проверка суммы
        /// </summary>
        /// <param name="sum"></param>
        /// <returns></returns>
        public int CheckSmall(decimal sum)
        {
            using (var connection = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand cmd = new OracleCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "bars.teller_tools.is_coins_need";

                    OracleParameter returnValue = new OracleParameter("result", OracleDbType.Decimal, ParameterDirection.ReturnValue);
                    cmd.Parameters.Add(returnValue);
                    OracleParameter amount = new OracleParameter("p_amount", OracleDbType.Decimal, sum, ParameterDirection.Input);
                    cmd.Parameters.Add(amount);
                    using (OracleDataReader rdr = cmd.ExecuteReader())
                    {
                        OracleDecimal returnResult = (OracleDecimal)returnValue.Value;
                        return (int)returnResult.Value;
                    }
                }
            }
        }

        /// <summary>
        /// возврат объекта клиента для метода ExecuteGetStatus
        /// </summary>
        /// <param name="methodName"></param>
        /// <returns></returns>
        private TellerClient<ATMModel, TellerWindowStatusModel> GetClient(String methodName)
        {
            AbstractFactory<ATMModel, TellerWindowStatusModel> factory = null;
            switch (methodName)
            {
                case "getwindowstatus":
                    factory = new GetWindowStatusFactory();
                    break;
                case "cancelatmwindowoperation":
                    factory = new CancelOperationFactory();
                    break;
                case "makerequest":
                    factory = new MakeRequestFactory();
                    break;
                case "endrequest":
                    factory = new EndRequestFactory();
                    break;
                case "confirmrequest":
                    factory = new ConfirmRequestFactory();
                    break;
            }

            return new TellerClient<ATMModel, TellerWindowStatusModel>(factory);
        }

        /// <summary>
        /// выполнение запросов связанных с получением статуса окна или с его изменением
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public TellerWindowStatusModel ExecuteGetStatus(ATMModel data)
        {
            TellerWindowStatusModel model = new TellerWindowStatusModel();            
            TellerClient<ATMModel, TellerWindowStatusModel> client = GetClient(data.Method.ToLower());

            using (OracleConnection connection = connect.GetUserConnection(HttpContext.Current))
            {
                using(OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.BindByName = true;
                    model = client.Run(data, command);
                }
            }
            model.Ref = data.Ref;
            return model;
        }

        /// <summary>
        /// выполнение отправки сообщений TechnicalButtonSubmit, CheckVisaDocs, CheckStornoDocs
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public TellerResponseModel DocsAndTechnical(TellerRequestModel data)
        {
            TellerResponseModel model = new TellerResponseModel();
            TellerClient<TellerRequestModel, TellerResponseModel> client = 
                        new TellerClient<TellerRequestModel, TellerResponseModel>(new DocsAndTechnicalFactory());

            using (OracleConnection connection = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.BindByName = true;
                    return client.Run(data, command);
                }
            }
        }

        /// <summary>
        /// обработка запросов и возврат массива параметров
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        private OracleParameterCollection OracleRequest(String sql, Object[] parameters)
        {
            using (OracleConnection con = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = sql;
                    cmd.Parameters.Clear();
                    cmd.BindByName = true;
                    cmd.Parameters.AddRange(parameters);

                    using (var reader = cmd.ExecuteReader())
                        return cmd.Parameters;
                }
            }
        }

        /// <summary>
        /// получение списка технических кнопок и sql строк запросов
        /// </summary>
        /// <returns></returns>
        public List<ATMTechnicalButtonsModel> GetTechnicalButtons()
        {
            var list = new AppModel().Entities.ExecuteStoreQuery<ATMTechnicalButtonsModel>("Select * from V_TELLER_ADD_FUNC").ToList();
            if (list == null)
                list = new List<ATMTechnicalButtonsModel>();
            return list;
        }

        /// <summary>
        /// Получение состояния Теллера
        /// </summary>
        /// <returns></returns>
        public TellerStatus GetTellerStatus()
        {
            TellerStatus tellerStatus = new TellerStatus();
            String sql = @"begin
                            :tellerInfo := bars.teller_tools.get_teller_info(); 
                            :tellerStatus := bars.teller_tools.get_equipment_info();
                            :IsButtonVisible := bars.teller_tools.is_button_visible();
                           end;";
            using (OracleConnection con = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = sql;
                    var infoP = new OracleParameter(    "tellerInfo",       OracleDbType.Varchar2, 4000, null,  ParameterDirection.Output);
                    cmd.Parameters.Add(infoP);
                    var statusP = new OracleParameter(  "tellerStatus",     OracleDbType.Varchar2, 4000, null,  ParameterDirection.Output);
                    cmd.Parameters.Add(statusP);
                    var isVisible = new OracleParameter("IsButtonVisible",  OracleDbType.Int32,                 ParameterDirection.Output);
                    cmd.Parameters.Add(isVisible);
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        OracleString info = (OracleString)infoP.Value;
                        tellerStatus.TellerInfo = Convert.ToString(info.Value);

                        OracleString status = (OracleString)statusP.Value;
                        tellerStatus.tellerStatus = Convert.ToString(status.Value);

                        OracleDecimal buttonVisible = (OracleDecimal)isVisible.Value;
                        tellerStatus.IsButtonVisible = Convert.ToInt32(buttonVisible.Value);
                    }
                }
            }
            return tellerStatus;
        }

        /// <summary>
        /// Получение статаса для отображения или скрытия кнопки теллера (пока зреализовано в Documents.aspx, Docinput.aspx)
        /// </summary>
        /// <returns></returns>
        public Int32 IsButtonVisible()
        {
            String sql = @"begin :IsButtonVisible := bars.teller_tools.is_button_visible(); end;";
            using (OracleConnection con = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = sql;
                    var isVisible = new OracleParameter("IsButtonVisible", OracleDbType.Int32, ParameterDirection.Output);
                    cmd.Parameters.Add(isVisible);
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        OracleDecimal buttonVisible = (OracleDecimal)isVisible.Value;
                        return Convert.ToInt32(buttonVisible.Value);
                    }
                }
            }
        }

        public TellerResponseModel ChangeRequest(TellerWindowStatusModel data)
        {
            TellerResponseModel model = new TellerResponseModel();
            Object[] parameters = {
                new OracleParameter("result",OracleDbType.Int32, ParameterDirection.ReturnValue),
                new OracleParameter("p_docref", OracleDbType.Varchar2, data.Ref, ParameterDirection.Input),
                new OracleParameter("p_curcode",OracleDbType.Varchar2, data.Currency, ParameterDirection.Input),
                new OracleParameter("p_amount", OracleDbType.Decimal, data.Amount, ParameterDirection.Input),
                new OracleParameter("p_errtxt", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output)
            };
            String sql = "bars.teller_tools.change_request";
            OracleParameterCollection paramCollection = OracleRequest(sql, parameters);

            OracleDecimal returnResult = (OracleDecimal)paramCollection["result"].Value;
            model.Result = (int)(returnResult.IsNull? 0: returnResult.Value);

            OracleString oracleText = (OracleString)paramCollection["p_errtxt"].Value;
            model.P_errtxt = oracleText.IsNull ? String.Empty : oracleText.Value;
            
            return model;
        }

        /// <summary>
        /// Запросы инкассации
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public TellerResponseModel Encashment(EncashmentModel data)
        {
            TellerClient<EncashmentModel, TellerResponseModel> client =
                    new TellerClient<EncashmentModel, TellerResponseModel>(new EncashmentFactory());

            using (OracleConnection connection = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.BindByName = true;
                    return client.Run(data, command);
                }
            }
        }

        /// <summary>
        /// получение списка валют
        /// </summary>
        /// <returns></returns>
        public IEnumerable<TellerCurrency> GetCurrencyList()
        {
            String sql = "select LCV, NAME from v_teller_currencies";
            return _entities.ExecuteStoreQuery<TellerCurrency>(sql).ToList();
        }

        /// <summary>
        /// получение номиналов и их количества определенной валюты
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public IEnumerable<ATMCurrencyListModel> GetAtmCurrencyList(String code)
        {
            String sql = "select CUR_CODE, NOMINAL, REV, COUNT from v_teller_atm_status where cur_code = :cur_code";
            Object[] parameters = {
                new OracleParameter("cur_code", OracleDbType.Varchar2, code, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<ATMCurrencyListModel>(sql, parameters).ToList();
        }

        /// <summary>
        /// передача списка номиналов и их количества для дальнейшего проведения операции инкассирования
        /// </summary>
        /// <param name="xml"></param>
        /// <param name="currency"></param>
        /// <returns></returns>
        public TellerResponseModel CollectPartial(String xml, String currency)
        {
            TellerResponseModel model = new TellerResponseModel();
            String sql = "bars.teller_soap_api.CollectATM";
            Object[] parameters = {
                new OracleParameter("p_currency", OracleDbType.Varchar2, currency, ParameterDirection.Input),
                new OracleParameter("p_nominal", OracleDbType.Clob, xml, ParameterDirection.Input),
                new OracleParameter("p_errtxt", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue)
            };

            var paramCollection = OracleRequest(sql, parameters);
            OracleDecimal returnResult = (OracleDecimal)paramCollection["result"].Value;
            model.Result = (int)(returnResult.IsNull? 0: returnResult.Value);

            OracleString oracleText = (OracleString)paramCollection["p_errtxt"].Value;
            model.P_errtxt = oracleText.IsNull ? String.Empty : oracleText.Value;
            
            return model;
        }

        /// <summary>
        /// получения статуса АТМ для отображения уведомления об необходимости забрать сдачу из АТМ
        /// </summary>
        /// <returns></returns>
        public TellerStatusModel TellerStatus(Boolean http)
        {
            GSRService gsr = new GSRService();
            String deviceUrl = GetDeviceUrl();
            gsr.Url = deviceUrl + "/axis2/services/GSRService";
            StatusRequestType srt = new StatusRequestType
            {
                Id          = "1",
                SeqNo       = "123",
                SessionID   = GetSession(),
                Option      = new StatusOptionType { type = "0" }
            };
            var res = gsr.GetStatus(srt);
            return ConvertStatusCode(res.Status.Code);           
        }

        /// <summary>
        /// получение текстовой строки уведомления из числового кода статуса возвращаемого (Glory)
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        private TellerStatusModel ConvertStatusCode(String code)
        {
            TellerStatusModel status = new TellerStatusModel();
            switch (code)
            {
                case "6":
                    status.Message = "Заберіть гроші";
                    status.TellerStatusCode = TellerStatusCode.PickUpStored;
                    break;
                case "7":
                    status.Message = "Заберіть гроші";
                    status.TellerStatusCode = TellerStatusCode.PickUpCash;
                    break;
                default:
                    status.Message = code;
                    status.TellerStatusCode = TellerStatusCode.Buisy;
                    break;
            }
            return status;
        }

        /// <summary>
        /// Получение ИД сессии
        /// </summary>
        /// <returns></returns>
        private String GetSession()
        {
            String sql = "bars.teller_soap_api.get_user_sessionID";
            return GetStringReturnValue(sql);
        }

        /// <summary>
        /// получение IP адреса АТМ
        /// </summary>
        /// <returns></returns>
        private String GetDeviceUrl()
        {
            String sql = "bars.teller_utils.get_device_full_url";
            return GetStringReturnValue(sql);
        }

        /// <summary>
        /// получение строковых возвращаемых данных.
        /// </summary>
        /// <param name="procedureSql"></param>
        /// <returns></returns>
        private String GetStringReturnValue(String procedureSql)
        {
            using (OracleParameter parameter = new OracleParameter("result", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue))
            {
                Object[] parameters = { parameter };
                OracleParameterCollection collection = OracleRequest(procedureSql, parameters);
                return ((OracleString)parameter.Value).IsNull? "0": ((OracleString)parameter.Value).Value;
            }
        }

        /// <summary>
        /// получение списка необходимых для проведения операций инкассации черех ТОХ
        /// </summary>
        /// <returns></returns>
        public List<TellerEncashmentList> EncashmentList()
        {
            String sql = "select * from v_teller_collection_opers";
            var result = _entities.ExecuteStoreQuery<TellerEncashmentList>(sql)
                                  .Where(x => x.Amount > 0)
                                  .OrderByDescending(x => x.Last_DT)
                                  .OrderBy(x => x.Oper_status)
                                  .ToList();
            return result == null ? new List<TellerEncashmentList>() : result;
        }

        /// <summary>
        /// подтверждение проведения операции черех ТОХ
        /// </summary>
        /// <param name="docRef"></param>
        /// <returns></returns>
        public Int32 ConfirmTox(ConfirmTox tox)
        {
            String sql = @"begin 
                            bars.teller_tools.confirm_tox(:p_oper_ref, :p_doc_ref); 
                           end;";
            Object[] parameters = {
                new OracleParameter("p_oper_ref", OracleDbType.Decimal, tox.OperRef, ParameterDirection.Input),
                new OracleParameter("p_doc_ref",  OracleDbType.Decimal, tox.DocRef,  ParameterDirection.Input)
            };
            return _entities.ExecuteStoreCommand(sql, parameters);
        }

        /// <summary>
        /// Получение типа роли Теллера:
        ///     Темпокасса
        ///     Теллер
        ///     Без роли
        /// </summary>
        /// <returns></returns>
        public TellerCurrentRole GetRole()
        {
            String sql = "bars.teller_utils.get_equip_type";
            TellerCurrentRole role = TellerCurrentRole.None;
            String result = GetStringReturnValue(sql);
            switch (result)
            {
                case "M":
                    role = TellerCurrentRole.Tempockassa;
                    break;
                case "A":
                    role = TellerCurrentRole.Teller;
                    break;
            }
            return role;
        }

        /// <summary>
        /// Получение наличия денег в темпокассе
        /// </summary>
        /// <returns></returns>
        public String GetEncashmentNonAmount(String cur_code)
        {
            Int32 res = cur_code == "980" ? 980 : 0;
            if (res != 980)
                res = Convert.ToInt32(GetCurrencyCode(cur_code));
            String sql = "bars.teller_utils.get_cur_nonatm_amount";
            OracleParameter[] parameters = {
                new OracleParameter("result", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue),
                new OracleParameter("p_curcode", OracleDbType.Varchar2, res, ParameterDirection.Input)
            };
            OracleParameterCollection collection = OracleRequest(sql, parameters);
            OracleString oracleString = (OracleString)collection["result"].Value;
            return oracleString.Value;
        }

        /// <summary>
        /// Получение кода валюты по значению
        /// </summary>
        /// <param name="currency"></param>
        /// <returns></returns>
        public String GetCurrencyCode(String currency)
        {
            if (currency == "980")
                return currency;
            String currSql = "bars.teller_utils.get_r030";
            OracleParameter[] param =
            {
                new OracleParameter("p_cur_code", OracleDbType.Varchar2, currency, ParameterDirection.Input),
                new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue)
            };
            OracleParameterCollection collect = OracleRequest(currSql, param);
            OracleDecimal oracleDecimal = (OracleDecimal)collect["result"].Value;
            return oracleDecimal.IsNull ? "0" : Convert.ToInt32(oracleDecimal.Value).ToString();
        }

        /// <summary>
        /// Получение списка валют и их количества в темпокассе
        /// используется для полного изъятия
        /// </summary>
        /// <returns></returns>
        public List<NonAtmAmount> nonAtmAmount()
        {
            String sql = "select teller_utils.get_cur_name(cur_code) cur_code, non_atm_amount from V_TELLER_STATE t where user_ref = user_id";
            return _entities.ExecuteStoreQuery<NonAtmAmount>(sql).ToList();
        }

        /// <summary>
        /// Проверка на незавершенные операции (для доступа на проведение инкассации)
        /// </summary>
        /// <param name="operation">
        /// I - незавершённые операции по принятию наличных
        /// O - незавершенные операции по выдаче наличных
        /// </param>
        /// <returns></returns>
        public Boolean IfAllowedEncashment(String operation)
        {
            String sql = "teller_utils.check_open_opers";
            OracleParameter[] parameters =
            {
                new OracleParameter("p_oper_type", OracleDbType.Varchar2, operation, ParameterDirection.Input),
                new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue)
            };
            var parametersResult = OracleRequest(sql, parameters);
            OracleDecimal oracleDecimal = (OracleDecimal)parametersResult["result"].Value;
            if (oracleDecimal.IsNull)
                return false;
            return Convert.ToInt32(oracleDecimal.Value) != 1;
        }

        public void CreateCollectOpper()
        {
            String sql = "teller_tools.create_collect_oper";
            OracleRequest(sql, new OracleParameter[0]);
        }

        /// <summary>
        /// Удаление операции из списка проведения через ТОХ
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public TellerResponseModel RemoveOper(Int32 id)
        {
            TellerResponseModel result = new TellerResponseModel();
            String sql = "teller_tools.delete_TOX";
            OracleParameter[] parameters = new OracleParameter[]
            {
                new OracleParameter("p_id", OracleDbType.Int32, id, ParameterDirection.Input),
                new OracleParameter("p_errtxt", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue)
            };
            OracleParameterCollection collection = OracleRequest(sql, parameters);

            OracleString oraString = (OracleString)collection["p_errtxt"].Value;
            result.P_errtxt = oraString.IsNull ? "" : oraString.Value;
            OracleDecimal oraDecimal = (OracleDecimal)collection["result"].Value;
            result.Result = oraDecimal.IsNull ? 0 : Int32.Parse(oraDecimal.Value.ToString());           
            return result;
        }

        /// <summary>
        /// Сторнирование операции
        /// </summary>
        /// <param name="docRef"></param>
        /// <returns></returns>
        public TellerResponseModel Storno(Decimal docRef)
        {
            TellerResponseModel result = new TellerResponseModel();
            String sql = "teller_tools.reject_doc";

            OracleParameter[] parameters = new OracleParameter[]
            {
                new OracleParameter("p_doc_ref", OracleDbType.Decimal, docRef, ParameterDirection.Input),
                new OracleParameter("p_errtxt", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue)
            };
            OracleParameterCollection collection = OracleRequest(sql, parameters);
            OracleString oraString = (OracleString)collection["p_errtxt"].Value;
            result.P_errtxt = oraString.IsNull ? "" : oraString.Value;
            OracleDecimal oraDecimal = (OracleDecimal)collection["result"].Value;
            result.Result = oraDecimal.IsNull ? 0 : Int32.Parse(oraDecimal.Value.ToString());
            return result;
        }

        /// <summary>
        /// Получение статуса при деактивации теллера
        /// </summary>
        /// 0 - всё плохо
        /// 1 - всё хорошо
        /// <returns></returns>
        public TellerResponseModel CheckTellerStatus()
        {
            TellerResponseModel result = new TellerResponseModel();
            String sql = "teller_tools.check_teller_status";
            OracleParameter[] parameters = new OracleParameter[]
            {
                new OracleParameter("p_errtxt", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue)
            };
            OracleParameterCollection collection = OracleRequest(sql, parameters);

            OracleString oraString = (OracleString)collection["p_errtxt"].Value;
            result.P_errtxt = oraString.IsNull ? "" : oraString.Value;
            OracleDecimal oraDecimal = (OracleDecimal)collection["result"].Value;
            result.Result = oraDecimal.IsNull ? 0 : Int32.Parse(oraDecimal.Value.ToString());
            return result;
        }

        /// <summary>
        /// Получение банковской даты
        /// </summary>
        /// <returns></returns>
        public String GetBankDate()
        {
            String result = "";
            String sql = "select gl.bd from dual";//"select GetGlobalOption('BANKDATE') from dual";
            DateTime? date = _entities.ExecuteStoreQuery<DateTime?>(sql).FirstOrDefault();
            if (date.HasValue)
                result = String.Format("{0:dd.MM.yyyy}", date.Value);
            return result;
        }

        /// <summary>
        /// Получение значения для отображения кнопки "внести" на форме инкасации
        /// 1 - показывать
        /// 0 - скрыть
        /// </summary>
        /// <returns></returns>
        public Int32 GetToxFlag()
        {
            OracleParameter[] parameters = new OracleParameter[1] { new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue) };
            String sql = @"begin
                             :result := teller_utils.get_tox_flag();
                           end;";
            using (OracleConnection con = connect.GetUserConnection(HttpContext.Current))
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = sql;
                    var oracleResult = new OracleParameter("result", OracleDbType.Int32, ParameterDirection.Output);
                    cmd.Parameters.Add(oracleResult);
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        OracleDecimal oraDecimal = (OracleDecimal)oracleResult.Value;
                        return  oraDecimal.IsNull? 0: Convert.ToInt32(oraDecimal.Value);
                    }
                }
            }
        }
    }
}
