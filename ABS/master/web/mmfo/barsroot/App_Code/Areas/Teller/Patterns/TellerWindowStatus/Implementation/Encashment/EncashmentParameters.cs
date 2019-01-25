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
    /// получение параметров для инкассации
    /// </summary>
    public class EncashmentParameters: AbstractOracleParameters<EncashmentModel>
    {
        public EncashmentParameters()
        {
            List = new List<OracleParameter>();
        }

        public override List<OracleParameter> GetParameters()
        {
            List.AddRange(ResultErrtxt());
            String method = Model.Method.ToLower();
            if (method == "endcashin" || method == "endcashout")
            {
                if (Model.EncashmentType != "OUTPUT")
                {
                    List.Add(new OracleParameter("p_non_atm_amount", OracleDbType.Decimal, Model.NonAmount, ParameterDirection.Input));
                    List.Add(new OracleParameter("p_curcode", OracleDbType.Varchar2, Model.Currency, ParameterDirection.Input));
                }
            }
            else if (method == "start_cashin")
                List.Add(new OracleParameter("p_cur_code",          OracleDbType.Varchar2,  Model.Currency,     ParameterDirection.Input));                
            return List;
        }
    }
}