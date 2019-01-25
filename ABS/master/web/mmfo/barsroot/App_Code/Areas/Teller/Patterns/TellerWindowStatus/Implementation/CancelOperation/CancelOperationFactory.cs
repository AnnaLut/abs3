using BarsWeb.Areas.Teller.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение моделей отмены операции
    /// </summary>
    public class CancelOperationFactory: AbstractFactory<ATMModel, TellerWindowStatusModel>
    {
        public override AbstractExecute<ATMModel, TellerWindowStatusModel> CreateAbstractExecute()
        {
            return new CancelOperationExecute();
        }

        public override AbstractOracleParameters<ATMModel> CreateAbstractOracleParameters()
        {
            return new CancelOperationParameters();
        }
    }
}