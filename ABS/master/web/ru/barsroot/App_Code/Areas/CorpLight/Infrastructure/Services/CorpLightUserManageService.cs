using BarsWeb.Areas.CorpLight.Infrastructure.Repository;
using CorpLight.Users;
using System;
using System.Linq;

namespace BarsWeb.Areas.CorpLight.Infrastructure.Services
{
    /// <summary>
    /// Provides user manage object
    /// </summary>
    public class CorpLightUserManageService : ICorpLightUserManageService
    {
        private readonly IUsersManage<string, decimal> _usersManage;

        public CorpLightUserManageService(
            IUsersManage<string, decimal> usersManage, 
            IParametersRepository parametersRepository)
        {
            _usersManage = usersManage;

            var parameters = parametersRepository.GetAll().ToList();
            var appId = parameters.FirstOrDefault(i => i.Name == "CorpLight.AppicationId");
            if (appId == null)
            {
                throw new Exception("Parameter CorpLight.AppicationId is null in MBM_PARAMETERS");
            }
            _usersManage.AppId = appId.Value;
            var appSecret = parameters.FirstOrDefault(i => i.Name == "CorpLight.AppicationSecret");
            if (appSecret == null)
            {
                throw new Exception("Parameter CorpLight.AppicationSecret is null in MBM_PARAMETERS");
            }
            _usersManage.AppSecret = appSecret.Value;
            var baseApiUrl = parameters.FirstOrDefault(i => i.Name == "CorpLight.BaseApiUrl");
            if (baseApiUrl == null)
            {
                throw new Exception("Parameter CorpLight.BaseApiUrl is null in MBM_PARAMETERS");
            }
            _usersManage.BaseApiUrl = baseApiUrl.Value;
        }
        public IUsersManage<string, decimal> GetCorpLightUserManage()
        {
            return _usersManage;
        }
    }
    
    public interface ICorpLightUserManageService
    {
        IUsersManage<string, decimal> GetCorpLightUserManage();
    }
}