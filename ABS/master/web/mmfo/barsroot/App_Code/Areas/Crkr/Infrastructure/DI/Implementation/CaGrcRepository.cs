using System;
using System.Data;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Infrastructure.Helper;
using BarsWeb.Areas.Crkr.ServiceModels.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation
{
    /// <summary>
    /// Процедуры миграции данных, вызывать на базе (ЦA-ГРЦ)
    /// </summary>
    public class CaGrcRepository : InteractionWithProc, ICaGrcRepository
    {
        
        public decimal CaMakeWiringData<T>(T requestData)
        {
            var model = requestData as CreateWiring;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.make_tran_tvbv"))
            {
                command.Parameters.Add("p_summa", OracleDbType.Varchar2, model.summa, ParameterDirection.Input);
                command.Parameters.Add("p_nls", OracleDbType.Varchar2, model.nls, ParameterDirection.Input);
                command.Parameters.Add("p_ob22", OracleDbType.Varchar2, model.ob22, ParameterDirection.Input);
                command.Parameters.Add("p_kv", OracleDbType.Varchar2, model.kv, ParameterDirection.Input);
                command.Parameters.Add("p_branch", OracleDbType.Varchar2, model.branch, ParameterDirection.Input);
                command.Parameters.Add("p_tvbv", OracleDbType.Varchar2, model.tvbv, ParameterDirection.Input);
                command.Parameters.Add("p_date_import", OracleDbType.Varchar2, model.date_import, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }
        
        public decimal CaDropWiringData<T>(T requestData)
        {
            var model = requestData as DeleteWiring;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.drop_tran_tvbv"))
            {
                command.Parameters.Add("p_tvbv", OracleDbType.Varchar2, model.tvbv, ParameterDirection.Input);
                command.Parameters.Add("p_kf", OracleDbType.Varchar2, model.kf, ParameterDirection.Input);
                command.Parameters.Add("p_date_import", OracleDbType.Varchar2, model.date_import, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }
        
        public decimal CaRebranDepositData<T>(T requestData)
        {
            var model = requestData as RebranDeposit;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.rebran_deposit"))
            {
                command.Parameters.Add("p_summa", OracleDbType.Varchar2, model.summa, ParameterDirection.Input);
                command.Parameters.Add("p_ob22", OracleDbType.Varchar2, model.ob22, ParameterDirection.Input);
                command.Parameters.Add("p_branchfrom", OracleDbType.Varchar2, model.branchfrom, ParameterDirection.Input);
                command.Parameters.Add("p_branchto", OracleDbType.Varchar2, model.branchto, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }

        public string PaymentsCompenData<T>(T requestData)
        {
            var model = requestData as XmlParam;
            using (var connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.payments_compen_xml"))
            {
                command.Parameters.Add("p_clob", OracleDbType.Clob, model.p_clob, ParameterDirection.InputOutput);
                command.ExecuteNonQuery();
                using (OracleClob clob = command.Parameters["p_clob"].Value as OracleClob)
                {
                    return null != clob && !clob.IsNull ? clob.Value.Replace("\n", string.Empty) : string.Empty;
                }
            }
        }

        public decimal PaymentsActualData<T>(T requestData)
        {
            var model = requestData as PayActual;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.payment_for_actual"))
            {
                command.Parameters.Add("p_branch_from", OracleDbType.Varchar2, model.branch_from, ParameterDirection.Input);
                command.Parameters.Add("p_branch_to", OracleDbType.Varchar2, model.branch_to, ParameterDirection.Input);
                command.Parameters.Add("p_type", OracleDbType.Varchar2, model.type, ParameterDirection.Input);
                command.Parameters.Add("p_s", OracleDbType.Decimal, model.summa, ParameterDirection.Input);
                command.Parameters.Add("p_ref", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                var refDoc = ((OracleDecimal)command.Parameters["p_ref"].Value).IsNull ? 0 : ((OracleDecimal)command.Parameters["p_ref"].Value).Value;
                if (refDoc != 0)
                    return refDoc;
                throw new Exception("Сервіс не повернув референс!");
            }
        }

        public decimal PaymentsDeActualData<T>(T requestData)
        {
            var model = requestData as PayActual;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.payment_for_deactual"))
            {
                command.Parameters.Add("p_branch_from", OracleDbType.Varchar2, model.branch_from, ParameterDirection.Input);
                command.Parameters.Add("p_branch_to", OracleDbType.Varchar2, model.branch_to, ParameterDirection.Input);
                command.Parameters.Add("p_s", OracleDbType.Decimal, model.summa, ParameterDirection.Input);
                command.Parameters.Add("p_ref", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                var refDoc = ((OracleDecimal)command.Parameters["p_ref"].Value).IsNull ? 0 : ((OracleDecimal)command.Parameters["p_ref"].Value).Value;
                if (refDoc != 0)
                    return refDoc;
                throw new Exception("Сервіс не повернув референс!");
            }
        }

        public string BackRefData<T>(T requestData)
        {
            var model = requestData as XmlParam;
            using (var connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.back_ref"))
            {
                command.Parameters.Add("p_ref", OracleDbType.Clob, model.p_clob, ParameterDirection.Input);
                command.Parameters.Add("p_out", OracleDbType.Clob, null, ParameterDirection.Output);
                command.ExecuteNonQuery();
                using (OracleClob clob = command.Parameters["p_out"].Value as OracleClob)
                {
                    return null != clob && !clob.IsNull ? clob.Value.Replace("\n", string.Empty) : string.Empty;
                }
            }
        }
        public string GetSosRefData<T>(T requestData)
        {
            var model = requestData as XmlParam;
            using (var connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "ca_compen.get_sos_ref"))
            {
                command.Parameters.Add("p_clob", OracleDbType.Clob, model.p_clob, ParameterDirection.InputOutput);
                command.ExecuteNonQuery();
                using (OracleClob clob = command.Parameters["p_clob"].Value as OracleClob)
                {
                    return null != clob && !clob.IsNull ? clob.Value.Replace("\n", string.Empty) : string.Empty;
                }
            }
        }
    }
}