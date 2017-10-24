using System.Linq;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IParamsRepository
    {
        IQueryable<Params> GetAllParams();
        Params GetParam(string id);
        Params SetParam(Params param);
        Params UpdateParam(Params param);
        void DeleteParam(string id);
    }
}