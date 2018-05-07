using System;
using BarsWeb.Areas.Acct.Infrastructure.Repository;

namespace BarsWeb.Areas.Acct
{
    public class ModuleConfiguration : IModuleConfiguration
    {
        private IParametersRepository _paramRepository;
        public ModuleConfiguration(IParametersRepository paramRepository)
        {
            _paramRepository = paramRepository;
        }
        bool IModuleConfiguration.IsAccReserve
        {
            get
            {
                var param = _paramRepository.GetParameterByName("ACC_RESERVE");
                if (param == null || param.Value == "0")
                {
                    return false;
                }
                return true;
            }
            set
            {
                throw new NotImplementedException();
            }
        }

    }

    public interface IModuleConfiguration
    {
        bool IsAccReserve { get; set; }
    }
}
