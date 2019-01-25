using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение параметров для EndRequest
    /// </summary>
    public class EndRequestParameters: AbstractOracleParameters<ATMModel>
    {
        public EndRequestParameters()
        {
            List = new List<OracleParameter>();
        }

        public override List<OracleParameter> GetParameters()
        {
            List.AddRange(ResultDocrefErrtxt(Model.Ref));
            List.Add(new OracleParameter("p_atm_amount",        OracleDbType.Decimal,   Model.Amount,       ParameterDirection.Input));
            List.Add(new OracleParameter("p_non_atm_amount",    OracleDbType.Decimal,   Model.NonAmount,    ParameterDirection.Input));
            return List;
        }
    }
}