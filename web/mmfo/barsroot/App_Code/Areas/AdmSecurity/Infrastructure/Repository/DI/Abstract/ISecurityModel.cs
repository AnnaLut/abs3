using Areas.AdmSecurity.Models;

namespace BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract
{
    public interface ISecurityModel
    {
        Entities Entities { get; }
    }
}