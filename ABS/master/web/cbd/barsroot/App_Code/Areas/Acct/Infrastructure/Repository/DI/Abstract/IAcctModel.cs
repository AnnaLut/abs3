using Areas.Acct.Models;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Abstract
{
    public interface IAcctModel
    {
        AcctEntities AcctEntities { get; }
    }
}
