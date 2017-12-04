using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Text;
using BarsWeb;
using BarsWeb.Areas.InsUi.Models.Transport;
using Oracle.DataAccess.Client;
using Bars.Classes;

namespace Areas.InsUi.Controllers.Api.RemoteBranch
{
    [AuthorizeApi]
    public class InfoRemoteBranchController : ApiController
    {
        // GET api/<controller>
        public HttpResponseMessage Get(string code, string DocumentTypes, DateTime? date, bool isLegal, string limit)
        {
            List<CustomerInfoList> customers = new List<CustomerInfoList>();
            var sqlString = @"select c.custtype,
                                     c.okpo,
                                     c.nmk,
                                     c.adr,
                                     p.bday,
                                     (select id from ins_ewa_document_types where ext_id = p.passp and rownum = 1) as passp,
                                     p.ser,
                                     p.numdoc,
                                     p.pdate,
                                     p.organ
                                 from customer c, person p
                                 where c.rnk = p.rnk
                                 and c.okpo = :p_inn
                                 and c.date_off is null
                                 and rownum <= :p_limit
                                 and c.custtype = :p_islegal";
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sqlString;
                cmd.Parameters.Add("p_inn", OracleDbType.Varchar2, code, ParameterDirection.Input);
                cmd.Parameters.Add("p_limit", OracleDbType.Varchar2, limit, ParameterDirection.Input);
                cmd.Parameters.Add("p_islegal", OracleDbType.Decimal, isLegal ? 2 : 3, ParameterDirection.Input);
                
                OracleDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        CustomerInfoList customer = new CustomerInfoList();
                        InsuredDocuments document = new InsuredDocuments();
                        customer.legal = rdr[0].ToString() == "3" ? false : true;
                        customer.code = rdr[1].ToString();
                        string nmk = "";
                        var name = rdr[2].ToString().Replace("  ", " ");
                        string[] nmkArray = name.Split(' ');
                        for (var i = 0; i < nmkArray.Count(); i++)
                        {
                            var first = nmkArray[i].Substring(0, 1).ToUpper();
                            var next = nmkArray[i].Substring(1).ToLower();
                            if (i == nmkArray.Count() - 1)
                            {
                                nmk += first + next;
                            }
                            else
                            {
                                nmk += first + next + " ";
                            }
                        }
                        customer.name = nmk;
                        customer.address = rdr[3].ToString();
                        customer.birthDate = String.IsNullOrEmpty(rdr[4].ToString()) ? "" : String.Format("{0:yyyy-MM-dd}", Convert.ToDateTime(rdr[4].ToString()));
                        document.type = rdr[5].ToString();
                        document.series = rdr[6].ToString();
                        document.number = rdr[7].ToString();
                        document.date = String.IsNullOrEmpty(rdr[8].ToString()) ? "" : String.Format("{0:yyyy-MM-dd}", Convert.ToDateTime(rdr[8].ToString()));
                        document.issuedBy = rdr[9].ToString();
                        customer.document = document;
                        customers.Add(customer);
                    }
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message);
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
            return Request.CreateResponse(HttpStatusCode.OK, customers);
        }
    }
}
