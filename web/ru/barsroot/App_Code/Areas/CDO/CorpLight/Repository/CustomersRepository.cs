using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.CDO.CorpLight.Models;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.CDO.CorpLight.Repository
{
    /// <summary>
    /// Summary description for CustomersRepository
    /// </summary>
    public class CustomersRepository : ICLCustomersRepository
    {

        readonly EntitiesBars _entities;
        public CustomersRepository(ICDOModel model)
        {
            _entities = model.CorpLightEntities;
        }

        private readonly string sql = @"
                SELECT 
                    RNK AS CustId,
                    OKPO AS OKPO,
                    CUSTTYPE AS CustType,
                    CL_OKPO AS CL_OKPO
                FROM V_MBM_CUSTOMERS_SEARCH
                    WHERE RNK = {0}
        ";


        public CLCustomerModel Get(decimal custId)
        {
            var entity = _entities.ExecuteStoreQuery<CLCustomerModel>(string.Format(sql, custId)).FirstOrDefault();
            return entity;
        }

    }


    /// <summary>
    /// The purpose of this interface is to get customer OKPO by CustomerId
    /// </summary>
    public interface ICLCustomersRepository
    {
        CLCustomerModel Get(decimal custId);
    }
}