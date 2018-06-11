using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using Oracle.DataAccess.Client;
using System.Data;
using Areas.BpkW4.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Collections;

namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Implementation
{
    public class CheckdkboRepository : ICheckdkboRepository
    {
        public CheckdkboRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("BpkW4", "BpkW4");
            _entities = new W4Model(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        private readonly W4Model _entities;
        private BarsSql _baseSql;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public CustomerFilter CreateDKBO(List<AddToDKBO> addToDKBO)
        {
            decimal out_id = 0;
            CustomerFilter custF = new CustomerFilter() { };

            object[] parameters =
                {
                   new OracleParameter("out_deal_id", OracleDbType.Decimal, out_id, ParameterDirection.Output)
                };

            for (int i = 0; i < addToDKBO.Count; i++)
            {
                string commandString = string.Format(@"
                           declare                           
                                out_deal_id integer; 
                           begin
                           pkg_dkbo_utl.p_acc_map_to_dkbo(
                           in_customer_id => {0},
                           in_deal_number => null,
                           in_acc_list => number_list({1}),
                           in_acc_nbs => null,
                           in_dkbo_date_from => trunc(SYSDATE),
                           in_dkbo_date_to => null,
                           out_deal_id => :out_deal_id);
                            commit;
                           end;", addToDKBO[i].CustomerRnk, string.Join(",", addToDKBO[i].CustomerAccounts.ToArray()));


                _entities.ExecuteStoreCommand(commandString, parameters);
                out_id = decimal.Parse(((OracleParameter)parameters[0]).Value.ToString());
                custF.DealId = out_id.ToString();
                custF.CustomerRnk = addToDKBO[i].CustomerRnk;
            }
            return custF;
        }

        public IEnumerable<W4_DKBO_WEB_Result> Get_W4_DKBO_WEB(DataSourceRequest request)
        {
            InitW4DKBO_WEB_Sql();
            var sql = _sqlTransformer.TransformSql(_baseSql, request);
            var result = _entities.ExecuteStoreQuery<W4_DKBO_WEB_Result>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public decimal Get_W4_DKBO_WEB_Count(DataSourceRequest request)
        {
            InitW4DKBO_WEB_Sql();
            var count = _kendoSqlCounter.TransformSql(_baseSql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return total;
        }

        public IEnumerable<W4_DKBO_QUESTION_Result> Get_W4_DKBO_QUESTION(W4_DKBO_WEB_FilterParams fp)
        {
            InitW4DKBO_WEB_QUESTION(fp);
            var result = _entities.ExecuteStoreQuery<W4_DKBO_QUESTION_Result>(_baseSql.SqlText, _baseSql.SqlParams);
            return result.ToList();
        }


        public IEnumerable<V_LIST_ITEMS_Result> Get_V_LIST_ITEMS(W4_DKBO_WEB_FilterParams fp)
        {
            InitV_LIST_ITEMS_Sql(fp);
            var result = _entities.ExecuteStoreQuery<V_LIST_ITEMS_Result>(_baseSql.SqlText, _baseSql.SqlParams);
            return result.ToList<V_LIST_ITEMS_Result>();
        }

        /// <summary>
        /// Запись всех пар ключ-значение полученных с уровня Request.Form
        /// </summary>
        /// <param name="ht">Hashtable куда помещены пары ключа-значение Request.Form</param>
        /// <returns></returns>
        public object SetAnswers(Hashtable ht, string new_dkbo_id)
        {
            Hashtable htResult = new Hashtable();
            string commandString = string.Empty;
            if (ht.Count > 0 && !string.IsNullOrEmpty(new_dkbo_id))
                foreach (DictionaryEntry entry in ht)
                {
                    if (!String.IsNullOrEmpty((string)entry.Value))
                    {
                        if (entry.Value.ToString().Contains("&"))
                        {   // commandString для LIST
                            commandString = String.Format(@"
                            begin         
                            pkg_dkbo_utl.p_quest_answ_ins(in_object_id => {0},
                                    in_attribute_code => '{1}',
                                    in_attribute_value => '{2}');                           
                            end;",
                                      new_dkbo_id, // TO DO: подставить параметр сгенерированного Id ДКБО
                                      entry.Value.ToString().Split('&')[1], // QUEST_CODE
                                      entry.Value.ToString().Split('&')[0]); // LIST_CODE
                        }
                        else
                        {
                            commandString = String.Format(@"     
                        begin       
                        pkg_dkbo_utl.p_quest_answ_ins(in_object_id => {0},
                                in_attribute_code => '{1}',
                                in_attribute_value => '{2}');                      
                        end;",
                                  new_dkbo_id, // TO DO: подставить параметр сгенерированного Id ДКБО
                                  entry.Key.ToString(), // Key
                                  entry.Value.ToString()); // Val 
                        }
                        try
                        {
                            // TO DO: ЕСЛИ НЕТ ЗНАЧЕНИЯ - НЕ ВЫПОЛНЯТЬ ДЛЯ LIST
                            var res = _entities.ExecuteStoreCommand(commandString, new object[] { });
                            htResult.Add(entry.Key, res);
                        }
                        catch (Exception ex)
                        {
                            htResult.Add(entry.Key, ex.Message);
                        }
                    }
                }
            return htResult;
        }



        public void InitV_LIST_ITEMS_Sql(W4_DKBO_WEB_FilterParams fp)
        {
            _baseSql = new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = string.Format(@"
                            select
                            t.list_code, t.list_item_id, t.list_item_code, T.LIST_ITEM_NAME
                            from BARS.V_LIST_ITEMS t 
                            where t.list_code='{0}'", fp.list_code)
            };
        }

        private void InitW4DKBO_WEB_Sql()
        {
            _baseSql = new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = "select * from W4_DKBO_WEB"
            };
        }
        private void InitW4DKBO_WEB_QUESTION(W4_DKBO_WEB_FilterParams fp)
        {
            string commandText = @"select * from V_DKBO_QUESTIONNAIRE";
            if (fp.DEAL_ID.HasValue)
                commandText = string.Format(@"
           select rownum rn
                ,t.QUEST_GROUP_ID
                ,t.QUEST_GROUP
                ,t.QUEST_CODE
                ,t.QUEST_NAME
                ,t.QUEST_TYPE
                ,t.LIST_CODE
                ,t.LIST_NAME
                ,t.LIST_ID
                ,t1.ATTRIBUTE_VALUE
            FROM v_dkbo_questionnaire t
            LEFT JOIN v_dkbo_attribute_value t1
            ON t.quest_code = t1.attribute_code
            AND t.quest_group IS NOT NULL
            AND t1.deal_id = {0} ", fp.DEAL_ID.Value.ToString());
            _baseSql = new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = commandText
            };
        }

    }
}