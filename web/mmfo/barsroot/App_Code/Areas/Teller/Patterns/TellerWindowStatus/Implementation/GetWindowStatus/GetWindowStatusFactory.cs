using BarsWeb.Areas.Teller.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// Получение моделей статуса окна
    /// </summary>
    public class GetWindowStatusFactory: AbstractFactory<ATMModel, TellerWindowStatusModel>
    {
        public override AbstractExecute<ATMModel, TellerWindowStatusModel> CreateAbstractExecute()
        {
            return new GetWindowStatusExecute();
        }

        public override AbstractOracleParameters<ATMModel> CreateAbstractOracleParameters()
        {
            return new GetWindowStatusParameters<ATMModel>();
        }
    }
}