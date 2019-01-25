using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// выполнение операций инкассирования
    /// </summary>
    public class EncashmentExecute: AbstractExecute<EncashmentModel, TellerResponseModel>
    {
        public EncashmentExecute()
        {
            sql = "bars.teller_tools.";
        }

        public override TellerResponseModel Implement(AbstractOracleParameters<EncashmentModel> abstractParameters, OracleCommand command)
        {
            if (abstractParameters.Model.Method == "collectatm")
                sql = "teller_soap_api.collectatm";
            else
                sql += abstractParameters.Model.Method;
            ImplementDefault(abstractParameters, command);
            return new TellerResponseModel { P_errtxt = message, Result = intResult };
        }
    }
}