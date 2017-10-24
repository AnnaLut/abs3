using BarsWeb.Areas.Cdm.Models.Transport;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract
{
    public interface IEbkFindRepository
    {
        QualityClientsContainer[] RequestEbkClient(ClientSearchParams searchParams);
    }
}