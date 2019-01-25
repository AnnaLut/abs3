using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// абстрактное выполнение запроса и возврат модели TellerWindowStatusModel
    /// </summary>
    public abstract class AbstractExecute<T1, T2> where T1: class
    {
        protected String sql;
        protected T2 model;
        protected Int32 intResult;
        protected String message;
        protected List<OracleParameter> list;

        public abstract T2 Implement(AbstractOracleParameters<T1> abstractParameters, OracleCommand command);

        protected Decimal GetValueFromOracleDecimal(OracleParameter parameter)
        {
            OracleDecimal decimalValue = (OracleDecimal)parameter.Value;
            return decimalValue.IsNull ? 0 : decimalValue.Value;
        }

        protected String GetValueFromOracleString(OracleParameter parameter)
        {
            OracleString stringValue = (OracleString)parameter.Value;
            return stringValue.IsNull ? "" : stringValue.Value;
        }

        protected Int32 GetIntValueFromOracleDecimal(OracleParameter parameter)
        {
            OracleDecimal oracleDecimal = (OracleDecimal)parameter.Value;
            return oracleDecimal.IsNull ? 0 : Convert.ToInt32(oracleDecimal.Value);
        }

        protected void Execute(AbstractOracleParameters<T1> abstractParameters, OracleCommand command)
        {
            command.CommandText = sql;
            list = abstractParameters.GetParameters();
            command.Parameters.AddRange(list.ToArray());

            using (OracleDataReader reader = command.ExecuteReader())
            { }
        }

        protected void ImplementDefault(AbstractOracleParameters<T1> abstractParameters, OracleCommand command)
        {
            Execute(abstractParameters, command);
            intResult = GetIntValueFromOracleDecimal(list.FirstOrDefault(x => x.ParameterName == "result"));
            message = GetValueFromOracleString(list.FirstOrDefault(x => x.ParameterName == "p_errtxt"));
        }
    }
}