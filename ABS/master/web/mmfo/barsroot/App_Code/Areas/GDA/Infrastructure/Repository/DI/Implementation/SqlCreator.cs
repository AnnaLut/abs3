using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.GDA.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql GetUserInfo()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT FIO,0 as ROLE FROM staff$base WHERE type=1 AND id in (select user_id from dual)",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql GetUserInfo(string id)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT FIO,0 as ROLE FROM staff$base WHERE type=1 AND id = :p_id",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Long){ Value = id }
                }
            };

        }

        //ПортфельДБО
        public static BarsSql GetDateDBODemand(string contract_number)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT contract_date FROM v_dbo where contract_number = :contract_num",
                SqlParams = new object[]
                {
                    new OracleParameter("contract_num", OracleDbType.Long){ Value = contract_number  }
                }
            };

        }

        //получаем дату для отображения в заголовке окна открытия вклада на требования через грид операциониста
        public static BarsSql GetDboPortfolio()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT * FROM v_dbo",
                SqlParams = new object[] { }
            };

        }
        //Получить валюту для дробдаун листа
        public static BarsSql GetCurrencyList()
        {
            return new BarsSql()
            {
                SqlText = @"select kv, lcv, name from tabval",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql GetDepositOnDemandCalcType()
        {
            return new BarsSql()
            {
                SqlText = @"select item_id, item_code,item_name
                                from table(smb_deposit_ui.get_calculation_type_dict())",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql GetPaymentList()
        {
            return new BarsSql()
            {
                SqlText = @"  select item_id payment_term_id
                             ,item_name payment_term  
                              from table(smb_deposit_ui.get_payment_term_list())",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql GetCapitalizationList()
        {
            return new BarsSql()
            {
                SqlText = @"  select item_id payment_term_id
                             ,item_name payment_term  
                              from table(smb_deposit_ui.get_capitalization_term_list())",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql GetPaymentListTranche()
        {
            return new BarsSql()
            {
                SqlText = @"  select *
                              from table(smb_deposit_ui.get_payment_term_list())",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql GetProlongationList()
        {
            return new BarsSql()
            {
                SqlText = @"  select item_id frequency_of_use_id
                               ,item_name frequency_of_use  
                                from table(smb_deposit_ui.get_prolongation_list())",
                SqlParams = new object[] { }
            };


        }

        public static BarsSql GetProlongationTrancheList()
        {
            return new BarsSql()
            {
                SqlText = @"select *
                            from table(smb_deposit_ui.get_prolongation_list ())",

                SqlParams = new object[] { }
            };


        }

        public static BarsSql GetNumberProlongationList(string startDate, string currencyId)
        {
            return new BarsSql()
            {
                SqlText = @"select x.NumberProlongation
                            ,x.interest_rate
                            ,x.ApplyBonusProlongation  
                            ,x.name_
                                    from table(smb_deposit_ui.get_prolongation_dict(
                                   p_start_date  => to_date(:p_start_date_text, 'dd.mm.yyyy')
                                  ,p_currency_id => :p_currency_id)) x
                                    order by x.NumberProlongation",

                SqlParams = new object[]
                {
                    new OracleParameter("p_start_date", OracleDbType.Varchar2){Direction = ParameterDirection.Input,Value = startDate },
                    new OracleParameter("p_currency_id", OracleDbType.Int32){Direction = ParameterDirection.Input,Value = currencyId }
                }
            };


        }

        //public static BarsSql GetCapitalizationTrancheList()
        //{
        //    return new BarsSql()
        //    {
        //        SqlText = @"select *
        //                    from table(smb_deposit_ui.get_capitalization_term_list())",

        //        SqlParams = new object[] { }
        //    };


        //}

        public static BarsSql GetTimeTranches(string customerId)
        {
            return new BarsSql()
            {
                SqlText = @"select *
                              from v_smb_deposit_tranche
                             where customer_id = :customer_id",
                SqlParams = new object[]
                {
                    new OracleParameter("customer_id", OracleDbType.Decimal){ Value = customerId }
                }
            };

        }

        public static BarsSql GetRequireDeposits(string customerId)
        {
            return new BarsSql()
            {
                SqlText = @"select * 
                            from v_smb_deposit_on_demand
                            where customer_id = :customer_id ",
                SqlParams = new object[]
                {
                    new OracleParameter("customer_id", OracleDbType.Decimal){ Value = customerId}
                }
            };

        }

        public static BarsSql GetDepositAccount(string customerId)
        {
            return new BarsSql()
            {
                SqlText = @"select * from v_smb_deposit_account where customer_id = :customer_id ",
                SqlParams = new object[]
                {
                    new OracleParameter("customer_id", OracleDbType.Decimal){ Value = customerId }
                }
            };

        }

        public static BarsSql GetDebitAccountList(string customerId, string currencyId)
        {

            return new BarsSql()
            {
                SqlText = @"
                select *
                  from v_smb_account_to_withdraw
                 where kv = :currency_id
                   and rnk = :customer_id",

                SqlParams = new object[]
                {
                    new OracleParameter("customer_id", OracleDbType.Decimal){ Value = customerId },
                    new OracleParameter("currency_id", OracleDbType.Decimal){ Value = currencyId }
                }
            };

        }

        public static BarsSql GetTrancheFromDB(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"select smb_deposit_ui.get_tranche_xml_data(:procces_id) xml_tranche from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("procces_id", OracleDbType.Varchar2).Value = processId
                }
            };
        }

        public static BarsSql GetClosingDeposit(string processId, string objectId)
        {
            return new BarsSql()
            {
                SqlText = @"select smb_deposit_ui.get_close_on_demand_xml_data(p_process_id => :process_id ,p_object_id  => :p_object_id) from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("procces_id", OracleDbType.Varchar2).Value = null ,
                    new OracleParameter("p_object_id", OracleDbType.Varchar2).Value = objectId
                }
            };
        }

        //Получить данные с базы про смену начисления процентов
        public static BarsSql GetEditingDeposit(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"select smb_deposit_ui.get_on_demand_change_calc_xml(p_process_id  => :p_process_id) xml_data from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("procces_id", OracleDbType.Varchar2).Value = processId
                }
            };
        }
        public static BarsSql SaveReplacementTranche(string processId, string xml)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.cor_tranche(:p_process_id,:p_data);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000},
                    new OracleParameter("p_data",OracleDbType.Clob) {Value = xml, Direction=ParameterDirection.Input}
                }
            };
        }


        public static BarsSql SaveDepositDemand(string processId, string xml)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.cor_on_demand(p_process_id => :p_process_id, p_data => :p_data);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000},
                    new OracleParameter("p_data",OracleDbType.Clob) {Value = xml, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql GetReplenishTrancheXml(string processId, string trancheId)
        {
            return new BarsSql()
            {
                SqlText = @"select  smb_deposit_ui.get_replenish_tanche_xml_data(:p_process_id, :p_object_id) from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=processId},
                    new OracleParameter("p_object_id",OracleDbType.Varchar2) {Value = trancheId, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql GetOperatorController(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"select smb_deposit_ui.get_users_activity(p_process_id => :p_process_id) h
                            from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=processId},
                }
            };
        }

        public static BarsSql GetCapitalizationTrancheList()
        {
            return new BarsSql()
            {
                SqlText = @"select *
                            from table(smb_deposit_ui.get_capitalization_term_list())",

                SqlParams = new object[] { }
            };


        }


        public static BarsSql SaveReplenishTrancheXml(string processId, string trancheId, string xml)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.cor_replenish_tranche(:p_process_id,:p_object_id,:p_data);
                                                          end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Value=processId,Direction = ParameterDirection.InputOutput,Size=500},
                    new OracleParameter("p_object_id",OracleDbType.Varchar2) {Value = trancheId, Direction=ParameterDirection.Input,Size=500},
                    new OracleParameter("p_data",OracleDbType.Clob) {Value = xml, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql GetEarlyRepaymentTrancheXml(string processId, string trancheId)
        {
            return new BarsSql()
            {
                SqlText = @"select  smb_deposit_ui.get_returning_tranche_xml(:p_process_id, :p_object_id) from dual",
                SqlParams = new object[]
                {
                    //Value=processId
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=null},
                    new OracleParameter("p_object_id",OracleDbType.Varchar2) {Value = trancheId, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql GetReplenishmentHistory(string trancheId)
        {
            return new BarsSql()
            {
                SqlText = @"select *
                          from v_smb_deposit_replenishment
                         where object_id = :TrancheId
                           and is_replenishment_tranche = 1",
                SqlParams = new object[]
                {

                    new OracleParameter("TrancheId",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=trancheId},
                }
            };
        }

        public static BarsSql SaveEarlyRepaymentTrancheXml(string processId, string trancheId, string xml)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.cor_returning_tranche(:p_process_id,:p_object_id,:p_data);
                                                          end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Value=processId,Direction = ParameterDirection.Output,Size=500},
                    new OracleParameter("p_object_id",OracleDbType.Varchar2) {Value = trancheId, Direction=ParameterDirection.Input,Size=500},
                    new OracleParameter("p_data",OracleDbType.Clob) {Value = xml, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql GetOnDemandTrancheXml(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"select smb_deposit_ui.get_on_demand_xml_data(:p_process_id) deposit_data from dual",

                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=processId},
                }
            };
        }

        public static BarsSql Autorize(string processId, string errorMess)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                               smb_deposit_ui.tranche_confirmation(
                                   :p_process_id  
                                  ,:p_is_confirmed
                                  ,:p_comment
                                  ,:p_error);
                            end;",

                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal){Direction = ParameterDirection.Input, Value=processId,Size=500},
                    new OracleParameter("p_is_confirmed",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value='Y'},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = "", Direction=ParameterDirection.Input},
                    //new OracleParameter("p_error",OracleDbType.Clob) {Value = error, Direction=ParameterDirection.InputOutput}
                    new OracleParameter("p_error",OracleDbType.Varchar2) {Value = errorMess, Direction=ParameterDirection.InputOutput, Size=4000}
                }
            };
        }

        public static BarsSql Reject(string processId, string comment, string error)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                               smb_deposit_ui.tranche_confirmation(
                                   :p_process_id
                                  ,:p_is_confirmed
                                  ,:p_comment
                                  ,:p_error);
                            end;",

                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal){Direction = ParameterDirection.Input, Value=processId,Size=500},
                    new OracleParameter("p_is_confirmed",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value='N'},
                    new OracleParameter("p_comment",OracleDbType.Clob) {Value = comment, Direction=ParameterDirection.Input},
                    new OracleParameter("p_error",OracleDbType.Clob) {Value = error, Direction=ParameterDirection.InputOutput}
                }
            };
        }

        public static BarsSql AutorizeOnDemand(string processId, string errorMess, string type)
        {
            BackDepositDemandType demandType;
            Enum.TryParse(type, out demandType);

            string query = "begin ";
            switch (demandType)
            {
                case BackDepositDemandType.NEW_ON_DEMAND:
                    query += "smb_deposit_ui.on_demand_confirmation";
                    break;
                case BackDepositDemandType.CLOSE_ON_DEMAND:
                    query += "smb_deposit_ui.close_on_demand_confirmation";
                    break;
                case BackDepositDemandType.CHANGE_CALCULATION_TYPE:
                    query += "smb_deposit_ui.change_calc_type_confirmation";
                    break;
                default:
                    break;
            }
            query += @"(
                          :p_process_id  
                         ,:p_is_confirmed
                         ,:p_comment
                         ,:p_error);
                     end;";

            return new BarsSql
            {
                SqlText = query,
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal){Direction = ParameterDirection.Input, Value=processId,Size=500},
                    new OracleParameter("p_is_confirmed",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value='Y'},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = "", Direction=ParameterDirection.Input},
                    new OracleParameter("p_error",OracleDbType.Varchar2) {Value = errorMess, Direction=ParameterDirection.InputOutput, Size=4000}
                }
            };
        }

        public static BarsSql RejectOnDemand(string processId, string comment, string error, string type)
        {
            BackDepositDemandType demandType;
            Enum.TryParse(type, out demandType);

            string query = "begin ";
            switch (demandType)
            {
                case BackDepositDemandType.NEW_ON_DEMAND:
                    query += "smb_deposit_ui.on_demand_confirmation";
                    break;
                case BackDepositDemandType.CLOSE_ON_DEMAND:
                    query += "smb_deposit_ui.close_on_demand_confirmation";
                    break;
                case BackDepositDemandType.CHANGE_CALCULATION_TYPE:
                    query += "smb_deposit_ui.change_calc_type_confirmation";
                    break;
                default:
                    break;
            }
            query += @"(
                          :p_process_id  
                         ,:p_is_confirmed
                         ,:p_comment
                         ,:p_error);
                     end;";

            return new BarsSql()
            {
                SqlText = query,
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal){Direction = ParameterDirection.Input, Value=processId,Size=500},
                    new OracleParameter("p_is_confirmed",OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value='N'},
                    new OracleParameter("p_comment",OracleDbType.Clob) {Value = comment, Direction=ParameterDirection.Input},
                    new OracleParameter("p_error",OracleDbType.Clob) {Value = error, Direction=ParameterDirection.InputOutput}
                }
            };
        }

        public static BarsSql Block(string processId, string comment, DateTime date, int blockType)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                               smb_deposit_ui.tranche_blocking(
                                   :p_process_id
                                  ,:p_lock_date
                                  ,:p_comment
                                  ,:p_lock_type );
                            end;",

                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal){Direction = ParameterDirection.Input, Value=processId, Size=500},
                    new OracleParameter("p_lock_date",OracleDbType.Date){Direction = ParameterDirection.Input, Value=date},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = comment, Direction=ParameterDirection.Input},
                    new OracleParameter("p_lock_type",OracleDbType.Decimal) {Value = blockType, Direction=ParameterDirection.Input},
                }
            };
        }

        public static BarsSql Unblock(string processId, string comment, DateTime date)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                               smb_deposit_ui.tranche_unblocking(
                                   :p_process_id
                                  ,:p_lock_date
                                  ,:p_comment);
                            end;",

                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal){Direction = ParameterDirection.Input, Value=processId, Size=500},
                    new OracleParameter("p_lock_date",OracleDbType.Date){Direction = ParameterDirection.Input, Value=date},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = comment, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql GetBlockTypes()
        {
            return new BarsSql()
            {
                SqlText = @"  select *
                              from table(smb_deposit_ui.get_tranche_lock_type_list())",
                SqlParams = new object[] { }
            };
        }
        public static BarsSql AuthTranche(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.tranche_authorization(p_process_id => :p_process_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

                }
            };
        }

        public static BarsSql ReturningAuthTranche(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.returning_tranche_auth(p_process_id => :p_process_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

                }
            };
        }

        public static BarsSql AuthDeposit(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.on_demand_authorization(p_process_id => :p_process_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

                }
            };
        }

        public static BarsSql AuthDepositClose(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                smb_deposit_ui.close_on_demand_authorization(p_process_id => :p_process_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

                }
            };
        }

        public static BarsSql CloseDeposit(string processId, string objectId, string xml)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                smb_deposit_ui.cor_close_on_demand(
                                    p_process_id   => :p_process_id
                                    ,p_object_id    => :p_object_id
                                    ,p_data         => :p_data);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id", OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000},
                    new OracleParameter("p_object_id", OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=objectId },
                    new OracleParameter("p_data", OracleDbType.Clob) {Value = xml, Direction=ParameterDirection.Input}
                }
            };
        }

        //public static BarsSql AuthReplacementTranche(string processId)
        //{
        //    return new BarsSql()
        //    {
        //        SqlText = @"begin
        //                    smb_deposit_ui.tranche_authorization(p_process_id => :p_process_id);
        //                    end;",
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

        //        }
        //    };
        //}
        //public static BarsSql AuthReplenishmentTranche(string processId)
        //{
        //    return new BarsSql()
        //    {
        //        SqlText = @"begin
        //                    smb_deposit_ui.tranche_authorization(p_process_id => :p_process_id);
        //                    end;",
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

        //        }
        //    };
        //}

        //public static BarsSql AuthEarlyRepaymentTranche(string processId)
        //{
        //    return new BarsSql()
        //    {
        //        SqlText = @"begin
        //                    smb_deposit_ui.tranche_authorization(p_process_id => :p_process_id);
        //                    end;",
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

        //        }
        //    };
        //}

        //public static BarsSql AuthEditReplenishmentTranche(string processId)
        //{
        //    return new BarsSql()
        //    {
        //        SqlText = @"begin
        //                    smb_deposit_ui.tranche_authorization(p_process_id => :p_process_id);
        //                    end;",
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

        //        }
        //    };
        //}

        //public static BarsSql AuthDepositDemand(string processId)
        //{
        //    return new BarsSql()
        //    {
        //        SqlText = @"begin
        //                    smb_deposit_ui.tranche_authorization(p_process_id => :p_process_id);
        //                    end;",
        //        SqlParams = new object[]
        //        {
        //            new OracleParameter("p_process_id",OracleDbType.Varchar2){Direction = ParameterDirection.InputOutput, Value=processId,Size=4000}

        //        }
        //    };
        //}
        public static BarsSql CountPlacementTranche(string xml)
        {
            return new BarsSql()
            {
                SqlText = @"select smb_deposit_ui.get_interest_rate_tranche(p_data => :process_data) interest_rate from dual",
                SqlParams = new object[]
                {

                    new OracleParameter("p_data",OracleDbType.Clob) {Value = xml, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql GetCalculationType()
        {
            return new BarsSql()
            {
                SqlText = @"select * from table(smb_deposit_ui.get_calculation_type_list())",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql ChangeCalculationType(ChangeCalcTypePostModel postModel)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.change_calculation_type_dod (
                                           p_process_id          => :p_process_id 
                                          ,p_calculation_type_id => :p_calculation_type_id
                                          ,p_comment             => :p_comment);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal) {Value = postModel.ProcessId, Direction=ParameterDirection.Input},
                    new OracleParameter("p_calculation_type_id",OracleDbType.Decimal) {Value = postModel.CalculationType, Direction=ParameterDirection.Input},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = postModel.Comment, Direction=ParameterDirection.Input},
                }
            };
        }

        public static BarsSql AuthChangeCalculationType(string processId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.change_calc_type_authorization(p_process_id => :process_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal) {Value = processId, Direction=ParameterDirection.Input},
                }
            };
        }

        public static BarsSql CountDepositDemand(string xml)
        {
            return new BarsSql()
            {
                SqlText = @"select smb_deposit_ui.get_interest_rate_on_demand(p_data => :process_data) interest_rate from dual",
                SqlParams = new object[]
                {

                    new OracleParameter("p_data",OracleDbType.Clob) {Value = xml, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql CancelTimeTranche(string processId, string comment)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.delete_tranche(p_process_id => :p_process_id,p_comment => :p_comment);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal) {Value = processId, Direction=ParameterDirection.Input},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = comment, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql CancelReplenishment(string processId, string comment)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.delete_replenishment(
                                   p_process_id => :p_process_id
                                  ,p_comment    => :p_comment);
                                   end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal) {Value = processId, Direction=ParameterDirection.Input},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = comment, Direction=ParameterDirection.Input}
                }
            };
        }

        public static BarsSql CancelRequireDeposit(string processId, string comment)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                            smb_deposit_ui.delete_on_demand(p_process_id => :p_process_id,p_comment => :p_comment);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_process_id",OracleDbType.Decimal) {Value = processId, Direction=ParameterDirection.Input},
                    new OracleParameter("p_comment",OracleDbType.Varchar2) {Value = comment, Direction=ParameterDirection.Input}

                }
            };
        }

        //Получение грида ДБО операциониста
        public static BarsSql GetOperationistDboPortfolio(string date)
        {
            return new BarsSql()
            {
                SqlText = @"select *
                            from v_smb_deposit_process d
                            where 1 = 1 
                            and trunc(d.sys_time) = to_date(:start_date, 'dd.mm.yyyy')",
                //SqlText = @"select *
                //            from v_smb_deposit_process d",
                SqlParams = new object[]
                {
                    new OracleParameter("start_date", OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=date }
                }
            };

        }

        public static BarsSql CountLastReplenishmentDate(string startDate, string expiryDate)
        {
            return new BarsSql()
            {
                //SqlText = @"select smb_deposit_ui.get_last_replenishment_date (
                //            p_start_date  => :start_date,
                //            p_end_date    => :end_date) dt
                //            from dual",
                SqlText = @"select smb_deposit_ui.get_last_replenishment_date (
                            p_start_date  => to_date(:start_date,'dd.mm.yyyy'),
                            p_end_date    => to_date(:end_date, 'dd.mm.yyyy')) dt
                            from dual",

                SqlParams = new object[]
                {
                   new OracleParameter("p_start_date", OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=startDate },
                   new OracleParameter("p_end_date", OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=expiryDate }
                }
            };
        }

        public static BarsSql ProlongationDetails(string processId)
        {
            return new BarsSql()
            {

                SqlText = @"select smb_deposit_ui.get_tranche_prolongation_xml(p_procesS_id => :p_process_id)
                            prolongation_data
                            from dual",

                SqlParams = new object[]
                {
                   new OracleParameter("p_procesS_id", OracleDbType.Varchar2){Direction = ParameterDirection.Input, Value=processId },
                }
            };
        }

    }
}
