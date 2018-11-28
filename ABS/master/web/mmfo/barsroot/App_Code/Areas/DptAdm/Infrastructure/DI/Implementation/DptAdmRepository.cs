using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using Areas.DptAdm.Models;
using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DptAdm.Models;
using Areas.DptAdm.Models;
using BarsWeb.Models;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.IO;
using System.Web.Mvc;

namespace BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Implementation
{
    public class DptAdmRepository : IDptAdmRepository
    {  // объявление DptAdmEntities
        private readonly DptAdmEntities _entities;
        public DptAdmRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("DptAdm", "DptAdm");
            _entities = new DptAdmEntities(connectionStr);
        }

        /// Отбираем типы договоров ДПТ         
        public List<DPT_TYPES> GetDptType()
        {
            return _entities.DPT_TYPES.ToList();
        }
        public IQueryable<pipe_DPT_TYPES> GetDptTypeLst()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_TYPE_SETS)";
            return _entities.ExecuteStoreQuery<pipe_DPT_TYPES>(query).AsQueryable();
        }
        public IQueryable<pipe_DPT_TYPES> GetDptTypeInfo(decimal TYPE_ID)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_TYPE_SETS) where type_id = :p_type_id";
            var parameters = new object[] { 
                new OracleParameter("p_type_id", OracleDbType.Decimal) { Value = TYPE_ID}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_TYPES>(query, parameters).AsQueryable();
        }
        /// Отбираем виды договоров ДПТ по типу
        public IQueryable<pipe_DPT_VIDD_SHORT> GetDptVidd(decimal? TYPE_ID)
        {
            if (TYPE_ID == null) { TYPE_ID = 0; }
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_VIDD_SETS(:p_type_id))";
            var parameters = new object[] { 
                new OracleParameter("p_type_id", OracleDbType.Decimal) { Value = TYPE_ID}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_SHORT>(query, parameters).AsQueryable();
        }
        public IQueryable<pipe_DPT_VIDD_INFO> GetDptViddINFOALL(decimal VIDD)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_VIDD_INFO(:p_vidd))";
            var parameters = new object[] { 
                new OracleParameter("p_vidd", OracleDbType.Decimal) { Value = VIDD}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_INFO>(query, parameters).AsQueryable();
        }
        public IQueryable<pipe_DPT_JOBS> GetDptJobs()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_JOBS)";
            return _entities.ExecuteStoreQuery<pipe_DPT_JOBS>(query).AsQueryable();
        }
        public IQueryable<pipe_DPT_VIDD_SHORT> GetDptViddInfo(decimal VIDD)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_VIDD_INFO(:p_vidd))";
            var parameters = new object[] { 
                new OracleParameter("p_vidd", OracleDbType.Decimal) { Value = VIDD}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_SHORT>(query, parameters).AsQueryable();
        }
        public IQueryable<pipe_KV> GetKV()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_KV)";
            return _entities.ExecuteStoreQuery<pipe_KV>(query).AsQueryable();
        }
        public IQueryable<pipe_BSD> GetBSD()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_BSD)";
            return _entities.ExecuteStoreQuery<pipe_BSD>(query).AsQueryable();
        }
        public IQueryable<pipe_BSN> GetBSN(string BSD)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_BSN(:p_BSD))";
            var parameters = new object[] { 
                new OracleParameter("p_BSD", OracleDbType.Decimal) { Value = BSD}
            };
            return _entities.ExecuteStoreQuery<pipe_BSN>(query, parameters).AsQueryable();
        }
        public IQueryable<pipe_BSA> GetBSA(string BSD, string Avans)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_BSA(:p_BSD, :p_flag))";
            var parameters = new object[] { 
                new OracleParameter("p_BSD", OracleDbType.Decimal) { Value = BSD},
                new OracleParameter("p_flag", OracleDbType.Decimal) { Value = Avans}
            };
            return _entities.ExecuteStoreQuery<pipe_BSA>(query, parameters).AsQueryable();
        }
        public IQueryable<pipe_BASEY> GetBASEY()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_BASEY)";
            return _entities.ExecuteStoreQuery<pipe_BASEY>(query).AsQueryable();
        }
        public IQueryable<pipe_FREQ> GetFREQ()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_FREQ)";
            return _entities.ExecuteStoreQuery<pipe_FREQ>(query).AsQueryable();
        }
        public IQueryable<pipe_METR> GetMETR()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_METR)";
            return _entities.ExecuteStoreQuery<pipe_METR>(query).AsQueryable();
        }
        public IQueryable<pipe_ION> GetION()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_ION)";
            return _entities.ExecuteStoreQuery<pipe_ION>(query).AsQueryable();
        }
        public IQueryable<pipe_BRATES> GetBRATES()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_BRATES)";
            return _entities.ExecuteStoreQuery<pipe_BRATES>(query).AsQueryable();
        }
        public IQueryable<pipe_DPT_STOP> GetDPT_STOP()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_STOP)";
            return _entities.ExecuteStoreQuery<pipe_DPT_STOP>(query).AsQueryable();
        }
        public IQueryable<pipe_DPT_VIDD_EXTYPES> GetDPT_VIDD_EXTYPES()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPT_VIDD_EXTYPES)";
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_EXTYPES>(query).AsQueryable();
        }
        public IQueryable<pipe_TARIF> GetTARIF()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_TARIF)";
            return _entities.ExecuteStoreQuery<pipe_TARIF>(query).AsQueryable();
        }
        public DPT_RESULT saveVidd(pipe_DPT_VIDD_INFO UpdateVidd)
        {
            DPT_RESULT p_result = new DPT_RESULT();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_VIDD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.VIDD},
                        new OracleParameter("p_TYPE_COD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TYPE_COD},
                        new OracleParameter("p_TYPE_NAME", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TYPE_NAME},
                        new OracleParameter("p_BASEY", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BASEY},
                        new OracleParameter("p_BASEM", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BASEM},
                        new OracleParameter("p_BR_ID", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BR_ID},
                        new OracleParameter("p_FREQ_N", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.FREQ_N},
                        new OracleParameter("p_FREQ_K", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.FREQ_K},
                        new OracleParameter("p_BSD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BSD},
                        new OracleParameter("p_BSN", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BSN},
                        new OracleParameter("p_METR", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.METR},
                        new OracleParameter("p_AMR_METR", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.AMR_METR},
                        new OracleParameter("p_DURATION", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DURATION},
                        new OracleParameter("p_TERM_TYPE", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TERM_TYPE},
                        new OracleParameter("p_MIN_SUMM", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.MIN_SUMM},
                        new OracleParameter("p_COMMENTS", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.COMMENTS},
                        new OracleParameter("p_DEPOSIT_COD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DEPOSIT_COD},                                                
                        new OracleParameter("p_KV", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.KV	},
                        new OracleParameter("p_TT", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TT	},
                        new OracleParameter("p_SHABLON", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.SHABLON	},
                        new OracleParameter("p_IDG", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.IDG	},
                        new OracleParameter("p_IDS", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.IDS	},
                        new OracleParameter("p_NLS_K", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.NLS_K	},
                        new OracleParameter("p_DATN", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DATN	},
                        new OracleParameter("p_DATK", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DATK	},
                        new OracleParameter("p_BR_ID_L", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BR_ID_L	},
                        new OracleParameter("p_FL_DUBL", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.FL_DUBL	},
                        new OracleParameter("p_ACC7", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.ACC7	},
                        new OracleParameter("p_ID_STOP", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.ID_STOP	},
                        new OracleParameter("p_KODZ", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.KODZ	},
                        new OracleParameter("p_FMT", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.FMT	},
                        new OracleParameter("p_FL_2620", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.FL_2620	},
                        new OracleParameter("p_COMPROC", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.COMPROC	},
                        new OracleParameter("p_LIMIT", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.LIMIT	},
                        new OracleParameter("p_TERM_ADD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TERM_ADD	},
                        new OracleParameter("p_TERM_DUBL", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TERM_DUBL	},
                        new OracleParameter("p_DURATION_DAYS", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DURATION_DAYS	},
                        new OracleParameter("p_EXTENSION_ID", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.EXTENSION_ID	},
                        new OracleParameter("p_TIP_OST", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TIP_OST	},
                        new OracleParameter("p_BR_WD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BR_WD	},
                        new OracleParameter("p_NLSN_K", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.NLSN_K	},
                        new OracleParameter("p_BSA", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BSA},
                        new OracleParameter("p_MAX_LIMIT", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.MAX_LIMIT},
                        new OracleParameter("p_BR_BONUS", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BR_BONUS},
                        new OracleParameter("p_BR_OP", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.BR_OP},
                        new OracleParameter("p_AUTO_ADD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.AUTO_ADD},
                        new OracleParameter("p_TYPE_ID", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.TYPE_ID},
                        new OracleParameter("p_DISABLE_ADD", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DISABLE_ADD},
                        new OracleParameter("p_CODE_TARIFF", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.CODE_TARIFF},
                        new OracleParameter("p_DURATION_MAX", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DURATION_MAX},
                        new OracleParameter("p_DURATION_DAYS_MAX", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.DURATION_DAYS_MAX},
                        new OracleParameter("p_IRREVOCABLE", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateVidd.IRREVOCABLE},
                        new OracleParameter("p_resultcode", OracleDbType.Decimal) {Direction = System.Data.ParameterDirection.Output},
                        new OracleParameter("p_resultmessage", OracleDbType.Varchar2) {Direction = System.Data.ParameterDirection.Output, Size=4000 }
                    };
            _entities.ExecuteStoreQuery<object>(@"begin dpt_adm.saveVidd(" +
                  ":p_VIDD,         :p_TYPE_COD,    :p_TYPE_NAME,           :p_BASEY,       :p_BASEM,       :p_BR_ID, " +
                  ":p_FREQ_N,       :p_FREQ_K,      :p_BSD,                 :p_BSN,         :p_METR,        :p_AMR_METR,  " +
                  ":p_DURATION,     :p_TERM_TYPE,   :p_MIN_SUMM,            :p_COMMENTS,    :p_DEPOSIT_COD, :p_KV," +
                  ":p_TT,           :p_SHABLON,     :p_IDG,                 :p_IDS,         :p_NLS_K,       :p_DATN, " +
                  ":p_DATK,         :p_BR_ID_L,     :p_FL_DUBL,             :p_ACC7,        :p_ID_STOP,     :p_KODZ, " +
                  ":p_FMT,          :p_FL_2620,     :p_COMPROC,             :p_LIMIT,       :p_TERM_ADD,    :p_TERM_DUBL," +
                  ":p_DURATION_DAYS,:p_EXTENSION_ID,:p_TIP_OST,             :p_BR_WD,       :p_NLSN_K,      :p_BSA," +
                  ":p_MAX_LIMIT,    :p_BR_BONUS,    :p_BR_OP,               :p_AUTO_ADD,    :p_TYPE_ID,     :p_DISABLE_ADD, " +
                  ":p_CODE_TARIFF,  :p_DURATION_MAX,:p_DURATION_DAYS_MAX,   :p_IRREVOCABLE, :p_resultcode,  :p_resultmessage" +
                  "); end;", sqlParams).ToList();
            p_result.res = ((OracleDecimal)((OracleParameter)sqlParams[52]).Value);
            p_result.mess = Convert.ToString((OracleString)((OracleParameter)sqlParams[53]).Value);            
            return p_result;
        }
        public int ShiftPriority(decimal Type_id, decimal direction)
        {
            var sqlParams = new object[]
                    {new OracleParameter("p_TYPE_ID", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = Type_id},
                     new OracleParameter("p_direction", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = direction}};

            _entities.ExecuteStoreCommand("begin dpt_adm.shift(:p_TYPE_ID, :p_direction); end;", sqlParams);
            return 1;
        }
        public int ActivateType(decimal Type_id)
        {
            var sqlParams = new object[] { new OracleParameter("p_TYPE_ID", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = Type_id } };

            _entities.ExecuteStoreCommand("begin dpt_adm.ActivateType(:p_TYPE_ID); end;", sqlParams);
            return 1;
        }
        public int setWBType(decimal Type_id)
        {
            var sqlParams = new object[] { new OracleParameter("p_TYPE_ID", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = Type_id } };

            _entities.ExecuteStoreCommand("begin dpt_adm.setWBType(:p_TYPE_ID); end;", sqlParams);
            return 1;
        }
        public int ActivateVidd(decimal Vidd)
        {
            var sqlParams = new object[] { new OracleParameter("p_Vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = Vidd } };

            _entities.ExecuteStoreCommand("begin dpt_adm.ActivateVidd(:p_Vidd); end;", sqlParams);
            return 1;
        }
        public int ActivateDOC(decimal VIDD, int FLG, string DOC, string DOC_FR)
        {
            if (DOC_FR == null) { DOC_FR = ""; }
            if (DOC == null) { DOC = ""; }
            var sqlParams = new object[] { new OracleParameter("p_Vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = VIDD },
                                           new OracleParameter("p_FLG", OracleDbType.Int32, System.Data.ParameterDirection.Input) { Value = FLG },
                                           new OracleParameter("p_DOC", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = DOC },
                                           new OracleParameter("p_DOC_FR", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = DOC_FR }
            };

            _entities.ExecuteStoreCommand("begin dpt_adm.AddDOC(:p_Vidd, :p_FLG, :p_DOC, :p_DOC_FR); end;", sqlParams);
            return 1;

        }
        public IQueryable<pipe_ACTIVE> GetActive() {
            const string query = @"select 1 id, 'Активний' name from dual union select 0 id, 'Не активний' name from dual";
            return _entities.ExecuteStoreQuery<pipe_ACTIVE>(query).AsQueryable();
            
        }
        public DPT_RESULT saveTYPE(pipe_DPT_TYPES UpdateType)
        {
            DPT_RESULT p_result = new DPT_RESULT();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_type_id", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = UpdateType.TYPE_ID},
                        new OracleParameter("p_type_name", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateType.TYPE_NAME},
                        new OracleParameter("p_type_code", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = UpdateType.TYPE_CODE},
                        new OracleParameter("p_fl_act", OracleDbType.Int16, System.Data.ParameterDirection.Input){Value = UpdateType.FL_ACT},                        
                        new OracleParameter("p_fl_dem", OracleDbType.Int16, System.Data.ParameterDirection.Input){Value = UpdateType.FL_DEM},
                        new OracleParameter("p_fl_wb", OracleDbType.Int16, System.Data.ParameterDirection.Input){Value = UpdateType.FL_WEBBANKING},
                        new OracleParameter("p_sort_ord", OracleDbType.Int16, System.Data.ParameterDirection.Input){Value = UpdateType.SORT_ORD},
                        new OracleParameter("p_resultcode", OracleDbType.Decimal) {Direction = System.Data.ParameterDirection.Output},                        
                        new OracleParameter("p_resulmessage", OracleDbType.Varchar2) {Direction = System.Data.ParameterDirection.Output, Size=4000 }
                    };
            _entities.ExecuteStoreQuery<object>(@"begin dpt_adm.saveType(:p_type_id, :p_type_name, :p_type_code, :p_fl_act, :p_fl_dem, :p_fl_wb, :p_sort_ord, :p_resultcode, :p_resulmessage);  end;", sqlParams).ToList();
            p_result.res = ((OracleDecimal)((OracleParameter)sqlParams[7]).Value);            
            p_result.mess= Convert.ToString((OracleString)((OracleParameter)sqlParams[8]).Value);            
            return p_result;
        }
        public IQueryable<pipe_DPT_VIDD_TTS> GetViddTTS(decimal VIDD)
        {
            var sqlParams = new object[] { new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = VIDD } };
            const string query = @"select * from table(BARS.DPT_ADM.get_ViddTTS(:p_vidd))";
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_TTS>(query,sqlParams).AsQueryable();
        }
        public IQueryable<pipe_DPT_VIDD_DOC> GetViddDOC(decimal VIDD)
        {
            var sqlParams = new object[] { new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = VIDD } };
            const string query = @"select * from table(BARS.DPT_ADM.get_ViddDOC(:p_vidd))";
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_DOC>(query, sqlParams).AsQueryable();
        }
        public IQueryable<pipe_DPT_VIDD_TTS> GetAvaliableTTS(decimal VIDD)
        {
            var sqlParams = new object[] { new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = VIDD } };
            const string query = @"select * from table(BARS.DPT_ADM.get_AvaliableTTS(:p_vidd))";
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_TTS>(query, sqlParams).AsQueryable();
        }
        public IQueryable<pipe_DPT_VIDD_DOC> GetAvaliableFLG(decimal VIDD)
        {
            var sqlParams = new object[] { new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = VIDD } };
            const string query = @"select * from table(BARS.DPT_ADM.get_AvaliableFLG(:p_vidd))";
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_DOC>(query, sqlParams).AsQueryable();
        }
        public IQueryable<pipe_DPT_DOC_SCHEME> GetDocScheme(int FR)
        {
            var sqlParams = new object[] { new OracleParameter("p_fr", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = FR } };
            const string query = @"select * from table(BARS.DPT_ADM.get_ViddDOCSCHEME(:p_fr))";
            return _entities.ExecuteStoreQuery<pipe_DPT_DOC_SCHEME>(query, sqlParams).AsQueryable();
        }     
        public int AddTTS(decimal Vidd, string OP_TYPE)
        {
            int p_result = 0;
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =Vidd},
                        new OracleParameter("p_tts", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =OP_TYPE}
                    };
            _entities.ExecuteStoreCommand("begin dpt_adm.AddTTS(:p_vidd, :p_tts);  end;", sqlParams);

            return p_result;
        }
        public int AddDoc(decimal VIDD, int FLG, string DOC, string DOC_FR)
        {
            int p_result = 0;
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =VIDD},
                        new OracleParameter("p_flg", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =FLG},
                        new OracleParameter("p_doc", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =DOC},
                        new OracleParameter("p_doc_fr", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =DOC_FR},
                    };
            _entities.ExecuteStoreCommand("begin dpt_adm.AddDOC(:p_vidd, :p_flg, :p_doc, :p_doc_fr);  end;", sqlParams);

            return p_result;
        }
        public int AddDoc2Type(decimal TYPE_ID, int FLG, string DOC, string DOC_FR)
        {
            int p_result = 0;
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_type", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =TYPE_ID},
                        new OracleParameter("p_flg", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =FLG},
                        new OracleParameter("p_doc", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =DOC},
                        new OracleParameter("p_doc_fr", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =DOC_FR},
                    };
            _entities.ExecuteStoreCommand("begin dpt_adm.AddDOC2Type(:p_type, :p_flg, :p_doc, :p_doc_fr);  end;", sqlParams);

            return p_result;
        }
        public int AddDoc2Vidd(decimal VIDD, int FLG, string DOC, string DOC_FR)
        {
            int p_result = 0;
            if (DOC == null) { DOC = ""; }
            if (DOC_FR == null) { DOC_FR = ""; }
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =VIDD},
                        new OracleParameter("p_flg", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =FLG},
                        new OracleParameter("p_doc", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =DOC},
                        new OracleParameter("p_doc_fr", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =DOC_FR},
                    };
            _entities.ExecuteStoreCommand("begin dpt_adm.AddDOC2Vidd(:p_vidd, :p_flg, :p_doc, :p_doc_fr);  end;", sqlParams);

            return p_result;
        }
        public IQueryable<pipe_DPT_VIDD_LIST> GetVidd()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_VIDDLIST)";
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_LIST>(query).AsQueryable();
        }
        public IQueryable<pipe_DPT_BRANCH_LIST> GetBranchList()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_BRANCHLIST)";
            return _entities.ExecuteStoreQuery<pipe_DPT_BRANCH_LIST>(query).AsQueryable();
        }
        public IQueryable<pipe_DPT_ARCH> GetDptArchive(System.DateTime? cdat, decimal? VIDD, string BRANCH)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DPTARC(:p_date, :p_vidd, :p_branch))";
            var parameters = new object[] { 
                new OracleParameter("p_date", OracleDbType.Date) { Value = cdat},
                new OracleParameter("p_vidd", OracleDbType.Decimal) { Value = VIDD},
                new OracleParameter("p_branch", OracleDbType.Varchar2) { Value = BRANCH}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_ARCH>(query, parameters).AsQueryable();
        }
        public DPT_RESULT DeleteType(decimal TYPE_ID)
        {
            DPT_RESULT p_result = new DPT_RESULT();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_type_id", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =TYPE_ID},
                        new OracleParameter("p_resultcode", OracleDbType.Decimal) {Direction = System.Data.ParameterDirection.Output},
                        new OracleParameter("p_resultmessage", OracleDbType.Varchar2) {Direction = System.Data.ParameterDirection.Output, Size=4000 }
                    };
            _entities.ExecuteStoreQuery<object>(@"begin dpt_adm.deleteType(:p_type_id, :p_resultcode, :p_resultmessage);  end;", sqlParams).ToList();
            p_result.res = ((OracleDecimal)((OracleParameter)sqlParams[1]).Value);
            p_result.mess = Convert.ToString((OracleString)((OracleParameter)sqlParams[2]).Value);            
            return p_result;
        }  
        public DPT_RESULT DeleteVidd(decimal VIDD)
        {
            DPT_RESULT p_result = new DPT_RESULT();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =VIDD},
                        new OracleParameter("p_resultcode", OracleDbType.Decimal) {Direction = System.Data.ParameterDirection.Output},
                        new OracleParameter("p_resultmessage", OracleDbType.Varchar2) {Direction = System.Data.ParameterDirection.Output, Size=4000 }
                    };
            _entities.ExecuteStoreQuery<object>(@"begin dpt_adm.deleteVidd(:p_vidd, :p_resultcode, :p_resultmessage);  end;", sqlParams).ToList();
            p_result.res = ((OracleDecimal)((OracleParameter)sqlParams[1]).Value);
            p_result.mess = Convert.ToString((OracleString)((OracleParameter)sqlParams[2]).Value);
            return p_result;
        }
        public void DoJob(string JOB_CODE, int JOB_MODE)
        {
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_jobcode", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =JOB_CODE},
                        new OracleParameter("p_jobmode", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =JOB_MODE}
                    };
            _entities.ExecuteStoreCommand("begin bars.dpt_execute_job(:p_jobcode, :p_jobmode);  end;", sqlParams);
        }
        public void DoJobCode(string JOB_CODE)
        {
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_jobcode", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =JOB_CODE},
                        new OracleParameter("p_jobmode", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =null}
                    };
            _entities.ExecuteStoreCommand("begin bars.dpt_execute_job(:p_jobcode, :p_jobmode);  end;", sqlParams);
        }
        public int GetNextTypeId()
        {
            const string query = @"select max(type_id)+1 from dpt_types";
            return _entities.ExecuteStoreQuery<int>(query).FirstOrDefault();
        }
        public int GetNextVidd()
        {
            const string query = @"select max(vidd)+1 from dpt_vidd";
            return _entities.ExecuteStoreQuery<int>(query).FirstOrDefault();
        }
        public IQueryable<pipe_DPT_VIDD_PARAMS> GetDptViddParam(decimal VIDD)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_viddparam(:p_vidd))";
            var parameters = new object[] {                 
                new OracleParameter("p_vidd", OracleDbType.Decimal) { Value = VIDD}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_PARAMS>(query, parameters).AsQueryable();
        }
        public void PutParam(decimal vidd, string tag, string val)
        {            
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =vidd},
                        new OracleParameter("p_tag", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =tag},
                        new OracleParameter("p_val", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =val},
                    };
            _entities.ExecuteStoreCommand("begin dpt_adm.SetParam(:p_vidd, :p_tag, :p_val);  end;", sqlParams);            
        }
        public IQueryable<pipe_DICTS> GetDictList()
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DICTS)";
            return _entities.ExecuteStoreQuery<pipe_DICTS>(query).AsQueryable();
        }
        public IQueryable<pipe_DPT_VIDD_DOC> GetDptTypeDocs(int TYPE_ID)
        {
            const string query = @"select * from table(BARS.DPT_ADM.get_DOCSCHEME(:p_type))";
            var parameters = new object[] {                 
                new OracleParameter("p_type", OracleDbType.Decimal) { Value = TYPE_ID}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_VIDD_DOC>(query, parameters).AsQueryable();        
        }
        public int ClearDoc2Vidd(decimal VIDD, int FLG) {
            int p_result = 0;
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_vidd", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =VIDD},
                        new OracleParameter("p_flg", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =FLG}                        
                    };
            _entities.ExecuteStoreCommand("begin dpt_adm.ClearDOC2Vidd(:p_vidd, :p_flg);  end;", sqlParams);

            return p_result;
        }
        public int ClearDoc2Type(decimal TYPE_ID, int FLG) {
            int p_result = 0;
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_type", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value =TYPE_ID},
                        new OracleParameter("p_flg", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =FLG}                        
                    };
            _entities.ExecuteStoreCommand("begin dpt_adm.ClearDOC2Type(:p_type, :p_flg);  end;", sqlParams);

            return p_result;
        }
        public IQueryable<pipe_DPT_JOBS_JRNL> GetDptJobsJrnl(int JOB_ID)
        {
            const string query = @"select * from table(dpt_adm.get_dptjobjrnl(:p_job_id))";
            var parameters = new object[] {
                new OracleParameter("p_job_id", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = JOB_ID}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_JOBS_JRNL>(query, parameters).AsQueryable();
        }
        public IQueryable<pipe_DPT_JOBS_LOG> GetDptJobsBlog(int Run_ID)
        {
            const string query = @"select * from table(dpt_adm.get_dptjoblog(:p_run_id))";
            var parameters = new object[] {
                new OracleParameter("p_run_id", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = Run_ID}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_JOBS_LOG>(query, parameters).AsQueryable();
        }
        public Tuple<MemoryStream, string> DptBratesExport(string date)
        {
            DPT_RESULT p_result = new DPT_RESULT();

            var sqlParamsName = new object[]
                    {
                        new OracleParameter("p_date", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value =date}
                    };

            string sql = @"select BARS.DPT_BRATES_EXPORT(:p_date) from dual";
            var res = _entities.ExecuteStoreQuery<string>(sql, sqlParamsName).Single();
            
            var sqlParamsStream = new object[]
                    {
                        new OracleParameter("p_fname", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = res}
                    };
            sql = @"select file_clob from imp_file where file_name = :p_fname";
            var resData = _entities.ExecuteStoreQuery<string>(sql, sqlParamsStream).Single();
            var file = new MemoryStream(Encoding.UTF8.GetBytes(resData ?? ""));

            return Tuple.Create(file, res); 
                
        }
        public IQueryable<pipe_DPT_DEPOSIT> GetDepostiStartAndEndDates(long depositId)
        {
            const string query = @"select dat_begin, dat_end from dpt_deposit where deposit_id = :p_deposit_id";
            var parameters = new object[] {
                new OracleParameter("p_deposit_id", OracleDbType.Long, System.Data.ParameterDirection.Input) { Value = depositId}
            };
            return _entities.ExecuteStoreQuery<pipe_DPT_DEPOSIT>(query, parameters).AsQueryable();
        }
        public void PutTermDepCorrForm(long depositNm, DateTime depositStartDt, DateTime depositEndDt, DateTime newDepositStartDt, DateTime newDepositEndDt, int prolongationNm)
        {
            
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_deposit_id", OracleDbType.Long, System.Data.ParameterDirection.Input){Value = depositNm},
                        new OracleParameter("DAT_BEGIN_OLD", OracleDbType.Date, System.Data.ParameterDirection.Input){Value = depositStartDt},
                        new OracleParameter("DAT_END_OLD", OracleDbType.Date, System.Data.ParameterDirection.Input){Value = depositEndDt},
                        new OracleParameter("DAT_BEGIN_NEW", OracleDbType.Date, System.Data.ParameterDirection.Input){Value = newDepositStartDt},
                        new OracleParameter("DAT_END_NEW", OracleDbType.Date, System.Data.ParameterDirection.Input){Value = newDepositEndDt},
                        new OracleParameter("CNTDUBL", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = prolongationNm}
                    };
            _entities.ExecuteStoreCommand("begin dpt.correct_deposit_term (:p_deposit_id, :DAT_BEGIN_OLD, :DAT_END_OLD, :DAT_BEGIN_NEW, :DAT_END_NEW, :CNTDUBL); end;", sqlParams);

        }
        public void PutReportForPnFondFormToDb (int repPeriodNum, DateTime repDt)
        {

            var sqlParams = new object[]
                    {
                        new OracleParameter("Param0", OracleDbType.Date, System.Data.ParameterDirection.Input){Value = repDt},
                        new OracleParameter("Param1", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = repPeriodNum}
                    };
            _entities.ExecuteStoreCommand("begin PF_NOT_PAY(:Param0,:Param1); end;", sqlParams);

        }        
        public string GetRateDate(decimal br_id, int kv) {
            var sqlParamsBefore = new object[]
                 {                       
                        new OracleParameter("nBR", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = br_id}
                 };
            const string querybefore = @"SELECT br_type FROM brates WHERE br_id = :nBR";
            int brtype = _entities.ExecuteStoreQuery<int>(querybefore, sqlParamsBefore).FirstOrDefault();
            if (brtype == 1)
            {
                var sqlParams = new object[]
                     {
                        new OracleParameter("nKV", OracleDbType.Int16, System.Data.ParameterDirection.Input){Value = kv},
                        new OracleParameter("nBR", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = br_id}
                     };
                const string query = @"SELECT to_char(max(BDATE),'dd/mm/yyyy') FROM br_normal WHERE bdate <= bankdate AND kv = :nKV AND br_id = :nBR";
                return _entities.ExecuteStoreQuery<string>(query, sqlParams).FirstOrDefault();
            }
            else { return null; }

        }
        public decimal? GetRate(decimal br_id, int kv)
        {
            var sqlParamsBefore = new object[]
               {
                        new OracleParameter("nBR", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = br_id}
               };
            const string querybefore = @"SELECT br_type FROM brates WHERE br_id = :nBR";
            int brtype = _entities.ExecuteStoreQuery<int>(querybefore, sqlParamsBefore).FirstOrDefault();
            if (brtype == 1)
            {
                
                string dat_brat = GetRateDate(br_id, kv);
                var sqlParams = new object[]
                        {
                        new OracleParameter("nKV", OracleDbType.Int16, System.Data.ParameterDirection.Input){Value = kv},
                        new OracleParameter("nBR", OracleDbType.Decimal, System.Data.ParameterDirection.Input){Value = br_id},
                        new OracleParameter("DAT_BRAT", OracleDbType.Varchar2, System.Data.ParameterDirection.Input){Value = dat_brat}
                        };
                const string query = @"SELECT RATE FROM br_normal WHERE kv = :nKV AND br_id = :nBR AND bdate = to_date(:DAT_BRAT,'dd/mm/yyyy')";
                return _entities.ExecuteStoreQuery<decimal>(query, sqlParams).FirstOrDefault();
            }
            else { return null; }
        }
        public IQueryable<pipe_BR_TIER> GetDpBrTier(decimal BR_ID, decimal kv) {
            const string query = @"SELECT to_char(b.bdate,'dd/mm/yyyy') BDATE, v.lcv LCV, 
                                          case when b.s> 9999999999 then 'infinity' else to_char( b.s/100) end S, 
                                          b.rate RATE
                                     FROM br_tier b, tabval v 
                                    WHERE b.br_id = :P_BR_ID
                                      AND b.kv    = :p_kv
                                      AND b.kv    = v.kv
                                      AND b.bdate = (SELECT max(t.bdate) 
                                                       FROM br_tier t
                                                      WHERE t.br_id = b.br_id
                                                        AND t.kv = b.kv
                                                        AND t.bdate <= bankdate) 
                                    ORDER BY b.bdate, b.s";
            var parameters = new object[] {
                new OracleParameter("p_BR_ID", OracleDbType.Decimal) { Value = BR_ID},
                new OracleParameter("p_kv", OracleDbType.Decimal) { Value = kv}
            };
            return _entities.ExecuteStoreQuery<pipe_BR_TIER>(query, parameters).AsQueryable();
        }

        public void NewPF(DateTime date_p)
        {
            var sqlParams = new object[]
                    {
                        new OracleParameter("date_p", OracleDbType.Date, date_p, System.Data.ParameterDirection.Input)
                    };
            _entities.ExecuteStoreCommand("begin bars.dpt_pf.not_get_pension_w4(:date_p); end;", sqlParams);

        }

        public void CorrectHolydayDeposit(CorrectHolydayData data)
        {
            _entities.ExecuteStoreCommand("begin dpt_web.change_deposit_end_date(:p_old_dat_end, :p_new_dat_end, :p_ext);  end;",
                new object[]
                {
                    new OracleParameter("p_old_dat_end", OracleDbType.Date, data.Current_Date_End, System.Data.ParameterDirection.Input),
                    new OracleParameter("p_new_dat_end", OracleDbType.Date, data.New_Date_End, System.Data.ParameterDirection.Input),
                    new OracleParameter("p_ext", OracleDbType.Int32, data.Corr_Type, System.Data.ParameterDirection.Input),
                });
        }
    }   
}