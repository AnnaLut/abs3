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
    /// получение параметров для ConfirmRequest
    /// </summary>
    public class ConfirmRequestParameters: AbstractOracleParameters<ATMModel>
    {
        public ConfirmRequestParameters()
        {
            List = new List<OracleParameter>();
        }

        public override List<OracleParameter> GetParameters()
        {
            List.AddRange(ResultDocrefErrtxt(Model.Ref));
            List.Add(new OracleParameter("p_atm_amount", OracleDbType.Decimal, ParameterDirection.Output));
            return List;
        }
    }
}