using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// абстрактная фабрика получения классов для проведения запроса
    /// </summary>
    public abstract class AbstractFactory<T1, T2> where T1: class where T2: class
    {
        public abstract AbstractExecute<T1, T2> CreateAbstractExecute();
        public abstract AbstractOracleParameters<T1> CreateAbstractOracleParameters();
    }

}