using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// клиент для обработки запросов
    /// </summary>
    public class TellerClient<T1, T2> where T1: class where T2: class
    {
        private AbstractOracleParameters<T1> abstractOracleParameters;
        private AbstractExecute<T1, T2> abstractExecute;

        public TellerClient(AbstractFactory<T1, T2> factory)
        {
            abstractExecute = factory.CreateAbstractExecute();
            abstractOracleParameters = factory.CreateAbstractOracleParameters();
        }

        public T2 Run(T1 model, OracleCommand command)
        {
            abstractOracleParameters.Model = model;
            return abstractExecute.Implement(abstractOracleParameters, command);
        }
    }
}