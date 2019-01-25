using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// выполнение запросов:
    /// TechnicalButtonSubmit,
    /// CancelCashin,
    /// CheckVisaDocs,
    /// CheckStornoDocs
    /// </summary>
    public class DocsAndTechnicalExecute : AbstractExecute<TellerRequestModel, TellerResponseModel>
    {
        public override TellerResponseModel Implement(AbstractOracleParameters<TellerRequestModel> abstractParameters, OracleCommand command)
        {
            sql = InitializeSql(abstractParameters.Model.Method.ToLower(), abstractParameters.Model.Sql);
            ImplementDefault(abstractParameters, command);
            return new TellerResponseModel { P_errtxt = message, Result = intResult };
        }

        private String InitializeSql(String method, String sql)
        {
            if (method == "checkvisadocs")
                return "bars.teller_tools.check_doclist";
            else if (method == "checkstornodocs")
                return "bars.teller_tools.storno_doclist";
            
            return sql;
        }
    }
}