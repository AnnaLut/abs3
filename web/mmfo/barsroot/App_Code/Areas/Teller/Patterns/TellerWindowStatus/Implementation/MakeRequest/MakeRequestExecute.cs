using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// выполнение запроса MakeRequest (внесение наличных)
    /// </summary>
    public class MakeRequestExecute: AbstractExecute<ATMModel, TellerWindowStatusModel>
    {
        public MakeRequestExecute()
        {
            sql = "bars.teller_tools.make_request";
            model = new TellerWindowStatusModel();
        }

        public MakeRequestExecute(String sql)
        {
            this.sql = sql;
            model = new TellerWindowStatusModel();
        }
     
        public override TellerWindowStatusModel Implement(AbstractOracleParameters<ATMModel> abstractParameters, OracleCommand command)
        {
            ImplementDefault(abstractParameters, command);
            model.Message = message;
            if (intResult == 0)
                model.Status = "ERR";
            return model;
        }
    }
}