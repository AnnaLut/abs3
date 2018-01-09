using Areas.Doc.Models;

namespace BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract
{
    public interface IDocModel
    {
        DocEntities DocEntities { get; }
    }
}
