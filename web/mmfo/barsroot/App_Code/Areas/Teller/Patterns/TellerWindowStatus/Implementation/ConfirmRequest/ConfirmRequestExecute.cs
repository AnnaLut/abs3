using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// выполнение запроса ConfirmRequest
    /// </summary>
    public class ConfirmRequestExecute: AbstractExecute<ATMModel, TellerWindowStatusModel>
    {
        public ConfirmRequestExecute()
        {
            sql = "bars.teller_tools.confirm_request";
        }

        public override TellerWindowStatusModel Implement(AbstractOracleParameters<ATMModel> abstractParameters, OracleCommand command)
        {
            ImplementDefault(abstractParameters, command);
            return new TellerWindowStatusModel
            {
                Status = intResult == 1? "Done": "ERR",
                Amount = GetValueFromOracleDecimal(list.FirstOrDefault(x => x.ParameterName == "p_atm_amount")),
                Message = message
            };            
        }
    }
}