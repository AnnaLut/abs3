using BarsWeb.Areas.KFiles.Infrastructure.DI.Abstract;
using BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.KFiles.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Linq;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using System.Text;
using Areas.KFiles.Models;

namespace BarsWeb.Areas.KFiles.Infrastucture.DI.Implementation
{
    public class KFilesAccountCorpRepository : IKFilesAccountCorpRepository
    {
        public BarsSql _getSql;
        readonly KFilesEntities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public KFilesAccountCorpRepository(IKFilesModel model, IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            _entities = model.KFilesEntities;
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }
        
        public List<V_CORP_ACCOUNTS_WEB> GetAccountCorp([DataSourceRequest] DataSourceRequest request, List<decimal> corpIndexes)
        {
            InitGetAccountsCorp(corpIndexes);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<V_CORP_ACCOUNTS_WEB>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        private void InitGetAccountsCorp(List<decimal> corpIndexes)
        {
            string corpCodes = string.Empty;

            if (corpIndexes != null)
            {
                StringBuilder query = new StringBuilder();
                for (int i = 0; i < corpIndexes.Count; i++)
                {
                    if (i == corpIndexes.Count - 1)
                    {
                        query.Append(corpIndexes[i]);
                    }
                    else
                    {
                        query.Append(corpIndexes[i] + ", ");
                    }
                }

                corpCodes = query.ToString();

                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@"select RNK, CORP_KOD as CORPORATION_CODE, CORP_NAME as CORPORATION_NAME, NMK, OKPO, NLS, KV, BRANCH, NMS, USE_INVP, TRKK_KOD, INST_KOD, ALT_CORP_COD from bars.V_CORP_ACCOUNTS_WEB
                                              WHERE CORP_KOD in ({0}) order by CORP_KOD", corpCodes),
                    SqlParams = new object[]
                    {
                        //new OracleParameter("P_CORP_KOD", OracleDbType.Varchar2) { Value = corpCodes }
                    }
                };
            }
            else
            {
                _getSql = new BarsSql()
                {
                    SqlText = @"select RNK, CORP_KOD as CORPORATION_CODE, CORP_NAME as CORPORATION_NAME, NMK, OKPO, NLS, KV, BRANCH, NMS, USE_INVP, TRKK_KOD, INST_KOD, ALT_CORP_COD from bars.V_CORP_ACCOUNTS_WEB",
                    SqlParams = new object[] { }
                };
            }
        }
        public decimal GetAccountCorpDataCount([DataSourceRequest] DataSourceRequest request, List<decimal> corpIndexes)
        {
            InitGetAccountsCorp(corpIndexes);
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }


        public IQueryable<V_OB_CORPORATION> GetCorpFilter()
        {
            string query = string.Format(@"select * 
                                          from OB_CORPORATION 
                                          where PARENT_ID is null");
            return _entities.ExecuteStoreQuery<V_OB_CORPORATION>(query).AsQueryable();
        }

        public List<V_ROOT_CORPORATION> GetDropDownAltCorpName([DataSourceRequest] DataSourceRequest request)
        {
            InitDropDownAltCorpName();
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<V_ROOT_CORPORATION>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        private void InitDropDownAltCorpName()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT V.EXTERNAL_ID , V.CORPORATION_NAME AS ALT_CORP_NAME  FROM V_ROOT_CORPORATION V ORDER BY TO_NUMBER(EXTERNAL_ID)"),
                SqlParams = new object[] { }
            };
        }

        private void InitCorporationsGrid()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_ORG_CORPORATIONS"),
                SqlParams = new object[] { }
            };
        }

        public void AccCorpSave(List<AccCorpSave> accCorpSave)
        {
            _getSql = new BarsSql();
            _getSql.SqlText = string.Format(@" begin KFILE_PACK.UPDATE_ACC_CORP( :p_acc_corp_params ); end;");

            _getSql.SqlParams = new object[]
            {

                new OracleParameter("p_acc_corp_params", OracleDbType.Array)
                {
                    UdtTypeName = "BARS.T_ACC_CORP_PARAMS",
                    Value = accCorpSave.ToArray()
                }

            };
             _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
            
        }

        public List<V_ORG_CORPORATIONS> GetCorporationsGrid([DataSourceRequest] DataSourceRequest request)
        {
            InitCorporationsGrid();
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<V_ORG_CORPORATIONS>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public decimal GetCorporationsDataCount([DataSourceRequest] DataSourceRequest request)
        {
            InitCorporationsGrid();
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }
    }
}