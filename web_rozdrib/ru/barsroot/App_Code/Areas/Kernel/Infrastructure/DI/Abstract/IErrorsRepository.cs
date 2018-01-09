using System.Linq;
using Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IErrorsRepository
    {
        IQueryable<S_ER> GetSErrors();
        S_ER GetSErrorByCode(string sErrorCode); 
    }
}