using Areas.Reference.Models;

namespace BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract
{
    public interface IReferenceModel
    {
        ReferenceEntities ReferenceEntities { get; }
    }
}
