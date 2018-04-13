using Areas.Admin.Models;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IAdminModel
    {
        Entities Entities { get; }
    }
}
