using System.Collections.Generic;
using System.Linq;
using Models;
using BarsWeb.Areas.CDO.Corp2.Models;
using BarsWeb.Areas.CDO.Common.Repository;

namespace BarsWeb.Areas.CDO.Corp2.Repository
{
    public class Corp2ProfileSignRepository : ICorp2ProfileSignRepository
    {
        /// <summary>
        /// Data access (entityFramework) class 
        /// </summary>
        readonly EntitiesBars _entities;
        /// <summary>
        /// Base sql query
        /// </summary>
        private const string sql = @"select
                                        r.user_id as UserId,
                                        r.visa_id as VisaId,
                                        r.visa_date as VisaDate,
                                        r.key_id as KeyId,
                                        r.signature as Signature
                                    from CORP2_USER_VISA_STAMPS r";

        public Corp2ProfileSignRepository(ICDOModel model)
        {
            _entities = model.CorpLightEntities;
        }

        public ProfileSignatureCorp2 GetSignBuffer(decimal relCustId)
        {
            var localSql = sql + @" where 
                                        r.user_id = :p_user_id 
                                        and rownum = 1
                                    order by 
                                        r.visa_id desc";
            var lastSign = _entities.ExecuteStoreQuery<ProfileSignatureCorp2>(localSql, relCustId).FirstOrDefault();
            return lastSign;
        }

        /// <summary>
        /// Get single visa
        /// </summary>
        /// <param name="relCustId"></param>
        /// <param name="visaId"></param>
        /// <returns></returns>
        public ProfileSignatureCorp2 Get(decimal relCustId, decimal visaId)
        {
            var localSql = sql + @" where 
                                        r.user_id = :p_user_id 
                                        and r.visa_id = :p_visa_id
                                        and rownum = 1
                                    order by 
                                        r.visa_id desc";
            var lastSign = _entities.ExecuteStoreQuery<ProfileSignatureCorp2>(localSql, relCustId, visaId).FirstOrDefault();
            return lastSign;
        }

        /// <summary>
        /// Return all signatures for related customer
        /// </summary>
        /// <param name="relCustId"></param>
        /// <returns></returns>
        public IEnumerable<ProfileSignatureCorp2> GetAll(decimal relCustId)
        {
            var localSql = sql + @" where 
                                        r.user_id = :p_rel_cust_id
                                    order by 
                                        r.visa_id asc";
            var signs = _entities.ExecuteStoreQuery<ProfileSignatureCorp2>(localSql, relCustId);
            return signs;
        }

        /// <summary>
        /// Add signature data
        /// </summary>
        /// <param name="profileSignature"></param>
        public void Add(ProfileSignatureCorp2 profileSignature)
        {
            var sql = @"insert into CORP2_USER_VISA_STAMPS (
                            user_id, 
                            visa_id,
                            visa_date, 
                            key_id, 
                            signature) 
                        values (
                            :p_user_id, 
                            :p_visa_id,
                            :p_visa_date, 
                            :p_key_id, 
                            :p_signature)";
            _entities.ExecuteStoreCommand(sql,
                profileSignature.UserId,
                profileSignature.VisaId, 
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
                            from CORP2_USER_VISA_STAMPS r
                        where 
                            r.user_id = :p_rel_cust_id 
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
                            from CORP2_USER_VISA_STAMPS r
                        where 
                            r.user_id = :p_rel_cust_id";
            _entities.ExecuteStoreCommand(sql, relCustId);
        }
    }

    /// <summary>
    /// Serves for managing user signs
    /// </summary>
    public interface ICorp2ProfileSignRepository
    {
        ProfileSignatureCorp2 GetSignBuffer(decimal relCustId);
        ProfileSignatureCorp2 Get(decimal relCustId, decimal visaId);
        IEnumerable<ProfileSignatureCorp2> GetAll(decimal relCustId);
        void Add(ProfileSignatureCorp2 profileSignature);
        void Delete(decimal relCustId, decimal visaId);
        void DeleteAll(decimal relCustId);
    }

}