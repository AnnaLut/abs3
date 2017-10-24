using Areas.KFiles.Models;
using BarsWeb.Areas.KFiles.Models;

namespace BarsWeb.Areas.KFiles.Infrastructure.DI.Abstract
{
    public interface IKFilesModel
    {
        KFilesEntities KFilesEntities { get; }
    }
}
