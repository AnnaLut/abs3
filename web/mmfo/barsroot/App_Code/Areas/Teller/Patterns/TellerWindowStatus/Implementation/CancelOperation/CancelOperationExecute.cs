using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// выполнение запроса Cancel Operation
    /// </summary>
    public class CancelOperationExecute: AbstractExecute<ATMModel, TellerWindowStatusModel>
    {
        public CancelOperationExecute()
        {
            sql = "bars.teller_tools.cancel_operation";
            model = new TellerWindowStatusModel();
        }

        public override TellerWindowStatusModel Implement(AbstractOracleParameters<ATMModel> abstractParameters, OracleCommand command)
        {
            ImplementDefault(abstractParameters, command);
            model.Message = message;
            model.Status = intResult == 1 ? "Done" : "ERR";
            return model;
        }
    }
}