using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Models;
using System.Text.RegularExpressions;
using BarsWeb.Areas.CDO.Common.Models;
using Oracle.DataAccess.Client;
using System.Data;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CDO.Common.Repository
{
    public class RelatedCustomersRepository : IRelatedCustomersRepository
    {
        readonly EntitiesBars _entities;
        private readonly IBanksRepository _bankRepository;
        private readonly IParametersRepository _parametersRepository;

        private List<Parameter> parameters;

        public RelatedCustomersRepository(
            ICDOModel model,
            IBanksRepository bankRepository,
            IParametersRepository parametersRepository)
        {
            _entities = model.CorpLightEntities;
            _bankRepository = bankRepository;
            _parametersRepository = parametersRepository;

            parameters = _parametersRepository.GetAll().ToList();

            SslValidation();
        }
        private void SslValidation()
        {
            // ReSharper disable once UnusedAnonymousMethodSignature
            ServicePointManager.ServerCertificateValidationCallback = delegate (object s, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };
        }
        public IEnumerable<RelatedCustomer> GetAllForConfirm(decimal custId)
        {
            #region sql
            var sql = @"select 
                            rc.id as Id,       
                            rc.tax_code as TaxCode,       
                            rc.first_name as FirstName,   
                            rc.last_name as LastName,
                            rc.second_name as SecondName, 
                            rc.doc_type as DocType, 
                            rc.doc_series as DocSeries,
                            rc.doc_number as DocNumber,
                            rc.doc_organization as DocOrganization,
                            rc.doc_date as DocDate,
                            'CorpLight' as Sdo,
                            rc.cell_phone as CellPhone,
                            rc.email as Email,                           
                            um.sign_number as SignNumber,                           
                            um.cust_id as CustId,
                            um.user_id as UserId,
                            um.approved_type as ApprovedType,
                            um.is_approved as IsApprovedDecimal,
                            null as Login,
                            null as AcskSertificateSn,
                            null as CreateDate,
                            null as SequentialVisa,
                            null as BirthDate,
                            null as FullNameGenitiveCase,
                            null as addressRegionId,
                            null as addressCity,
                            null as addressStreet,
                            null as addressHouseNumber,
                            null as addressAddition
                              from
                                  MBM_REL_CUSTOMERS rc
                            left join mbm_cust_rel_users_map um on (
                                  rc.id = um.rel_cust_id )
                            where um.cust_id = :p_cust_id AND um.approved_type IN ('update', 'delete', 'add') AND um.sign_number <> 0
                        UNION
                        select 
                            rc.id as Id,       
                            rc.tax_code as TaxCode,       
                            rc.first_name as FirstName,   
                            rc.last_name as LastName,
                            rc.second_name as SecondName, 
                            rc.doc_type as DocType,
                            rc.doc_series as DocSeries,
                            rc.doc_number as DocNumber,
                            rc.doc_organization as DocOrganization,
                            rc.doc_date as DocDate,
                            'Corp2' as Sdo,
                            rc.cell_phone as CellPhone,
                            rc.email as Email,                           
                            um.sign_number as SignNumber,                           
                            um.cust_id as CustId,
                            um.user_id as UserId,
                            um.approved_type as ApprovedType,
                            um.is_approved as IsApprovedDecimal,
                            rc.login as Login,
                            rc.key_id as AcskSertificateSn,
                            rc.CREATED_DATE as CreateDate,
                            um.sequential_visa as SequentialVisa,
                            rc.birth_date as BirthDate,
                            rc.FIO_CARD as FullNameGenitiveCase,
                            ca.region_id as addressRegionId,
                            ca.city as addressCity,
                            ca.street as addressStreet,
                            ca.house_number as addressHouseNumber,
                            ca.addition as addressAddition
                              from
                                  CORP2_REL_CUSTOMERS rc
                            left join corp2_rel_customers_address ca on(
                                rc.id = ca.rel_cust_id
                            )
                            left join corp2_acsk_registration ar on(
                                rc.id = ar.rel_cust_id
                            )
                            left join corp2_cust_rel_users_map um on (
                                  rc.id = um.rel_cust_id )
                            where um.cust_id = :p_cust_id AND um.approved_type IN ('update', 'delete', 'add')  AND um.sign_number <> 0";
#endregion
            var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, custId).ToList();
            
            return result;
        }
        public IEnumerable<decimal> GetAllIdNotVisa()
        {
            var sql = @"select distinct cust_id 
                            from 
                                mbm_cust_rel_users_map
                            where 
                                (is_approved = 0 or is_approved is null) AND sign_number <> 0
                        UNION
                        select distinct cust_id 
                            from CORP2_CUST_REL_USERS_MAP
                            where (is_approved = 0 or is_approved is null) AND sign_number <> 0";
            var result = _entities.ExecuteStoreQuery<decimal>(sql).ToList();
            return result;
        }
        public IEnumerable<RelatedCustomer> GetCustomerRelatedCustomers(decimal custId)
        {
            var sql = @"select 
                            cr.rnk as CustId,
                            cr.relext_id as relid,
                            cr.relcust_rnk as rnk,
                            cr.okpo as taxcode,
                            cr.doc_number as DocNumber,
                            cr.doc_serial as DocSeries,
                            REGEXP_SUBSTR (cr.name, '[^[:space:]]+', 1) LastName,
                            REGEXP_SUBSTR (cr.name, '[^[:space:]]+', 1, 2) FirstName,
                            REGEXP_SUBSTR (cr.name, '[^[:space:]]+', 1, 3) SecondName,
                            cr.doc_date as DocDate,
                            to_char(cr.Doc_Type) as DocType,
                            cr.doc_issuer as DocOrganization,
                            cr.sex,
                            cr.birthday as BirthDate,
                            cr.tel as CellPhone,
                            cr.email as email,
                            cr.adr as Address
                        from 
                            v_cust_relations cr
                        where
                            CR.CUSTTYPE = 2
                            and cr.rnk = :p_rnk";
            var result = _entities.ExecuteStoreQuery<RelatedCustomer>(sql, custId);
            return result;
        }
        public RelatedCustomer GetFOPData(decimal id)
        {
            var sql = string.Format(@"SELECT 
                            -1 AS Id,
                            CUS.OKPO AS TaxCode, 
                            TRIM(F_NAME.VALUE) AS FirstName,
                            TRIM(L_NAME.VALUE) AS LastName,
                            TRIM(M_NAME.VALUE) AS SecondName,
                            PER.BDAY AS BirthDate,  
                            TO_CHAR(PER.PASSP) AS DocType,
                            PER.PDATE AS DocDate,
                            PER.SER AS DocSeries, 
                            PER.NUMDOC AS DocNumber, 
                            PER.ORGAN AS DocOrganization,
                            TRIM(TOWN.VALUE) AS AddressCity,
                            TRIM(STREET.VALUE) AS AddressStreet
    
                        FROM CUSTOMER CUS 
                            LEFT JOIN PERSON PER ON PER.RNK = CUS.RNK AND PER.PASSP = 1
                            LEFT JOIN V_CUSTOMERW F_NAME ON F_NAME.RNK = CUS.RNK AND F_NAME.TAG = 'SN_FN' 
                            LEFT JOIN V_CUSTOMERW L_NAME ON L_NAME.RNK = CUS.RNK AND L_NAME.TAG = 'SN_LN' 
                            LEFT JOIN V_CUSTOMERW M_NAME ON M_NAME.RNK = CUS.RNK AND M_NAME.TAG = 'SN_MN'
                            LEFT JOIN V_CUSTOMERW TOWN ON TOWN.RNK = CUS.RNK AND TOWN.TAG = 'FGTWN'
                            LEFT JOIN V_CUSTOMERW STREET ON STREET.RNK = CUS.RNK AND STREET.TAG = 'FGADR'
                        WHERE CUS.RNK = {0}
                            AND CUS.CUSTTYPE = 3", id);

            var query = _entities.ExecuteStoreQuery<RelatedCustomer>(sql);

            var result = query.FirstOrDefault();
            if (result != null)
            {
                if (!string.IsNullOrEmpty(result.AddressStreet))
                {
                    var match = Regex.Match(result.AddressStreet, @"(\s|[.,_])*(\d+)(\s|[.,_]|\p{L})*$");
                    if (match.Success)
                    {
                        int index = match.Groups[1].Index;
                        result.AddressHouseNumber = result.AddressStreet.Substring(index);
                        result.AddressStreet = result.AddressStreet.Substring(0, match.Index);
                    }
                }

            }

            return result;
        }
        public IEnumerable<DocsType> GetDocsData()
        {
            var sql = string.Format(@"SELECT t.PASSP, t.NAME from PASSP t WHERE t.PASSP IN (1, 5 ,7, 13, 15)");
            var query = _entities.ExecuteStoreQuery<DocsType>(sql).ToList();
            //var result = query.Where(x => x.PASSP == 1 || x.PASSP == 7 || x.PASSP == 15 || x.PASSP == 13 || x.PASSP == 5).Select(x => new DocsType { PASSP = x.PASSP, NAME = x.NAME }).ToList();
            return query;
        }
        public bool IsCanSign(decimal custId, string taxCode)
        {
            var p_rnk = new OracleParameter("p_rnk", OracleDbType.Decimal, custId, ParameterDirection.Input);
            var p_okpo = new OracleParameter("p_okpo", OracleDbType.NVarchar2, taxCode, ParameterDirection.Input);
            var commandText = "begin :result := bars.is_can_sign(p_rnk => :p_rnk, p_okpo => :p_okpo); end; ";
            var result = new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue);
            _entities.ExecuteStoreCommand(commandText, result, p_rnk, p_okpo);
            int res;
            if (result.Value != null && int.TryParse(result.Value.ToString(), out res)) return res == 1;
            return false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="custId"></param>
        /// <returns>bank - банк, corp - юр.лица, fop - фіз.особа-підприємець, person - фізична особа</returns>
        public string GetTypeOfCustomer(decimal custId)
        {
            var sql = @"select 
                    CASE when t.CUSTTYPE = 1 then 'bank'
                         when t.CUSTTYPE = 2 then 'corp'
                         when t.CUSTTYPE = 3 and t.SED = 91 then 'fop'
                         when t.CUSTTYPE = 3 and t.SED != 91 then 'person' 
                         else null end
                    from CUSTOMER t
                            where t.rnk = :p_rnk";
            var result = _entities.ExecuteStoreQuery<string>(sql, custId).FirstOrDefault();
            if (result == null) throw new Exception(string.Format("Контрагент (RNK: {0}) не знайдений", custId));
            return result;
        }
    }

    /// <summary>
    /// Contains logic for accessing and operationg with related customers
    /// </summary>
    public interface IRelatedCustomersRepository
    {
        IEnumerable<RelatedCustomer> GetAllForConfirm(decimal custId);
        /// <summary>
        /// Get all not visa customers id`s
        /// </summary>
        /// <returns></returns>
        IEnumerable<decimal> GetAllIdNotVisa();
        /// <summary>
        /// Get related customers (shorted)
        /// </summary>
        /// <param name="custId"></param>
        /// <returns></returns>
        IEnumerable<RelatedCustomer> GetCustomerRelatedCustomers(decimal custId);
        /// <summary>
        /// Get main data from main customer requisites for creating new related user (available only for FOP)
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        RelatedCustomer GetFOPData(decimal id);
        IEnumerable<DocsType> GetDocsData();
        bool IsCanSign(decimal custId, string taxCode);
        string GetTypeOfCustomer(decimal custId);
    }
}