using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Areas.Zay.Models;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using Bars.Classes;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation
{
    public class CurrencyOperations : ICurrencyOperations
    {

        private readonly ZayModel _entities;
        public CurrencyOperations()
        {
            var connectionStr = EntitiesConnection.ConnectionString("ZayModel", "Zay");
            _entities = new ZayModel(connectionStr);
        }
        
        public GetFileFromClModel GetModelFileForCl(long id)
        {
           var parameters = new object[]
           {
                new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input)
           };
            string query = "select z.id,v.adr,v.NMK,v.bank_name,v.address_bank,v.phone,z.kom,z.fnamekb from zayavka  z " +
                "inner join  V_MBM_CUSTOMERS  v on z.rnk = v.RNK where z.id = :p_id";
           return  _entities.ExecuteStoreQuery<GetFileFromClModel>(query, parameters).ToList().FirstOrDefault();
        }

        public string GetFNameKb(long id)
        {
            var parameters = new object[]
           {
                new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input)
           };
            string query = " select FNAMEKB from v_zay_salform where id = :p_id";
            return _entities.ExecuteStoreQuery<string>(query, parameters).ToList().FirstOrDefault();
        }

        public IList<Nmk> GetCustomerNmk(decimal rnk)
        {
            const string query = @"SELECT nmk FROM customer WHERE rnk = :dfRNK";

            var parameters = new object[]
            {
                new OracleParameter("dfRNK", OracleDbType.Decimal, rnk, ParameterDirection.Input),
           //     new OracleParameter("dfNMK", OracleDbType.NVarchar2, dfNMK, ParameterDirection.Output)
            };
            //       _entities.ExecuteStoreCommand(query, parameters);
            //         _entities.ExecuteStoreQuery<Nmk>(query, parameters).ToList();

            return _entities.ExecuteStoreQuery<Nmk>(query, parameters).ToList();
        }

        public IList<Nmk> GetTabvalName(decimal dfKV)
        {
            const string query = @"SELECT name FROM tabval WHERE kv = :dfKV";

            var parameters = new object[]
            {
                new OracleParameter("dfKV", OracleDbType.Decimal, dfKV, ParameterDirection.Input)
            };

            return _entities.ExecuteStoreQuery<Nmk>(query, parameters).ToList();
        }

        public IList<Nmk> GetApplication(decimal dfID, decimal dfKV, decimal dfRNK, decimal nDk)
        {
            const string query = @"SELECT z.viza, z.sos, z.s2/power(10,t.dig) as DK, z.fdat, z.ref, t.dig
                                FROM zayavka z, tabval t
                                WHERE z.id = :dfID
                                AND z.rnk = :dfRNK
                                AND z.dk = :nDk
                                AND z.kv2 = :dfKV
                                AND z.kv2 = t.kv
                                ";

            var parameters = new object[]
             {
                new OracleParameter("dfID", OracleDbType.Decimal, dfID, ParameterDirection.Input),
                new OracleParameter("dfRNK", OracleDbType.Decimal, dfRNK, ParameterDirection.Input),
                new OracleParameter("nDk", OracleDbType.Decimal, nDk, ParameterDirection.Input),
                new OracleParameter("dfKV", OracleDbType.Decimal, dfKV, ParameterDirection.Input)
             };

            _entities.ExecuteStoreQuery<Nmk>(query, parameters).ToList();

            return _entities.ExecuteStoreQuery<Nmk>(query, parameters).ToList();
        }


        public void DeleteApplication(decimal dfID)
        {
            const string query = @"update zayavka set sos = -1
                                WHERE id = :dfID
                                ";

            var parameters = new object[]
            {
                new OracleParameter("dfID", OracleDbType.Decimal, dfID, ParameterDirection.Input)
            };

            _entities.ExecuteStoreCommand(query, parameters);
        }
        public void RestoreApplication(decimal dfID)
        {
            string query = "begin\ninsert into zay_queue (id) values (" + dfID + ");\nexception\nwhen dup_val_on_index then null;\nend;";
            _entities.ExecuteStoreCommand(query);


            query = @"update zayavka set sos = 0, viza = 0, kurs_f = null, vdate = null
                                WHERE id = :dfID
                                ";
            var parameters = new object[]
            {
                new OracleParameter("dfID", OracleDbType.Decimal, dfID, ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(query, parameters);
        }

        public IList<Nmk> GetNrefSos(decimal nRef)
        {
            string query = @"uselect sos as nRefSos from oper 
                            where ref = :nRef
                             ";
            var parameters = new object[]
            {
                new OracleParameter("nRef", OracleDbType.Decimal, nRef, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<Nmk>(query, parameters).ToList();
        }
        public IList<ZAY_SPLITTING_AMOUNT> GetCurEarning()
        {
            string query = @"select RNK, NMK, ACC, KV, LCV, NLS, FDAT, REF, AMNT, IS_SPLIT
                                from BARS.V_ZAY_SPLIT_AMOUNT
                                order by KV, RNK, FDAT desc
                                ";
            return _entities.ExecuteStoreQuery<ZAY_SPLITTING_AMOUNT>(query).ToList();
        }
        public IList<V_ZAY_SPLIT_AMOUNT> GetDefaultSpliter(decimal? AMNT)
        {
            string query = @"Select cast( null as number(38) ) as ID, TP_ID, TP_NM
                                 , case when TP_ID = 2 then :nDocAmnt else 0 end as AMNT, 0 as VIRTUAL
                              from ZAY_SALE_TYPES 
                             order by TP_ID";
            var parameters = new object[]
           {
                new OracleParameter("nDocAmnt", OracleDbType.Decimal, AMNT, ParameterDirection.Input)
           };
            return _entities.ExecuteStoreQuery<V_ZAY_SPLIT_AMOUNT>(query, parameters).ToList();
        }
        public IList<V_ZAY_SPLIT_AMOUNT> GetSplitSum(_Spliter _data)
        {
            
            string query = @"select sa.ID, sa.SALE_TP, t.TP_NM, sa.AMNT/100 as AMNT, 1 as VIRTUAL
                               from BARS.ZAY_SPLITTING_AMOUNT sa
                                  , ZAY_SALE_TYPES t
                              where t.TP_ID = sa.SALE_TP
                                and REF = :nREF";
            var parameters = new object[]
            {
                new OracleParameter("nRef", OracleDbType.Decimal, _data.nRef, ParameterDirection.Input)
            };
            var result = _entities.ExecuteStoreQuery<V_ZAY_SPLIT_AMOUNT>(query, parameters).ToList().Count() > 0 ? _entities.ExecuteStoreQuery<V_ZAY_SPLIT_AMOUNT>(query, parameters).ToList() : GetDefaultSpliter(_data.AMNT);

            return result;
        }

        public void SaveSplitSettings(V_ZAY_SPLIT_AMOUNT _data, decimal nREF)
        {
            string query = @"bars_zay.set_amount";
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand(query, connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_id", OracleDbType.Decimal, _data.ID, ParameterDirection.Input);
                command.Parameters.Add("p_ref", OracleDbType.Decimal, nREF, ParameterDirection.Input);
                command.Parameters.Add("p_sale_tp", OracleDbType.Decimal, _data.TP_ID, ParameterDirection.Input);
                command.Parameters.Add("p_amnt", OracleDbType.Decimal, _data.AMNT*100, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }

        }
        public void DeleteSetting(decimal ID)
        {
            string query = @"bars_zay.del_amount";
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand(query, connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_id", OracleDbType.Decimal, ID, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }

        }
        
    }
}