using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using DropDownList = BarsWeb.Areas.Cdm.Models.DropDownList;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation
{
    public class QualityRepository : IQualityRepository
    {
        private readonly CdmModel _entities;
        private readonly IBanksRepository _banksRepository;
        private readonly IKendoSqlTransformer _kendoSqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        private string _lastDialogDescr;
        private decimal _lastDialogDataLendth;
        private BarsSql _baseAdvListSql;
        private const string WholeCardQualityGroupName = "card";


        private void InitBaseAdvListSql(AdvisoryListParams advisoryListParams, DataSourceRequest request)
        {
            if (advisoryListParams.Type == "individualPerson")
            {
                _baseAdvListSql = new BarsSql()
                {
                    SqlText = @" select *  from table  (ebk_get_cust_subgrp_f (p_group_id => :p_group_id, 
                                                       p_prc_quality_id => :p_prc_quality_id, 
                                                       p_nmk => :p_customer_name,
                                                       p_rnk => :p_rnk,
                                                       p_okpo => :p_inn,
                                                       p_ser => :p_ser,
                                                       p_numdoc => :p_numdoc,
                                                       p_quality_group => :p_quality_group, 
                                                       p_percent => :p_percent,  
                                                       p_attr_qty => :p_attr_qty, 
                                                       p_branch => :p_branch, 
                                                       p_rn_from => :p_rn_from,
                                                       p_rn_to => :p_rn_to))",
                    SqlParams = new object[]
                            {
                    new OracleParameter("p_group_id", OracleDbType.Decimal) {Value = advisoryListParams.GroupId},
                    new OracleParameter("p_prc_quality_id", OracleDbType.Decimal) {Value = advisoryListParams.SubGroupId},
                    new OracleParameter("p_customer_name", OracleDbType.Varchar2) { Value = advisoryListParams.CustName },
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = advisoryListParams.CustRnk },
                    new OracleParameter("p_inn", OracleDbType.Decimal) { Value = advisoryListParams.CustInn },
                    new OracleParameter("p_ser", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocSerial },
                    new OracleParameter("p_numdoc", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocNumber },
                    new OracleParameter("p_quality_group", OracleDbType.Varchar2)
                    {
                        Value =
                            String.IsNullOrEmpty(advisoryListParams.CustQualityGroup) ||
                            advisoryListParams.CustQualityGroup == WholeCardQualityGroupName
                                ? null
                                : advisoryListParams.CustQualityGroup
                    },
                    new OracleParameter("p_percent", OracleDbType.Decimal) {Value = advisoryListParams.CustQuality},
                    new OracleParameter("p_attr_qty", OracleDbType.Decimal) {Value = advisoryListParams.CustAtrCount},
                    new OracleParameter("p_branch", OracleDbType.Varchar2) {Value = advisoryListParams.CustBranch},
                    new OracleParameter("p_rn_from", OracleDbType.Decimal) {Value = (request.Page - 1) * request.PageSize + 1},
                    new OracleParameter("p_rn_to", OracleDbType.Decimal) {Value = request.Page * request.PageSize}
                            }
                };
            }
            else if (advisoryListParams.Type == "legalPerson")
            {
                _baseAdvListSql = new BarsSql()
                {
                    SqlText = @" select *  from table  (ebkc_wforms_utl.get_legal_subgrp (p_group_id => :p_group_id, 
                                                       p_prc_quality_id => :p_prc_quality_id, 
                                                       p_nmk => :p_customer_name,
                                                       p_rnk => :p_rnk,
                                                       p_okpo => :p_inn,
                                                       p_quality_group => :p_quality_group, 
                                                       p_percent => :p_percent,  
                                                       p_attr_qty => :p_attr_qty, 
                                                       p_branch => :p_branch, 
                                                       p_rn_from => :p_rn_from,
                                                       p_rn_to => :p_rn_to))",
                    SqlParams = new object[]
                        {
                    new OracleParameter("p_group_id", OracleDbType.Decimal) {Value = advisoryListParams.GroupId},
                    new OracleParameter("p_prc_quality_id", OracleDbType.Decimal) {Value = advisoryListParams.SubGroupId},
                    new OracleParameter("p_customer_name", OracleDbType.Varchar2) { Value = advisoryListParams.CustName },
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = advisoryListParams.CustRnk },
                    new OracleParameter("p_inn", OracleDbType.Decimal) { Value = advisoryListParams.CustInn },
                    new OracleParameter("p_quality_group", OracleDbType.Varchar2)
                    {
                        Value =
                            String.IsNullOrEmpty(advisoryListParams.CustQualityGroup) ||
                            advisoryListParams.CustQualityGroup == WholeCardQualityGroupName
                                ? null
                                : advisoryListParams.CustQualityGroup
                    },
                    new OracleParameter("p_percent", OracleDbType.Decimal) {Value = advisoryListParams.CustQuality},
                    new OracleParameter("p_attr_qty", OracleDbType.Decimal) {Value = advisoryListParams.CustAtrCount},
                    new OracleParameter("p_branch", OracleDbType.Varchar2) {Value = advisoryListParams.CustBranch},
                    new OracleParameter("p_rn_from", OracleDbType.Decimal) {Value = (request.Page - 1) * request.PageSize + 1},
                    new OracleParameter("p_rn_to", OracleDbType.Decimal) {Value = request.Page * request.PageSize}
                        }
                };

            }
            else if (advisoryListParams.Type == "entrepreneurPerson")
            {
                _baseAdvListSql = new BarsSql()
                {
                    SqlText = @" select *  from table  (ebkc_wforms_utl.get_priv_subgrp (p_group_id => :p_group_id, 
                                                       p_prc_quality_id => :p_prc_quality_id, 
                                                       p_nmk => :p_customer_name,
                                                       p_rnk => :p_rnk,
                                                       p_okpo => :p_inn,
                                                       p_ser => :p_ser,
                                                       p_numdoc => :p_numdoc,
                                                       p_quality_group => :p_quality_group, 
                                                       p_percent => :p_percent,  
                                                       p_attr_qty => :p_attr_qty, 
                                                       p_branch => :p_branch, 
                                                       p_rn_from => :p_rn_from,
                                                       p_rn_to => :p_rn_to))",
                    SqlParams = new object[]
                        {
                    new OracleParameter("p_group_id", OracleDbType.Decimal) {Value = advisoryListParams.GroupId},
                    new OracleParameter("p_prc_quality_id", OracleDbType.Decimal) {Value = advisoryListParams.SubGroupId},
                    new OracleParameter("p_customer_name", OracleDbType.Varchar2) { Value = advisoryListParams.CustName },
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = advisoryListParams.CustRnk },
                    new OracleParameter("p_inn", OracleDbType.Decimal) { Value = advisoryListParams.CustInn },
                    new OracleParameter("p_ser", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocSerial },
                    new OracleParameter("p_numdoc", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocNumber },
                    new OracleParameter("p_quality_group", OracleDbType.Varchar2)
                    {
                        Value =
                            String.IsNullOrEmpty(advisoryListParams.CustQualityGroup) ||
                            advisoryListParams.CustQualityGroup == WholeCardQualityGroupName
                                ? null
                                : advisoryListParams.CustQualityGroup
                    },
                    new OracleParameter("p_percent", OracleDbType.Decimal) {Value = advisoryListParams.CustQuality},
                    new OracleParameter("p_attr_qty", OracleDbType.Decimal) {Value = advisoryListParams.CustAtrCount},
                    new OracleParameter("p_branch", OracleDbType.Varchar2) {Value = advisoryListParams.CustBranch},
                    new OracleParameter("p_rn_from", OracleDbType.Decimal) {Value = (request.Page - 1) * request.PageSize + 1},
                    new OracleParameter("p_rn_to", OracleDbType.Decimal) {Value = request.Page * request.PageSize}
                        }
                };
            }

        }

        public string LastDialogDescription()
        {
            return _lastDialogDescr;
        }

        public decimal LastDialogDataLendth()
        {
            return _lastDialogDataLendth;
        }

        public QualityRepository(IBanksRepository banksRepository, IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdmModel", "Cdm");
            _entities = new CdmModel(connectionStr);
            _banksRepository = banksRepository;
            _kendoSqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }
        public IEnumerable<QualityGroup> GetQualityGroups(bool isAdminMode, string type)
        {

            if (type == "individualPerson")
            {
                var result = _entities.ExecuteStoreQuery<QualityGroup>("select id, name from EBK_GROUPS order by id").ToList();
                foreach (var grp in result)
                {
                    if (!isAdminMode)
                    {
                        grp.CardCount = GetCardCountInGroup(grp.Id, type);
                    }
                    else
                    {
                        grp.CardCount = grp.Id * 11;
                    }
                }
                return result;
            }
            else if (type == "legalPerson")
            {
                var result = _entities.ExecuteStoreQuery<QualityGroup>("select id, name from V_EBKC_GROUPS_LEGAL order by id").ToList();
                foreach (var grp in result)
                {
                    if (!isAdminMode)
                    {
                        grp.CardCount = GetCardCountInGroup(grp.Id, type);
                    }
                    else
                    {
                        grp.CardCount = grp.Id * 11;
                    }
                }
                return result;
            }
            else if (type == "entrepreneurPerson")
            {
                var result = _entities.ExecuteStoreQuery<QualityGroup>("select id, name from V_EBKC_GROUPS_PRIVATE order by id").ToList();
                foreach (var grp in result)
                {
                    if (!isAdminMode)
                    {
                        grp.CardCount = GetCardCountInGroup(grp.Id, type);
                    }
                    else
                    {
                        grp.CardCount = grp.Id * 11;
                    }
                }
                return result;
            }
            return null;

        }

        private decimal GetCardCountInGroup(decimal groupId, string type)
        {
            if (type == "individualPerson")
            {
                var sqlParams = new object[]
                {
                        new OracleParameter("p_group_id", OracleDbType.Int16)
                        {
                            Value = groupId
                        }
                };
                return
                    _entities.ExecuteStoreQuery<decimal>(
                        "select EBK_WFORMS_UTL.GET_CUST_QUANTITY_FOR_GROUP(:p_group_id) from dual", sqlParams).Single();
            }
            else if (type == "legalPerson")
            {
                var sqlParams = new object[]
                {
                        new OracleParameter("p_group_id", OracleDbType.Int16)
                        {
                            Value = groupId
                        }
                };
                return
                    _entities.ExecuteStoreQuery<decimal>(
                        "select EBKC_WFORMS_UTL.get_legal_quantity_for_group(:p_group_id) from dual", sqlParams).Single();
            }
            else if (type == "entrepreneurPerson")
            {
                var sqlParams = new object[]
                {
                        new OracleParameter("p_group_id", OracleDbType.Int16)
                        {
                            Value = groupId
                        }
                };
                return
                    _entities.ExecuteStoreQuery<decimal>(
                        "select EBKC_WFORMS_UTL.get_priv_quantity_for_group(:p_group_id) from dual", sqlParams).Single();
            }
            return 0;
        }


        public IEnumerable<QualitySubGroup> GetQualitySubGroups(string type)
        {
            if (type == "individualPerson")
            {
                return
                    _entities.ExecuteStoreQuery<QualitySubGroup>(@"select  id_grp, ID_PRC_QUALITY, PRC_QUALITY_TXT, PRC_QUALITY_DESCR, PRC_QUALITY_NAME, PRC_QUALITY_ORD   
                                                                    from EBK_SUB_GROUPS_V
                                                                    order by id_grp, id_prc_quality");
            }
            else if (type == "legalPerson")
            {
                return
                   _entities.ExecuteStoreQuery<QualitySubGroup>(@"select  id_grp, ID_PRC_QUALITY, PRC_QUALITY_TXT, PRC_QUALITY_DESCR, PRC_QUALITY_NAME, PRC_QUALITY_ORD  
                                                                    from  V_EBKC_SUB_GROUPS_LEGAL
                                                                    order by id_grp, id_prc_quality");
            }
            else if (type == "entrepreneurPerson")
            {
                return
                   _entities.ExecuteStoreQuery<QualitySubGroup>(@"select  id_grp, ID_PRC_QUALITY, PRC_QUALITY_TXT, PRC_QUALITY_DESCR, PRC_QUALITY_NAME, PRC_QUALITY_ORD  
                                                                    from V_EBKC_SUB_GROUPS_PRIV
                                                                    order by id_grp, id_prc_quality");
            }
            return null;

        }
        public IQueryable<EBK_CUST_SUBGRP_V> GetAdvisoryList(AdvisoryListParams advisoryListParams)
        {

            var result = _entities.EBK_CUST_SUBGRP_V.Where(a => a.GROUP_ID == advisoryListParams.GroupId);

            if (advisoryListParams.SubGroupId != null)
            {
                result = result.Where(a => a.ID_PRC_QUALITY == advisoryListParams.SubGroupId);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustName))
            {
                result = result.Where(a => a.NMK.ToUpper().Contains(advisoryListParams.CustName.ToUpper()));
            }
            if (advisoryListParams.CustRnk != null)
            {
                result = result.Where(a => a.RNK == advisoryListParams.CustRnk);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustInn))
            {
                result = result.Where(a => a.OKPO == advisoryListParams.CustInn);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustDocSerial))
            {
                result = result.Where(a => a.DOCUMENT.StartsWith(advisoryListParams.CustDocSerial));
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustDocNumber))
            {
                result = result.Where(a => a.DOCUMENT.EndsWith(advisoryListParams.CustDocNumber));
            }
            if (advisoryListParams.CustQuality != null)
            {
                result = result.Where(a => a.QUALITY <= advisoryListParams.CustQuality);
            }
            if (advisoryListParams.CustAtrCount != null)
            {
                result = result.Where(a => a.ATTR_QTY >= advisoryListParams.CustAtrCount);
            }
            return result;


        }

        public IQueryable<V_EBKC_LEGAL_SUBGRP> GetAdvisoryListLegal(AdvisoryListParams advisoryListParams)
        {

            var result = _entities.V_EBKC_LEGAL_SUBGRP.Where(a => a.GROUP_ID == advisoryListParams.GroupId);

            if (advisoryListParams.SubGroupId != null)
            {
                result = result.Where(a => a.ID_PRC_QUALITY == advisoryListParams.SubGroupId);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustName))
            {
                result = result.Where(a => a.NMK.ToUpper().Contains(advisoryListParams.CustName.ToUpper()));
            }
            if (advisoryListParams.CustRnk != null)
            {
                result = result.Where(a => a.RNK == advisoryListParams.CustRnk);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustInn))
            {
                result = result.Where(a => a.OKPO == advisoryListParams.CustInn);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustDocSerial))
            {
                result = result.Where(a => a.DOCUMENT.StartsWith(advisoryListParams.CustDocSerial));
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustDocNumber))
            {
                result = result.Where(a => a.DOCUMENT.EndsWith(advisoryListParams.CustDocNumber));
            }
            if (advisoryListParams.CustQuality != null)
            {
                result = result.Where(a => a.QUALITY <= advisoryListParams.CustQuality);
            }
            if (advisoryListParams.CustAtrCount != null)
            {
                result = result.Where(a => a.ATTR_QTY >= advisoryListParams.CustAtrCount);
            }
            return result;


        }

        public IQueryable<V_EBKC_PRIV_SUBGRP> GetAdvisoryListPrivate(AdvisoryListParams advisoryListParams)
        {

            var result = _entities.V_EBKC_PRIV_SUBGRP.Where(a => a.GROUP_ID == advisoryListParams.GroupId);

            if (advisoryListParams.SubGroupId != null)
            {
                result = result.Where(a => a.ID_PRC_QUALITY == advisoryListParams.SubGroupId);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustName))
            {
                result = result.Where(a => a.NMK.ToUpper().Contains(advisoryListParams.CustName.ToUpper()));
            }
            if (advisoryListParams.CustRnk != null)
            {
                result = result.Where(a => a.RNK == advisoryListParams.CustRnk);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustInn))
            {
                result = result.Where(a => a.OKPO == advisoryListParams.CustInn);
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustDocSerial))
            {
                result = result.Where(a => a.DOCUMENT.StartsWith(advisoryListParams.CustDocSerial));
            }
            if (!String.IsNullOrEmpty(advisoryListParams.CustDocNumber))
            {
                result = result.Where(a => a.DOCUMENT.EndsWith(advisoryListParams.CustDocNumber));
            }
            if (advisoryListParams.CustQuality != null)
            {
                result = result.Where(a => a.QUALITY <= advisoryListParams.CustQuality);
            }
            if (advisoryListParams.CustAtrCount != null)
            {
                result = result.Where(a => a.ATTR_QTY >= advisoryListParams.CustAtrCount);
            }
            return result;


        }

        public IEnumerable<EBK_CUST_SUBGRP_V> GetAdvisoryList(AdvisoryListParams advisoryListParams, DataSourceRequest request)
        {
            InitBaseAdvListSql(advisoryListParams, request);
            var result = _entities.ExecuteStoreQuery<EBK_CUST_SUBGRP_V>(_baseAdvListSql.SqlText, _baseAdvListSql.SqlParams).ToList();
            return result;
        }

        public IEnumerable<V_EBKC_LEGAL_SUBGRP> GetAdvisoryListLegal(AdvisoryListParams advisoryListParams, DataSourceRequest request)
        {
            InitBaseAdvListSql(advisoryListParams, request);
            var result = _entities.ExecuteStoreQuery<V_EBKC_LEGAL_SUBGRP>(_baseAdvListSql.SqlText, _baseAdvListSql.SqlParams).ToList();
            return result;
        }

        public IEnumerable<V_EBKC_PRIV_SUBGRP> GetAdvisoryListPrivate(AdvisoryListParams advisoryListParams, DataSourceRequest request)
        {
            InitBaseAdvListSql(advisoryListParams, request);
            var result = _entities.ExecuteStoreQuery<V_EBKC_PRIV_SUBGRP>(_baseAdvListSql.SqlText, _baseAdvListSql.SqlParams).ToList();
            return result;
        }

        public decimal GetAdvisoryListCount(AdvisoryListParams advisoryListParams, DataSourceRequest request)
        {
            if (advisoryListParams.Type == "individualPerson")
            {
                _baseAdvListSql = new BarsSql()
                {
                    SqlText = @"begin ebk_wforms_utl.get_cust_subgrp_count(p_group_id => :p_group_id, 
                                                       p_prc_quality_id => :p_prc_quality_id, 
                                                       p_nmk => :p_customer_name,
                                                       p_rnk => :p_rnk,
                                                       p_okpo => :p_inn,
                                                       p_ser => :p_ser,
                                                       p_numdoc => :p_numdoc,
                                                       p_quality_group => :p_quality_group, 
                                                       p_percent => :p_percent,                                                        
                                                       p_attr_qty => :p_attr_qty, 
                                                       p_branch => :p_branch,
                                                       p_count_row => :p_rn_from); end;",
                    SqlParams = new object[]
                {
                    new OracleParameter("p_group_id", OracleDbType.Decimal) {Value = advisoryListParams.GroupId},
                    new OracleParameter("p_prc_quality_id", OracleDbType.Decimal) {Value = advisoryListParams.SubGroupId},
                    new OracleParameter("p_customer_name", OracleDbType.Varchar2) { Value = advisoryListParams.CustName },
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = advisoryListParams.CustRnk },
                    new OracleParameter("p_inn", OracleDbType.Decimal) { Value = advisoryListParams.CustInn },
                    new OracleParameter("p_ser", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocSerial },
                    new OracleParameter("p_numdoc", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocNumber },
                    new OracleParameter("p_quality_group", OracleDbType.Varchar2)
                    {
                        Value =
                            String.IsNullOrEmpty(advisoryListParams.CustQualityGroup) ||
                            advisoryListParams.CustQualityGroup == WholeCardQualityGroupName
                                ? null
                                : advisoryListParams.CustQualityGroup
                    },
                    new OracleParameter("p_percent", OracleDbType.Decimal) {Value = advisoryListParams.CustQuality},
                    new OracleParameter("p_attr_qty", OracleDbType.Decimal) {Value = advisoryListParams.CustAtrCount},
                    new OracleParameter("p_branch", OracleDbType.Varchar2) {Value = advisoryListParams.CustBranch},
                    new OracleParameter("p_count_row", OracleDbType.Decimal) {Direction  = ParameterDirection.Output }
                }
                };

                _entities.ExecuteStoreCommand(_baseAdvListSql.SqlText, _baseAdvListSql.SqlParams);
                return decimal.Parse(((OracleParameter)_baseAdvListSql.SqlParams[11]).Value.ToString());
            }
            else if (advisoryListParams.Type == "legalPerson")
            {
                _baseAdvListSql = new BarsSql()
                {
                    SqlText = @"begin ebkc_wforms_utl.get_legal_subgrp_count(p_group_id => :p_group_id, 
                                                       p_prc_quality_id => :p_prc_quality_id, 
                                                       p_nmk => :p_customer_name,
                                                       p_rnk => :p_rnk,
                                                       p_okpo => :p_inn,
                                                       p_quality_group => :p_quality_group, 
                                                       p_percent => :p_percent,                                                        
                                                       p_attr_qty => :p_attr_qty, 
                                                       p_branch => :p_branch,
                                                       p_count_row => :p_rn_from); end;",
                    SqlParams = new object[]
                      {
                    new OracleParameter("p_group_id", OracleDbType.Decimal) {Value = advisoryListParams.GroupId},
                    new OracleParameter("p_prc_quality_id", OracleDbType.Decimal) {Value = advisoryListParams.SubGroupId},
                    new OracleParameter("p_customer_name", OracleDbType.Varchar2) { Value = advisoryListParams.CustName },
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = advisoryListParams.CustRnk },
                    new OracleParameter("p_inn", OracleDbType.Decimal) { Value = advisoryListParams.CustInn },
                    new OracleParameter("p_quality_group", OracleDbType.Varchar2)
                    {
                        Value =
                            String.IsNullOrEmpty(advisoryListParams.CustQualityGroup) ||
                            advisoryListParams.CustQualityGroup == WholeCardQualityGroupName
                                ? null
                                : advisoryListParams.CustQualityGroup
                    },
                    new OracleParameter("p_percent", OracleDbType.Decimal) {Value = advisoryListParams.CustQuality},
                    new OracleParameter("p_attr_qty", OracleDbType.Decimal) {Value = advisoryListParams.CustAtrCount},
                    new OracleParameter("p_branch", OracleDbType.Varchar2) {Value = advisoryListParams.CustBranch},
                    new OracleParameter("p_count_row", OracleDbType.Decimal) {Direction  = ParameterDirection.Output }
                      }
                };

                _entities.ExecuteStoreCommand(_baseAdvListSql.SqlText, _baseAdvListSql.SqlParams);
                return decimal.Parse(((OracleParameter)_baseAdvListSql.SqlParams[9]).Value.ToString());
            }
            else if (advisoryListParams.Type == "entrepreneurPerson")
            {
                _baseAdvListSql = new BarsSql()
                {
                    SqlText = @"begin ebkc_wforms_utl.get_priv_subgrp_count(p_group_id => :p_group_id, 
                                                       p_prc_quality_id => :p_prc_quality_id, 
                                                       p_nmk => :p_customer_name,
                                                       p_rnk => :p_rnk,
                                                       p_okpo => :p_inn,
                                                       p_ser => :p_ser,
                                                       p_numdoc => :p_numdoc,
                                                       p_quality_group => :p_quality_group, 
                                                       p_percent => :p_percent,                                                        
                                                       p_attr_qty => :p_attr_qty, 
                                                       p_branch => :p_branch,
                                                       p_count_row => :p_rn_from); end;",
                    SqlParams = new object[]
                       {
                    new OracleParameter("p_group_id", OracleDbType.Decimal) {Value = advisoryListParams.GroupId},
                    new OracleParameter("p_prc_quality_id", OracleDbType.Decimal) {Value = advisoryListParams.SubGroupId},
                    new OracleParameter("p_customer_name", OracleDbType.Varchar2) { Value = advisoryListParams.CustName },
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = advisoryListParams.CustRnk },
                    new OracleParameter("p_inn", OracleDbType.Decimal) { Value = advisoryListParams.CustInn },
                    new OracleParameter("p_ser", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocSerial },
                    new OracleParameter("p_numdoc", OracleDbType.Varchar2) { Value = advisoryListParams.CustDocNumber },
                    new OracleParameter("p_quality_group", OracleDbType.Varchar2)
                    {
                        Value =
                            String.IsNullOrEmpty(advisoryListParams.CustQualityGroup) ||
                            advisoryListParams.CustQualityGroup == WholeCardQualityGroupName
                                ? null
                                : advisoryListParams.CustQualityGroup
                    },
                    new OracleParameter("p_percent", OracleDbType.Decimal) {Value = advisoryListParams.CustQuality},
                    new OracleParameter("p_attr_qty", OracleDbType.Decimal) {Value = advisoryListParams.CustAtrCount},
                    new OracleParameter("p_branch", OracleDbType.Varchar2) {Value = advisoryListParams.CustBranch},
                    new OracleParameter("p_count_row", OracleDbType.Decimal) {Direction  = ParameterDirection.Output }
                       }
                };

                _entities.ExecuteStoreCommand(_baseAdvListSql.SqlText, _baseAdvListSql.SqlParams);
                return decimal.Parse(((OracleParameter)_baseAdvListSql.SqlParams[11]).Value.ToString());
            }
            return 0;

        }

        public IQueryable<EBK_CUST_ATTR_RECOMEND_V> GetCustAdvisory(decimal rnk)
        {
            var ourMfo = _banksRepository.GetOurMfo();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = rnk,
                        },
                        new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value = ourMfo,
                        }
                    };
            var result = _entities.ExecuteStoreQuery<EBK_CUST_ATTR_RECOMEND_V>("select * from EBK_CUST_ATTR_RECOMEND_V where rnk = :p_rnk and kf = :p_kf order by ATTR_GR_ID, SORT_NUM", sqlParams);
            return result.AsQueryable();
        }

        public IQueryable<V_EBKC_LEGAL_ATTR_RECOMEND> GetCustAdvisoryLegal(decimal rnk)
        {

            var ourMfo = _banksRepository.GetOurMfo();
            var sqlParams = new object[]
                    {
                    new OracleParameter("p_rnk", OracleDbType.Decimal)
                    {
                        Value = rnk,
                    },
                    new OracleParameter("p_kf", OracleDbType.Varchar2)
                    {
                        Value = ourMfo,
                    }
                    };
            var result = _entities.ExecuteStoreQuery<V_EBKC_LEGAL_ATTR_RECOMEND>("select * from V_EBKC_LEGAL_ATTR_RECOMEND where rnk = :p_rnk and kf = :p_kf order by ATTR_GR_ID, SORT_NUM", sqlParams);
            return result.AsQueryable();

        }
        public IQueryable<V_EBKC_PRIV_ATTR_RECOMEND> GetCustAdvisoryPrivate(decimal rnk)
        {

            var ourMfo = _banksRepository.GetOurMfo();
            var sqlParams = new object[]
                    {
                    new OracleParameter("p_rnk", OracleDbType.Decimal)
                    {
                        Value = rnk,
                    },
                    new OracleParameter("p_kf", OracleDbType.Varchar2)
                    {
                        Value = ourMfo,
                    }
                    };
            var result = _entities.ExecuteStoreQuery<V_EBKC_PRIV_ATTR_RECOMEND>("select * from V_EBKC_PRIV_ATTR_RECOMEND where rnk = :p_rnk and kf = :p_kf order by ATTR_GR_ID, SORT_NUM", sqlParams);
            return result.AsQueryable();

        }


        public IQueryable<EBK_CARD_ATTR_GROUPS> GetAllAttrGroups()
        {
            return _entities.EBK_CARD_ATTR_GROUPS;
        }

        public IQueryable<EBK_CUST_ATTR_LIST_V> GetCustAttributesList(decimal rnk)
        {
            var ourMfo = _banksRepository.GetOurMfo();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = rnk,
                        },
                        new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value = ourMfo,
                        }
                    };
            var result = _entities.ExecuteStoreQuery<EBK_CUST_ATTR_LIST_V>("select * from EBK_CUST_ATTR_LIST_V where rnk = :p_rnk and kf = :p_kf order by ATTR_GR_ID, SORT_NUM", sqlParams);
            return result.AsQueryable();
        }
        public IQueryable<V_EBKC_LEGAL_ATTR_LIST> GetCustAttributesListLegal(decimal rnk)
        {
            var ourMfo = _banksRepository.GetOurMfo();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = rnk,
                        },
                        new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value = ourMfo,
                        }
                    };
            var result = _entities.ExecuteStoreQuery<V_EBKC_LEGAL_ATTR_LIST>("select * from V_EBKC_LEGAL_ATTR_LIST where rnk = :p_rnk and kf = :p_kf order by ATTR_GR_ID, SORT_NUM", sqlParams);
            return result.AsQueryable();
        }
        public IQueryable<V_EBKC_PRIV_ATTR_LIST> GetCustAttributesListPrivate(decimal rnk)
        {
            var ourMfo = _banksRepository.GetOurMfo();
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = rnk,
                        },
                        new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value = ourMfo,
                        }
                    };
            var result = _entities.ExecuteStoreQuery<V_EBKC_PRIV_ATTR_LIST>("select * from V_EBKC_PRIV_ATTR_LIST where rnk = :p_rnk and kf = :p_kf order by ATTR_GR_ID, SORT_NUM", sqlParams);
            return result.AsQueryable();
        }
        public int SaveCustomerAttributes(IEnumerable<CustomerAttribute> attributes, string type)
        {
            if (type == "individualPerson")
            {
                var ourMfo = _banksRepository.GetOurMfo();
                foreach (var atr in attributes)
                {
                    var sqlParams = new object[]
                        {
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = atr.Rnk,
                        },
                        new OracleParameter("p_attr_name", OracleDbType.Varchar2)
                        {
                            Value = atr.AttributeName
                        },
                        new OracleParameter("p_new_val", OracleDbType.Varchar2)
                        {
                            Value = atr.NewValue
                        }
                        };
                    _entities.ExecuteStoreCommand(
                        "begin ebk_wforms_utl.change_cust_attr(:p_rnk, :p_attr_name, :p_new_val); end;", sqlParams);

                    sqlParams = new object[]
                        {
                        new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value = ourMfo,
                        },
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = atr.Rnk
                        },
                        new OracleParameter("p_attr_name", OracleDbType.Varchar2)
                        {
                            Value = atr.AttributeName
                        }
                        };
                    _entities.ExecuteStoreCommand(
                        "begin ebk_wforms_utl.dell_one_recomm(:p_kf, :p_rnk, :p_attr_name); end;", sqlParams);

                }
            }
            else if (type == "legalPerson")
            {
                var ourMfo = _banksRepository.GetOurMfo();
                foreach (var atr in attributes)
                {
                    var sqlParams = new object[]
                        {
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = atr.Rnk,
                        },
                        new OracleParameter("p_attr_name", OracleDbType.Varchar2)
                        {
                            Value = atr.AttributeName
                        },
                        new OracleParameter("p_new_val", OracleDbType.Varchar2)
                        {
                            Value = atr.NewValue
                        }
                        };
                    _entities.ExecuteStoreCommand(
                        "begin ebkc_wforms_utl.change_cust_attr(:p_rnk, :p_attr_name, :p_new_val); end;", sqlParams);

                    sqlParams = new object[]
                        {
                        new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value = ourMfo,
                        },
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = atr.Rnk
                        },
                        new OracleParameter("p_attr_name", OracleDbType.Varchar2)
                        {
                            Value = atr.AttributeName
                        }
                        };
                    _entities.ExecuteStoreCommand(
                        "begin ebkc_wforms_utl.dell_one_recomm(:p_kf, :p_rnk, :p_attr_name); end;", sqlParams);

                }
            }
            else if (type == "entrepreneurPerson")
            {
                var ourMfo = _banksRepository.GetOurMfo();
                foreach (var atr in attributes)
                {
                    var sqlParams = new object[]
                        {
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = atr.Rnk,
                        },
                        new OracleParameter("p_attr_name", OracleDbType.Varchar2)
                        {
                            Value = atr.AttributeName
                        },
                        new OracleParameter("p_new_val", OracleDbType.Varchar2)
                        {
                            Value = atr.NewValue
                        }
                        };
                    _entities.ExecuteStoreCommand(
                        "begin ebkc_wforms_utl.change_cust_attr(:p_rnk, :p_attr_name, :p_new_val); end;", sqlParams);

                    sqlParams = new object[]
                        {
                        new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value = ourMfo,
                        },
                        new OracleParameter("p_rnk", OracleDbType.Decimal)
                        {
                            Value = atr.Rnk
                        },
                        new OracleParameter("p_attr_name", OracleDbType.Varchar2)
                        {
                            Value = atr.AttributeName
                        }
                        };
                    _entities.ExecuteStoreCommand(
                        "begin ebkc_wforms_utl.dell_one_recomm(:p_kf, :p_rnk, :p_attr_name); end;", sqlParams);

                }
            }
            return 0;
        }

        public List<DropDownList> GetAllDropDownData(string type)
        {
            List<DropDownList> result = null;
            List<AttributeParams> ddList;
            switch (type)
            {
                case "individualPerson":
                         ddList =
                                    _entities.ExecuteStoreQuery<AttributeParams>(
                                    "select NAME, LIST_OF_VALUES from  EBK_CARD_ATTRIBUTES where list_of_values is not null and page_item_view = 'DropDown'").ToList();

                         result = (
                            from item in ddList
                            let attrList = _entities.ExecuteStoreQuery<DropDownItem>(item.LIST_OF_VALUES)
                            select new DropDownList() { ATTR_NAME = item.NAME, DROPDOWN_DATA = attrList.ToList<DropDownItem>() }).ToList();
                    break;

                case "entrepreneurPerson":
                       ddList =
                                    _entities.ExecuteStoreQuery<AttributeParams>(
                                    "select NAME, LIST_OF_VALUES from  EBKC_CARD_ATTRIBUTES where list_of_values is not null and page_item_view = 'DropDown' and cust_type = 'P'").ToList();

                       result = (
                            from item in ddList
                            let attrList = _entities.ExecuteStoreQuery<DropDownItem>(item.LIST_OF_VALUES)
                            select new DropDownList() { ATTR_NAME = item.NAME, DROPDOWN_DATA = attrList.ToList<DropDownItem>() }).ToList();
                    break;

                case "legalPerson":
                    ddList =
                                 _entities.ExecuteStoreQuery<AttributeParams>(
                                 "select NAME, LIST_OF_VALUES from  EBKC_CARD_ATTRIBUTES where list_of_values is not null and page_item_view = 'DropDown' and cust_type = 'L'").ToList();

                    result = (
                         from item in ddList
                         let attrList = _entities.ExecuteStoreQuery<DropDownItem>(item.LIST_OF_VALUES)
                         select new DropDownList() { ATTR_NAME = item.NAME, DROPDOWN_DATA = attrList.ToList<DropDownItem>() }).ToList();
                    break;
            }
            return result;
        }


        public IEnumerable<DropDownItem> GetDialogData(string dialogName, DataSourceRequest request)
        {
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_name", OracleDbType.Varchar2)
                        {
                            Value = dialogName,
                        }
                    };
            var ddList =
                _entities.ExecuteStoreQuery<AttributeParams>(
                    "select DESCR, LIST_OF_VALUES from  EBK_CARD_ATTRIBUTES where list_of_values is not null and NAME = :p_name", sqlParams);

            var query = ddList.FirstOrDefault();
            _lastDialogDescr = query.DESCR;


            var baseSql = new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = string.Format("select * from ({0}) ddListData", query.LIST_OF_VALUES)
            };

            _lastDialogDataLendth = GetDialogDataCount(baseSql, request);

            var sql = _kendoSqlTransformer.TransformSql(baseSql, request);
            return _entities.ExecuteStoreQuery<DropDownItem>(sql.SqlText, sql.SqlParams);
        }


        private decimal GetDialogDataCount(BarsSql sql, DataSourceRequest request)
        {
            var filteredSql = _kendoSqlCounter.TransformSql(sql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(filteredSql.SqlText, filteredSql.SqlParams).Single();
            return total;
        }

        public IEnumerable<CustomQualityGroup> GetCustomGroupsList(decimal groupId)
        {
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_quality_group", OracleDbType.Decimal)
                        {
                            Value = groupId,
                        }
                    };
            var result =
                _entities.ExecuteStoreQuery<CustomQualityGroup>(
                    @"select distinct QUALITY_GROUP, QUALITY_GROUP_DESC from EBK_QUALITYATTR_CUST_GRP_V
                      where group_id = :p_quality_group
                      order by QUALITY_GROUP_DESC",
                                                  sqlParams).ToList();

            result.Insert(0, new CustomQualityGroup() { QUALITY_GROUP = WholeCardQualityGroupName, QUALITY_GROUP_DESC = "Картка" });
            return result;
        }


        public void DeleteQualitySubgroup(decimal group, decimal subGroup)
        {
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_group_id", OracleDbType.Decimal){ Value = group },
                        new OracleParameter("p_subgr_id", OracleDbType.Decimal){ Value = subGroup }
                    };
            _entities.ExecuteStoreCommand("begin ebk_wforms_utl.del_subgr(:p_group_id, :p_subgr_id); end; ", sqlParams);
        }

        public void AddSubgroup(decimal group, string sign, decimal percent)
        {
            var sqlParams = new object[]
                    {
                        new OracleParameter("p_group_id", OracleDbType.Decimal){ Value = group },
                        new OracleParameter("p_sign", OracleDbType.Varchar2){ Value = ConvertWebSignToSql(sign) },
                        new OracleParameter("p_percent", OracleDbType.Decimal){ Value = percent }
                    };
            _entities.ExecuteStoreCommand("begin ebk_wforms_utl.add_subgr(:p_group_id, :p_sign, :p_percent); end; ", sqlParams);
        }

        private string ConvertWebSignToSql(string webSign)
        {
            switch (webSign)
            {
                case "eq":
                    return "=";
                case "lt":
                    return "<";
                case "gt":
                    return ">";
                case "lte":
                    return "<=";
                case "gte":
                    return ">=";
                default:
                    return webSign;
            }

        }
    }

}