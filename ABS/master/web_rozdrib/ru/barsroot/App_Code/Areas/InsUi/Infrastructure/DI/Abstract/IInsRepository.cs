using System.Linq;
using System.Net.Http;
using Areas.InsUi.Models;
using BarsWeb.Areas.InsUi.Models;
using BarsWeb.Areas.InsUi.Models.Transport;
using System.Collections.Generic;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract
{
    public interface IInsRepository
    {
        /// <summary>
        /// Параметри з`єднання
        /// </summary>
        /// <returns></returns>
        IQueryable<INS_PARAMS_INTG> GetParams();

        IEnumerable<CardInsurance> GetCardsInsur(SearchModel par);

        /// <summary>
        /// Параметри з`єднання по МФО
        /// </summary>
        /// <param name="kf"></param>
        /// <returns></returns>
        IQueryable<INS_PARAMS_INTG> GetParamMfo(string kf);
        int CheckUrlApi(string url);

        void CreateSyncParams(CreateParams param);
        void UpdateSyncParams(CreateParams param);
        void DeleteSyncParams(CreateParams param);
        string CreateDealEWA(ParamsEwa parameters, OracleConnection connection);
        byte[] GetReport(decimal insextid, decimal insexttmp, bool? draft);
        string GetParameter(string par);
    }
}
