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
    /// получение параметров для MakeRequest
    /// </summary>
    public class MakeRequestParameters<T>: AbstractOracleParameters<ATMModel>
    {
        public MakeRequestParameters()
        {
            List = new List<OracleParameter>();
        }

        public override List<OracleParameter> GetParameters()
        {
            List.AddRange(ResultErrtxt());
            List.Add(new OracleParameter("p_oper_ref",  OracleDbType.Decimal,   Model.Ref,  ParameterDirection.Input));
            return List;
        }
    }
}