using BarsWeb.Areas.ExternalServices.Repository;
using CorpLight.Users;
using System;
using System.Linq;

namespace BarsWeb.Areas.ExternalServices.Services.CorpLight
{
    public class CorpLightServices : ICorpLightServices
    {
        public CorpLightServices(IParametersRepository parRepo, ISupportDocumentsManage supportDocumentsManage)
        {
            FileLoaderService = supportDocumentsManage;
            var parameters = parRepo.GetAll().ToList();

            var appId = parameters.FirstOrDefault(i => i.Name == "CorpLight.AppicationId");
            if (appId == null)
            {
                throw new Exception("Parameter CorpLight.AppicationId is null in MBM_PARAMETERS");
            }
            var appSecret = parameters.FirstOrDefault(i => i.Name == "CorpLight.AppicationSecret");
            if (appSecret == null)
            {
                throw new Exception("Parameter CorpLight.AppicationSecret is null in MBM_PARAMETERS");
            }
            var baseApiUrl = parameters.FirstOrDefault(i => i.Name == "CorpLight.BaseApiUrl");
            if (baseApiUrl == null)
            {
                throw new Exception("Parameter CorpLight.BaseApiUrl is null in MBM_PARAMETERS");
            }
            string bankId = parRepo.GetMFO();

            FileLoaderService.AppId = appId.Value;
            FileLoaderService.AppSecret = appSecret.Value;
            FileLoaderService.BaseApiUrl = baseApiUrl.Value;
            FileLoaderService.BankId = bankId;

        }
        public ISupportDocumentsManage FileLoaderService { get; private set; }

    }
    public interface ICorpLightServices
    {
        ISupportDocumentsManage FileLoaderService { get; }
    }
}