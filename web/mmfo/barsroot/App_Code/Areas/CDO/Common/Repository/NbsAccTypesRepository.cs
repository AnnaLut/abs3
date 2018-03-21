using System.Collections.Generic;
using System.Linq;
using Models;

using BarsWeb.Areas.CDO.Common.Models;

namespace BarsWeb.Areas.CDO.Common.Repository
{
    /// <summary>
    /// Class for managing nbs accs
    /// </summary>
    public class NbsAccTypesRepository : INbsAccTypesRepository
    {
        readonly EntitiesBars _entities;
        public NbsAccTypesRepository(ICDOModel model)
        {
            _entities = model.CorpLightEntities;
        }
        public List<NbsAccType> GetAll()
        {
            var sql = @"select 
                            NBS as ""Nbs"",
                            TYPE_ID as ""TypeId"",
                            NAME as ""TypeName""
                      from 
                            V_MBM_NBS_ACC_TYPES";
            var result = _entities.ExecuteStoreQuery<NbsAccType>(sql).ToList();
            return result;
        }

        public NbsAccType Get(NbsAccType type)
        {
            var sql = @"select 
                            NBS as ""Nbs"",
                            TYPE_ID as ""TypeId""
                      from 
                            MBM_NBS_ACC_TYPES
                      where
                            NBS = :p_nbs
                            and TYPE_ID = :p_type_id";
            var result = _entities.ExecuteStoreQuery<NbsAccType>(sql, type.Nbs, type.TypeId).FirstOrDefault();
            return result;
        }

        public void Add(NbsAccType type)
        {
            var typeInBase = Get(type);
            if (typeInBase == null)
            {
                Insert(type);
            }
        }

        private void Insert(NbsAccType type)
        {
            var sql = @"insert into MBM_NBS_ACC_TYPES (NBS, TYPE_ID) values (:p_nbs, :p_type_id)";
            _entities.ExecuteStoreCommand(sql, type.Nbs, type.TypeId);
        }

        public void Delete(NbsAccType type)
        {
            var sql = @"delete from MBM_NBS_ACC_TYPES where NBS = :p_nbs and TYPE_ID = :p_type_id";
            _entities.ExecuteStoreCommand(sql, type.Nbs, type.TypeId);
        }

        public void Update(NbsAccType type)
        {
            Add(type);
        }
    }

    public interface INbsAccTypesRepository
    {
        List<NbsAccType> GetAll();
        NbsAccType Get(NbsAccType type);
        void Add(NbsAccType type);
        void Delete(NbsAccType type);
        void Update(NbsAccType type);
    }
}