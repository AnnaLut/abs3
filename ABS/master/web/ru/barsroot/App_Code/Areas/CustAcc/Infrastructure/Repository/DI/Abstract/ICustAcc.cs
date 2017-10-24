using Areas.CustAcc.Models;

namespace BarsWeb.Areas.CustAcc.Infrastructure.Repository.DI.Abstract
{
    public interface ICustAcc
    {
        CustAccModel CustAccModel { get; }
    }
}