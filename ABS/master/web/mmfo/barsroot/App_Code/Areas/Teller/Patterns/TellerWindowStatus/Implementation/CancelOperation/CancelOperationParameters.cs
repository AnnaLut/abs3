using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение параметров для CancelOperation
    /// </summary>
    public class CancelOperationParameters: AbstractOracleParameters<ATMModel>
    {
        public CancelOperationParameters()
        {
            List = new List<OracleParameter>();
        }

        public override List<OracleParameter> GetParameters()
        {
            List.AddRange(ResultDocrefErrtxt(Model.Ref));            
            return List;
        }
    }
}