using Kendo.Mvc.UI;
using System.Collections.Generic;
using BarsWeb.Areas.Admin.Models.Enums;
using BarsWeb.Areas.Admin.Models.AssignmentSpecParams;


namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IAssignmentSpecParamsRepository
    {
        List<BalanceAccount> GetBalanceAccount([DataSourceRequest]DataSourceRequest request);

        decimal GetBalanceAccountCount([DataSourceRequest]DataSourceRequest request);

        List<Parameter> GetParameters([DataSourceRequest]DataSourceRequest request, string parameterType, string balanceAccountNumber);

        decimal GetParametersCount([DataSourceRequest]DataSourceRequest request, string parameterType, string balanceAccountNumber);

        void EditBalanceAccount(List<Parameter> paramsToDelete, Operation operation);

    }
}
