using Areas.Sto.Models;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sto.Models;
using BarsWeb.Models;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using Oracle.DataAccess.Types;
using System.Data;

namespace BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Implementation
{
    /// <summary>
    /// Репозиторий для работы со "старыми" регулярными платежами (STO)
    /// </summary>
    public class ContractRepository : IContractRepository
    {
        private readonly stoContainer _sto;
        public ContractRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("stoContainer", "Sto");
            this._sto = new stoContainer(connectionStr);
        }

        private System.Data.Common.DbTransaction transaction;

        public void BeginTransaction ()
        {
            if (_sto.Connection.State != System.Data.ConnectionState.Open)
                _sto.Connection.Open();
            transaction = _sto.Connection.BeginTransaction();
        }

        public void Commit ()
        {
            transaction.Commit();
        }

        public void Rollback ()
        {
            if (transaction != null)
                transaction.Rollback();
        }

        public IQueryable<STO_LST> ContractData()
        {
            var data = _sto.STO_LST;
            return data;
        }
        /// <summary>
        /// Список договоров на рег. платежи по группе
        /// </summary>
        /// <param name="group_id">ИД группы (STO_GRP)</param>
        /// <returns></returns>
        public List<STOContractData> GetContractDataList(int group_id)
        {
            List<STOContractData> contracts = new List<STOContractData>();
            using (OracleConnection conn = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand command = conn.CreateCommand())
                {
                    command.CommandType = CommandType.Text;
                    command.CommandText = "Select * from bars.v_sto_lst where idg=:groupId";
                    command.Parameters.Add("groupId", OracleDbType.Int32, group_id, ParameterDirection.Input);

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var contractInfo = new STOContractData()
                            {
                                IDS = Convert.ToInt64(reader["IDS"]),
                                RNK = Convert.ToInt64(reader["RNK"]),
                                NMK = Convert.ToString(reader["NMK"]),
                                Name = Convert.ToString(reader["Name"]),
                                SDat = Convert.ToDateTime(reader["SDAT"]),
                                IDG = Convert.ToInt64(reader["IDG"]),
                                KF = Convert.ToString(reader["KF"]),
                                Branch = Convert.ToString(reader["Branch"])
                            };

                            if(!Convert.IsDBNull(reader["SDAT"]))
                                contractInfo.SDat = Convert.ToDateTime(reader["SDAT"]);

                            if (!Convert.IsDBNull(reader["Date_close"]))
                                contractInfo.ClosingDate = Convert.ToDateTime(reader["Date_close"]);
                            contracts.Add(contractInfo);
                        }
                    }
                }
            }

            return contracts;
        }

        public IQueryable<V_STO_DET> ContractDetData()
        {
            var data = _sto.V_STO_DET;
            return data;
        }
        public IQueryable<STO_GRP> GroupData()
        {
            return _sto.STO_GRP;
        }

        //Makes the same as GroupData() but might be faster
        public List<STOGroup> GetGroupsList()
        {
            List<STOGroup> groups = new List<STOGroup>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.Text;
                    command.CommandText = "Select * from bars.v_sto_grp_ui";

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            groups.Add(new STOGroup()
                            {
                                IDG = Convert.ToInt64(reader["IDG"]),
                                Name = Convert.ToString(reader["Name"]),
                                KF = Convert.ToString(reader["KF"]),
                            });
                        }
                    }
                }
            }

            return groups;
        }
        /// <summary>
        /// Подтверждение / отклонение макета рег. платежа
        /// </summary>
        /// <param name="idd">ИД макета</param>
        /// <param name="statusId">Статус, 1 - подтвердить, -1 - отклонить</param>
        /// <param name="disclaimId">Причина отклонения (STO_DISCLAIMER)</param>
        /// <returns>1 - выполнено успешно, 0 - ошибка</returns>
        public int ClaimProc(string idd, string statusId, string disclaimId)
        {
            var procResult = 1;
            const string command = @"
                    begin
                        sto_all.claim_idd ( :p_IDD, :p_statusid, :p_disclaimid);
                    end;
                ";
            var commParams = new object[] {
                new OracleParameter("p_IDD", OracleDbType.Decimal) { Value = idd },
                new OracleParameter("p_statusid", OracleDbType.Decimal) { Value = statusId },
                new OracleParameter("p_disclaimid", OracleDbType.Decimal) { Value = disclaimId }
            };
            try
            {
                _sto.ExecuteStoreCommand(command, commParams);
            }
            catch (Exception ex)
            {
                procResult = 0;
            }
            return procResult;
        }
        /// <summary>
        /// Список причин отклонения макета РП
        /// </summary>
        /// <returns></returns>
        public IQueryable<STO_DISCLAIMER> DisclaimerData()
        {
            return _sto.STO_DISCLAIMER;
        }
        /// <summary>
        /// История изменений макетов РП
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_STO_DET_HIST> DetInfoData()
        {
            return _sto.V_STO_DET_HIST;
        }

        public string CurrentBranch()
        {
            const string query = @"select SYS_CONTEXT('bars_context', 'user_branch') from dual";
            var branch = _sto.ExecuteStoreQuery<string>(query).Single();
            return branch;
        }
        /// <summary>
        /// Частота выполнения РП (справочник)
        /// </summary>
        /// <returns></returns>
        public IQueryable<pipe_FREQ> GetFREQ()
        {
            const string query = @"select freq, name from FREQ";
            return _sto.ExecuteStoreQuery<pipe_FREQ>(query).AsQueryable();
        }
        public List<pipe_customer> GetRNKLIST(string OKPO, decimal? RNK)
        {
            List<pipe_customer> list = new List<pipe_customer>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.Text;
                    string query = "select rnk, nmk, okpo from V_CUSTOMER_ACTIVE where";

                    if (!String.IsNullOrEmpty(OKPO))
                    {
                        if (RNK == null)
                        {
                            query += " okpo= :p_okpo";
                            command.Parameters.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2) { Value = OKPO });
                        }
                        else
                        {
                            query += " okpo= :p_okpo AND rnk= :p_rnk";
                            command.Parameters.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2) { Value = OKPO });
                            command.Parameters.Add(new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK.Value });
                        }
                    }
                    else
                    //if (RNK != null)
                    {
                        query += " RNK= :p_rnk";
                        command.Parameters.Add(new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK.Value });
                    }

                    command.CommandText = query;
                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            list.Add(new pipe_customer()
                            {
                                RNK = Convert.ToDecimal(reader["rnk"]),
                                NMK = Convert.ToString(reader["nmk"]),
                            });
                        }
                    }
                }
            }
            return list;
        }
        /// <summary>
        /// Операции, доступные для использования в макетах РП
        /// </summary>
        /// <returns>Список tt, name</returns>
        public List<pipe_TTS> GetTTS()
        {
            List<pipe_TTS> tts_list = new List<pipe_TTS>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.Text;
                    command.CommandText = "select tt, name as name from V_STO_TTS";
                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            tts_list.Add(new pipe_TTS()
                            {
                                TT = Convert.ToString(reader["tt"]),
                                NAME = Convert.ToString(reader["name"])
                            });
                        }
                    }
                }
            }

            return tts_list;
        }
        public IQueryable<string> GetNLS(decimal RNK, decimal? KV)
        {
            string query = "";
            var parameters = new object[] { };
            if (KV == null)
            {
                query = @"select nls from accounts where rnk = :p_rnk and dazs is null";
                parameters = new object[] {
                new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK}
                };
            }
            else
            {
                query = @"select nls from accounts where rnk = :p_rnk and dazs is null and kv = :p_kv";
                parameters = new object[] {
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK},
                    new OracleParameter("p_kv", OracleDbType.Decimal) { Value = KV}
                    };
            }
            return _sto.ExecuteStoreQuery<string>(query, parameters).AsQueryable();
        }

        public IQueryable<DropDown> GetKVs(decimal? RNK)
        {
            string query = "";
            var parameters = new object[] { };
            if (RNK != null)
            {
                query = @"select kv, name from tabval where kv in 
                    (select distinct kv from accounts where rnk = :p_rnk and dazs is null)";
                parameters = new object[] {
                new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK}
            };
            }
            else
            {
                query = @"select kv, name from tabval";
            }
            return _sto.ExecuteStoreQuery<DropDown>(query, parameters).AsQueryable();
        }
        public IQueryable<string> GetNMK(decimal RNK)
        {
            const string query = @"select nmk from customer where rnk = :p_rnk";
            var parameters = new object[] {
                new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK}
            };
            return _sto.ExecuteStoreQuery<string>(query, parameters).AsQueryable();
        }

        /// <summary>
        /// Создание макета рег. платежа
        /// </summary>
        /// <param name="newpayment">Данные макета рег. платежа</param>
        /// <returns>ИД созданного макета</returns>
        public decimal AddPayment(payment newpayment)
        {
            try
            {
                BeginTransaction();
                const string query = @"begin sto_all.Add_RegularTreaty( :IDS,:ord, :tt, :vob, :dk, :nlsa,:kva, :nlsb, :kvb, :mfob, :polu, " +
                    ":nazn,:fsum, :okpo, :DAT1, :DAT2, :FREQ, null,:WEND, :DR, null, :p_nd,:p_sdate,:p_idd,:p_status,:p_status_text);end;";
                OracleParameter p_idd = new OracleParameter("p_idd", OracleDbType.Decimal, newpayment.idd, System.Data.ParameterDirection.Output); // результирующий ИД макета платежа
                var parameters = new object[] {
                new OracleParameter("IDS", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.IDS},
                new OracleParameter("ord", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.ord},
                new OracleParameter("tt", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.tt},
                new OracleParameter("vob", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.vob},
                new OracleParameter("dk", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.dk},
                new OracleParameter("nlsa", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.nlsa},
                new OracleParameter("kva", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.kva},
                new OracleParameter("nlsb", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.nlsb},
                new OracleParameter("kvb", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.kvb},
                new OracleParameter("mfob", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.mfob},
                new OracleParameter("polu", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.polu},
                new OracleParameter("nazn", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.nazn},
                new OracleParameter("fsum", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.fsum},
                new OracleParameter("okpo", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.okpo},
                new OracleParameter("DAT1", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newpayment.DAT1},
                new OracleParameter("DAT2", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newpayment.DAT2},
                new OracleParameter("FREQ", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.FREQ},
                new OracleParameter("WEND", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.WEND},
                new OracleParameter("DR", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.DR},
                new OracleParameter("p_nd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.nd},
                new OracleParameter("p_sdate", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newpayment.sdate},
                p_idd,
                new OracleParameter("p_status", OracleDbType.Decimal, System.Data.ParameterDirection.Output) { Value = newpayment.status},
                new OracleParameter("p_status_text", OracleDbType.Varchar2, 4000, System.Data.ParameterDirection.Output) { Value = newpayment.status_text} };

                _sto.ExecuteStoreCommand(query, parameters);
                newpayment.idd = ((OracleDecimal)p_idd.Value).Value;

                const string addKodGovBuyQuery = @"begin sto_all.add_operw(:p_idd, :p_tag, :p_value); end;";
                var addKodGovBuyQueryParameters =
                new object[]
                {
                      new OracleParameter("p_idd", OracleDbType.Decimal, ParameterDirection.Input) { Value = newpayment.idd},
                      new OracleParameter("p_tag", OracleDbType.Varchar2, ParameterDirection.Input) { Value = "KODDZ"},
                      new OracleParameter("p_value", OracleDbType.Varchar2, ParameterDirection.Input) { Value = newpayment.govBuyCode},
                };
                _sto.ExecuteStoreCommand(addKodGovBuyQuery, addKodGovBuyQueryParameters);
                Commit();
            }
            catch (Exception ex)
            {
                Rollback();
                throw ex;
            }
            return newpayment.idd;
        }

        public decimal AvaliableNPP(decimal IDS)
        {
            const string query = @"select bars.sto_all.get_AvaliableNPP(:p_ids) from dual";
            var parameters = new object[] {
                new OracleParameter("p_ids", OracleDbType.Decimal) { Value = IDS}
            };
            return _sto.ExecuteStoreQuery<decimal>(query, parameters).Single();

        }

        /// <summary>
        /// Создание договора на рег. платежи
        /// </summary>
        /// <param name="newids">Данные договора</param>
        /// <returns>ИД созданного договора</returns>
        public decimal AddIDS(ids newids)
        {
            const string query = @"begin sto_all.set_lst( :IDG,:IDS, :RNK, :NAME, :SDAT); end;";
            OracleParameter IDS = new OracleParameter("IDS", OracleDbType.Decimal, newids.IDS, System.Data.ParameterDirection.Output); // результирующий ИД договора
            OracleParameter[] parameters = new OracleParameter[] {
                IDS,
                new OracleParameter("IDG", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newids.IDG},
                new OracleParameter("RNK", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newids.RNK},
                new OracleParameter("NAME", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newids.NAME},
                new OracleParameter("SDAT", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newids.SDAT}
             };
            _sto.ExecuteStoreCommand(query, parameters);
            newids.IDS = ((OracleDecimal)IDS.Value).Value;
            return newids.IDS;
        }

        /// <summary>
        /// Удаление / закрытие договора на рег. платежи
        /// </summary>
        /// <param name="ids">Идентификатор договора</param>
        /// <returns>Сообщение о результате операции</returns>
        public string Remove_Contract(decimal ids)
        {
            string resultMessage = null;
            const string query = @"begin sto_all.remove_lst(:p_ids,:p_resultMsg); end;";
            var parameters = new object[] {
                new OracleParameter("p_ids", OracleDbType.Decimal, ParameterDirection.Input) { Value = ids},
                new OracleParameter("p_resultMsg", OracleDbType.Varchar2, ParameterDirection.Output) { Size=4000 }
             };
            _sto.ExecuteStoreQuery<object>(query, parameters);
            resultMessage = Convert.ToString((OracleString)((OracleParameter)parameters[1]).Value);
            return resultMessage;
        }

        public List<PaymentDopRekvModel> GetDopRekvforPaymentList(decimal idd)
        {
            List<PaymentDopRekvModel> dopRekvList = new List<PaymentDopRekvModel>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.Text;
                    command.CommandText = "select name, value from v_sto_operw where idd=:p_idd";
                    command.Parameters.Add(new OracleParameter("p_idd", OracleDbType.Decimal, idd, ParameterDirection.Input));

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            dopRekvList.Add(new PaymentDopRekvModel()
                            {
                                RekvName = Convert.ToString(reader["name"]),
                                RekvValue = Convert.ToString(reader["value"]),
                            });
                        }
                    }
                }
            }

            return dopRekvList;
        }

        public List<GovBuyingCodeRekv> GetGovCodesValue()
        {
            List<GovBuyingCodeRekv> dopRekvList = new List<GovBuyingCodeRekv>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.Text;
                    command.CommandText = "select n1, n2 from kod_dz order by n1";

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            dopRekvList.Add(new GovBuyingCodeRekv()
                            {
                                GovCode = Convert.ToString(reader["n1"]),
                                GovCodeText = Convert.ToString(reader["n2"]),
                            });
                        }
                    }
                }
            }

            return dopRekvList;
        }
    }
}
