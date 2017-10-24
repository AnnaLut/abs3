using System;
using System.Data;
using System.Linq;
using BarsWeb.Areas.KFiles.Infrastructure.DI.Abstract;
using BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.KFiles.Models;
using AttributeRouting.Helpers;
using Oracle.DataAccess.Client;
using Bars.KFiles;
using ibank.core;
using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;
//using BarsWeb.Core.Models;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Areas.KFiles.Models;

namespace BarsWeb.Areas.KFiles.Infrastucture.DI.Implementation
{
    public class KFilesRepository : IKFilesRepository
    {
        public BarsSql _getSql;
        readonly KFilesEntities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public KFilesRepository(IKFilesModel model, IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            _entities = model.KFilesEntities;
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }


        public IQueryable<V_OB_CORPORATION> GetCorporationsList(bool mode)
        {
            InitGetCorporationListSql(mode);
            var result = _entities.ExecuteStoreQuery<V_OB_CORPORATION>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        //public IQueryable<V_OB_CORPORATION> GetCorporations(bool mode)
        //{
        //    InitGetCorporationSql(mode);
        //    var result = _entities.ExecuteStoreQuery<V_OB_CORPORATION>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
        //    return result;
        //}

        public IQueryable<V_OB_CORPORATION> GetCorporations(bool mode, string parent_id)
        {
            InitGetCorporationSql(mode, parent_id);
            var result = _entities.ExecuteStoreQuery<V_OB_CORPORATION>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<HierarchyCorporations> GetCorporationsForChangeHierarchy(decimal ID)
        {
            InitGetCorporationsForChangeHierarchy(ID);
            var result = _entities.ExecuteStoreQuery<HierarchyCorporations>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<V_OB_CORPORATION_SESSION> GetCorporationsFiles(string CorporationID)
        {
            InitGetCorporationFilesSql(CorporationID);
            var result = _entities.ExecuteStoreQuery<V_OB_CORPORATION_SESSION>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<V_OB_CORPORATION_DATA> GetCorporationDataFiles(decimal sessionID)
        {
            InitGetCorporationDataFilesSql(sessionID);
            var result = _entities.ExecuteStoreQuery<V_OB_CORPORATION_DATA>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public void AddCorporationOrSubCorporation(string CORPORATION_NAME, string CORPORATION_CODE, string EXTERNAL_ID, decimal PARENT_ID)
        {


            BbConnection bb_con = new BbConnection();


            try
            {
                
                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);
               
                // додаємо корпорацію
                kp.ADD_CORPORATION_OR_SUB_CORPORATION(CORPORATION_NAME, CORPORATION_CODE, EXTERNAL_ID, PARENT_ID); 
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                bb_con.CloseConnection();
            }

        }

        public void EditCorporation(decimal ID, string CORPORATION_CODE, string CORPORATION_NAME, string EXTERNAL_ID)
        {


            BbConnection bb_con = new BbConnection();


            try
            {

                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);

                kp.EDIT_CORPORATION(ID, CORPORATION_CODE, CORPORATION_NAME, EXTERNAL_ID);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                bb_con.CloseConnection();
            }

        }

        public void LockCorporation(decimal ID)
        {

            BbConnection bb_con = new BbConnection();

            try
            {

                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);

                kp.LOCK_CORPORATION(ID);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                bb_con.CloseConnection();
            }
        }

        public void UnLockCorporation(decimal ID)
        {
            BbConnection bb_con = new BbConnection();

            try
            {

                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);

                kp.UNLOCK_CORPORATION(ID);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                bb_con.CloseConnection();
            }
        }

        public void CloseCorporation(decimal ID)
        {
            BbConnection bb_con = new BbConnection();

            try
            {

                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);

                kp.CLOSE_CORPORATION(ID);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                bb_con.CloseConnection();
            }
        }

        public void ChangeHierarchy (decimal ID, decimal PARENT_ID)
        {
            BbConnection bb_con = new BbConnection();

            try
            {

                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);

                kp.CHANGE_HIERARCHY(ID, PARENT_ID);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                bb_con.CloseConnection();
            }
        }

