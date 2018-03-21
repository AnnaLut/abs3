using BarsWeb.Areas.CDO.Common.Models.Acsk;
using BarsWeb.Areas.CDO.Common.Repository;
using Models;
using System.Linq;

namespace BarsWeb.Areas.CDO.Common.Services
{
    /// <summary>
    /// Request logger class
    /// </summary>
    public class AcskLogger : IAcskLogger
    {

        readonly EntitiesBars _entities;
        public AcskLogger(ICDOModel model)
        {
            _entities = model.CorpLightEntities;
        }
        /// <summary>
        /// Logging request
        /// </summary>
        /// <param name="request"></param>
        public void LogRequest(AcskRequest request)
        {
            if (!IsExistLog(request.Id))
            {
                var sql = @"insert into MBM_ACSK_REQUESTS_HISTORY (
                            NONCE, 
                            REQUEST_DATE, 
                            REQUEST_BODY) 
                        values (
                            :p_NONCE, 
                            :p_REQUEST_DATE, 
                            :p_REQUEST_BODY)";
                _entities.ExecuteStoreCommand(sql,
                    request.Id,
                    request.Date,
                    request.Base64RequestData);
            }
        }
        /// <summary>
        /// Logging responce
        /// </summary>
        /// <param name="response"></param>
        public void LogResponse(AcskResponse response)
        {
            var message = response.Message.Length > 4000 ? response.Message.Substring(0, 4000) : response.Message;
            if (IsExistLog(response.Id))
            {
                var sql =
                    @"update MBM_ACSK_REQUESTS_HISTORY set
                            RESPONSE_DATE = :p_RESPONSE_DATE, 
                            RESPONSE_CODE = :p_RESPONSE_CODE, 
                            RESPONSE_MESSAGE = :p_RESPONSE_MESSAGE
                        where NONCE = :p_NONCE";
                _entities.ExecuteStoreCommand(sql,
                    response.Date,
                    response.Code,
                    message,
                    response.Id);
            }
            else
            {
                var sql = @"insert into MBM_ACSK_REQUESTS_HISTORY (
                                NONCE,
                                REQUEST_DATE, 
                                RESPONSE_DATE, 
                                RESPONSE_CODE,
                                RESPONSE_MESSAGE) 
                            values (
                                :p_NONCE, 
                                :p_REQUEST_DATE,
                                :p_RESPONSE_DATE, 
                                :p_RESPONSE_CODE,
                                :p_RESPONSE_MESSAGE)";
                _entities.ExecuteStoreCommand(sql,
                    response.Id,
                    response.Date,
                    response.Date,
                    response.Code,
                    message);
            }
        }
        /// <summary>
        /// If log is exist
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        private bool IsExistLog(string id)
        {
            var countSql = @"select count(0) from MBM_ACSK_REQUESTS_HISTORY where NONCE = :p_NONCE";
            var count = _entities.ExecuteStoreQuery<decimal>(countSql, id).FirstOrDefault();
            return count != 0;
        }
    }

    public interface IAcskLogger
    {
        void LogRequest(AcskRequest request);
        void LogResponse(AcskResponse response);
    }
}