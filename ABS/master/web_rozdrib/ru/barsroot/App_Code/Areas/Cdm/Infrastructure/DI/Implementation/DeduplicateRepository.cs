using System;
using System.Collections.Generic;
using System.Linq;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation
{
    public class DeduplicateRepository : IDeduplicateRepository
    {
        private readonly CdmModel _entities;
        private BarsSql _groupSelectSql;
        private readonly IKendoSqlTransformer _kendoSqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        private readonly IBanksRepository _banksRepository;

        public DeduplicateRepository(IBanksRepository banksRepository, IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdmModel", "Cdm");
            _entities = new CdmModel(connectionStr);
            _kendoSqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _banksRepository = banksRepository;
        }

        private void InitSelectDedupeGroups(DupGroupParams groupParams)
        {
            if (_groupSelectSql != null)
            {
                return;
            }
            bool firstWhere = true;
            List<object> tmpParams = new List<object>();
            _groupSelectSql = new BarsSql()
            {
                SqlText = @"select M_RNK, NMK, QTY_D_RNK, BRANCH from EBK_DUP_GRP_LIST_V ",
                SqlParams = new object[] { }
            };

            if (!groupParams.IsParamsEmpty)
            {
                _groupSelectSql.SqlText = _groupSelectSql.SqlText + " where";

                if (groupParams.M_rnk != null)
                {
                    _groupSelectSql.SqlText = _groupSelectSql.SqlText + " M_RNK = :p_rnk";
                    tmpParams.Add(new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = groupParams.M_rnk });
                    firstWhere = false;
                }
                if (!string.IsNullOrEmpty(groupParams.Okpo))
                {
                    _groupSelectSql.SqlText = _groupSelectSql.SqlText + (!firstWhere ? " and" : "") + " OKPO = :p_okpo";
                    tmpParams.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2) { Value = groupParams.Okpo });
                    firstWhere = false;
                }
                if (!string.IsNullOrEmpty(groupParams.Document.Trim()))
                {
                    _groupSelectSql.SqlText = _groupSelectSql.SqlText + (!firstWhere ? " and" : "") + " DOCUMENT = :p_document";
                    tmpParams.Add(new OracleParameter("p_document", OracleDbType.Varchar2) { Value = groupParams.Document });
                    firstWhere = false;
                }
                if (groupParams.Card_Quality != null && groupParams.Card_Quality < 100)
                {
                    _groupSelectSql.SqlText = _groupSelectSql.SqlText + (!firstWhere ? " and" : "") + "  CARD_QUALITY <= :p_quality";
                    tmpParams.Add(new OracleParameter("p_quality", OracleDbType.Decimal) { Value = groupParams.Card_Quality });
                    firstWhere = false;
                }
                if (!string.IsNullOrEmpty(groupParams.Nmk))
                {
                    _groupSelectSql.SqlText = _groupSelectSql.SqlText + (!firstWhere ? " and" : "") + " NMK = :p_nmk";
                    tmpParams.Add(new OracleParameter("p_nmk", OracleDbType.Varchar2) { Value = groupParams.Nmk });
                    firstWhere = false;
                }
                if (!String.IsNullOrEmpty(groupParams.Branch.Trim()))
                {
                    _groupSelectSql.SqlText = _groupSelectSql.SqlText + (!firstWhere ? " and" : "") + " BRANCH = :p_branch";
                    tmpParams.Add(new OracleParameter("p_branch", OracleDbType.Varchar2) { Value = groupParams.Branch });
                }
                _groupSelectSql.SqlParams = tmpParams.ToArray();
            }            
        }

        public IEnumerable<DupGroup> RequestEbkClient(DupGroupParams groupParams, DataSourceRequest request)
        {
            InitSelectDedupeGroups(groupParams);
            var sql = _kendoSqlTransformer.TransformSql(_groupSelectSql, request);
            return _entities.ExecuteStoreQuery<DupGroup>(sql.SqlText, sql.SqlParams);
        }

        public decimal RequestEbkClientCount(DupGroupParams groupParams, DataSourceRequest request)
        {
            InitSelectDedupeGroups(groupParams);
            var filteredSql = _kendoSqlCounter.TransformSql(_groupSelectSql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(filteredSql.SqlText, filteredSql.SqlParams).Single();
            return total;
        }

        public DupMainCard GetMainCard(decimal rnk)
        {
            return _entities.ExecuteStoreQuery<DupMainCard>("select * from EBK_DUP_GRP_LIST_V where M_RNK = :p_rnk",
                new object[] { new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = rnk } }).SingleOrDefault();
        }

        public IEnumerable<DupChildCard> GetChildCards(decimal rnk)
        {
            return _entities.ExecuteStoreQuery<DupChildCard>("select * from  EBK_DUP_CHILD_LIST_V where M_RNK = :p_rnk",
                new object[] { new OracleParameter("p_quality", OracleDbType.Decimal) { Value = rnk } });
        }

        public IEnumerable<AttrGroup> GetAttrGroups(decimal rnk)
        {
            return _entities.ExecuteStoreQuery<AttrGroup>(@"select distinct ATTR_GR_ID,  ATTR_GR_NAME
                            from EBK_DUP_CUST_ATTR_LIST_V 
                            where rnk = :m_rnk 
                            order by ATTR_GR_ID ",
                new object[] { new OracleParameter("m_rnk", OracleDbType.Decimal) { Value = rnk } });
        }
        public IEnumerable<AttributeMainCard> GetCardAttributes(decimal rnk)
        {
            return _entities.ExecuteStoreQuery<AttributeMainCard>(@"select ATTR_GR_ID, NAME, DB_VALUE, ATT_UKR_NAME, REQUIRED, TYPE
                        from EBK_DUP_CUST_ATTR_LIST_V 
                        where rnk = :m_rnk 
                        order by ATTR_GR_ID, SORT_NUM ",
                new object[] { new OracleParameter("m_rnk", OracleDbType.Decimal) { Value = rnk } });
        }

        public void SetCardAsMaster(decimal mRnk, decimal dRnk)
        {
            _entities.ExecuteStoreCommand(@"begin ebk_dup_wform_utl.change_master_card(:p_m_rnk, :p_new_m_rnk);  end;",
                new object[]
                {
                    new OracleParameter("p_m_rnk", OracleDbType.Decimal) { Value = mRnk },
                    new OracleParameter("p_new_m_rnk", OracleDbType.Decimal) { Value = dRnk }
                });
        }


        public void IgnoreChild(decimal mRnk, decimal dRnk)
        {
            _entities.ExecuteStoreCommand(@"begin ebk_dup_wform_utl.ignore_card(:p_m_rnk, :p_new_m_rnk);  end;",
                new object[]
                {
                    new OracleParameter("p_m_rnk", OracleDbType.Decimal) { Value = mRnk },
                    new OracleParameter("p_new_m_rnk", OracleDbType.Decimal) { Value = dRnk }
                });
        }

        public void MergeDupes(decimal mRnk, decimal dRnk)
        {
            _entities.ExecuteStoreCommand(@"begin ebk_dup_wform_utl.merge_2rnk(:p_m_rnk, :p_new_m_rnk);  end;",
                new object[]
                {
                    new OracleParameter("p_m_rnk", OracleDbType.Decimal) { Value = dRnk },
                    new OracleParameter("p_new_m_rnk", OracleDbType.Decimal) { Value = mRnk }
                });
        }

        private void SetNewAttributeValue(decimal rnk, string attrName, string value)
        {
            _entities.ExecuteStoreCommand(@"begin ebk_dup_wform_utl.change_cust_attr(:p_rnk, :p_attr_name, :p_new_val);  end;",
                new object[]
                {
                    new OracleParameter("p_m_rnk", OracleDbType.Decimal) { Value = rnk },
                    new OracleParameter("p_attr_name", OracleDbType.Varchar2) { Value = attrName },
                    new OracleParameter("p_new_val", OracleDbType.Varchar2) { Value = value }
                });
        }

        public void MoveAttributesFromChild(decimal rnk, string[] attributes, string[] values)
        {
            if (attributes.Length != values.Length)
            {
                throw new Exception("Кількість параметрів не відповідає кількості значень!");
            }
            for (int i = 0; i < attributes.Length; i++)
            {
                SetNewAttributeValue(rnk, attributes[i], values[i]);
            }
        }


        public EBK_GCIF GetGcif(decimal rnk, string kf = null)
        {
            var ourMfo = kf ?? _banksRepository.GetOurMfo();
            return _entities.EBK_GCIF.FirstOrDefault(g => g.KF == ourMfo && g.RNK == rnk);
        }
    }
}