using Bars.Classes;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using Dapper;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Implementation
{
    public class RegisterRepository : IRegisterRepository
    {
        private DateTime ConvertToDateTime(string str)
        {
            DateTime date;
            if (!DateTime.TryParseExact(str, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out date))
                throw new Exception("Невірний формат дати!");
            return date;
        }
        public IEnumerable<PayRegister> GetPeyments(Registry item)
        {            
            var query = "";
            object param = null;

            if (item.type == "dep")
            {
                query = "select * from V_COMPEN_PAYMENTS_REG_DEP v";
            }
            else if (item.type == "bur")
            {
                query = "select * from V_COMPEN_PAYMENTS_REG_BUR v";
            }

            if (!string.IsNullOrEmpty(item.startDate) && !string.IsNullOrEmpty(item.endDate))
            {
                query = query.Insert(query.Length, " where v.DATE_VAl_REG >= to_date(:startDate, 'dd.mm.yyyy') and v.DATE_VAl_REG <= to_date(:endDate, 'dd.mm.yyyy')");
                param = new { item.startDate, item.endDate };
            }
            if (item.check)
            {
                query = query.Insert(query.Length, " and state_id in (0, 2)");
            }
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<PayRegister>(query, param).ToList();
            }
        }

        public ResultPay CreateRegister(Registry item)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                if (item.type == "dep")
                {
                    p.Add("p_opercode ", "PAY_DEP", DbType.String, ParameterDirection.Input);
                }
                else if (item.type == "bur")
                {
                    p.Add("p_opercode ", "PAY_BUR", DbType.String, ParameterDirection.Input);
                }
                p.Add("p_data_from", ConvertToDateTime(item.startDate), DbType.DateTime, ParameterDirection.Input);
                p.Add("p_date_to", ConvertToDateTime(item.endDate), DbType.DateTime, ParameterDirection.Input);
                connection.Execute("crkr_compen_web.CREATE_PAYMENTS_REGISTRY", p, commandType: CommandType.StoredProcedure);
            }
            return new ResultPay(GetPeyments(item), -1, -1);
        }

        public ResultPay SendRegister(Registry item)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                string procName;
                var p = new DynamicParameters();
                if (item.type == "dep")
                {
                    p.Add("p_regcode ", "PAY_DEP", DbType.String, ParameterDirection.Input);
                }
                else if (item.type == "bur")
                {
                    p.Add("p_regcode ", "PAY_BUR", DbType.String, ParameterDirection.Input);
                }
                p.Add("p_data_from", ConvertToDateTime(item.startDate), DbType.DateTime, ParameterDirection.Input);
                p.Add("p_date_to", ConvertToDateTime(item.endDate), DbType.DateTime, ParameterDirection.Input);
                p.Add("p_sum", null, DbType.Decimal, ParameterDirection.Output);
                p.Add("p_cnt", null, DbType.Decimal, ParameterDirection.Output);

                if (item.preRequest)
                {
                    procName = "CRKR_COMPEN_WEB.GET_PAYMENTS_COMPEN_XML";
                }
                else
                {
                    procName = "CRKR_COMPEN_WEB.SEND_PAYMENTS_COMPEN_XML";
                }
                connection.Execute(procName, p, commandType: CommandType.StoredProcedure);

                var sum = p.Get<decimal?>("p_sum");
                var cnt = p.Get<decimal?>("p_cnt");

                IEnumerable<PayRegister> dataSource = null;
                if (!item.preRequest)
                {
                    dataSource = GetPeyments(item);

                }
                return new ResultPay(dataSource, sum, cnt);
            }
        }

        public ResultPay BlockOrUnBlock(Registry item)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                string procName = "";
                if (item.block == true)
                    procName = "crkr_compen_web.set_registry_status_block";
                else
                    procName = "crkr_compen_web.set_registry_status_no_block";

                var command = new OracleCommand(procName, connection);
                command.CommandType = CommandType.StoredProcedure;

                var approveListParam = new OracleParameter("p_reg_list", OracleDbType.Array, item.id.Length, item.id, ParameterDirection.Input);
                approveListParam.UdtTypeName = "NUMBER_LIST";
                command.Parameters.Add(approveListParam);
                command.Parameters.Add("p_info", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.ExecuteNonQuery();

                var info = ((OracleString)command.Parameters["p_info"].Value).IsNull ? string.Empty : ((OracleString)command.Parameters["p_info"].Value).Value;
                return new ResultPay(GetPeyments(item), info);                
            }
        }
    }
}
