using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Areas.Zay.Models;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation
{
    public class CurrencyDictionary : ICurrencyDictionary
    {
        private readonly ZayModel _entities;
        public CurrencyDictionary()
        {
            var connectionStr = EntitiesConnection.ConnectionString("ZayModel", "Zay");
            _entities = new ZayModel(connectionStr);
        }

        public IEnumerable<ZAY_AIMS> ZayAimsDictionary(bool isBuying)
        {
            string param = isBuying ? "1" : "2"; // 1 - купівля, 2 - продаж
            string query = @"select za.AIM AIM_CODE, za.DESCRIPTION DESCRIPTION, 
                za.DESCRIPTION_ENG DESCRIPTION_ENG, za.NAME AIM_NAME, za.TYPE TYPE from ZAY_AIMS za where za.TYPE="+param;
            return _entities.ExecuteStoreQuery<ZAY_AIMS>(query);
        }

        public IEnumerable<ZAY_BuyContract> ContractDictionary(decimal rnk)
        {
            string query = @"select distinct contr_id as CONTRACT_ID, num as CONTRACT_NUMBER, open_date as CONTRACT_DATE from V_CIM_ALL_CONTRACTS where rnk= :RNK";
            var param = new object[]
            {
                new OracleParameter("RNK", OracleDbType.Decimal, rnk, ParameterDirection.Input),
            };

            return _entities.ExecuteStoreQuery<ZAY_BuyContract>(query, param);
        }

        public IEnumerable<F092Model> F092Dictionary()
        {
            var query = @"select f092 as F092_Code, txt as F092_Name from f092";
            return _entities.ExecuteStoreQuery<F092Model>(query);
        }

        public IEnumerable<Country> CountryDictionary()
        {
            const string query = @"select lpad(to_char(c.country), 3, '0') as COUNTRY_CODE, c.NAME as COUNTRY_NAME from COUNTRY c ORDER BY TO_NUMBER(COUNTRY_CODE) asc";
            return _entities.ExecuteStoreQuery<Country>(query);
        }

        public IEnumerable<v_rc_bnk> RcBankDictionary()
        {
            const string query = @"select lpad(rc.b010, 10, '0') BANK_CODE, rc.NAME BANK_NAME from V_RC_BNK rc";
            return _entities.ExecuteStoreQuery<v_rc_bnk>(query);
        }

        public IEnumerable<v_kod_70_2> Kod70_2Dictionary()
        {
            const string query = @"select * from V_KOD_70_2";
            return _entities.ExecuteStoreQuery<v_kod_70_2>(query);
        }

        public IEnumerable<v_kod_70_4> Kod70_4Dictionary()
        {
            const string query = @"select k.P70 PRODUCT_GROUP, k.TXT PRODUCT_GROUP_NAME from V_KOD_70_4 k";
            return _entities.ExecuteStoreQuery<v_kod_70_4>(query);
        }
        public IEnumerable<ZAY_BACK> ReasonDictionary()
        {
            const string query = @"select * from ZAY_BACK order by id";
            return _entities.ExecuteStoreQuery<ZAY_BACK>(query);
        }
        public IEnumerable<v_kod_d3_1> AimDescriptionDictionary()
        {
            const string query = @"select * from V_KOD_D3_1";
            return _entities.ExecuteStoreQuery<v_kod_d3_1>(query);
        }
        public IEnumerable<ZAY_PRIORITY> PrioritysDictionary()
        {
            const string query = @"select * from zay_priority";
            return _entities.ExecuteStoreQuery<ZAY_PRIORITY>(query);
        }
        public IEnumerable<ZAY_CLOSE_TYPES> CloseTypes()
        {
            const string query = @"select zct.id CLOSE_TYPE, zct.name CLOSE_TYPE_NAME from ZAY_CLOSE_TYPES zct";
            return _entities.ExecuteStoreQuery<ZAY_CLOSE_TYPES>(query);
        }
        public IEnumerable<V_P12_2C> OperMarkDictionary()
        {
            const string query = @"select p.CODE, p.TXT from V_P12_2C p";
            return _entities.ExecuteStoreQuery<V_P12_2C>(query);
        }
        public IEnumerable<V_P_L_2C> CodeImportDictionary()
        {
            const string query = @"select p.ID, p.NAME from V_P_L_2C p";
            return _entities.ExecuteStoreQuery<V_P_L_2C>(query);
        }
        public IEnumerable<CurrencyPair> CurrencyPairsDictionary()
        {
            const string query = @"
                select z.kv1 kv_f, t1.name name_f, z.kv2 kv_s, t2.name name_s, z.kv_base 
                from ZAY_CONV_KV z, tabval t1, tabval t2 
                where z.kv1 = t1.kv and z.kv2 = t2.kv";
            return _entities.ExecuteStoreQuery<CurrencyPair>(query);
        }

        public IEnumerable<Kurs> KursDictionary()
        {
            const string query = @"
                  SELECT T.KV kv, T.LCV || ' ' || T.NAME name
                    FROM TABVAL T, TABVAL_SORT S
                   WHERE     T.KV <> getglobaloption ('BASEVAL')
                         AND T.KV = S.KV(+)
                         AND S.USER_ID(+) = bars.user_id
                ORDER BY S.SORT_ORD, T.KV    
            ";
            return _entities.ExecuteStoreQuery<Kurs>(query);
        }

        public DilerIndCurrentRate DilerIndRate(decimal kv)
        {
            const string query = @"
                  SELECT kurs_b kursB, kurs_s kursS, vip_b vipB, vip_s vipS, blk  
                FROM diler_kurs
                WHERE kv=:dfKV AND dat = (SELECT max(dat) FROM diler_kurs 
               WHERE kv=:dfKV2 AND trunc(dat)=trunc(sysdate))
            ";
            var param = new object[]
            {
                new OracleParameter("dfKV", OracleDbType.Decimal, kv, ParameterDirection.Input),
                new OracleParameter("dfKV2", OracleDbType.Decimal, kv, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<DilerIndCurrentRate>(query, param).SingleOrDefault();
        }

        public DilerFactCurrentRate DilerFactRate(decimal kv)
        {
            const string query = @"
                  SELECT kurs_b kursB, kurs_s kursS
                FROM diler_kurs_fact
                WHERE kv=:dfKV AND dat = (SELECT max(dat) FROM diler_kurs_fact
               WHERE kv=:dfKV2 AND trunc(dat)=trunc(sysdate)) 
            ";
            var param = new object[]
            {
                new OracleParameter("dfKV", OracleDbType.Decimal, kv, ParameterDirection.Input),
                new OracleParameter("dfKV2", OracleDbType.Decimal, kv, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<DilerFactCurrentRate>(query, param).SingleOrDefault();
        }


        public decimal? DilerConversionRate(decimal id, decimal kvF, decimal kvS)
        {
            var query = string.Format(@"
                select {0}
                from diler_kurs_conv
                where kv1 = :nKv1 and kv2 = :nKv2 and dat = trunc(sysdate)", id == 1 ? "kurs_i" : "kurs_f");
            var param = new object[]
            {
                new OracleParameter("nKv1", OracleDbType.Decimal, kvF, ParameterDirection.Input),
                new OracleParameter("nKv2", OracleDbType.Decimal, kvS, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<decimal>(query, param).SingleOrDefault();
        }


        public IEnumerable<VizaStatus> VizaStatusData(decimal id)
        {
            const string query = @"
                select id ID, track_id TrackId, change_time ChangeTime, fio FIO, viza Viza, status_name StatusName  
                from v_zay_track_full where id = :nID
                union all
                select id ID, track_id TrackId, change_time ChangeTime, fio FIO, viza Viza, status_name StatusName
                from v_zay_track_full  where id in (select unique id_prev from (select * from v_zay_track_full where id = :nID) where id_prev is not null)
                order by TrackId
            ";
            var param = new object[]
            {
                new OracleParameter("nID", OracleDbType.Decimal, id, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<VizaStatus>(query, param);
        }
    }
}