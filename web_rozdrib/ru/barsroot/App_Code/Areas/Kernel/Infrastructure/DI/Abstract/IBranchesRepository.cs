using System.Linq;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IBranchesRepository
    {
        IQueryable<Branches> GetAllBranches();
        Branches GetBranch(string id);
        Branches SetBranch(Branches branch);
        Branches UpdateBranch(Branches branch);
        void DeleteBranch(string id);
    }
}