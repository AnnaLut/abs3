using BarsWeb.Areas.Teller.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// получение моделей инкассации, обработки запросов технических кнопок
    /// </summary>
    public class DocsAndTechnicalFactory : AbstractFactory<TellerRequestModel, TellerResponseModel>
    {
        public override AbstractExecute<TellerRequestModel, TellerResponseModel> CreateAbstractExecute()
        {
            return new DocsAndTechnicalExecute();
        }

        public override AbstractOracleParameters<TellerRequestModel> CreateAbstractOracleParameters()
        {
            return new DocsAndTechnicalParameters();
        }
    }
}