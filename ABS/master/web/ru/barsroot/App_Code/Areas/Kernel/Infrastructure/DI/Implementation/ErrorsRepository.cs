using System.Linq;
using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public class ErrorsRepository: IErrorsRepository
    {
        private readonly IKernelModel _model;

        public ErrorsRepository(IKernelModel model)
        {
            _model = model;
        }
        
        public IQueryable<S_ER> GetSErrors()
        {
            return _model.KernelEntities.S_ER;
        }

        public S_ER GetSErrorByCode(string sErrorCode)
        {
            return GetSErrors().SingleOrDefault(e => e.K_ER == sErrorCode);
        }
    }
}