using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using Models;
using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.Corp2.Models;

namespace BarsWeb.Areas.CDO.Corp2.Services
{
    /// <summary>
    /// Provides state of related customer
    /// </summary>
    public class Corp2RelatedCustomerValidator : ICorp2RelatedCustomerValidator
    {
        readonly EntitiesBars _entities;
        public Corp2RelatedCustomerValidator(
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
                            corp2_cust_rel_users_map 
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
        public bool IsExistByParameters(string taxCode, /*string phoneNumber,*/ string email)
        {
            var sql = @"select 
                            count(1) 
                        from 
                            corp2_REL_CUSTOMERS
                        where 
                            tax_code = :p_tax_code 
                            or email = :p_email";//or cell_phone = :p_cell_phone
            var result = _entities.ExecuteStoreQuery<decimal>(sql, taxCode, /*phoneNumber,*/ email).FirstOrDefault();
            if (result > 0)
            {
                return true;
            }
            return false;
        }

        public bool IsExistAccountVisa(CustAccVisaCount visa)
        {
            var sql = @"select 
                            count(1) 
                        from 
                            CORP2_ACC_VISA_COUNT
                        where 
                            ACC_ID = :p_acc_id 
                            and VISA_ID = :p_visa_id";
            var result = _entities.ExecuteStoreQuery<decimal>(sql, visa.ACC_ID, visa.VISA_ID).FirstOrDefault();
            if (result > 0)
            {
                return true;
            }
            return false;
        }
    }

    public interface ICorp2RelatedCustomerValidator
    {
        bool CustomerIsMapped(decimal id, decimal custId);
        bool IsExistByParameters(string taxCode, /*string phoneNumber, */string email);
        bool IsExistAccountVisa(CustAccVisaCount visa);
    }
}