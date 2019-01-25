using BarsWeb.Areas.Teller.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение параметров для ConfirmRequest
    /// </summary>
    public class ConfirmRequestFactory: AbstractFactory<ATMModel, TellerWindowStatusModel>
    {
        public override AbstractExecute<ATMModel, TellerWindowStatusModel> CreateAbstractExecute()
        {
            return new ConfirmRequestExecute();
        }

        public override AbstractOracleParameters<ATMModel> CreateAbstractOracleParameters()
        {
            return new ConfirmRequestParameters();
        }
    }
}