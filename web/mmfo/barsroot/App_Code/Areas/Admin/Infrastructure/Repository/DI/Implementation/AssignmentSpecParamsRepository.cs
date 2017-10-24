using System.Linq;
using Kendo.Mvc.UI;
using Areas.Admin.Models;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Admin.Models.Enums;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Admin.Models.AssignmentSpecParams;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class AssignmentSpecParamsRepository : IAssignmentSpecParamsRepository
    {

        private readonly BarsSql _barsSql;
        private readonly Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public AssignmentSpecParamsRepository(IAdminModel model, IKendoSqlTransformer sqlTransformer, IKendoSqlCounter sqlCounter)
        {
            _entities = model.Entities;
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = sqlCounter;
            _barsSql = new BarsSql() { };
        }

        public List<BalanceAccount> GetBalanceAccount([DataSourceRequest]DataSourceRequest request)
        {
            GetBalanceAccountSqlQuery();
            BarsSql barsSql = _sqlTransformer.TransformSql(_barsSql, request);
            var result = _entities.ExecuteStoreQuery<BalanceAccount>(barsSql.SqlText, barsSql.SqlParams).ToList();
            return result;
        }

        public decimal GetBalanceAccountCount([DataSourceRequest]DataSourceRequest request)
        {
            GetBalanceAccountSqlQuery();
            BarsSql barsSql = _kendoSqlCounter.TransformSql(_barsSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(barsSql.SqlText, barsSql.SqlParams).Single();
            return result;
        }

        private void GetBalanceAccountSqlQuery()
        {
            _barsSql.SqlText = "SELECT NBS AS BalanceAccountNumber, NAME AS BalanceAccountName FROM V_PS_LIST";
            _barsSql.SqlParams = new object[] { };
        }

        public List<Parameter> GetParameters([DataSourceRequest]DataSourceRequest request, string parameterType, string balanceAccountNumber)
        {
            GetParametersSqlQuery(parameterType, balanceAccountNumber);
            BarsSql barsSql = _sqlTransformer.TransformSql(_barsSql, request);
            var result = _entities.ExecuteStoreQuery<Parameter>(barsSql.SqlText, barsSql.SqlParams).ToList();
            return result;
        }

        public decimal GetParametersCount([DataSourceRequest]DataSourceRequest request, string parameterType, string balanceAccountNumber)
        {
            GetParametersSqlQuery(parameterType, balanceAccountNumber);
            BarsSql barsSql = _kendoSqlCounter.TransformSql(_barsSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(barsSql.SqlText, barsSql.SqlParams).Single();
            return result;
        }


        private void GetParametersSqlQuery(string parameterType, string balanceAccountNumber)
        {
            if (parameterType == "selected")
            {
                _barsSql.SqlText = string.Format("SELECT NAME AS Code, SEMANTIC AS ParameterName, OPT AS RequiredParameter, SQLVAL AS SqlExpression, SPID AS ParameterId FROM V_PS_SPARAM_LIST WHERE NBS = '{0}'", balanceAccountNumber);
            }
            else
            {
                _barsSql.SqlText = string.Format("SELECT NAME AS Code, SEMANTIC AS ParameterName, SPID AS ParameterId FROM V_SPARAM_LIST WHERE NBS = '{0}'", balanceAccountNumber);
            }
            _barsSql.SqlParams = new object[] { };
        }

        public void EditBalanceAccount(List<Parameter> paramsToDelete, Operation operation)
        {

            _barsSql.SqlText = " begin P_EDIT_PS_SPARAM( :p_fl, :p_nbs, :p_spid, :p_opt, :p_sqlval ); end;";

            for (int i = 0; i < paramsToDelete.Count; i++)
            {
                _barsSql.SqlParams = new object[]
                {
                    new OracleParameter("p_fl", OracleDbType.Decimal) { Value =  (int)operation },
                    new OracleParameter("p_nbs", OracleDbType.Varchar2) { Value = paramsToDelete[i].BalanceAccountNumber },
                    new OracleParameter("p_spid", OracleDbType.Decimal) { Value = paramsToDelete[i].ParameterId },
                    new OracleParameter("p_opt", OracleDbType.Varchar2) { Value = paramsToDelete[i].RequiredParameter },
                    new OracleParameter("p_sqlval", OracleDbType.Varchar2) { Value = paramsToDelete[i].SqlExpression }
                };
                _entities.ExecuteStoreCommand(_barsSql.SqlText, _barsSql.SqlParams);
            }
        }

    }
}
