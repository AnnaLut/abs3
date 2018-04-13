using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static IQueryable<RegionBranch> ToViewModel(IQueryable<V_CLIM_BRANCH> dbModel)
        {
            return dbModel.Select(x => new RegionBranch
            {
                Branch = x.BRANCH,
                Name = x.NAME,
                CloseDate = x.DATE_CLOSED,
                OpenDate = x.DATE_OPENED,
                DeleteDate = x.DELETED,
                B040 = x.B040,
                Description = x.DESCRIPTION,
                IdPdr = x.IDPDR,
                Obl = x.OBL,
                Sab = x.SAB
            });
        }
    }
}