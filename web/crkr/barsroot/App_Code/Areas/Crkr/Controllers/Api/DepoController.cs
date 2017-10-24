using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Services;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using BarsWeb.Areas.OpenCloseDay.Helpers;
using Dapper;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class DepoController : ApiController
    {
        private IDoposProfileRepository _repository;
        public DepoController(IDoposProfileRepository repository)
        {
            _repository = repository;
        }
        [HttpPost]
        [WebMethod]
        public HttpResponseMessage UnDep(Deposits model)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var command = new OracleCommand("crkr_compen_web.deactualization_compen", connection);
                command.CommandType = CommandType.StoredProcedure;

                var approveListParam = new OracleParameter("p_compen_list", OracleDbType.Array, model.id.Length, model.id, ParameterDirection.Input);
                approveListParam.UdtTypeName = "NUMBER_LIST";
                command.Parameters.Add("p_rnk", OracleDbType.Decimal, model.rnk, ParameterDirection.Input);
                command.Parameters.Add(approveListParam);
                command.Parameters.Add("p_opercode", OracleDbType.Varchar2, model.opercode, ParameterDirection.Input);
                command.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }            
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        [WebMethod]
        public HttpResponseMessage ReqUnDep(Deposits model)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var command = new OracleCommand("crkr_compen_web.request_deactualization_compen", connection);
                command.CommandType = CommandType.StoredProcedure;

                var approveListParam = new OracleParameter("p_compen_list", OracleDbType.Array, model.id.Length, model.id, ParameterDirection.Input);
                approveListParam.UdtTypeName = "NUMBER_LIST";
                command.Parameters.Add("p_rnk", OracleDbType.Decimal, model.rnk, ParameterDirection.Input);
                command.Parameters.Add(approveListParam);
                command.Parameters.Add("p_opercode", OracleDbType.Varchar2, model.opercode, ParameterDirection.Input);
                command.Parameters.Add("p_reason", OracleDbType.Varchar2, model.reason, ParameterDirection.Input);
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage GetDepo(decimal id)
        {
            var profile = _repository.GetProfile(id);
            return Request.CreateResponse(HttpStatusCode.OK, profile);
        }
        
        [HttpGet]
        public HttpResponseMessage ClientDepo(decimal rnk, string nsc, string fio, decimal? id)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new OracleDynamicParameters();
                p.Add("p_nsc", nsc, OracleDbType.Varchar2, ParameterDirection.Input);
                p.Add("p_fio", fio, OracleDbType.Varchar2, ParameterDirection.Input);
                p.Add("p_compen_id", id, OracleDbType.Decimal, ParameterDirection.Input);
                p.Add("outp ", dbType: OracleDbType.RefCursor, direction: ParameterDirection.ReturnValue);
                var results = connection.Query<ClientDepo>("crkr_compen_web.get_compens_write_down", p, commandType: CommandType.StoredProcedure);

                return Request.CreateResponse(HttpStatusCode.OK, results);
            }
        }

        [HttpGet]
        public HttpResponseMessage DeleteDepo(int benefId, decimal commpenId)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id_compen", commpenId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_idb", benefId, DbType.Int32, ParameterDirection.Input);
                connection.Execute("crkr_compen_web.delete_benef", p, commandType: CommandType.StoredProcedure);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }

        [HttpPost]
        public HttpResponseMessage AddMoney(Money model)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var p = new DynamicParameters();
                p.Add("p_rnk", model.Rnk, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_compen_donor_id", model.CompenId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_amount", model.Amount, DbType.Decimal, ParameterDirection.Input);
                connection.Execute("crkr_compen_web.open_new_compen_transfer", p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK);

        }

        [HttpGet]
        public HttpResponseMessage CurrentDepo(decimal rnk)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                object result = connection.Query("select name from v_customer_crkr where rnk = :rnk", new { rnk }).SingleOrDefault();
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
        }

        [HttpPost]
        public HttpResponseMessage BlockDepo(ReasonForBlock model)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var p = new DynamicParameters();
                p.Add("p_compen_id", model.CompenId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_status_id", model.StatusId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_reason_change_status", model.Reason, DbType.String, ParameterDirection.Input);
                connection.Execute("crkr_compen_web.set_compen_status", p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage UnblockDepo(string id)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var p = new DynamicParameters();
                p.Add("p_compen_id", id, DbType.String, ParameterDirection.Input);
                connection.Execute("crkr_compen_web.unblock_compen", p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage ChangeDoc(DocInDepo item)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                DateTime docdate;
                if (
                    !DateTime.TryParseExact(item.docdate, "dd.MM.yyyy", CultureInfo.InvariantCulture,
                        DateTimeStyles.None, out docdate))
                    throw new Exception("Custom: Невірний формат дати! ORA");

                var p = new DynamicParameters();
                p.Add("p_compen_id", item.id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_doc_type", item.doctype, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_ser", item.docserial, DbType.String, ParameterDirection.Input);
                p.Add("p_numdoc", item.docnumber, DbType.String, ParameterDirection.Input);
                p.Add("p_date_of_issue", docdate, DbType.DateTime, ParameterDirection.Input);
                p.Add("p_organ", item.docorg, DbType.String, ParameterDirection.Input);
                p.Add("p_type_person", item.type_person, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_name_person", item.name_person, DbType.String, ParameterDirection.Input);
                p.Add("p_edrpo_person", item.edrpo_person, DbType.String, ParameterDirection.Input);             

                connection.Execute("crkr_compen_web.change_compen_document", p, commandType: CommandType.StoredProcedure);
                
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        public HttpResponseMessage ActualCompen(Actual item)
        {

            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var p = new DynamicParameters();
                p.Add("p_rnk", item.userid, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_compenid", item.compenid, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_opercode", item.opercode, DbType.String, ParameterDirection.Input);
               
                connection.Execute("crkr_compen_web.actualization_compen", p, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpGet]
        public HttpResponseMessage SendToReg(decimal id)
        {

            var connection = OraConnector.Handler.UserConnection;
            try
            {
                var p = new DynamicParameters();
                p.Add("p_compen_id", id, DbType.Decimal, ParameterDirection.Input);
                connection.Execute("crkr_compen_web.add_to_registry_bur", p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }


        [HttpGet]
        public HttpResponseMessage GetDepoForActual(decimal? rnk)
        {
            List<dynamic> list;
            var connection = OraConnector.Handler.UserConnection;
            try
            {
                string query;
                if (rnk != null)
                {
                    query = @" select ID, FIO, DOCSERIAL, DOCNUMBER, ICOD, 
                                     KKNAME, NSC, LCV, DATO, SUM, OST
                               from v_potential_cust_compens where rnk = :rnk";
                }
                else
                {
                    query = @"select ID, FIO, DOCSERIAL, DOCNUMBER, ICOD, 
                                     KKNAME, NSC, LCV, DATO, SUM, OST, STATUS_NAME
                              from v_compens";
                }
                
                list = connection.Query(query, new {rnk}).ToList();
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK, list);
        }

        [HttpGet]
        public HttpResponseMessage NonSightPasp(decimal id)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new OracleDynamicParameters();
                p.Add("p_compen_id", id, OracleDbType.Decimal, ParameterDirection.Input);
                p.Add("outp ", dbType: OracleDbType.RefCursor, direction: ParameterDirection.ReturnValue);
                var results = connection.Query<dynamic>("crkr_compen_web.get_compen_new_doc", p, commandType: CommandType.StoredProcedure);

                return Request.CreateResponse(HttpStatusCode.OK, results);
            }
        }
    }

    public class Actual
    {
        public decimal userid { get; set; }
        public decimal compenid { get; set; }
        public string opercode { get; set; }
    }
}
