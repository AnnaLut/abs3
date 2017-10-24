using System;
using System.Linq;
using Models;
using BarsWeb.Areas.CorpLight.Models.Acsk;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CorpLight.Infrastructure.Repository
{
    public class AcskRepository : IAcskRepository
    {

        readonly EntitiesBars _entities;
        private readonly IRelatedCustomersRepository _relCustRepository;

        public AcskRepository(
            ICorpLightModel model,
            IRelatedCustomersRepository relCustRepository)
        {
            _entities = model.CorpLightEntities;
            _relCustRepository = relCustRepository;
        }

        public void MapRelatedCustomerToAcskUser(decimal relCustId, AcskSendProfileInfo profileInfo)
        {
            var user = _relCustRepository.GetById(relCustId);
            if (user.AcskRegistrationId != null)
            {
                throw new Exception("Користувач (id=" + relCustId + ") "
                    + "вже зареєстрований в АЦСК (registrationId=" + user.AcskRegistrationId + ")");
            }
            var sql = @"insert into MBM_ACSK_REGISTRATION 
                            (rel_cust_id, registration_id, registration_date, acsk_user_id)
                        values
                            (:rel_cust_id, :registration_id, :registration_date, :acsk_user_id)";
            _entities.ExecuteStoreCommand(
                sql, relCustId, profileInfo.RegistrationId, DateTime.Now, profileInfo.UserId);
        }

        public AcskCertificate GetAcskCertificate(decimal id)
        {
            var sql = @"select 
                            ID as Id,
                            REL_CUST_ID as RelCustId,
                            REQUEST_TIME as RequesTime,
                            REQUEST_STATE as RequestState,
                            REQUEST_STATE_MESSAGE as RequestStateMessage,
                            CERTIFICATE_SN as CertificateSn,
                            TEMPLATE_NAME as TemplateName,
                            TEMPLATE_OID as TemplateOid,
                            CERTIFICATE_ID as CertificateId,
                            CERTIFICATE_BODY as CertificateBody,
                            REVOKE_CODE as RevokeCode,
                            TOKEN_SN as TokenSn,
                            TOKEN_NAME as TokenName
                        from
                            MBM_ACSK_CERTIFICATE_REQ
                        where
                            ID = :id";
            var certificate = _entities.ExecuteStoreQuery<AcskCertificate>(sql, id).FirstOrDefault();
            return certificate;
        }

        public void UpdateCertificateInfo(decimal relCustId, AcskCertificate certificate)
        {
            var count = _entities.ExecuteStoreQuery<int>(
                @"select count(0) from MBM_ACSK_CERTIFICATE_REQ where ID = :id",
                    certificate.Id).FirstOrDefault();
            string sql;

            if (count == 0)
            {
                sql = @"insert into MBM_ACSK_CERTIFICATE_REQ (
                            REL_CUST_ID,
                            REQUEST_TIME,
                            REQUEST_STATE,
                            REQUEST_STATE_MESSAGE,
                            CERTIFICATE_SN,
                            TEMPLATE_NAME,
                            TEMPLATE_OID,
                            CERTIFICATE_ID,
                            CERTIFICATE_BODY,
                            REVOKE_CODE,
                            TOKEN_SN,
                            TOKEN_NAME,
                            ID)
                        values (
                            :relCustId,
                            :RequesTime,
                            :RequestState,
                            :RequestStateMessage,
                            :CertificateSn,
                            :TemplateName,
                            :TemplateOid,
                            :CertificateId,
                            :CertificateBody,
                            :RevokeCode,
                            :TokenSn,
                            :TokenName,
                            :id)";
            }
            else
            {
                sql = @"update MBM_ACSK_CERTIFICATE_REQ set
                            REL_CUST_ID = :relCustId,
                            REQUEST_TIME = :RequesTime,
                            REQUEST_STATE = :RequestState,
                            REQUEST_STATE_MESSAGE = :RequestStateMessage,
                            CERTIFICATE_SN = :CertificateSn,
                            TEMPLATE_NAME = :TemplateName,
                            TEMPLATE_OID = :TemplateOid,
                            CERTIFICATE_ID = :CertificateId,
                            CERTIFICATE_BODY = :CertificateBody,
                            REVOKE_CODE = :RevokeCode,
                            TOKEN_SN = :TokenSn,
                            TOKEN_NAME = :TokenName
                        where
                            ID = :id";
            }
            
            _entities.ExecuteStoreCommand(
                sql,
                relCustId,
                certificate.RequesTime,
                certificate.RequestState,
                certificate.RequestStateMessage,
                certificate.CertificateSn,
                certificate.TemplateName,
                certificate.TemplateOid,
                certificate.CertificateId,
                certificate.CertificateBody,
                certificate.RevokeCode,
                certificate.TokenSn,
                certificate.TokenName,
                certificate.Id);
        }
        public void SaveEnrollRequest(decimal relCustId, AcskEnrollResponse enroll)
        {
            if (enroll != null)
            {
                var count = _entities.ExecuteStoreQuery<int>(
                    @"select count(0) from MBM_ACSK_CERTIFICATE_REQ where ID = :id",
                    enroll.RequestId).FirstOrDefault();
                if (count != 0)
                {
                    throw new Exception(
                        string.Format("Запит (ID={0}) вже було збережено раніше. Перевірте коректність даних",
                        enroll.RequestId));
                }

                var sql = @"insert into MBM_ACSK_CERTIFICATE_REQ
                                (REL_CUST_ID, ID, REQUEST_TIME, REQUEST_STATE)
                            values
                                (:REL_CUST_ID, :ID, :REQUEST_TIME, :REQUEST_STATE)";
                _entities.ExecuteStoreCommand(
                    sql, relCustId, enroll.RequestId, enroll.CreateTime, enroll.Status);
            }
        }


    }

    public interface IAcskRepository
    {
        void MapRelatedCustomerToAcskUser(decimal relCustId, AcskSendProfileInfo profileInfo);
        AcskCertificate GetAcskCertificate(decimal id);
        void UpdateCertificateInfo(decimal relCustId, AcskCertificate certificate);
        void SaveEnrollRequest(decimal relCustId, AcskEnrollResponse enroll);
    }
}