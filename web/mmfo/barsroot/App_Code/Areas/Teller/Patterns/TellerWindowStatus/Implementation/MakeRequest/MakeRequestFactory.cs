using BarsWeb.Areas.Teller.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение моделей для MakeRequest (команда внесения наличных)
    /// </summary>
    public class MakeRequestFactory : AbstractFactory<ATMModel, TellerWindowStatusModel>
    {
        public override AbstractExecute<ATMModel, TellerWindowStatusModel> CreateAbstractExecute()
        {
            return new MakeRequestExecute();
        }

        public override AbstractOracleParameters<ATMModel> CreateAbstractOracleParameters()
        {
            return new MakeRequestParameters<ATMModel>();
        }
    }
}