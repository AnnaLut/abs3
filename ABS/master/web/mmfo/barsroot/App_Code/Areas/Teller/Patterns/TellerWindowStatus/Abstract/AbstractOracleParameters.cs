using Bars.Oracle;
using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// абстрактное получение параметров для запроса
    /// </summary>
    public abstract class AbstractOracleParameters<T> where T: class
    {
        protected List<OracleParameter> List;
        public T Model { get; set; }

        public abstract List<OracleParameter> GetParameters();

        protected OracleParameter[] ResultDocref(Decimal Ref)
        {
            return new OracleParameter[2] {
                new OracleParameter("result",       OracleDbType.Varchar2,  4000, null,     ParameterDirection.ReturnValue),
                new OracleParameter("p_doc_ref",    OracleDbType.Decimal,   Ref,            ParameterDirection.InputOutput)
            };
        }

        protected OracleParameter[] ResultDocrefErrtxt(String Ref)
        {
            var parameters = ResultErrtxt();

            return new OracleParameter[3]
            {
                parameters[0],
                new OracleParameter("p_docref",     OracleDbType.Decimal,   Ref,            ParameterDirection.Input),
                parameters[1]
            };
        }

        protected OracleParameter[] ResultErrtxt()
        {
            return new OracleParameter[2]
            {
                new OracleParameter("result",       OracleDbType.Int32,     4000, null,     ParameterDirection.ReturnValue),
                new OracleParameter("p_errtxt",     OracleDbType.Varchar2,  4000, null,     ParameterDirection.Output)
            };
        }

        protected OracleParameter[] GetParametersWithRef(List<Decimal> Ref)
        {
            var result = ResultErrtxt().ToList();
            OracleParameter refList = new OracleParameter("p_doclist", OracleDbType.Array, Ref.Count, (NumberList)Ref, ParameterDirection.Input);
            refList.UdtTypeName = "BARS.NUMBER_LIST";
            result.Add(refList);
            return result.ToArray();
        }
    }
}