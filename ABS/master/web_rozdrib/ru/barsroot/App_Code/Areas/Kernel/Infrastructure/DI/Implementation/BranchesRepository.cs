using System.Linq;
using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class BranchesRepository : IBranchesRepository
    {
        private readonly KernelContext _entities;

        public BranchesRepository(IKernelModel model)
        {
            _entities = model.KernelEntities;
        }

        public IQueryable<Branches> GetAllBranches()
        {
            return _entities.V_USER_BRANCHES.Select(i => new Branches
            {
                Branch = i.BRANCH,
                Name = i.NAME,
                Description = i.DESCRIPTION,
                B040 = i.B040,
                DateOpened = i.DATE_OPENED,
                DateClosed = i.DATE_CLOSED,
                DateDeleted = i.DELETED,
                Sab = i.SAB,
                Idpdr = i.IDPDR
            });
        }

        public Branches GetBranch(string id)
        {
            return GetAllBranches().FirstOrDefault(i => i.Branch == id);
        }

        public Branches SetBranch(Branches branch)
        {
            throw new System.NotImplementedException();
        }

        public Branches UpdateBranch(Branches branch)
        {
            throw new System.NotImplementedException();
        }

        public void DeleteBranch(string id)
        {
            throw new System.NotImplementedException();
        }
    }
}