        private void InitGetCorporationsForChangeHierarchy(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM TABLE(KFILE_PACK.GET_POSSIBLE_UNITS(:ID))"),
                SqlParams = new object[] { new OracleParameter("ID", OracleDbType.Decimal) { Value = ID } }
            };
        }


        private void InitGetCorporationListSql(bool mode)
        {
            var where = "WHERE STATE_ID != 3 and PARENT_ID is null";
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM  BARS.V_OB_CORPORATION " + (mode == false ? where : "")),
                SqlParams = new object[] { }
            };
        }


        //private void InitGetCorporationSql(bool mode)
        //{
        //    var where = "WHERE STATE_ID != 3";
        //    _getSql = new BarsSql()
        //    {
        //        SqlText = string.Format(@"SELECT * FROM  BARS.V_OB_CORPORATION " + (mode == false ? where : "")),
        //        SqlParams = new object[] { }
        //    };
        //}

        private void InitGetCorporationSql(bool mode, string parent_id)
        {
            var state_where = " and STATE_ID != 3";
            var id_where = String.Concat(" and base_extid = ", parent_id); 
            //var parent_where = String.Concat(" and PARENT_ID = ", parent_id);

            _getSql = new BarsSql()
            {
                //SqlText = string.Concat(@"SELECT * FROM  BARS.V_OB_CORPORATION WHERE 1=1", (mode == false ? state_where : "") + ((parent_id == String.Empty || parent_id == null) ? "" : parent_where)),

                //                SqlText = string.Format(@"
                //select * from BARS.V_OB_CORPORATION
                //where 1=1 
                //and PARENT_ID is null
                //{0} 
                //{1}
                //union all
                //select * from BARS.V_OB_CORPORATION
                //where 1=1 
                //{0} 
                //{2}", (mode == false ? state_where : "")
                //                    , (parent_id == String.Empty || parent_id == null) ? "" : id_where
                //                    , (parent_id == String.Empty || parent_id == null) ? "" : parent_where
                //),

                SqlText = string.Format(@"
select CORPORATION_CODE  
,   CORPORATION_NAME
,   EXTERNAL_ID
,   ID  
,   PARENT_ID 
,   STATE_ID   
,   case
        when STATE_ID = 1 then 'Активний'
        when STATE_ID = 2 then 'Заблокований'
        when STATE_ID = 3 then 'Закритий'
        else ''
    end CORPORATION_STATE
,   BASE_CORP_NAME as PARENT_NAME 
from v_org_corporations 
where 1=1
{0}
{1}", (mode == false ? state_where : "")
    , (parent_id == String.Empty || parent_id == null) ? "" : id_where
            ),



                SqlParams = new object[] { }
            };
        }


        private void InitGetCorporationFilesSql(string CorporationID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM  BARS.V_OB_CORPORATION_SESSION WHERE CORPORATION = :CorporationID "),
                SqlParams = new object[] { new OracleParameter("CorporationID", OracleDbType.Varchar2) { Value = CorporationID } }
            };
        }

        private void InitGetCorporationDataFilesSql(decimal sessionID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM  BARS.V_OB_CORPORATION_DATA WHERE SESSION_ID = :sessionID "),
                SqlParams = new object[] { new OracleParameter("sessionID", OracleDbType.Decimal) { Value = sessionID } }
            };
        }


        private void InitSyncSql()
        {
            _getSql = new BarsSql()
            {
                //SqlText = string.Format(@"SELECT ID, MFO, FILE_DATE, CORPORATION, STATE, SYNCTIME  FROM  BARS.v_ob_corporation_session"),
                SqlText = string.Format(@"SELECT ID, MFO || ' - ' || MFO_NAME as MFO, FILE_DATE, CORPORATION, STATE, SYNCTIME  FROM  BARS.v_ob_corporation_session"),

                SqlParams = new object[] { }
            };
        }



        public IEnumerable<V_SYNC_SESSION> GetSyncData(DataSourceRequest request)
        {
            InitSyncSql();

            var sql = _sqlTransformer.TransformSql(_getSql, request);
            IQueryable<V_SYNC_SESSION> result = _entities.ExecuteStoreQuery<V_SYNC_SESSION>(sql.SqlText, sql.SqlParams).AsQueryable();

            //var result = _entities.ExecuteStoreQuery<V_SYNC_SESSION>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }
        
        public decimal GetSyncDataCount(DataSourceRequest request)
        {
            InitSyncSql();

            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();


            //var count = IKendoSqlCounter.TransformSql(_getSql, request);
            //var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }


    }
}