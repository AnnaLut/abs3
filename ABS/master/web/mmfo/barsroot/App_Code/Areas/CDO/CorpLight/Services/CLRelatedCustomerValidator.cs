﻿using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using Models;

using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Common.Models;

namespace BarsWeb.Areas.CDO.CorpLight.Services
{
    /// <summary>
    /// Provides state of related customer
    /// </summary>
    public class CLRelatedCustomerValidator : ICLRelatedCustomerValidator
    {
        readonly EntitiesBars _entities;
        public CLRelatedCustomerValidator(
            ICDOModel model)
        {
            _entities = model.CorpLightEntities;

            SslValidation();
        }
        private void SslValidation()
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
        }
        /// <summary>
        /// State of user ismapped 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="custId"></param>
        /// <returns></returns>
        public bool CustomerIsMapped(decimal id, decimal custId)
        {
            var sql = @"select 
                            count(1) 
                        from 
                            mbm_cust_rel_users_map 
                        where 
                            rel_cust_id = :p_id 
                            and cust_id = :p_cust_id";
            var result = _entities.ExecuteStoreQuery<decimal>(sql, id, custId).FirstOrDefault();
            if (result > 0)
            {
                return true;
            }
            return false;
        }
        /// <summary>
        /// Is exist user by parametrs
        /// </summary>
        /// <param name="taxCode"></param>
        /// <param name="phoneNumber"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        public bool IsExistByParameters(string taxCode, string phoneNumber, string email)
        {
            var sql = @"select 
                            count(1) 
                        from 
                            MBM_REL_CUSTOMERS
                        where 
                            (tax_code = :p_tax_code  and tax_code != '0000000000')
                            or cell_phone = :p_cell_phone
                            or email = :p_email
                           ";
            var result = _entities.ExecuteStoreQuery<decimal>(sql, taxCode, phoneNumber, email).FirstOrDefault();
            if (result > 0)
            {
                return true;
            }
            return false;
        }

        //HACK: delete
        //public bool IsExistByEmail(string email)
        //{
        //    var sql = @"select 
        //                    count(*) 
        //                from 
        //                    MBM_REL_CUSTOMERS
        //                where 
        //                    email = :p_email";
        //    var result = _entities.ExecuteStoreQuery<decimal>(sql, email).FirstOrDefault();
        //    if (result > 0)
        //    {
        //        return true;
        //    }
        //    return false;
        //}
        public bool IsEmailEdited(string email, decimal? id)
        {
            var sql = @"select 
                            *
                        from 
                            MBM_REL_CUSTOMERS
                        where 
                            id = :id";
            var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, id).FirstOrDefault();
            return result.Email != email ? true : false;
        }

        public bool IsPhoneEdited(string phone, decimal? id)
        {
            var sql = @"select 
                            count(*)
                        from 
                            MBM_REL_CUSTOMERS
                        where 
                            id = :id and  CELL_PHONE = :phone";
            var result = _entities.ExecuteStoreQuery<decimal>(sql, id, phone).FirstOrDefault();
            return result > 0 ? false : true;
        }
    }

    public interface ICLRelatedCustomerValidator
    {
        bool CustomerIsMapped(decimal id, decimal custId);
        bool IsExistByParameters(string taxCode, string phoneNumber, string email);
        //bool IsExistByEmail(string email);
        bool IsEmailEdited(string email, decimal? custId);
        bool IsPhoneEdited(string phone, decimal? id);
    }
}