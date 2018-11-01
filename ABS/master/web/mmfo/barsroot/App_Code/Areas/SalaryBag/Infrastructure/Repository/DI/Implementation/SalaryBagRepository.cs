using Areas.SalaryBag.Models;
using Bars.Classes;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SalaryBag.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using Dapper;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Globalization;
using System.Linq;

namespace BarsWeb.Areas.SalaryBag.Infrastructure.DI.Implementation
{
    public class SalaryBagRepository : ISalaryBagRepository
    {
        readonly SalaryBagModel _SalaryBag;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public SalaryBagRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _SalaryBag = new SalaryBagModel(EntitiesConnection.ConnectionString("SalaryBagModel", "SalaryBag"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        private CultureInfo _ci;
        public CultureInfo Ci
        {
            get
            {
                if (_ci == null)
                {
                    _ci = CultureInfo.CreateSpecificCulture("en-GB");
                    _ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                    _ci.DateTimeFormat.DateSeparator = ".";
                }
                return _ci;
            }
        }

        #region Salary Bag
        public void CreateDeal(DealModel model)
        {
            DateTime startDate = Convert.ToDateTime(model.StartDate, Ci);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_rnk", model.Rnk, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_deal_name", model.DealName, DbType.String, ParameterDirection.Input);
                p.Add("p_start_date", startDate, DbType.Date, ParameterDirection.Input);
                p.Add("p_deal_premium", model.Premium, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_central", model.Central, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_kod_tarif", model.KodTarif, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_acc", model.Account, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_fs", model.Fs, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.create_deal", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void UpdateDeal(DealModel model)
        {
            DateTime startDate = Convert.ToDateTime(model.StartDate, Ci);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", model.Id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_deal_name", model.DealName, DbType.String, ParameterDirection.Input);
                p.Add("p_start_date", startDate, DbType.Date, ParameterDirection.Input);
                p.Add("p_deal_premium", model.Premium, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_central", model.Central, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_kod_tarif", model.KodTarif, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_fs", model.Fs, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_acc_3570", model.acc3570, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.update_deal", p, commandType: CommandType.StoredProcedure);
            }

            //_SalaryBag.ExecuteStoreQuery()
        }

        public void ApproveDeal(decimal id, string comment)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_comm_reject", comment, DbType.String, ParameterDirection.Input);

                connection.Execute("zp.approve_deal", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AdditionalChangeDeal(decimal id, string comment)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_comm", comment, DbType.String, ParameterDirection.Input);

                connection.Execute("zp.additional_change_deal", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void DeleteDeal(decimal id)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.del_deal", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AuthorizeDeal(decimal id)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.authorize_deal", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void RejectDeal(decimal id, string comment)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_comm_reject", comment, DbType.String, ParameterDirection.Input);

                connection.Execute("zp.reject_deal", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void CloseDeal(decimal id, string comment)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_comm", comment, DbType.String, ParameterDirection.Input);

                connection.Execute("zp.close_deal", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void Pay3570(string acc)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_acc", acc, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.pay3570", p, commandType: CommandType.StoredProcedure);
            }
        }
        #endregion

        #region Accounts 2625
        public void MigrateAcc(decimal dealId)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", dealId, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.zp_acc_migr", p, commandType: CommandType.StoredProcedure);
            }
        }

