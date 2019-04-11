using System;
using System.Collections.Generic;
using System.Linq;

using Areas.Pfu.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Pfu.Models.Console;
using BarsWeb.Areas.Pfu.Models.Grids;
using Kendo.Mvc.UI;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Pfu.Models.ApiModels;
using Dapper;
using Bars.Classes;
using System.Data;
using System.Text;

namespace BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Implementation
{
    /// <summary>
    /// Summary description for GridRepository
    /// </summary>
    public class GridRepository : IGridRepository
    {
        private readonly PfuModel _pfu;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public GridRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("PfuModel", "Pfu");
            this._pfu = new PfuModel(connectionStr);

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        #region Request Grid Data

        public BarsSql _requestQuery;
        public IEnumerable<V_PFU_REQUEST> RequestsData(DataSourceRequest request)
        {
            InitRequestQuery();
            var query = _sqlTransformer.TransformSql(_requestQuery, request);
            var result = _pfu.ExecuteStoreQuery<V_PFU_REQUEST>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal CountRequests(DataSourceRequest request)
        {
            InitRequestQuery();
            var query = _kendoSqlCounter.TransformSql(_requestQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        private void InitRequestQuery()
        {
            _requestQuery = new BarsSql()
            {
                SqlText = string.Format(@"select * from PFU.V_PFU_REQUEST ORDER BY id DESC"),
                SqlParams = new object[] { }
            };
        }
        #endregion
        public List<V_PFU_ENVELOP_ARH> GetSentConvert()
        {
            string sql = @"select * from pfu.v_pfu_envelope_arh";

            return _pfu.ExecuteStoreQuery<V_PFU_ENVELOP_ARH>(sql).ToList();
        }


        #region Files Grid Data

        public BarsSql _fileQuery;

        public IEnumerable<V_PFU_FILE> FilesData(decimal Id, DataSourceRequest request)
        {
            InitFilesQuery(Id);
            var query = _sqlTransformer.TransformSql(_fileQuery, request);
            var result = _pfu.ExecuteStoreQuery<V_PFU_FILE>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal CountFiles(decimal Id, DataSourceRequest request)
        {
            InitFilesQuery(Id);
            var query = _kendoSqlCounter.TransformSql(_fileQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }
        /// <summary>
        /// список файлов в конверте
        /// </summary>
        /// <param name="Id">Id конверта</param>
        private void InitFilesQuery(decimal Id)
        {
            _fileQuery = new BarsSql()
            {
                SqlText = string.Format(@"Select * from pfu.v_pfu_file where ENVELOPE_REQUEST_ID = :p_id"),
                SqlParams = new object[] {
                     new OracleParameter("p_id", OracleDbType.Decimal) { Value = Id }
                }
            };
        }

        #endregion

        #region Envelopes Grid Data

        public BarsSql _envelopeQuery;
        /// <summary>
        /// Список конвертов
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public IEnumerable<V_PFU_ENVELOPE_WFILE> EnvelopesData(DataSourceRequest request)
        {
            InitEnvelopeQuery();
            var query = _sqlTransformer.TransformSql(_envelopeQuery, request);
            var result = _pfu.ExecuteStoreQuery<V_PFU_ENVELOPE_WFILE>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal CountEnvelopes(DataSourceRequest request)
        {
            InitEnvelopeQuery();
            var query = _kendoSqlCounter.TransformSql(_envelopeQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        private void InitEnvelopeQuery()
        {
            _envelopeQuery = new BarsSql()
            {
                SqlText = string.Format(@"select * from pfu.v_pfu_envelope_wfile"),
                SqlParams = new object[] { }
            };
        }

        #endregion

        public IEnumerable<V_PFU_FILE_STATE> PfuFileStatus()
        {
            string SqlText = @"select * from pfu.v_pfu_file_state";
            return _pfu.ExecuteStoreQuery<V_PFU_FILE_STATE>(SqlText, new object[1]);
        }

        public IEnumerable<EnvelopState> PfuEnvelopState()
        {
            string SqlText = @"select state id, state_name name from pfu.v_pfu_envelop_state";
            return _pfu.ExecuteStoreQuery<EnvelopState>(SqlText, new object[1]);
        }

        #region Session Info

        private BarsSql InitSessionQuery(decimal id)
        {
            return new BarsSql()
            {
                SqlText = string.Format(@"select * from PFU.V_PFU_SESSION_TRACKING where request_id = :p_id order by id desc"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = id }
                }
            };
        }

        public decimal CountSession(decimal id, DataSourceRequest request)
        {
            var sessionQuery = InitSessionQuery(id);
            var query = _kendoSqlCounter.TransformSql(sessionQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        public IEnumerable<V_PFU_SESSION_TRACKING> SessionInfo(decimal id, DataSourceRequest request)
        {
            var sessionQuery = InitSessionQuery(id);
            var query = _sqlTransformer.TransformSql(sessionQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_SESSION_TRACKING>(query.SqlText, query.SqlParams);
            return item;
        }

        #endregion

        #region Search
        /*

    */
        private int? GetIPNNforSearch(SearchQuery qv)
        {
            if (qv.IPN == "Так")
            {
                return 1;
            }
            else if (qv.IPN == "Ні")
            { return 0; }
            else if (qv.IPN == "Всі")
            {
                return null;
            }
            return null;
        }
        private BarsSql InitSearchQuery(SearchQuery qv)
        {
            var sqlText = new StringBuilder(@"SELECT * FROM pfu.v_pfu_pensioner where null is null ");
            var sqlParams = new List<OracleParameter>();
            if (!string.IsNullOrWhiteSpace(qv.Okpo))
            {
                sqlText.Append(@"and okpo = :p_okpo ");
                sqlParams.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2) { Value = qv.Okpo.Trim() });
            }
            if (!string.IsNullOrWhiteSpace(qv.Ser))
            {
                sqlText.Append(@"and ser = :p_ser ");
                sqlParams.Add(new OracleParameter("p_ser", OracleDbType.Varchar2) { Value = qv.Ser.Trim() });
            }
            if (!string.IsNullOrWhiteSpace(qv.NumDoc))
            {
                sqlText.Append(@"and numdoc = :p_numdoc ");
                sqlParams.Add(new OracleParameter("p_numdoc", OracleDbType.Varchar2) { Value = qv.NumDoc.Trim() });
            }
            if (qv.Passp.HasValue)
            {
                sqlText.Append(@"and passp = :p_passp ");
                sqlParams.Add(new OracleParameter("p_passp", OracleDbType.Decimal) { Value = qv.Passp });
            }
            if (!string.IsNullOrWhiteSpace(qv.Nmk))
            {
                sqlText.Append(@"and nmk like :p_nmk ");
                sqlParams.Add(new OracleParameter("p_nmk", OracleDbType.Varchar2) { Value = string.Format("%{0}%", qv.Nmk.Trim().ToUpper()) });
            }
            if (!string.IsNullOrWhiteSpace(qv.Branch))
            {
                sqlText.Append(@"and branch = :p_branch ");
                sqlParams.Add(new OracleParameter("p_branch", OracleDbType.Varchar2) { Value = qv.Branch.Trim() });
            }
            if (!string.IsNullOrWhiteSpace(qv.Nls))
            {
                sqlText.Append(@"and nls like :p_nls ");
                sqlParams.Add(new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = string.Format("{0}%", qv.Nls.Trim()) });
            }
            if (!string.IsNullOrWhiteSpace(qv.Kf))
            {
                sqlText.Append(@"and kf = :p_kf ");
                sqlParams.Add(new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = qv.Kf.Trim() });
            }
            var isOkpoWell = GetIPNNforSearch(qv);
            if (isOkpoWell.HasValue)
            {
                sqlText.Append(@"and is_okpo_well = :p_is_okpo_well ");
                sqlParams.Add(new OracleParameter("p_is_okpo_well", OracleDbType.Int32) { Value = isOkpoWell });
            }
            return new BarsSql
            {
                SqlText = sqlText.ToString(),
                SqlParams = sqlParams.ToArray()
            };
            //return new BarsSql()
            //{
            //    SqlText = @"SELECT * FROM pfu.v_pfu_pensioner WHERE
            //        (okpo = :p_okpo OR :p_okpo IS NULL)
            //           AND ((ser = :p_ser OR :p_ser IS NULL)
            //                AND (numdoc = :p_numdoc OR :p_numdoc IS NULL)
            //                AND (passp = :p_passp OR :p_passp IS NULL))
            //           AND (nmk LIKE '%' || upper(:p_nmk) || '%' OR :p_nmk IS NULL)
            //           AND (branch = :p_branch OR :p_branch IS NULL)
            //           AND (nls LIKE :p_nls || '%' OR :p_nls IS NULL)
            //           AND (kf = :p_kf OR :p_kf IS NULL)
            //           AND (is_okpo_well = :p_ipn OR :p_ipn IS NULL)",

            //    SqlParams = new object[]
            //    {
            //        new OracleParameter("p_okpo", OracleDbType.Varchar2) { Value = qv.Okpo },
            //        new OracleParameter("p_okpo", OracleDbType.Varchar2) { Value = qv.Okpo },
            //        new OracleParameter("p_ser", OracleDbType.Varchar2) { Value = qv.Ser },
            //        new OracleParameter("p_ser", OracleDbType.Varchar2) { Value = qv.Ser },
            //        new OracleParameter("p_numdoc", OracleDbType.Varchar2) { Value = qv.NumDoc },
            //        new OracleParameter("p_numdoc", OracleDbType.Varchar2) { Value = qv.NumDoc },
            //        new OracleParameter("p_passp", OracleDbType.Decimal) { Value = qv.Passp },
            //        new OracleParameter("p_passp", OracleDbType.Decimal) { Value = qv.Passp },
            //        new OracleParameter("p_nmk", OracleDbType.Varchar2) { Value = qv.Nmk },
            //        new OracleParameter("p_nmk", OracleDbType.Varchar2) { Value = qv.Nmk },
            //        new OracleParameter("p_branch", OracleDbType.Varchar2) { Value = qv.Branch },
            //        new OracleParameter("p_branch", OracleDbType.Varchar2) { Value = qv.Branch },
            //        new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = qv.Nls },
            //        new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = qv.Nls },
            //        new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = qv.Kf },
            //        new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = qv.Kf },
            //        new OracleParameter("p_ipn", OracleDbType.Int32) {Value = GetIPNNforSearch(qv)},
            //        new OracleParameter("p_ipn", OracleDbType.Int32) {Value =GetIPNNforSearch(qv) }
            //    }
            //};
        }


        BarsSql InitSearchDestroyedEpcQuery(SearchDestroyedEpcQuery qv)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT * FROM bars.pfu_epp_line WHERE
                    (tax_registration_number = :p_tax_registration_number OR :p_tax_registration_number IS NULL)
                       AND (name_pensioner LIKE '%' || :p_name_pensioner || '%' OR :p_name_pensioner IS NULL)
                       AND (nls = :p_nls OR :p_nls IS NULL)
                       AND (epp_number = :p_epp_number OR :p_epp_number IS NULL)",
                SqlParams = new object[]
                {
                    new OracleParameter("tax_registration_number", OracleDbType.Varchar2) { Value = qv.TAX_REGISTRATION_NUMBER },
                    new OracleParameter("tax_registration_number", OracleDbType.Varchar2) { Value = qv.TAX_REGISTRATION_NUMBER },
                    new OracleParameter("p_name_pensioner", OracleDbType.Varchar2) { Value = qv.NAME_PENSIONER },
                    new OracleParameter("p_name_pensioner", OracleDbType.Varchar2) { Value = qv.NAME_PENSIONER },
                    new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = qv.NLS },
                    new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = qv.NLS },
                    new OracleParameter("epp_number", OracleDbType.Varchar2) { Value = qv.EPP_NUMBER },
                    new OracleParameter("epp_number", OracleDbType.Varchar2) { Value = qv.EPP_NUMBER }
                }
            };
        }

        public decimal CountSearch(SearchQuery qv, DataSourceRequest request)
        {
            var searchQuery = InitSearchQuery(qv);
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        public IEnumerable<V_PFU_PENSIONER> Search(SearchQuery qv, DataSourceRequest request)
        {
            var searchQuery = InitSearchQuery(qv);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_PENSIONER>(query.SqlText, query.SqlParams);
            return item;
        }

        public IEnumerable<V_PFU_DESTROYED_EPC> SearchDestroyedEpc(SearchDestroyedEpcQuery qv, DataSourceRequest request)
        {
            var searchQuery = InitSearchDestroyedEpcQuery(qv);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_DESTROYED_EPC>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountSearchDestroyedEpc(SearchDestroyedEpcQuery qv, DataSourceRequest request)
        {
            var searchQuery = InitSearchDestroyedEpcQuery(qv);
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        public IEnumerable<PensionerBlockType> GetPensionerBlockType()
        {
            string SqlText = @"select id block_type, name BlockName from pfu.v_pfu_pens_block_type";
            return _pfu.ExecuteStoreQuery<PensionerBlockType>(SqlText, new object[1]);
        }

        public IEnumerable<SignEPC> GetSignsEPC()
        {
            string SqlText = @"select ID_TYPE, NAME from bars.pfu_epp_kill_type";
            return _pfu.ExecuteStoreQuery<SignEPC>(SqlText, new object[1]);
        }

        #endregion

        #region Search Catalog (Перелік реєстрів)
        private BarsSql InitSearchCatalog(SearchCatalog qv)
        {
            string sql = @"select * from pfu.v_pfu_registers
                    where (id = :id or :id is null)
                      and (receiver_mfo = :mfo or :mfo is null)
                      and (state= :state or :state is null)
                      and (register_date = :register_date or :register_date is null)
                      and (env_id = :env_id or :env_id is null)
                      and (payment_date = :payment_date or :payment_date is null)";

            List<OracleParameter> _params = new List<OracleParameter>
            {
                new OracleParameter(":id", OracleDbType.Varchar2) { Value = qv.IdCatalog },
                new OracleParameter(":id", OracleDbType.Varchar2) { Value = qv.IdCatalog },
                new OracleParameter(":mfo", OracleDbType.Varchar2) { Value = qv.Mfo },
                new OracleParameter(":mfo", OracleDbType.Varchar2) { Value = qv.Mfo },
                new OracleParameter(":state", OracleDbType.Varchar2) { Value = qv.State },
                new OracleParameter(":state", OracleDbType.Varchar2) { Value = qv.State },
                new OracleParameter(":register_date", OracleDbType.Date) { Value = qv.CatalogDate },
                new OracleParameter(":register_date", OracleDbType.Date) { Value = qv.CatalogDate },
                new OracleParameter(":env_id", OracleDbType.Varchar2) { Value = qv.EnvelopeId },
                new OracleParameter(":env_id", OracleDbType.Varchar2) { Value = qv.EnvelopeId },
                new OracleParameter(":payment_date", OracleDbType.Date) { Value = qv.PayDate},
                new OracleParameter(":payment_date", OracleDbType.Date) { Value = qv.PayDate }
            };

            if (null != qv.FileType)
            {
                sql += null == qv.FileType ? "" : " and file_type = :p_file_type";
                _params.Add(new OracleParameter(":p_file_type", OracleDbType.Varchar2) { Value = qv.FileType });
            }

            return new BarsSql()
            {
                SqlText = sql,
                SqlParams = _params.ToArray()
            };
        }
        private BarsSql InitSearchCatalogInPay(SearchCatalog qv)
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_pfu_registers
                    where (id = :id or :id is null)
                      and (receiver_mfo = :mfo or :mfo is null)
                      and state = 'IN_PAY'
                      and (register_date = :register_date or :register_date is null)
                      and (payment_date = :payment_date or :payment_date is null)",
                SqlParams = new object[]
                {
                    new OracleParameter(":id", OracleDbType.Varchar2) { Value = qv.IdCatalog },
                    new OracleParameter(":id", OracleDbType.Varchar2) { Value = qv.IdCatalog },
                    new OracleParameter(":mfo", OracleDbType.Varchar2) { Value = qv.Mfo },
                    new OracleParameter(":mfo", OracleDbType.Varchar2) { Value = qv.Mfo },
                    new OracleParameter(":register_date", OracleDbType.Date) { Value = qv.CatalogDate },
                    new OracleParameter(":register_date", OracleDbType.Date) { Value = qv.CatalogDate },
                    new OracleParameter(":payment_date", OracleDbType.Date) { Value = qv.PayDate},
                    new OracleParameter(":payment_date", OracleDbType.Date) { Value = qv.PayDate }
                }
            };
        }
        private BarsSql InitSearchEnvelope(SearchEnvelop qv)
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.V_PFU_ENVELOPE_KVIT1
                            where (id = :id or :id is null)
                                   and (state = :state or :state is null)
                                   and (date_insert =:date_insert or :date_insert is null)",
                SqlParams = new object[]
                {
                    new OracleParameter(":id", OracleDbType.Varchar2) { Value = qv.Id },
                    new OracleParameter(":id", OracleDbType.Varchar2) { Value = qv.Id },
                    new OracleParameter(":state", OracleDbType.Varchar2) { Value = qv.State },
                    new OracleParameter(":state", OracleDbType.Varchar2) { Value = qv.State },
                    new OracleParameter(":date_insert", OracleDbType.Date) { Value = qv.CreatingDate},
                    new OracleParameter(":date_insert", OracleDbType.Date) { Value = qv.CreatingDate}
                }
            };
        }

        public IEnumerable<V_PFU_REGISTERS> Catalog(SearchCatalog search, DataSourceRequest request)
        {
            var searchQuery = InitSearchCatalog(search);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_REGISTERS>(query.SqlText, query.SqlParams);
            return item;
        }
        public IEnumerable<V_PFU_REGISTERS> CatalogInPay(SearchCatalog search, DataSourceRequest request)
        {
            var searchQuery = InitSearchCatalogInPay(search);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_REGISTERS>(query.SqlText, query.SqlParams);
            return item;
        }
        public void ProcessRegistres(int[] registersIds)
        {
            for (int i = 0; i < registersIds.Length; i++)
            {
                _pfu.ExecuteStoreCommand("begin pfu.pfu_files_utl.check_set_file_state_payed(p_file_id => :p_file_id); end;",
                    new OracleParameter("p_file_id", OracleDbType.Int32) { Value = registersIds[i] });
            }
        }
        public IEnumerable<V_PFU_REGISTERS_EPC> SearchRegisterEpc(SearchRegisterEpc search, DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchRegisterEpc(search);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_REGISTERS_EPC>(query.SqlText, query.SqlParams);
            return item;
        }

        public decimal CountRegisterEpc(SearchRegisterEpc search, DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchRegisterEpc(search);
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        public IEnumerable<V_PFU_REGISTERS_LINES_EPC> SearchRegisterEpcLine(SearchRegisterLinesEpc search, DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchRegisterLinesEpc(search);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_REGISTERS_LINES_EPC>(query.SqlText, query.SqlParams);
            return item;
        }

        public IEnumerable<V_PFU_EPC_LINE_STATE> PfuEpcLineeStatus()
        {
            string SqlText = @"select * from pfu.pfu_epp_line_state";
            return _pfu.ExecuteStoreQuery<V_PFU_EPC_LINE_STATE>(SqlText, new object[1]);
        }

        public V_PFU_DESTROYED_EPC_INFO GetDestroyedEpcInfo(string epcId)
        {
            BarsSql searchQuery = SqlCreator.GetDestroyedEpcInfo(epcId);
            return _pfu.ExecuteStoreQuery<V_PFU_DESTROYED_EPC_INFO>(searchQuery.SqlText, searchQuery.SqlParams).FirstOrDefault();
        }

        public decimal CountRegisterEpcLine(SearchRegisterLinesEpc search, DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchRegisterLinesEpc(search);
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        public IEnumerable<V_PFU_ENVELOPES> Envelopes(SearchEnvelop search, DataSourceRequest request)
        {
            var searchQuery = InitSearchEnvelope(search);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_ENVELOPES>(query.SqlText, query.SqlParams);
            return item;

            //string SqlText = @"select * from pfu.V_PFU_ENVELOPE_KVIT1";
            //return _pfu.ExecuteStoreQuery<V_PFU_ENVELOPES>(SqlText, new object[1]);
        }
        public decimal CountEnvelopes(SearchEnvelop search, DataSourceRequest request)
        {
            var lineQuery = InitSearchEnvelope(search);
            var query = _kendoSqlCounter.TransformSql(lineQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        public decimal CountCatalog(SearchCatalog search, DataSourceRequest request)
        {
            var searchQuery = InitSearchCatalog(search);
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }
        public decimal CountCatalogInPay(SearchCatalog search, DataSourceRequest request)
        {
            var searchQuery = InitSearchCatalogInPay(search);
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }
        #endregion
        #region Інформаційні рядки Реєстру
        private BarsSql InitLineCatalog(decimal Id)
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_pfu_records where file_id = :p_id",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = Id}
                }
            };
        }
        private BarsSql InitLineCatalogInPay(decimal? id)
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_pfu_records where state in (0,19,20) and file_id = :p_id",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = id}
                }
            };
        }
        public IEnumerable<V_PFU_RECORDS> LineCatalog(decimal Id, DataSourceRequest request)
        {
            var lineQuery = InitLineCatalog(Id);
            var query = _sqlTransformer.TransformSql(lineQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_RECORDS>(query.SqlText, query.SqlParams);
            return item;
        }
        public IEnumerable<V_PFU_RECORDS> LineCatalogInPay(decimal? id, DataSourceRequest request)
        {
            var lineQuery = InitLineCatalogInPay(id);
            var query = _sqlTransformer.TransformSql(lineQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_RECORDS>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountLineCatalog(decimal Id, DataSourceRequest request)
        {
            var lineQuery = InitLineCatalog(Id);
            var query = _kendoSqlCounter.TransformSql(lineQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }
        public decimal CountLineCatalogInPay(decimal? id, DataSourceRequest request)
        {
            var lineQuery = InitLineCatalogInPay(id);
            var query = _kendoSqlCounter.TransformSql(lineQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }
        public void ProcessRecords(int[] ids, string stateName)
        {
            for (int i = 0; i < ids.Length; i++)
            {
                _pfu.ExecuteStoreCommand("begin pfu.pfu_files_utl.set_file_record_state(p_file_rec_id => :p_file_rec_id, p_state => :p_state); end;",
                    new OracleParameter("p_file_rec_id", OracleDbType.Int32) { Value = ids[i] },
                    new OracleParameter("p_state", OracleDbType.Varchar2) { Value = stateName });
            }
        }
        #endregion
        public void BlockPensioner(IList<BlockPensioner> pensioners)
        {
            foreach (BlockPensioner pen in pensioners)
            {
                BarsSql sql = new BarsSql()
                {
                    SqlText = @"begin
                        pfu.pfu_sync_ru.set_pensioner_state_blocked(p_id => :p_id, p_comm => :p_comm, p_block_type => :p_block_type);
                    end;",
                    SqlParams = new object[]
                                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = pen.id },
                    new OracleParameter("p_comm", OracleDbType.Varchar2) { Value = pen.comment },
                    new OracleParameter("p_block_type", OracleDbType.Int32) {Value=pen.block_type }
                                }
                };

                _pfu.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
            }

        }

        public void RemoveFromPayPensioner(IList<BlockPensioner> pensioners)
        {
            foreach (BlockPensioner pen in pensioners)
            {
                BarsSql sql = new BarsSql()
                {
                    SqlText = @"begin
                        pfu.pfu_sync_ru.set_filerec_state_blocked(p_id => :p_id, p_comm => :p_comm, p_block_type => :p_block_type);
                    end;",
                    SqlParams = new object[]
                                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = pen.id },
                    new OracleParameter("p_comm", OracleDbType.Varchar2) { Value = pen.comment },
                    new OracleParameter("p_block_type", OracleDbType.Int32) {Value=pen.block_type }
                                }
                };

                _pfu.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
            }

        }

        public void DestroyEpc(IList<DestroyEpc> pensioners)
        {
            foreach (DestroyEpc pen in pensioners)
            {
                BarsSql sql = new BarsSql()
                {
                    SqlText = @"begin
                        pfu_ru_file_utl.set_epp_killed(:p_epp_number, :p_kill_type);
                    end;",
                    SqlParams = new object[] {
                        new OracleParameter("p_epp_number", OracleDbType.Varchar2) { Value = pen.EPP_NUMBER },
                        new OracleParameter("p_kill_type", OracleDbType.Int32) {Value=pen.KILL_TYPE }
                    }
                };
                _pfu.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
            }
        }

        public void SetReadyForSignStatus(decimal fileId)
        {
            string command = @"
            begin
                 pfu.pfu_files_utl.set_file_state_for_pay(:file_id);
            end;";
            var parameters = new object[]
            {
                new OracleParameter("file_id", OracleDbType.Decimal) { Value = fileId }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }

        public void SetCheckingPayStatus(decimal fileId, decimal docRef)
        {
            string command = @"
            begin
                 pfu.pfu_files_utl.set_file_state_checking_pay(:file_id, :doc_ref);
            end;";
            var parameters = new object[]
            {
                new OracleParameter("file_id", OracleDbType.Decimal) { Value = fileId },
                new OracleParameter("doc_ref", OracleDbType.Decimal) { Value = docRef }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }

        public Payment VerifyFile(decimal fileId)
        {
            string command = @"
            begin
                 pfu.pfu_files_utl.checking_record2(:file_id);
            end;";
            var parameters = new object[]
            {
                new OracleParameter("file_id", OracleDbType.Decimal) { Value = fileId }
            };
            _pfu.ExecuteStoreCommand(command, parameters);

            string SqlText = @"select acc_2909 as RecipientAccNum, name_2909 as RecipientName, okpo_2909 as RecipientCustCode, mfo_2909 as RecipientBankId, acc_2560 as SenderAccNum, name_2560 as SenderName, okpo_2560 as SenderCustCode, mfo_2560 as SenderBankId, debet_tts as OpCode,sum, nazn as Narrative from pfu.v_pfu_paym_fields where id=:file_id";
            return _pfu.ExecuteStoreQuery<Payment>(SqlText, parameters).FirstOrDefault();
        }

        public void SetReadyForMatchingStatus(FileForMatchingKvit1And2 kvit)
        {
            if (kvit.KvitType == 3)
            {
                GenDeathMatching(kvit);
                return;
            }

            string command = string.Format(@"
            begin
                 pfu.pfu_service_utl.gen_matching{0}(:Id, :Sign);
            end;", kvit.KvitType);
            var parameters = new object[]
            {
                new OracleParameter("Id", OracleDbType.Decimal) { Value = kvit.Id },
                new OracleParameter("Sign", OracleDbType.Varchar2) { Value = kvit.Sign }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }
        public void SetRegenMatchingStatus(FileForMatchingKvit1And2 kvit)
        {
            string command = string.Format(@"
            begin
                 pfu.pfu_service_utl.gen_matching{0}(:Id, :Sign);
            end;", kvit.KvitType);
            var parameters = new object[]
            {
                new OracleParameter("Id", OracleDbType.Decimal) { Value = kvit.Id },
                new OracleParameter("Sign", OracleDbType.Varchar2) { Value = kvit.Sign }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }

        public string PrepareForMatchingStatus(FileForMatching d)
        {
            if (d.KvitType == 3)
            {
                return PrepareDeathMatching(d);
            }

            string sql = string.Format(@"select pfu.pfu_service_utl.prepare_matching{0}(:ID, :Type) from dual", d.KvitType);

            var parameters = new object[]
            {
                new OracleParameter("ID", OracleDbType.Decimal) { Value = d.ID },
                new OracleParameter("Type", OracleDbType.Decimal) {Value = d.Type }
            };
            return _pfu.ExecuteStoreQuery<string>(sql, parameters).FirstOrDefault();
        }

        #region kvit death
        public string PrepareDeathMatching(FileForMatching d)
        {
            string sql = @"select pfu.pfu_service_utl.prepare_death_matching(:ID, :Type) from dual";
            var parameters = new object[]
            {
                new OracleParameter("ID", OracleDbType.Decimal) { Value = d.ID },
                new OracleParameter("Type", OracleDbType.Decimal) {Value = d.Type }
            };
            return _pfu.ExecuteStoreQuery<string>(sql, parameters).FirstOrDefault();
        }

        public void GenDeathMatching(FileForMatchingKvit1And2 kvit)
        {
            string command = @"
                                begin
                                     pfu.pfu_service_utl.gen_death_matching(:Id, :Sign);
                                end;";
            var parameters = new object[]
            {
                new OracleParameter("Id", OracleDbType.Decimal) { Value = kvit.Id },
                new OracleParameter("Sign", OracleDbType.Varchar2) { Value = kvit.Sign }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }
        #endregion

        public void SetReadyForMatchingStatus2(decimal file_id)
        {
            string command = @"
            begin
                 pfu.pfu_service_utl.gen_matching2(:file_id);
            end;";
            var parameters = new object[]
            {
                new OracleParameter("file_id", OracleDbType.Decimal) { Value = file_id }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }

        public void SetPaybackKvit2(decimal p_id_rec, string p_numpay_back, DateTime? p_dateback)
        {
            string command = @"
            begin
                 pfu.pfu_service_utl.set_paybach_attr(p_id_rec => :p_id_rec, p_dateback => :p_dateback, p_numpay_back => :p_numpay_back);
            end;";
            var parameters = new object[]
            {
                new OracleParameter("p_id_rec", OracleDbType.Decimal) { Value = p_id_rec },
                new OracleParameter("p_dateback", OracleDbType.Date) { Value = p_dateback },
                new OracleParameter("p_numpay_back", OracleDbType.Varchar2) { Value = p_numpay_back }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }

        // SYNC
        public void SyncPensioners(IList<SyncPensioners> pensioners)
        {
            foreach (SyncPensioners pen in pensioners)
            {
                BarsSql sql = new BarsSql()
                {
                    SqlText = @"begin
                        pfu.pfu_service_utl.prepare_pensioner_claim(p_kf => :p_kf);
                        pfu.pfu_service_utl.prepare_pensacc_claim(p_kf => :p_kf);
                    end;",
                    SqlParams = new object[] {
                        new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = pen.KF }
                    }
                };
                _pfu.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
            }
        }
        public IEnumerable<V_PFU_SYNC_STATE> PfuSyncStatus()
        {
            string SqlText = @"select * from pfu.transport_state";
            return _pfu.ExecuteStoreQuery<V_PFU_SYNC_STATE>(SqlText, new object[1]);
        }
        public IEnumerable<V_PFU_SYNC> SearchSync(SearchSyncPensioners search, DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchSync(search);
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_SYNC>(query.SqlText, query.SqlParams);
            return item;
        }

        public decimal CountSync(SearchSyncPensioners search, DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchSync(search);
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _pfu.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        #endregion

        public IEnumerable<V_PFU_REGISTERS> CatalogHistory(DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchCatalogHistory();
            var query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _pfu.ExecuteStoreQuery<V_PFU_REGISTERS>(query.SqlText, query.SqlParams);
            return item;
        }

        public decimal CountCatalogHistory(DataSourceRequest request)
        {
            var searchQuery = SqlCreator.InitSearchCatalogHistory();
            var query = _kendoSqlCounter.TransformSql(searchQuery, request);
            var count = _pfu.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
            return count;
        }

        public void BalanceRequest(string acc, decimal id, decimal p_kf)
        {

            string command = @"begin
                       pfu.pfu_service_utl.prepare_acc_rest(p_acc => :acc, p_fileid => :id, p_kf => :kf);
                    end;";
            var parameters = new object[]
            {
                new OracleParameter("p_acc", OracleDbType.Varchar2) { Value = acc },
                new OracleParameter("p_fileid", OracleDbType.Decimal) { Value = id },
                new OracleParameter("p_kf", OracleDbType.Decimal) { Value = p_kf }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }
        public List<BranchesMonitoring> GetBranchСode()
        {
            string SqlText = @"select kf from pfu.v_cm_err_trans";
            var list = _pfu.ExecuteStoreQuery<BranchesMonitoring>(SqlText).ToList();
            return list;
        }
        public List<pfuMFO> GetMFO()
        {
            string SqlText = @"select kf as mfo,name||' '||kf as mfo_name from pfu.V_PFU_SYNCRU_PARAMS t";
            var list = _pfu.ExecuteStoreQuery<pfuMFO>(SqlText).ToList();
            return list;
        }
        public List<LineStates> GetStatesFromLine(decimal id)
        {
            var p = new DynamicParameters();
            string sql = @"select distinct state, state_name from pfu.v_pfu_records where file_id = :p_id";
            //string sql = @"select distinct state, state_name from pfu.v_pfu_records";
            p.Add("p_id", dbType: DbType.Decimal, size: 50, value: Convert.ToDecimal(id), direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<LineStates>(sql, p).ToList();
            }
        }
        public List<Enquiry> GetEnquiries(string kf)
        {
            string sql = @"select * from pfu.v_cm_err_trans where kf =:kf";

            var parameters = new object[]
            {
                new OracleParameter("kf", OracleDbType.Varchar2) { Value = kf}
            };
            return _pfu.ExecuteStoreQuery<Enquiry>(sql, parameters).ToList();
        }
        public List<CmEpp> GetCmEpp(decimal id)
        {
            string sql = @"select * from table(pfu.pfu_service_utl.get_xml_cm_epp(:id))";

            var parameters = new object[]
            {
                new OracleParameter("id", OracleDbType.Decimal) { Value = id}
            };
            return _pfu.ExecuteStoreQuery<CmEpp>(sql, parameters).ToList();
        }
        public List<EppLine> GetVEppLine(string id)
        {
            string sql = @"select * from pfu.v_epp_line_all where epp_number = :epp_number";

            var parameters = new object[]
            {
                new OracleParameter("epp_number", OracleDbType.Varchar2) { Value = id}
            };
            return _pfu.ExecuteStoreQuery<EppLine>(sql, parameters).ToList();
        }
        public void SendRequest(int kf)
        {
            string sql = @"begin pfu.pfu_service_utl.prepare_cm_error_claim(:kf); end;";

            var parameters = new object[]
            {
                new OracleParameter("kf", OracleDbType.Varchar2) { Value = kf}
            };
            _pfu.ExecuteStoreCommand(sql, parameters);
        }
        public List<PfuEppLine> GetEppLine(DataSourceRequest request, string kff, string bdate1, string bdate, string status, string epp, string inn, string acc)
        {
            List<DummyEppLineSql> _d = new List<DummyEppLineSql>();
            if (!string.IsNullOrEmpty(kff))
            {
                _d.Add(new DummyEppLineSql { values = new List<DummyEppLine> { new DummyEppLine { value = kff, type = DbType.String, key = "P_BANK_MFO" } }, template = "BANK_MFO=:P_BANK_MFO" });
            }
            if (!string.IsNullOrEmpty(epp))
            {
                _d.Add(new DummyEppLineSql { values = new List<DummyEppLine> { new DummyEppLine { value = epp, type = DbType.String, key = "P_EPP_NUMBER" } }, template = "EPP_NUMBER=:P_EPP_NUMBER" });
            }
            if (!string.IsNullOrEmpty(inn))
            {
                _d.Add(new DummyEppLineSql { values = new List<DummyEppLine> { new DummyEppLine { value = inn, type = DbType.String, key = "P_TAX_REGISTRATION_NUMBER" } }, template = "TAX_REGISTRATION_NUMBER=:P_TAX_REGISTRATION_NUMBER" });
            }
            if (!string.IsNullOrEmpty(acc))
            {
                _d.Add(new DummyEppLineSql { values = new List<DummyEppLine> { new DummyEppLine { value = acc, type = DbType.String, key = "P_ACCOUNT_NUMBER" } }, template = "ACCOUNT_NUMBER=:P_ACCOUNT_NUMBER" });
            }
            if (!string.IsNullOrEmpty(bdate1) && !string.IsNullOrEmpty(bdate))
            {
                _d.Add(new DummyEppLineSql
                {
                    values = new List<DummyEppLine> {
                    new DummyEppLine { value = bdate1, type = DbType.String, key = "P_BATCH_DATE1" },
                    new DummyEppLine { value = bdate, type = DbType.String, key = "P_BATCH_DATE2" },
                },
                    template = "(BATCH_DATE BETWEEN TO_DATE (:P_BATCH_DATE1, 'DD/MM/YY') AND TO_DATE (:P_BATCH_DATE2, 'DD/MM/YY'))"
                });
            }

            if (_d.Count == 0)
            {
                throw new Exception("Не задано параметри для пошуку.");
            }

            var p = new DynamicParameters();
            StringBuilder _sb = new StringBuilder(@"select * from pfu.v_epp_line_all");
            bool _isFirst = false;
            foreach (DummyEppLineSql o in _d)
            {
                foreach (var l in o.values)
                {
                    p.Add(l.key, l.value, l.type, ParameterDirection.Input);
                }
                _sb.Append(!_isFirst ? " where " : " and ");
                _sb.Append(o.template);
                _isFirst = true;
            }
            if (!string.IsNullOrEmpty(status))
            {
                _sb.Append(string.Format(" AND (STATE_ID = 0 {0})", status));
            }

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<PfuEppLine>(_sb.ToString(), p).ToList();
            }
        }
        public List<DateTime> GetEppDate()
        {
            var sql = @"select UNIQUE(batch_date) from pfu.v_epp_line_all";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DateTime>(sql).ToList();
            }
        }

        public decimal GetCountGrid()
        {
            string SqlText = @"select count(*) from pfu.v_epp_line_all";
            var count = _pfu.ExecuteStoreQuery<decimal>(SqlText).SingleOrDefault();
            return count;
        }

        public List<PfuEppLine> GetTableByRNK(string id, decimal id_row)
        {
            string sql = @"select * from pfu.v_epp_line_all where rnk = :rnk and id = :id_row";

            var parameters = new object[]
            {
                new OracleParameter("rnk", OracleDbType.Varchar2) { Value = id},
                new OracleParameter("id_row", OracleDbType.Decimal) { Value = id_row}
            };
            return _pfu.ExecuteStoreQuery<PfuEppLine>(sql, parameters).ToList();
        }
        public List<PfuEppLine> GetTableByEppNum(string id)
        {
            string sql = @"select * from pfu.v_epp_line_all where epp_number = :epp_number";

            var parameters = new object[]
            {
                new OracleParameter("epp_number", OracleDbType.Varchar2) { Value = id}
            };
            return _pfu.ExecuteStoreQuery<PfuEppLine>(sql, parameters).ToList();
        }
        public List<PfuEppLine> GetTableByAccNum(string id)
        {
            string sql = @"select * from pfu.v_epp_line_all where ACCOUNT_NUMBER = :ACCOUNT_NUMBER";

            var parameters = new object[]
            {
                new OracleParameter("ACCOUNT_NUMBER", OracleDbType.Varchar2) { Value = id}
            };
            return _pfu.ExecuteStoreQuery<PfuEppLine>(sql, parameters).ToList();
        }

        public void RepeatProcessing(dynamic rows)
        {
            for (int i = 0; i < rows.Count; i++)
            {
                var p = new DynamicParameters();
                p.Add("LINE_ID", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(rows[i].ID), direction: ParameterDirection.Input);

                var sql = @"begin pfu.pfu_epp_utl.set_line_state(:LINE_ID,30,'перезапуск ЕПП', null);  end;";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
            }
        }
        public void AssignRNK(dynamic rows)
        {
            for (int i = 0; i < rows.Count; i++)
            {
                var p = new DynamicParameters();
                p.Add("line_id", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(rows[i].ID), direction: ParameterDirection.Input);
                p.Add("rnk", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(rows[i].RNK), direction: ParameterDirection.Input);

                var sql = @"begin pfu.pfu_epp_utl.set_epp_rnk(:line_id, :rnk);  end;";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    connection.Execute(sql, p);
                }
            }
        }
        public StatesEppLines GetStatusRows(decimal? kff, string dateto, string datefrom, string cod_epp, string inden_cod, string account)
        {
            var p = new DynamicParameters();
            StatesEppLines states = new StatesEppLines();
            List<PfuEppLine> grid = new List<PfuEppLine>();
            string add_sql_kf = "";
            string add_sql_dates = "";
            string add_sql_epp = "";
            string add_sql_ind = "";
            string add_sql_acc = "";
            bool issql = false;
            string qwery = "";
            string sql = @"select * from pfu.v_epp_line_all where  ";

            if (kff != null)
            {
                add_sql_kf = " BANK_MFO =:kff";
                add_sql_kf = !issql ? add_sql_kf : " and " + add_sql_kf;
                issql = true;
                p.Add("kff", dbType: DbType.String, size: 50, value: Convert.ToString(kff), direction: ParameterDirection.Input);

            }
            if (datefrom != "null" && dateto != "null")
            {
                add_sql_dates = !issql ? " (BATCH_DATE BETWEEN TO_DATE(:bdate2, 'DD/MM/YY') and TO_DATE(:bdate1, 'DD/MM/YY'))" : " and " + " (BATCH_DATE BETWEEN TO_DATE(:bdate2, 'DD/MM/YY') and TO_DATE(:bdate1, 'DD/MM/YY'))";
                p.Add("bdate1", dbType: DbType.String, size: 50, value: dateto, direction: ParameterDirection.Input);
                p.Add("bdate2", dbType: DbType.String, size: 50, value: datefrom, direction: ParameterDirection.Input);
                issql = true;
            }
            if (cod_epp != null && cod_epp != "null" && cod_epp != "")
            {
                add_sql_epp = " EPP_NUMBER =:cod_epp";
                add_sql_epp = !issql ? add_sql_epp : " and " + add_sql_epp;
                issql = true;
                p.Add("cod_epp", dbType: DbType.String, size: 50, value: Convert.ToString(cod_epp), direction: ParameterDirection.Input);
            }
            if (inden_cod != null && inden_cod != "null" && inden_cod != "")
            {
                add_sql_ind = " TAX_REGISTRATION_NUMBER =:inden_cod ";
                add_sql_ind = !issql ? add_sql_ind : " and " + add_sql_ind;
                issql = true;
                p.Add("inden_cod", dbType: DbType.String, size: 50, value: Convert.ToString(inden_cod), direction: ParameterDirection.Input);
            }
            if (account != null && account != "null" && account != "")
            {
                add_sql_acc = " ACCOUNT_NUMBER =:account";
                add_sql_acc = !issql ? add_sql_acc : " and " + add_sql_acc;
                issql = true;
                p.Add("account", dbType: DbType.String, size: 50, value: Convert.ToString(account), direction: ParameterDirection.Input);
            }

            qwery = sql + add_sql_kf + add_sql_dates + add_sql_epp + add_sql_ind + add_sql_acc;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                grid = connection.Query<PfuEppLine>(qwery, p).ToList();
            }

            IEnumerable<PfuEppLine> rows = grid.AsEnumerable();
            states.news = rows.Count(x => x.STATE_ID == 1);
            states.passval = rows.Count(x => x.STATE_ID == 2);
            states.sendru = rows.Count(x => x.STATE_ID == 20);
            states.accopen = rows.Count(x => x.STATE_ID == 8);
            states.cardsact = rows.Count(x => x.STATE_ID == 12);
            states.passact = rows.Count(x => x.STATE_ID == 13);
            states.kv2send = rows.Count(x => x.STATE_ID == 14);
            states.failedval = rows.Count(x => x.STATE_ID == 3);
            states.erropenaclient = rows.Count(x => x.STATE_ID == 27);
            states.erropenacc = rows.Count(x => x.STATE_ID == 28);
            states.errpercard = rows.Count(x => x.STATE_ID == 29);
            states.blockepp = rows.Count(x => x.STATE_ID == 19);
            states.kminwork = rows.Count(x => x.STATE_ID == 24);
            states.prockm = rows.Count(x => x.STATE_ID == 25);
            states.errkm = rows.Count(x => x.STATE_ID == 26);
            states.perprocc = rows.Count(x => x.STATE_ID == 30);
            states.inprocc = rows.Count(x => x.STATE_ID == 31);
            states.erropen = rows.Count(x => x.STATE_ID == 7);
            return states;
        }

        public List<PfuEppLine> GetRowsByStatus(string status, decimal kff, string bdate)
        {
            var p = new DynamicParameters();
            string sql = @"select * from pfu.v_epp_line_all where BATCH_DATE = TO_DATE(:bdate, 'DD/MM/YY') and BANK_MFO =:kff";
            if (status != null || status != "")
                sql = sql + " AND STATE_ID = 0 " + status;

            p.Add("kff", dbType: DbType.String, size: 50, value: Convert.ToDecimal(kff), direction: ParameterDirection.Input);
            p.Add("bdate", dbType: DbType.String, size: 50, value: Convert.ToString(bdate), direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<PfuEppLine>(sql, p).ToList();
            }
        }

        public IQueryable<ErrorRows> GetErrorRows(string MFO, string ID, string STATE)
        {
            var p = new DynamicParameters();
            string sql = @"select * from pfu.V_PFU_ERR_RECORD";
            string additional_sql = "";
            if ((MFO != null && MFO != "") || (ID != null && ID != "") || (STATE != null && STATE != ""))
            {
                sql = sql + " where ";
            }
            if (MFO != null && MFO != "")
                if (additional_sql != "")
                    additional_sql = additional_sql + " and MFO =" + Convert.ToString(MFO);
                else
                    additional_sql = additional_sql + " MFO =" + Convert.ToString(MFO);

            if (ID != null && ID != "")
                if (additional_sql != "")
                    additional_sql = additional_sql + " and FILE_ID =" + Convert.ToDecimal(ID);
                else
                    additional_sql = additional_sql + " FILE_ID =" + Convert.ToDecimal(ID);

            if (STATE != null && STATE != "")
                if (additional_sql != "")
                    additional_sql = additional_sql + " and STATE =" + Convert.ToDecimal(STATE);
                else
                    additional_sql = additional_sql + " STATE =" + Convert.ToDecimal(STATE);
            sql = sql + additional_sql;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<ErrorRows>(sql, p).AsQueryable();
            }
        }
        public List<pfuState> GetStates()
        {
            var p = new DynamicParameters();
            string sql = @"select distinct state,state_name from pfu.V_PFU_ERR_RECORD";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<pfuState>(sql).ToList();
            }
        }

        public void MarkToPayment(decimal id)
        {
            var p = new DynamicParameters();
            p.Add("id", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(id), direction: ParameterDirection.Input);

            var sql = @"begin  pfu.pfu_files_utl.set_rec_unerror(:id);  end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }

        }
        #region Повідомлення про смерть пенсіонера

        /// <summary>
        /// Повертає список повідомлень про смерть пенсіонерів
        /// в залежності від параметрів або їх відсутності
        /// </summary>
        /// <param name="id"> ID повідомлення про смерть </param>
        /// <param name="rdate"> Дата отримання </param>
        /// <param name="state"> Статус </param>
        public IQueryable<V_PFU_DEATHS> GetNotifyList(string id, string rdate, string state)
        {
            var p = new DynamicParameters();
            string sql = @"select * from pfu.v_pfu_death";
            string additional_sql = "";
            if ((id != null && id != "") || (rdate != null && rdate != "") || (state != null && state != ""))
            {
                sql = sql + " where ";
            }
            if (id != null && id != "")
                if (additional_sql != "")
                    additional_sql = additional_sql + " and ID =" + Convert.ToDecimal(id);
                else
                    additional_sql = additional_sql + " ID =" + Convert.ToDecimal(id);

            if (rdate != null && rdate != "")
                if (additional_sql != "")
                    additional_sql = additional_sql + " and FILE_ID =" + Convert.ToDecimal(rdate);
                else
                    additional_sql = additional_sql + " FILE_ID =" + Convert.ToDecimal(rdate);

            if (state != null && state != "")
                if (additional_sql != "")
                    additional_sql = additional_sql + " and STATE =" + Convert.ToDecimal(state);
                else
                    additional_sql = additional_sql + " STATE =" + Convert.ToDecimal(state);
            sql = sql + additional_sql;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<V_PFU_DEATHS>(sql, p).AsQueryable();
            }
        }

        /// <summary>
        /// Повертає список інформаційних строк по первному по ID пенсіонера
        /// </summary>
        /// <param name="id"> ID повідомлення про смерть </param>
        public List<V_PFU_DEATHS_RECORDS> GetNotifyRecords(decimal id)
        {
            string sql = @"select * from pfu.v_pfu_death_records where LIST_ID =:id";

            var parameters = new object[]
            {
                new OracleParameter("id", OracleDbType.Decimal) { Value = id}
            };
            return _pfu.ExecuteStoreQuery<V_PFU_DEATHS_RECORDS>(sql, parameters).ToList();
        }

        /// <summary>
        ///Блокування - виконує процедуру блокування пенсионера по ID
        /// </summary>
        /// <param name="id"> ID повідомлення про смерть </param>
        public void BlockPensioner(string id)
        {
            var p = new DynamicParameters();
            p.Add("p_recid", dbType: DbType.Decimal, size: 100, value: Convert.ToDecimal(id), direction: ParameterDirection.Input);

            var sql = @"begin pfu.pfu_utl.set_death(p_recid => :p_recid); end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }

        /// <summary>
        /// Списання з рахунку - виконує запит який повертає вид платежу
        /// яких необхідно здійснити по певному ID пенсіонера
        /// </summary>
        /// <param name="id"> ID повідомлення про смерть </param>
        public PaymentDoc GetOption(string id)
        {
            string sql = @"select * from  pfu.V_PFU_PAYM_DEATH_FIELDS where ID =:id";

            var parameters = new object[]
            {
                new OracleParameter("id", OracleDbType.Decimal) { Value = id}
            };
            return _pfu.ExecuteStoreQuery<PaymentDoc>(sql, parameters).FirstOrDefault();
        }

        /// <summary>
        /// Запит залишку - виконує процедуру запиту залишку по ID
        /// </summary>
        /// <param name="acc"> номер счета </param>
        /// <param name="id"> ID повідомлення про смерть </param>
        /// <param name="mfo"> МФО </param>
        public void BalanceReq(string acc, string id, string mfo)
        {
            string command = @"begin
                       pfu.pfu_service_utl.prepare_acc_rest(p_acc => :acc, p_fileid => :id, p_kf => :kf);
                    end;";
            var parameters = new object[]
            {
                new OracleParameter("p_acc", OracleDbType.Varchar2) { Value = acc },
                new OracleParameter("p_fileid", OracleDbType.Decimal) { Value = Convert.ToDecimal(id) },
                new OracleParameter("p_kf", OracleDbType.Decimal) { Value = Convert.ToDecimal(mfo) }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }

        /// <summary>
        /// Процедура записує реферненс документа у таблицю #### після успішного виконання
        /// </summary>
        /// <param name="id"> ID повідомлення про смерть </param>
        /// <param name="docref"> Референс документа </param>
        public void SetDeathDebetRef(string id, string docref)
        {
            string command = @"begin
                       pfu.pfu_files_utl.set_death_debet_ref(p_recid => :p_recid,
                                                    p_ref_debet => :p_ref_debet);
                    end;";
            var parameters = new object[]
            {
                new OracleParameter("p_recid", OracleDbType.Decimal) { Value = Convert.ToDecimal(id) },
                new OracleParameter("p_ref_debet", OracleDbType.Decimal) { Value = Convert.ToDecimal(docref) }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }
        #endregion

        #region  Моніторинг джобів
        public IQueryable<V_PFU_JOB_INFO> GetJobList()
        {
            string sql = @"select * from pfu.v_pfu_job_info";
            //var list = _pfu.ExecuteStoreQuery<V_PFU_JOB_INFO>(sql).ToList();
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var l = connection.Query<V_PFU_JOB_INFO>(sql).AsQueryable();
                return l;
            }

        }
        public void JobON(string job_name)
        {
            var p = new DynamicParameters();
            p.Add("p_job_name", dbType: DbType.String, size: 100, value: job_name, direction: ParameterDirection.Input);

            var sql = @"begin pfu.pfu_service_utl.enable_job(:p_job_name); end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }
        public void JobOFF(string job_name)
        {
            var p = new DynamicParameters();
            p.Add("p_job_name", dbType: DbType.String, size: 100, value: job_name, direction: ParameterDirection.Input);

            var sql = @"begin pfu.pfu_service_utl.disable_job(:p_job_name); end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }
        public void JobStart(string job_name)
        {
            var p = new DynamicParameters();
            p.Add("p_job_name", dbType: DbType.String, size: 100, value: job_name, direction: ParameterDirection.Input);

            var sql = @"begin pfu.pfu_service_utl.start_job(:p_job_name); end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }
        public void JobStop(string job_name)
        {
            var p = new DynamicParameters();
            p.Add("p_job_name", dbType: DbType.String, size: 100, value: job_name, direction: ParameterDirection.Input);

            var sql = @"begin pfu.pfu_service_utl.stop_job(:p_job_name); end;";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }

        #endregion


        public string PrepareForNoTurnover(decimal id, string mfo)
        {

            string sql = @"select pfu.pfu_service_utl.prepare_no_turnover(:p_nt_id, :p_mfo, 1) from dual";
            var parameters = new object[]
            {
                new OracleParameter("p_nt_id", OracleDbType.Decimal) { Value = id },
                new OracleParameter("p_mfo", OracleDbType.Varchar2) {Value = mfo }
            };
            return _pfu.ExecuteStoreQuery<string>(sql, parameters).FirstOrDefault();
        }
        public void GenNoTurnover(FileForNoTurnOver d)
        {
            string sql = "begin pfu.pfu_service_utl.gen_no_turnover(:p_nt_id, :p_mfo, :p_ecp); end;";

            var parameters = new object[]
            {
                new OracleParameter("p_nt_id", OracleDbType.Decimal) { Value = d.ID },
                new OracleParameter("p_mfo", OracleDbType.Varchar2) {Value = d.MFO },
                new OracleParameter("p_ecp ", OracleDbType.Varchar2) {Value = d.SIGN}
            };
            _pfu.ExecuteStoreQuery<FileForNoTurnOver>(sql, parameters).FirstOrDefault();
        }

        public string GetBranch()
        {
            string SqlText = @"select branch_usr.get_branch from dual";
            return _pfu.ExecuteStoreQuery<string>(SqlText).FirstOrDefault();
        }

        public IEnumerable<FileType> GetFileTypes()
        {
            return _pfu.ExecuteStoreQuery<FileType>("select id, name from pfu.PFU_FILE_TYPE", null).AsEnumerable();
        }
    }

    public class DummyEppLine
    {
        public string value { get; set; }
        public DbType type { get; set; }
        public string key { get; set; }
    }

    public class DummyEppLineSql
    {
        public List<DummyEppLine> values { get; set; }
        public string template { get; set; }
    }
}

