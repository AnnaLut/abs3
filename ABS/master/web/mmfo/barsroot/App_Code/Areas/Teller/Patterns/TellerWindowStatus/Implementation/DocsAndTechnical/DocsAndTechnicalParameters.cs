using Bars.Oracle;
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
    /// получение параметров для проверки документов, обработки запросов технических кнопок
    /// </summary>
    public class DocsAndTechnicalParameters : AbstractOracleParameters<TellerRequestModel>
    {
        public DocsAndTechnicalParameters()
        {
            List = new List<OracleParameter>();
        }

        /// <summary>
        /// получение параметров p_errtxt (Output) и result (ReturnValue)
        /// </summary>
        /// <returns></returns>
        public override List<OracleParameter> GetParameters()
        {
            if (Model.Method.ToLower() == "technicalbuttonsubmit")
                List.AddRange(ResultErrtxt());
            else
                List.AddRange(GetParametersWithRef(Model.Ref));
            return List;
        }
    }
}