        /// <summary>
        /// state : -1 - Delete, 0 - Lock, 1 - Unlock
        /// </summary>
        /// <param name="acc"></param>
        /// <param name="sos"></param>
        public void SetAccSos(decimal acc, int sos)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_acc", acc, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_sost", sos, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.set_acc_sos", p, commandType: CommandType.StoredProcedure);
            }
        }
        #endregion

        #region SalaryProcessing and SalaryNote
        public ZpDealInfo GetZpDealAndPayRollInfoByPId(string id)
        {
            BarsSql sql = SqlCreator.GetDealAndPayRollInfoByPId(id);
            return SearchGlobal<ZpDealInfo>(null, sql).ToList().FirstOrDefault();
        }

        public decimal? CalculateCommission(string tarifCode, string nls2909, decimal? sum)
        {
            BarsSql sql = SqlCreator.CalcComissionSql(tarifCode, nls2909, (decimal)sum);
            return SearchGlobal<decimal?>(null, sql).ToList().FirstOrDefault();
        }

        public void ApprovePayroll(string id, List<OracleSignArrayItem> results)
        {
            if (results == null)
                results = new List<OracleSignArrayItem>();

            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = new OracleCommand())
                {
                    using (OracleParameter param = new OracleParameter("p_sign_doc_set", OracleDbType.Array)
                    {
                        UdtTypeName = "BARS.T_SIGN_DOC_SET",
                        Value = results.ToArray()
                    })
                    {
                        cmd.Connection = connection;
                        cmd.CommandText = "zp.approve_payroll";
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add(param);
                        cmd.Parameters.Add("p_id", OracleDbType.Decimal).Value = id;

                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        public void DeletePayroll(string id)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.del_zp_payroll", p, commandType: CommandType.StoredProcedure);
            }
        }

        public long GetNewPayRollId(string zpId)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_zp_id", zpId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_id", zpId, DbType.Decimal, ParameterDirection.Output);

                connection.Execute("zp.create_payroll_draft", p, commandType: CommandType.StoredProcedure);

                var resultId = p.Get<decimal>("p_id");

                return (long)resultId;
            }
        }

        public void AddEditPayRollDocument(PayRollDocumentModel model)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id_pr", model.payrollId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_okpob", model.OkpoB, DbType.String, ParameterDirection.Input);
                p.Add("p_namb", model.NameB, DbType.String, ParameterDirection.Input);
                p.Add("p_mfob", model.MfoB, DbType.String, ParameterDirection.Input);
                p.Add("p_nlsb", model.NlsB, DbType.String, ParameterDirection.Input);
                p.Add("p_source", model.Source, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_nazn", model.PaymentPurpose, DbType.String, ParameterDirection.Input);
                p.Add("p_s", model.Summ, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_id", model.DocumentId, DbType.Decimal, ParameterDirection.Input);

                p.Add("p_passp_serial", model.PasspSeries, DbType.String, ParameterDirection.Input);
                p.Add("p_passp_num", model.PasspNumber, DbType.String, ParameterDirection.Input);
                p.Add("p_id_card_num", model.IdCardNumber, DbType.String, ParameterDirection.Input);

                connection.Execute("zp.add_payroll_doc", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void DeletePayrollDocument(string id)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.del_payroll_doc", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void DeletePayrollDocuments(List<string> ids)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                foreach (string id in ids)
                {
                    var p = new DynamicParameters();
                    p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);

                    connection.Execute("zp.del_payroll_doc", p, commandType: CommandType.StoredProcedure);
                }
            }
        }

        public string GetOwnMfo()
        {
            BarsSql sql = SqlCreator.OurMfoSql();
            return SearchGlobal<string>(null, sql).ToList().FirstOrDefault();
        }

        public bool CheckAcc(string mfo, string acc)
        {
            BarsSql sql = SqlCreator.ChechAccSql(mfo, acc);

            string result = "";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                //result = SearchGlobal<string>(null, sql).ToList().FirstOrDefault();
                var a = _SalaryBag.ExecuteStoreQuery<string>(sql.SqlText, sql.SqlParams).ToList();
                result = a.FirstOrDefault();
            }
            if (!string.IsNullOrWhiteSpace(result))
            {
                result = result.Trim();
                return acc == result;
            }
            return false;
        }

        public void CreatePayRoll(CreatePayRollModel model)
        {
            DateTime dt = Convert.ToDateTime(model.PrDate, Ci);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", model.Id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_pr_date", dt, DbType.Date, ParameterDirection.Input);
                p.Add("p_payroll_num", model.PayrollNum, DbType.String, ParameterDirection.Input);
                p.Add("p_nazn", model.Purpose, DbType.String, ParameterDirection.Input);

                connection.Execute("zp.create_payroll", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void ClonePayrollDocuments(string idFrom, string idTo)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_old_id", idFrom, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_new_id", idTo, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.payroll_doc_clone", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void RejectPayroll(string payrollId, string comment)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", payrollId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_comm", comment, DbType.String, ParameterDirection.Input);

                connection.Execute("zp.reject_payroll", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void PayPayroll(SignResultsPostModel data)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = new OracleCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandText = "zp.pay_payroll";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("p_id", OracleDbType.Decimal).Value = data.payrollId;
                    cmd.Parameters.Add("p_sign", OracleDbType.Clob).Value = data.records[0].Sign;
                    cmd.Parameters.Add("p_key_id", OracleDbType.Varchar2).Value = data.records[0].SubjectSN;
                    cmd.Parameters.Add("p_docbufer", OracleDbType.Varchar2).Value = data.records[0].buffer;

                    cmd.ExecuteNonQuery();
                }
            }
        }

        public ClientModel SearchExistingClient(string nls)
        {
            ClientModel client = new ClientModel();

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            using (OracleParameter pOkpo = new OracleParameter("p_okpo", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                                    pNmk = new OracleParameter("p_nmk", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                            pPasspSerial = new OracleParameter("p_pass_serial", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                               pPasspNum = new OracleParameter("p_pass_num", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                              pPasspCard = new OracleParameter("p_pass_card", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                             pActualDate = new OracleParameter("p_actual_date", OracleDbType.Date, null, ParameterDirection.Output))
            {
                cmd.CommandText = "zp.get_doc_person";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.Parameters.Add(new OracleParameter("p_nls", OracleDbType.Varchar2, nls, ParameterDirection.Input));
                cmd.Parameters.AddRange(new OracleParameter[] { pOkpo, pNmk, pPasspSerial, pPasspNum, pPasspCard, pActualDate });
                cmd.ExecuteNonQuery();

                client.okpo = GetStrFromOraParam(pOkpo);
                if (string.IsNullOrWhiteSpace(client.okpo)) return client;

                client.nmk = GetStrFromOraParam(pNmk);
                client.nls = nls;
                client.PassportIdCardNum = GetStrFromOraParam(pPasspCard);
                client.PassportNumber = GetStrFromOraParam(pPasspNum);
                client.PassportSerial = GetStrFromOraParam(pPasspSerial);

                OracleDate actualDate = (OracleDate)pActualDate.Value;
                client.ActualDate = actualDate.IsNull ? (DateTime?)null : actualDate.Value;
            }
            return client;
        }
        private string GetStrFromOraParam(OracleParameter par)
        {
            OracleString oraStr = (OracleString)par.Value;
            if (oraStr.IsNull) return string.Empty;

            return oraStr.Value;
        }
        #endregion

        #region Import
        public string ImportPayrollItemsFile(PostFileModel postFileModel)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = new OracleCommand())
                {
                    using (OracleParameter param = new OracleParameter("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output))
                    {
                        cmd.Connection = connection;
                        cmd.CommandText = "zp.payroll_imp";
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("p_id_pr", OracleDbType.Decimal).Value = postFileModel.p_id_pr;
                        cmd.Parameters.Add("p_file_name", OracleDbType.Varchar2).Value = postFileModel.p_file_name;
                        cmd.Parameters.Add("p_clob", OracleDbType.Blob).Value = postFileModel.p_clob;
                        cmd.Parameters.Add("p_encoding", OracleDbType.Varchar2).Value = postFileModel.p_encoding;
                        cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2).Value = postFileModel.p_nazn;
                        cmd.Parameters.Add("p_id_dbf_type", OracleDbType.Decimal).Value = postFileModel.p_id_dbf_type;
                        cmd.Parameters.Add("p_file_type", OracleDbType.Varchar2).Value = postFileModel.p_file_type;
                        cmd.Parameters.Add("p_nlsb_map", OracleDbType.Varchar2).Value = postFileModel.p_nlsb_map;
                        cmd.Parameters.Add("p_s_map", OracleDbType.Varchar2).Value = postFileModel.p_s_map;
                        cmd.Parameters.Add("p_okpob_map", OracleDbType.Varchar2).Value = postFileModel.p_okpob_map;
                        cmd.Parameters.Add("p_mfob_map", OracleDbType.Varchar2).Value = postFileModel.p_mfob_map;
                        cmd.Parameters.Add("p_namb_map", OracleDbType.Varchar2).Value = postFileModel.p_namb_map;
                        cmd.Parameters.Add("p_nazn_map", OracleDbType.Varchar2).Value = postFileModel.p_nazn_map;
                        cmd.Parameters.Add("p_save_draft", OracleDbType.Varchar2).Value = postFileModel.p_save_draft;
                        cmd.Parameters.Add("p_sum_delimiter", OracleDbType.Decimal).Value = postFileModel.p_sum_delimiter;
                        cmd.Parameters.Add(param);

                        cmd.ExecuteNonQuery();

                        OracleString errResult = (OracleString)param.Value;
                        if (errResult.IsNull) return "";
                        return errResult.Value;
                    }
                }
            }
        }

        public void DeleteImportedFile(string fileId)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", fileId, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("zp.payroll_imp_del", p, commandType: CommandType.StoredProcedure);
            }
        }
        //DBF preload procedure
        public object PreloadDbf(PostFileModel postFileModel) //fileType = dbf
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = new OracleCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandText = "zp.prev_dbf_load";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("p_blob", OracleDbType.Blob).Value = postFileModel.p_clob;
                    cmd.Parameters.Add("p_encoding", OracleDbType.Varchar2).Value = postFileModel.p_encoding;

                    cmd.ExecuteNonQuery();

                    return connection.Query(SqlCreator.GetDbfData().SqlText);
                }
            }
        }
        #endregion

        #region EA
        public List<Bars.EAD.Structs.Result.DocumentData> CheckDocs(List<Bars.EAD.Structs.Result.DocumentData> val, List<string> filterCodes)
        {
            List<Bars.EAD.Structs.Result.DocumentData> res = new List<Bars.EAD.Structs.Result.DocumentData>();
            if (val.Count <= 0) return res;
            for (int i = 0; i < val.Count; i++)
            {
                if (!string.IsNullOrWhiteSpace(val[i].DocLink) && !string.IsNullOrWhiteSpace(val[i].Struct_Name))
                {
                    if (null == filterCodes || filterCodes.Contains(val[i].Struct_Code))
                        res.Add(val[i]);
                }
            }
            return res;
        }
        #endregion

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _SalaryBag.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _SalaryBag.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _SalaryBag.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _SalaryBag.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
}
