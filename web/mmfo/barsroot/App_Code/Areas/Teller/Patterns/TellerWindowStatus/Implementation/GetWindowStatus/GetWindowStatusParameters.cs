using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение параметров для GrtWindowStatus
    /// </summary>
    public class GetWindowStatusParameters<T>: AbstractOracleParameters<ATMModel>
    {
        public GetWindowStatusParameters()
        {
            List = new List<OracleParameter>();
        }
        public override List<OracleParameter> GetParameters()
        {
            if (String.IsNullOrEmpty(Model.isSWI))
                Model.isSWI = "0";
            Decimal Ref = Convert.ToDecimal(Model.Ref);
            List.AddRange(ResultDocref(Ref));
            List.Add(new OracleParameter("p_warning",    OracleDbType.Decimal,   Convert.ToDecimal(Model.isSWI),                 ParameterDirection.Input));
            List.Add(new OracleParameter("p_amount",     OracleDbType.Decimal,                                                   ParameterDirection.Output));
            List.Add(new OracleParameter("p_atm",        OracleDbType.Varchar2,  4000, null,                                     ParameterDirection.Output));
            List.Add(new OracleParameter("p_currency",   OracleDbType.Varchar2,  4000, null,                                     ParameterDirection.Output));
            List.Add(new OracleParameter("p_oper_desc",  OracleDbType.Varchar2,  4000, null,                                     ParameterDirection.Output));
            return List;
        }
    }
}