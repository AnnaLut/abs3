using System;
using System.Data;
using System.Linq;
using AttributeRouting.Helpers;
using Oracle.DataAccess.Client;
using ibank.core;
using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using Bars.Classes;
using Areas.AccessToAccounts.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AccessToAccounts.Infrastucture.DI.Implementation
{
    public class AccGroupsRepository : IAccGroupsRepository
    {
        public BarsSql _getSql;
        readonly AccessToAccountsEntities _entities;
        public AccGroupsRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("AccessToAccounts", "AccessToAccounts");
            _entities = new AccessToAccountsEntities(connectionStr);
        }

        public IQueryable<AccGroups> GetAccGroups()
        {
            InitGetAccGroups();
            var result = _entities.ExecuteStoreQuery<AccGroups>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        private void InitGetAccGroups()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT ID, NAME FROM GROUPS_ACC ORDER BY ID ASC"),
                SqlParams = new object[] { }
            };
        }

        public IQueryable<IssuedAccounts> GetIssuedAccounts(decimal? grpId, decimal? ACC, string NLS)
        {
            InitGetIssuedAccounts(grpId, ACC, NLS);
            var result = _entities.ExecuteStoreQuery<IssuedAccounts>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        private void InitGetIssuedAccounts(decimal? grpId, decimal? ACC, string NLS)
        {
            string p_nbs = string.Empty;
            string p_nls = string.Empty;
            string p_acc = string.Empty;

            if (!String.IsNullOrEmpty(NLS) /*&& ACC != 0*/)
            {
                switch (NLS)
                {
                    case "НБР або рахунок":
                        {
                            _getSql = new BarsSql()
                            {
                                SqlText = string.Format(@"SELECT a.acc, a.nls, a.kv, a.nms, to_char(a.dazs,'dd.mm.yyyy') dazs, a.BRANCH
                                              FROM accounts a
                                              WHERE sec.fit_gmask(a.sec, :p_grpid) > 0
                                                and 0 != nvl(:p_grpid_zero,0)
                                                and rownum < 100
                                              ORDER BY a.BRANCH, a.nls, a.kv"),

                                SqlParams = new object[] {
                                    new OracleParameter("p_grpid", OracleDbType.Decimal) { Value = grpId },
                                    new OracleParameter("p_grpid_zero", OracleDbType.Decimal) { Value = grpId }
                                }
                            };
                            break;
                        }

                    default:
                        {
                            //if (NLS.Length >= 4)
                            
                                p_nls = NLS + "%";
                                p_nbs = (NLS.Length == 4) ? NLS : NLS.Substring(0, 4);
                                p_acc = (ACC != 0) ? ACC.ToString() + "%" : "";

                               


                                _getSql = new BarsSql()
                                {
                                    SqlText = string.Format(@"SELECT a.acc, a.nls, a.kv, a.nms, to_char(a.dazs,'dd.mm.yyyy') dazs, a.BRANCH
                                              FROM accounts a
                                              WHERE sec.fit_gmask(a.sec, :p_grpid) > 0
                                                and 0 != nvl(:p_grpid_zero,0)
                                                and a.nbs = :p_nbs
                                                and a.nls like  :p_nls
                                                /*and a.acc like :p_acc*/
                                                and rownum < 100
                                              ORDER BY a.BRANCH, a.nls, a.kv"),

                                    SqlParams = new object[] {
                                    new OracleParameter("p_grpid", OracleDbType.Decimal) { Value = grpId },
                                    new OracleParameter("p_grpid_zero", OracleDbType.Decimal) { Value = grpId },
                                    new OracleParameter("p_nbs", OracleDbType.Varchar2) { Value = p_nbs},
                                    new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = p_nls}//,
                                    //new OracleParameter("p_acc", OracleDbType.Decimal) { Value = p_acc}
                                }
                                };
                                break;
                            
                        }
                }
            }
            else
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@"SELECT 0 acc, null nls, 0 kv, 'Параметр пошуку має складатися від 4 і більше символів' nms, null dazs, null BRANCH FROM dual"),
                    SqlParams = new object[] { }
                };

            }
        }

        public IQueryable<NotIssuedAccounts> GetNotIssuedAccounts(decimal? grpId, string nls)
        {
            InitGetNotIssuedAccounts(grpId, nls);
            var result = _entities.ExecuteStoreQuery<NotIssuedAccounts>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        private void InitGetNotIssuedAccounts(decimal? grpId, string nls)
        {
            if (!String.IsNullOrEmpty(nls) && nls.Length >= 4)
            {
                string p_nbs = string.Empty;
                string p_nls = string.Empty;

                p_nls = nls + "%";
                p_nbs = (nls.Length == 4) ? nls : nls.Substring(0, 4);
             
                if (nls == "НБР або рахунок")
                {
                    _getSql = new BarsSql()
                    {
                        SqlText = string.Format(@"SELECT a.acc, a.nls, a.kv, a.nms, to_char(a.dazs,'dd.mm.yyyy') dazs,  a.BRANCH
                                              FROM accounts a
                                              WHERE sec.fit_gmask(a.sec, :p_grpid) = 0
                                                and 0 != nvl(:p_grpid_zero,0)                                               
                                                and rownum < 100
                                              ORDER BY a.BRANCH, a.nls, a.kv"),

                        SqlParams = new object[] {
                            new OracleParameter("p_grpid", OracleDbType.Decimal) { Value = grpId },
                            new OracleParameter("p_grpid_zero", OracleDbType.Decimal) { Value = grpId }
                        }
                    };
                }
                else
                {
                    _getSql = new BarsSql()
                    {
                        SqlText = string.Format(@"SELECT a.acc, a.nls, a.kv, a.nms, to_char(a.dazs,'dd.mm.yyyy') dazs, a.BRANCH
                                                  FROM accounts a
                                                  WHERE sec.fit_gmask(a.sec, :p_grpid) = 0
                                                    and 0 != nvl(:p_grpid_zero,0)
                                                    and a.nbs = :p_nbs
                                                    and a.nls like  :p_nls
                                                    and rownum < 100
                                                  ORDER BY a.BRANCH, a.nls, a.kv"),

                        SqlParams = new object[] {
                            new OracleParameter("p_grpid", OracleDbType.Decimal) { Value = grpId },
                             new OracleParameter("p_grpid_zero", OracleDbType.Decimal) { Value = grpId },
                            new OracleParameter("p_nbs", OracleDbType.Varchar2) { Value = p_nbs},
                            new OracleParameter("p_nls", OracleDbType.Varchar2) { Value = p_nls}
                        }
                    };
                }
            }
            else
            {
                _getSql = new BarsSql()
                {
                    SqlText = string.Format(@"SELECT 0 acc, null nls, 0 kv, 'Параметр пошуку має складатися від 4 і більше символів' nms, null dazs, null BRANCH FROM dual"),
                    SqlParams = new object[] { }
                };
            }
        }

        public void addAgrp(decimal grpId, decimal acc)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin sec.addAgrp(:nAcc, :nAccGrp); end; "),
                SqlParams = new object[]
                {
                    new OracleParameter("nAcc", OracleDbType.Decimal) { Value = acc },
                    new OracleParameter("nAccGrp", OracleDbType.Decimal) { Value = grpId }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }


        public void delAgrp(decimal grpId, decimal acc)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin sec.delAgrp(:nAcc, :nAccGrp); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("nAcc", OracleDbType.Decimal) { Value = acc },
                    new OracleParameter("nAccGrp", OracleDbType.Decimal) { Value = grpId }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }
    }
}
