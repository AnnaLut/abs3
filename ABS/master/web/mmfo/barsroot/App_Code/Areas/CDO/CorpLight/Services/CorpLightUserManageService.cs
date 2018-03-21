using CorpLight.Users;
using System;
using System.Linq;

using BarsWeb.Areas.CDO.Common.Repository;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.CDO.CorpLight.Services
{
    /// <summary>
    /// Provides user manage object
    /// </summary>
    public class CorpLightUserManageService : ICorpLightUserManageService
    {
        private readonly IUsersManage<string, string> _usersManage;

        public CorpLightUserManageService(
            IUsersManage<string, string> usersManage,
            IParametersRepository parametersRepository,
            IBanksRepository banks)
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

            string bankId = parametersRepository.GetMFO();
            _usersManage.BankId = bankId;
        }
        public IUsersManage<string, string> GetCorpLightUserManage()
        {
            return _usersManage;
        }
    }

    public interface ICorpLightUserManageService
    {
        IUsersManage<string, string> GetCorpLightUserManage();
    }
}