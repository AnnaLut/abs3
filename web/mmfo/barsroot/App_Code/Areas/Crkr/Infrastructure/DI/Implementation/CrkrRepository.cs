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
    /// Процедуры миграции данных, вызывать на базе (ЦРКР)
    /// </summary>
    public class CrkrRepository : InteractionWithProc, ICrkrRepository
    {
        public decimal TransportData<T>(OracleConnection connection, T requestData)
        {
            var model = requestData as CrkrModel;
            using (var command = MakeCommand(connection, "crkr_compen.create_recport"))
            {
                command.Parameters.Add("P_CLOB", OracleDbType.Clob, model.record, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }


        public decimal UpdateCompenData<T>(T requestData)
        {
            var model = requestData as CrkrModel;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "crkr_compen.update_info_from_file_j"))
            {
                command.Parameters.Add("p_record", OracleDbType.Clob, model.record, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }

        public decimal MakeWiringData<T>(T requestData)
        {
            var model = requestData as CreateWiring;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "crkr_compen.make_wiring"))
            {
                command.Parameters.Add("p_tvbv", OracleDbType.Varchar2, model.tvbv, ParameterDirection.Input);
                command.Parameters.Add("p_summa", OracleDbType.Varchar2, model.summa, ParameterDirection.Input);
                command.Parameters.Add("p_nls", OracleDbType.Varchar2, model.nls, ParameterDirection.Input);
                command.Parameters.Add("p_ob22", OracleDbType.Varchar2, model.ob22, ParameterDirection.Input);
                command.Parameters.Add("p_kv", OracleDbType.Varchar2, model.kv, ParameterDirection.Input);
                command.Parameters.Add("p_branch", OracleDbType.Varchar2, model.branch, ParameterDirection.Input);
                command.Parameters.Add("p_date_import", OracleDbType.Clob, model.date_import, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }

        public decimal DropCompenData<T>(T requestData)
        {
            var model = requestData as DeleteCompen;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, @"crkr_compen.drop_port_tvbv"))
            {
                command.Parameters.Add("p_tvbv", OracleDbType.Varchar2, model.tvbv, ParameterDirection.Input);
                command.Parameters.Add("p_kf", OracleDbType.Varchar2, model.kf, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }

        public decimal FixCompenData<T>(T requestData)
        {
            var model = requestData as DeleteCompen;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, @"crkr_compen.fix_port_tvbv"))
            {
                command.Parameters.Add("p_tvbv", OracleDbType.Varchar2, model.tvbv, ParameterDirection.Input);
                command.Parameters.Add("p_kf", OracleDbType.Varchar2, model.kf, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }

        public decimal DropWiringData<T>(T requestData)
        {
            var model = requestData as DeleteWiring;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "crkr_compen.drop_wiring"))
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

        public decimal CountCompenData<T>(T requestData)
        {
            var model = requestData as CountCompen;
            using (var connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "crkr_compen.count_compen"))
            {
                command.Parameters.Add("p_mode", OracleDbType.Varchar2, model.mode, ParameterDirection.Input);
                command.Parameters.Add("p_tvbv", OracleDbType.Varchar2, model.tvbv, ParameterDirection.Input);
                command.Parameters.Add("p_mfo", OracleDbType.Varchar2, model.mfo, ParameterDirection.Input);
                command.Parameters.Add("p_err", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_ret", OracleDbType.Decimal, ParameterDirection.Output);
                command.ExecuteNonQuery();
                return ReturnValues(command);
            }
        }

        public string VerifyCompenData<T>(T requestData)
        {
            var model = requestData as VerifyCompen;
            using (var connection = OraConnector.Handler.UserConnection)
            using (var command = MakeCommand(connection, "crkr_compen.get_info_vkl"))
            {
                command.Parameters.Add("p_mode", OracleDbType.Varchar2, model.mode, ParameterDirection.Input);
                command.Parameters.Add("p_tvbv", OracleDbType.Varchar2, model.tvbv, ParameterDirection.Input);
                command.Parameters.Add("p_brmf", OracleDbType.Varchar2, model.brmf, ParameterDirection.Input);
                command.Parameters.Add("p_ret", OracleDbType.Clob, null, ParameterDirection.Output);
                command.ExecuteNonQuery();
                using (OracleClob clob = command.Parameters["p_ret"].Value as OracleClob)
                {
                    return null != clob && !clob.IsNull ? clob.Value.Replace("\n", string.Empty) : string.Empty;
                }
            }
        }
    }
}