using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Security.Infrastructure.Repository.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Security.Controllers.Api.V1
{
    public class AuditController : ApiController
    {
        private readonly IAuditRepository _auditRepository;
        public AuditController(IAuditRepository auditRepository)
        {
            _auditRepository = auditRepository;
        }

        public DataSourceResult Get(
            [ModelBinder(typeof (WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            var list = _auditRepository.GetAllMessages();
            return list.ToDataSourceResult(request);
        }
    }
}