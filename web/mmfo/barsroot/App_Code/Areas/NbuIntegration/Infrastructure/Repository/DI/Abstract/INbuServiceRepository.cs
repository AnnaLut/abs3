using Areas.NbuIntegration.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Abstract
{
    public interface INbuServiceRepository
    {
        ReqSaveRes GetAndProcessDataFromNbu(OracleConnection con, string date);
    }
}