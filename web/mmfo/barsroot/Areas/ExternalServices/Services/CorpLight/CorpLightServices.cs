using BarsWeb.Areas.ExternalServices.Repository;
using CorpLight.Users;
using System;
using System.Linq;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.ExternalServices.Services.CorpLight
{
    public class CorpLightServices : ICorpLightServices
    {
    public CorpLightServices(IParametersRepository parRepo, ICurrencyOperations zayRepo,
            ISupportDocumentsManage supportDocumentsManage, IPrintFilesManage fileLoaderServiceByApi)
        {
            FileLoaderService = supportDocumentsManage;
            FileLoaderServiceByApi = fileLoaderServiceByApi;
            var parameters = parRepo.GetAll().ToList();
            InternalDbHelper = new ClInternalDbHelper();
            InternalDbHelper.CurrencyRepo = zayRepo;
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

            FileLoaderServiceByApi.AppId = appId.Value;
            FileLoaderServiceByApi.AppSecret = appSecret.Value;
            FileLoaderServiceByApi.BaseApiUrl = baseApiUrl.Value;
            FileLoaderServiceByApi.BankId = bankId;
        }
        public ClInternalDbHelper InternalDbHelper { get; set; }
        public ISupportDocumentsManage FileLoaderService { get; private set; }

        public IPrintFilesManage FileLoaderServiceByApi
        {
            get; private set;
        }

    }
        public interface ICorpLightServices
        {
            ClInternalDbHelper InternalDbHelper { get; set; }
            ISupportDocumentsManage FileLoaderService { get; }
            IPrintFilesManage FileLoaderServiceByApi { get; }
    }
    
}