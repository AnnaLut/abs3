using BarsWeb.Areas.Teller.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение моделей окончания операции
    /// </summary>
    public class EndRequestFactory: AbstractFactory<ATMModel, TellerWindowStatusModel>
    {

        public override AbstractExecute<ATMModel, TellerWindowStatusModel> CreateAbstractExecute()
        {
            return new MakeRequestExecute("bars.teller_tools.end_request");
        }

        public override AbstractOracleParameters<ATMModel> CreateAbstractOracleParameters()
        {
            return new EndRequestParameters();
        }
    }
}