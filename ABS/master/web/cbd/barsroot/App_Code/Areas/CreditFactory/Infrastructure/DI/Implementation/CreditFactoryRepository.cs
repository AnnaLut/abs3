using System;
using System.Data;
using System.Linq;
using BarsWeb.Areas.CreditFactory.Infrastructure;
using BarsWeb.Areas.CreditFactory.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CreditFactory.Infrastructure.Repository.DI.Abstract;
using Areas.CreditFactory.Models;
using BarsWeb.Areas.CreditFactory.ViewModels;

using Oracle.DataAccess.Client;
using Bars.Classes;

namespace BarsWeb.Areas.CreditFactory.Infrastucture.DI.Implementation
{
    public class CreditFactoryRepository : ICreditFactoryRepository
    {
        readonly CreditFactoryEntities _entities;
        public CreditFactoryRepository(ICreditFactoryModel model)
        {
            _entities = model.CreditFactoryEntities;
        }

        public IQueryable<CF_REQUEST_LOG> GetReqRespLog()
        {
            return _entities.CF_REQUEST_LOG.OrderByDescending(i => i.ID);
        }

        public IQueryable<CF_REQUEST_LOG> GetReqRespLogDir(string logDir)
        {
            return _entities.CF_REQUEST_LOG.Where(i => i.LOG_DIR == logDir).OrderByDescending(i => i.ID);
        }

        public IQueryable<CF_REQUEST_SETINGS> GetSetings()
        {
            return _entities.CF_REQUEST_SETINGS;
        }

        public IQueryable<V_CF_SETINGS> GetSetingsBranch()
        {
            return _entities.V_CF_SETINGS;
        }

        public SyncParams CreateSyncParam(SyncParams syncParams)
        {
            var dbModel = ModelConverter.ToDbModel(syncParams);
            _entities.CF_REQUEST_SETINGS.AddObject(dbModel);
            _entities.SaveChanges();
            return ModelConverter.ToViewModel(dbModel);
        }

        public void UpdateSyncParams(SyncParams syncParams)
        { 
            var dbModel = ModelConverter.ToDbModel(syncParams);
            var rowToUpdate = _entities.CF_REQUEST_SETINGS.FirstOrDefault(x => x.MFO == syncParams.Mfo);
            if (rowToUpdate != null)
            {
                rowToUpdate.MFO = syncParams.Mfo;
                rowToUpdate.URL_SERVICE = syncParams.Url_Service;
                rowToUpdate.USERNAME = syncParams.Username;
                rowToUpdate.PASSWORD = syncParams.Password;
                rowToUpdate.IS_ACTIVE = syncParams.Is_Active;
                _entities.SaveChanges();
            }
        }

        public void DestroySyncParam(string mfo)
        {
            var rowToDelete = _entities.CF_REQUEST_SETINGS.FirstOrDefault(x => x.MFO == mfo);
            if (rowToDelete != null)
            {
                _entities.CF_REQUEST_SETINGS.DeleteObject(rowToDelete);
                _entities.SaveChanges();
            }
        }

        public void Ping()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.utl_credit_factory.ping";

                cmd.ExecuteNonQuery();
            }
            finally
            {
                connection.Dispose();
                connection.Close();
            }
        }
    }
}