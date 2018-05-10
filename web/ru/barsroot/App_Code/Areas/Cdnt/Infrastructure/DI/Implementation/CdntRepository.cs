using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using Areas.Cdnt.Models;
using BarsWeb.Areas.Cdnt.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cdnt.Models;
using BarsWeb.Areas.Cdnt.Models.Transport;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using barsroot.core;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.Cdnt.Infrastructure.DI.Implementation
{
    public class CdntRepository : ICdntRepository
    {
        private readonly CdntModel _entities;
        private readonly IParamsRepository _globalParams;

        private const string GetListItemSql =
            @"select list_item_id, list_item_name from  list_item where list_type_id in (
                select id from list_type where list_code = :p_list_code)";

        private void UserLogin()
        {
            var userName = _globalParams.GetParam("NOTA_LOGIN_CA").Value;
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            var sqlParams = new object[]
            {
                new OracleParameter("p_sessionid", OracleDbType.Varchar2) {Value = HttpContext.Current.Session.SessionID},
                new OracleParameter("p_userid", OracleDbType.Decimal) {Value = userMap.user_id},
                new OracleParameter("p_hostname", OracleDbType.Varchar2) {Value = "localhost"},
                new OracleParameter("p_appname", OracleDbType.Varchar2) {Value = "barsroot"}
            };
            _entities.ExecuteStoreCommand("begin bars.bars_login.login_user(:p_sessionid, :p_userid, :p_hostname, :p_appname); end;", sqlParams);

            HttpContext.Current.Session["UserLoggedIn"] = true;
        }

        public CdntRepository(IParamsRepository globalParams)
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdntModel", "Cdnt");
            _entities = new CdntModel(connectionStr);
            _globalParams = globalParams;
        }

        public IQueryable<V_NOTARY> GetNotaries()
        {
            return _entities.V_NOTARY;
        }

        public decimal AddNotary(NOTARY notary)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_TIN", OracleDbType.Varchar2) {Value = notary.TIN},
                new OracleParameter("p_ADR", OracleDbType.Varchar2) {Value = notary.ADDRESS},
                new OracleParameter("p_DATP", OracleDbType.Date) {Value = notary.DATE_OF_BIRTH},
                new OracleParameter("p_EMAIL", OracleDbType.Varchar2) {Value = notary.EMAIL},
                new OracleParameter("p_LAST_NAME", OracleDbType.Varchar2) {Value = notary.LAST_NAME},
                new OracleParameter("p_FIRST_NAME", OracleDbType.Varchar2) {Value = notary.FIRST_NAME},
                new OracleParameter("p_MIDDLE_NAME", OracleDbType.Varchar2) {Value = notary.MIDDLE_NAME},
                new OracleParameter("p_PHONE_NUMBER", OracleDbType.Varchar2) {Value = notary.PHONE_NUMBER},
                new OracleParameter("p_MOBILE_PHONE_NUMBER", OracleDbType.Varchar2) {Value = notary.MOBILE_PHONE_NUMBER},
                new OracleParameter("p_PASSPORT_SERIES", OracleDbType.Varchar2) {Value = notary.PASSPORT_SERIES},
                new OracleParameter("p_PASSPORT_NUMBER", OracleDbType.Varchar2) {Value = notary.PASSPORT_NUMBER},
                new OracleParameter("p_PASSPORT_ISSUER", OracleDbType.Varchar2) {Value = notary.PASSPORT_ISSUER},
                new OracleParameter("p_PASSPORT_ISSUED", OracleDbType.Date) {Value = notary.PASSPORT_ISSUED},
                new OracleParameter("p_NOTARY_TYPE", OracleDbType.Decimal) {Value = notary.NOTARY_TYPE},
                new OracleParameter("p_CERTIFICATE_NUMBER", OracleDbType.Varchar2) {Value = notary.CERTIFICATE_NUMBER},
                new OracleParameter("p_CERTIFICATE_ISSUE_DATE", OracleDbType.Date) {Value = notary.CERTIFICATE_ISSUE_DATE},
                new OracleParameter("p_CERTIFICATE_CANCELATION_DATE", OracleDbType.Date) {Value = notary.CERTIFICATE_CANCELATION_DATE},
                new OracleParameter("p_RNK", OracleDbType.Varchar2) {Value = null},
                new OracleParameter("p_MFORNK", OracleDbType.Varchar2) {Value = null},
                new OracleParameter("p_DOCUMENT_TYPE", OracleDbType.Int32) {Value = notary.DOCUMENT_TYPE},
                new OracleParameter("p_IDCARD_DOCUMENT_NUMBER", OracleDbType.Decimal) {Value = notary.IDCARD_DOCUMENT_NUMBER},
                new OracleParameter("p_IDCARD_NOTATION_NUMBER", OracleDbType.Varchar2) {Value = notary.IDCARD_NOTATION_NUMBER},
                new OracleParameter("p_PASSPORT_EXPIRY", OracleDbType.Date) {Value = notary.PASSPORT_EXPIRY},

                new OracleParameter("p_RET", OracleDbType.Decimal) {Direction = ParameterDirection.Output},
                new OracleParameter("p_ERR", OracleDbType.Varchar2) {Direction = ParameterDirection.Output, Size = 4000}
            };
            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(@"begin 
                    BARS.nota.create_nota(:p_TIN, :p_adr, :p_datp, :p_email, :p_last_name, :p_first_name, :p_middle_name, 
                            :p_phone_number, :p_MOBILE_PHONE_NUMBER, :p_PASSPORT_SERIES, :p_PASSPORT_NUMBER,  :PASSPORT_ISSUER, :PASSPORT_ISSUED, 
                            :p_NOTARY_TYPE, :p_CERTIFICATE_NUMBER, :p_CERTIFICATE_ISSUE_DATE, :p_CERTIFICATE_CANCELATION_DATE,
                            :p_RNK, :p_MFORNK, :p_DOCUMENT_TYPE, :p_IDCARD_DOCUMENT_NUMBER, :p_IDCARD_NOTATION_NUMBER, :p_PASSPORT_EXPIRY, :p_ret, :p_err);
                    end;", sqlParams);

                OracleString errMsg = ((OracleString)((OracleParameter)sqlParams[24]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
                t.Commit();
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            finally
            {
                _entities.Connection.Close();
            }
            return decimal.Parse(((OracleParameter)sqlParams[23]).Value.ToString());
        }

        public void EditNotary(NOTARY notary)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_ID", OracleDbType.Decimal) {Value = notary.ID},
                new OracleParameter("p_TIN", OracleDbType.Varchar2) {Value = notary.TIN},
                new OracleParameter("p_ADR", OracleDbType.Varchar2) {Value = notary.ADDRESS},
                new OracleParameter("p_DATP", OracleDbType.Date) {Value = notary.DATE_OF_BIRTH},
                new OracleParameter("p_EMAIL", OracleDbType.Varchar2) {Value = notary.EMAIL},
                new OracleParameter("p_LAST_NAME", OracleDbType.Varchar2) {Value = notary.LAST_NAME},
                new OracleParameter("p_FIRST_NAME", OracleDbType.Varchar2) {Value = notary.FIRST_NAME},
                new OracleParameter("p_MIDDLE_NAME", OracleDbType.Varchar2) {Value = notary.MIDDLE_NAME},
                new OracleParameter("p_PHONE_NUMBER", OracleDbType.Varchar2) {Value = notary.PHONE_NUMBER},
                new OracleParameter("p_MOBILE_PHONE_NUMBER", OracleDbType.Varchar2) {Value = notary.MOBILE_PHONE_NUMBER},
                new OracleParameter("p_PASSPORT_SERIES", OracleDbType.Varchar2) {Value = notary.PASSPORT_SERIES},
                new OracleParameter("p_PASSPORT_NUMBER", OracleDbType.Varchar2) {Value = notary.PASSPORT_NUMBER},
                new OracleParameter("p_PASSPORT_ISSUER", OracleDbType.Varchar2) {Value = notary.PASSPORT_ISSUER},
                new OracleParameter("p_PASSPORT_ISSUED", OracleDbType.Date) {Value = notary.PASSPORT_ISSUED},
                new OracleParameter("p_NOTARY_TYPE", OracleDbType.Decimal) {Value = notary.NOTARY_TYPE},
                new OracleParameter("p_CERTIFICATE_NUMBER", OracleDbType.Varchar2) {Value = notary.CERTIFICATE_NUMBER},
                new OracleParameter("p_CERTIFICATE_ISSUE_DATE", OracleDbType.Date) {Value = notary.CERTIFICATE_ISSUE_DATE},
                new OracleParameter("p_CERTIFICATE_CANCELATION_DATE", OracleDbType.Date) {Value = notary.CERTIFICATE_CANCELATION_DATE},
                new OracleParameter("p_RNK", OracleDbType.Varchar2) {Value = null},
                new OracleParameter("p_MFORNK", OracleDbType.Varchar2) {Value = null},
                new OracleParameter("p_DOCUMENT_TYPE", OracleDbType.Int32) {Value = notary.DOCUMENT_TYPE},
                new OracleParameter("p_IDCARD_DOCUMENT_NUMBER", OracleDbType.Decimal) {Value = notary.IDCARD_DOCUMENT_NUMBER},
                new OracleParameter("p_IDCARD_NOTATION_NUMBER", OracleDbType.Varchar2) {Value = notary.IDCARD_NOTATION_NUMBER},
                new OracleParameter("p_PASSPORT_EXPIRY", OracleDbType.Date) {Value = notary.PASSPORT_EXPIRY},

                new OracleParameter("p_ERR", OracleDbType.Varchar2) {Direction = ParameterDirection.Output, Size = 4000}
            };
            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(@"begin 
                    BARS.nota.edit_nota(:p_ID, :p_TIN, :p_adr, :p_datp, :p_email, :p_last_name, :p_first_name, :p_middle_name, 
                            :p_phone_number, :p_MOBILE_PHONE_NUMBER, :p_PASSPORT_SERIES, :p_PASSPORT_NUMBER, :PASSPORT_ISSUER, :PASSPORT_ISSUED,
                            :p_NOTARY_TYPE, :p_CERTIFICATE_NUMBER, :p_CERTIFICATE_ISSUE_DATE, :p_CERTIFICATE_CANCELATION_DATE,
                            :p_RNK, :p_MFORNK,  :p_DOCUMENT_TYPE, :p_IDCARD_DOCUMENT_NUMBER, :p_IDCARD_NOTATION_NUMBER, :p_PASSPORT_EXPIRY, :p_err);
                    end;", sqlParams);

                OracleString errMsg = ((OracleString)((OracleParameter)sqlParams[24]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();
        }

        public void DeleteNotary(long id)
        {
            var sqlParams = new object[]
            {
                 new OracleParameter("p_ID", OracleDbType.Decimal) {Value = id}
            };
            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(@"begin 
                                                  BARS.nota.close_notary(:p_ID); 
                                                end;", sqlParams);
                t.Commit();
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            finally
            {

                _entities.Connection.Close();
            }
        }


        public IQueryable<V_NOTARY_ACCREDITATION> GetNotaryAccreditations(decimal notaryId)
        {
            return _entities.V_NOTARY_ACCREDITATION.Where(n => n.NOTARY_ID == notaryId);
        }

        private string parseAccreditationCollections(NOTARY_ACCREDITATION accreditation)
        {
            StringBuilder par = new StringBuilder();
            par.Append("VARCHAR2_LIST(");
            if (accreditation.Branches != null && accreditation.Branches.Count > 0)
            {
                par.Append("'" + string.Join("', '", accreditation.Branches) + "'");
            }
            else
            {
                par.Append("null");
            }
            par.Append("), NUMBER_LIST(");
            if (accreditation.Businesses != null && accreditation.Businesses.Count > 0)
            {
                par.Append(string.Join(",", accreditation.Businesses));
            }
            else
            {
                par.Append("null");
            }
            par.Append(")");
            return par.ToString();
        }

        public decimal AddAcreditation(NOTARY_ACCREDITATION accreditation)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_notary_id", OracleDbType.Decimal) {Value = accreditation.NOTARY_ID},
                new OracleParameter("p_accreditation_type_id", OracleDbType.Decimal)
                {
                    Value = accreditation.ACCREDITATION_TYPE_ID
                },
                new OracleParameter("p_START_DATE", OracleDbType.Date) {Value = accreditation.START_DATE},
                new OracleParameter("p_expiry_DATE", OracleDbType.Date) {Value = accreditation.EXPIRY_DATE},
                new OracleParameter("p_account_number", OracleDbType.Varchar2) {Value = accreditation.ACCOUNT_NUMBER},
                new OracleParameter("p_account_mfo", OracleDbType.Varchar2) {Value = accreditation.ACCOUNT_MFO},
                new OracleParameter("p_state_id", OracleDbType.Decimal) {Value = accreditation.STATE_ID},
                new OracleParameter("p_ret", OracleDbType.Decimal) {Direction = ParameterDirection.Output},
                new OracleParameter("p_err", OracleDbType.Varchar2) {Direction = ParameterDirection.Output, Size = 4000}
            };
            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(string.Format(@"begin 
                    BARS.nota.add_accr(:p_notary_id, :p_accreditation_type_id, 
                         :p_START_DATE, :p_expiry_DATE, 
                         :p_account_number, :p_account_mfo, :p_state_id, 
                         {0},
                         :p_ret, :p_err);
                    end;", parseAccreditationCollections(accreditation)), sqlParams);

                OracleString errMsg = ((OracleString)((OracleParameter)sqlParams[8]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();
            return decimal.Parse(((OracleParameter)sqlParams[7]).Value.ToString());
        }

        public V_NOTARY_ACCREDITATION CloseAccreditation(decimal accreditationId)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_accr_id", OracleDbType.Decimal) {Value = accreditationId},
                new OracleParameter("p_err", OracleDbType.Varchar2) {Direction = ParameterDirection.Output, Size = 4000}
            };
            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(@"begin 
                    BARS.nota.close_accr(:p_accr_id, :p_err);
                    end;", sqlParams);
                OracleString errMsg = ((OracleString)((OracleParameter)sqlParams[1]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();

            return _entities.V_NOTARY_ACCREDITATION.SingleOrDefault(a => a.ID == accreditationId);
        }

        public IQueryable<V_NOTARY_TRANSACTION> GetAccreditationTransactions(decimal accreditationId)
        {
            return _entities.V_NOTARY_TRANSACTION.Where(t => t.ACCREDITATION_ID == accreditationId);
        }

        public IEnumerable<BarsListItem> GetNotaryTypes()
        {
            return _entities.ExecuteStoreQuery<BarsListItem>(GetListItemSql, "NOTARY_TYPE");
        }
        public IEnumerable<BarsListItem> GetDocumentTypes()
        {
            var sql= "SELECT PASSP as list_item_id, (case when PASSP = 7 then 'ID-картка' else NAME end) as list_item_name FROM PASSP WHERE PSPTYP = '01'";
            //var sql = "SELECT PASSP as list_item_id, NAME as list_item_name FROM PASSP WHERE PSPTYP = '01'";
            return _entities.ExecuteStoreQuery<BarsListItem>(sql);
        }
        public IEnumerable<BarsListItem> GetAccreditationTypes()
        {
            return _entities.ExecuteStoreQuery<BarsListItem>(GetListItemSql, "NOTARY_ACCREDITATION_TYPE");
        }

        public IEnumerable<BarsListItem> GetAccreditationStates()
        {
            return _entities.ExecuteStoreQuery<BarsListItem>(GetListItemSql, "NOTARY_ACCREDITATION_STATE");
        }

        public IQueryable<NOTARY_TRANSACTION_TYPES> GetTransactionTypes()
        {
            return _entities.NOTARY_TRANSACTION_TYPES;
        }

        public IEnumerable<BarsListItem> GetSegmentsOfBusiness()
        {
            return _entities.ExecuteStoreQuery<BarsListItem>(GetListItemSql, "NOTARY_SEGMENT_OF_BUSINESS");
        }

        public void EditAccreditation(NOTARY_ACCREDITATION accreditation)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_accr_id", OracleDbType.Decimal) {Value = accreditation.ID},
                new OracleParameter("p_accreditation_type_id", OracleDbType.Decimal)
                {
                    Value = accreditation.ACCREDITATION_TYPE_ID
                },
                new OracleParameter("p_START_DATE", OracleDbType.Date) {Value = accreditation.START_DATE},
                new OracleParameter("p_expiry_DATE", OracleDbType.Date) {Value = accreditation.EXPIRY_DATE},
                new OracleParameter("p_account_number", OracleDbType.Varchar2) {Value = accreditation.ACCOUNT_NUMBER},
                new OracleParameter("p_account_mfo", OracleDbType.Varchar2) {Value = accreditation.ACCOUNT_MFO},
                new OracleParameter("p_state_id", OracleDbType.Decimal) {Value = accreditation.STATE_ID},
                new OracleParameter("p_err", OracleDbType.Varchar2) {Direction = ParameterDirection.Output, Size = 4000}
            };
            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(string.Format(@"begin 
                    BARS.nota.edit_accr(:p_accr_id, :p_accreditation_type_id, 
                         :p_START_DATE, :p_expiry_DATE, 
                         :p_account_number, :p_account_mfo, :p_state_id, 
                         {0},
                         :p_err);
                    end;", parseAccreditationCollections(accreditation)), sqlParams);

                OracleString errMsg = ((OracleString)((OracleParameter)sqlParams[7]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();
        }


        public IEnumerable<string> GetAccreditationBranches(decimal accrId)
        {
            const string attrName = "NOTARY_ACCR_BRANCHES";
            var sqlParams = new object[]
            {
                new OracleParameter("p_accr_id", OracleDbType.Decimal) {Value = accrId},
                new OracleParameter("p_attr_name", OracleDbType.Varchar2) {Value = attrName}
            };
            return
                _entities.ExecuteStoreQuery<string>(
                    "select column_value from table (select attribute_utl.get_string_values(:p_accr_id, :p_attr_name) from dual)",
                    sqlParams);
        }

        public IEnumerable<decimal> GetAccreditationBusinesses(decimal accrId)
        {
            const string attrName = "NOTARY_ACCR_SEG_OF_BUSINESS";
            var sqlParams = new object[]
            {
                new OracleParameter("p_accr_id", OracleDbType.Decimal) {Value = accrId},
                new OracleParameter("p_attr_name", OracleDbType.Varchar2) {Value = attrName}
            };
            return
                _entities.ExecuteStoreQuery<decimal>(
                    "select column_value from table (select attribute_utl.get_number_values(:p_accr_id, :p_attr_name) from dual)",
                    sqlParams);
        }

        public IQueryable<V_NOTARY_TRANSACTION> GetTransactions(decimal accrId)
        {
            return _entities.V_NOTARY_TRANSACTION.Where(t => t.ACCREDITATION_ID == accrId);
        }


        public IQueryable<NOTARY> GetNotary()
        {
            return _entities.NOTARY;
        }


        public decimal GetNotaryCount()
        {
            return _entities.NOTARY.Count();
        }


        public void CancelAccreditation(decimal accreditationId)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_accr_id", OracleDbType.Decimal) {Value = accreditationId},
                new OracleParameter("p_err", OracleDbType.Varchar2) {Direction = ParameterDirection.Output, Size = 4000}
            };
            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(@"begin 
                    BARS.nota.redemption_accr(:p_accr_id, :p_ret);
                    end;", sqlParams);
                OracleString errMsg = ((OracleString)((OracleParameter)sqlParams[1]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();
        }

        public V_NOTARY_ACCREDITATION GetAccreditation(decimal accreditationId)
        {
            return _entities.V_NOTARY_ACCREDITATION.SingleOrDefault(a => a.ID == accreditationId);
        }

        public void AddAccreditationQuery(AccreditationQuery query)
        {
            UserLogin();
            var sqlParams = new object[]
            {
                new OracleParameter("p_sender_mfo", OracleDbType.Varchar2) {Value = query.SenderMfo},
                new OracleParameter("p_notary_type", OracleDbType.Decimal) {Value = query.NotaryType},
                new OracleParameter("p_certificate_number", OracleDbType.Varchar2) {Value = query.CertNumber},
                new OracleParameter("p_first_name", OracleDbType.Varchar2) {Value = query.FirstName},
                new OracleParameter("p_middle_name", OracleDbType.Varchar2) {Value = query.MiddleName},
                new OracleParameter("p_last_name", OracleDbType.Varchar2) {Value = query.LastName},
                new OracleParameter("p_date_of_birth", OracleDbType.Date) {Value = query.DateOfBirth},
                new OracleParameter("p_accreditation_type", OracleDbType.Varchar2) {Value = query.AccreditationType},
                new OracleParameter("p_tin", OracleDbType.Varchar2) {Value = query.Tin},
                new OracleParameter("p_passport_series", OracleDbType.Varchar2) {Value = query.PassportSeries},
                new OracleParameter("p_passport_number", OracleDbType.Varchar2) {Value = query.PassportNumber},
                new OracleParameter("p_passport_issuer", OracleDbType.Varchar2) {Value = query.PassportIssuer},
                new OracleParameter("p_passport_issued", OracleDbType.Date) {Value = query.PassportIssued},
                new OracleParameter("p_address", OracleDbType.Varchar2) {Value = query.Address},
                new OracleParameter("p_phone_number", OracleDbType.Varchar2) {Value = query.PhoneNumber},
                new OracleParameter("p_mobile_phone_number", OracleDbType.Varchar2) {Value = query.MobilePhoneNumber},
                new OracleParameter("p_email", OracleDbType.Varchar2) {Value = query.Email},
                new OracleParameter("p_rnk", OracleDbType.Decimal) {Value = query.Rnk},
                new OracleParameter("p_account_number", OracleDbType.Varchar2) {Value = query.AccountNumber},
                new OracleParameter("p_DOCUMENT_TYPE", OracleDbType.Int32) {Value = query.DocumentType},
                new OracleParameter("p_IDCARD_DOCUMENT_NUMBER", OracleDbType.Decimal) {Value = query.IdcardDocumentNumber},
                new OracleParameter("p_IDCARD_NOTATION_NUMBER", OracleDbType.Varchar2) {Value = query.IdcardNotationNumber},
                new OracleParameter("p_PASSPORT_EXPIRY", OracleDbType.Date) {Value = query.PassportExpiry}
            };

            _entities.ExecuteStoreCommand(
                @"begin BARS.nota.process_accreditation_request(:p_sender_mfo, :p_notary_type, :p_certificate_number,
                :p_first_name, :p_middle_name, :p_last_name, :p_date_of_birth, :p_accreditation_type, :p_tin, :p_passport_series, :p_passport_number,
                :p_passport_issuer, :p_passport_issued, :p_address, :p_phone_number, :p_mobile_phone_number, :p_email, :p_rnk, :p_account_number,
                :p_DOCUMENT_TYPE, :p_IDCARD_DOCUMENT_NUMBER, :p_IDCARD_NOTATION_NUMBER, :p_PASSPORT_EXPIRY); end;",
                sqlParams);
        }

        public void AlterAccreditationQuery(AccreditationQuery query)
        {
            UserLogin();
            var sqlParams = new object[]
            {
                new OracleParameter("p_sender_mfo", OracleDbType.Varchar2) {Value = query.SenderMfo},
                new OracleParameter("p_notary_type", OracleDbType.Decimal) {Value = query.NotaryType},
                new OracleParameter("p_certificate_number", OracleDbType.Varchar2) {Value = query.CertNumber},
                new OracleParameter("p_account_number", OracleDbType.Varchar2) {Value = query.AccountNumber}
            };
            _entities.ExecuteStoreCommand(
                @"begin BARS.nota.process_alter_request(:p_sender_mfo, :p_notary_type, :p_certificate_number, :p_account_number); end;",
                sqlParams);
        }

        public void AddProfit(V_NOTARY_PROFIT profit)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_NOTARY_ID", OracleDbType.Decimal) {Value = profit.NOTARY_ID},
                new OracleParameter("p_ACCR_ID", OracleDbType.Decimal) {Value = profit.ACCR_ID},
                new OracleParameter("p_BRANCH", OracleDbType.Varchar2) {Value = profit.BRANCH},
                new OracleParameter("p_NBSOB22", OracleDbType.Varchar2) {Value = profit.NBSOB22},
                new OracleParameter("p_REF_OPER", OracleDbType.Decimal) {Value = profit.REF_OPER},
                new OracleParameter("p_DAT_OPER", OracleDbType.Date) {Value = profit.DAT_OPER},
                new OracleParameter("p_PROFIT", OracleDbType.Decimal) {Value = profit.PROFIT},
                new OracleParameter("p_err", OracleDbType.Varchar2) {Direction = ParameterDirection.Output},
                new OracleParameter("p_ret", OracleDbType.Decimal) {Direction = ParameterDirection.Output, Size = 4000}
            };

            _entities.Connection.Open();
            var t = _entities.Connection.BeginTransaction();
            try
            {
                _entities.ExecuteStoreCommand(
                    @"begin BARS.notary_toprofit(:p_NOTARY_ID, :p_ACCR_ID, :p_BRANCH, :p_NBSOB22, :p_REF_OPER, :p_DAT_OPER, :p_PROFIT, :p_err, :p_ret); end;",
                    sqlParams);
                OracleString errMsg = ((OracleString)((OracleParameter)sqlParams[7]).Value);
                if (!errMsg.IsNull)
                {
                    throw new Exception(errMsg.Value);
                }
            }
            catch (Exception)
            {
                t.Rollback();
                throw;
            }
            t.Commit();

        }
    }
}