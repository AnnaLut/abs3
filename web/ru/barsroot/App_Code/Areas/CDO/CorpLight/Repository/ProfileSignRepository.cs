using System.Collections.Generic;
using System.Linq;
using Models;

using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Models;

namespace BarsWeb.Areas.CDO.CorpLight.Repository
{ 
    public class ProfileSignRepository : IProfileSignRepository
    {
        /// <summary>
        /// Data access (entityFramework) class 
        /// </summary>
        readonly EntitiesBars _entities;
        /// <summary>
        /// Base sql query
        /// </summary>
        private const string sql = @"select 
                                        r.rel_cust_id as CustomerId,
                                        r.visa_id as VisaId,
                                        r.user_id as UserId,
                                        r.visa_date as VisaDate,
                                        r.key_id as KeyId,
                                        r.signature as Signature
                                    from 
                                        mbm_rel_cust_visa_stamps r";

        public ProfileSignRepository(ICDOModel model)
        {
            _entities = model.CorpLightEntities;
        }

        public ProfileSignature GetSignBuffer(decimal relCustId)
        {
            var localSql = sql + @" where 
                                        r.rel_cust_id = :p_rel_cust_id 
                                        and rownum = 1
                                    order by 
                                        r.visa_id desc";
            var lastSign = _entities.ExecuteStoreQuery<ProfileSignature>(localSql, relCustId).FirstOrDefault();
            if (lastSign == null)
            {
                return null;
            }
            return lastSign;
        }

        /// <summary>
        /// Get single visa
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="visaId"></param>
        /// <returns></returns>
        public ProfileSignature Get(decimal relCustId, decimal visaId)
        {
            var localSql = sql + @" where 
                                        r.rel_cust_id = :p_rel_cust_id 
                                        and r.visa_id = :p_visa_id
                                        and rownum = 1
                                    order by 
                                        r.visa_id desc";
            var lastSign = _entities.ExecuteStoreQuery<ProfileSignature>(localSql, relCustId, visaId).FirstOrDefault();
            return lastSign;
        }

        /// <summary>
        /// Return all signatures for related customer
        /// </summary>
        /// <param name="relCustId"></param>
        /// <returns></returns>
        public IEnumerable<ProfileSignature> GetAll(decimal relCustId)
        {
            var localSql = sql + @" where 
                                        r.rel_cust_id = :p_rel_cust_id
                                    order by 
                                        r.visa_id asc";
            var signs = _entities.ExecuteStoreQuery<ProfileSignature>(localSql, relCustId);
            return signs;
        }

        /// <summary>
        /// Add signature data
        /// </summary>
        /// <param name="profileSignature"></param>
        public void Add(ProfileSignature profileSignature)
        {
            var sql = @"insert into mbm_rel_cust_visa_stamps (
                            rel_cust_id, 
                            visa_id, 
                            user_id, 
                            visa_date, 
                            key_id, 
                            signature) 
                        values (
                            :p_rel_cust_id, 
                            :p_visa_id, 
                            :p_user_id, 
                            :p_visa_date, 
                            :p_key_id, 
                            :p_signature)";
            _entities.ExecuteStoreCommand(sql,
                profileSignature.CustomerId,
                profileSignature.VisaId, 
                profileSignature.UserId,
                profileSignature.VisaDate,
                profileSignature.KeyId,
                profileSignature.Signature);
        }

        /// <summary>
        /// Delete visa from related customer
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="visaId"></param>
        public void Delete(decimal relCustId, decimal visaId)
        {
            var sql = @"delete 
                            from mbm_rel_cust_visa_stamps r
                        where 
                            r.rel_cust_id = :p_rel_cust_id 
                            and r.r.visa_id = :p_visa_id";
            _entities.ExecuteStoreCommand(sql, relCustId, visaId);
        }

        /// <summary>
        /// Delete all signs form customer
        /// </summary>
        /// <param name="relCustId"></param>
        public void DeleteAll(decimal relCustId)
        {
            var sql = @"delete 
                            from mbm_rel_cust_visa_stamps r
                        where 
                            r.rel_cust_id = :p_rel_cust_id";
            _entities.ExecuteStoreCommand(sql, relCustId);
        }
    }

    /// <summary>
    /// Serves for managing user signs
    /// </summary>
    public interface IProfileSignRepository
    {
        ProfileSignature GetSignBuffer(decimal relCustId);
        ProfileSignature Get(decimal relCustId, decimal visaId);
        IEnumerable<ProfileSignature> GetAll(decimal relCustId);
        void Add(ProfileSignature profileSignature);
        void Delete(decimal relCustId, decimal visaId);
        void DeleteAll(decimal relCustId);
    }
}