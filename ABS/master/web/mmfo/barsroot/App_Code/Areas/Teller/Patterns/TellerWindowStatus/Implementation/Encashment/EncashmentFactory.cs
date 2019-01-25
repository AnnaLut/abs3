using BarsWeb.Areas.Teller.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение моделей инкассации
    /// </summary>
    public class EncashmentFactory: AbstractFactory<EncashmentModel, TellerResponseModel>
    {
        public override AbstractExecute<EncashmentModel, TellerResponseModel> CreateAbstractExecute()
        {
            return new EncashmentExecute();
        }

        public override AbstractOracleParameters<EncashmentModel> CreateAbstractOracleParameters()
        {
            return new EncashmentParameters();
        }
    }
}