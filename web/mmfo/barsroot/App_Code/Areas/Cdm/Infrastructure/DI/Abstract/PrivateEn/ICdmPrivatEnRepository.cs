using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn
{
    public interface ICdmPrivateEnRepository
    {
        void SaveRequestToTempTable(string packName, string packBody);
        decimal PackAndSendClientCards(int? cardsCount, int packSize, string kf);
        decimal PackAndSendRcifs(int? rcifsCount, int packSize, string kf);
        ActionStatus PackAndSendSingleCard(decimal rnk);
        int SaveCardsAdvisoryFast(AdvisoryCards advisory);
        int SaveCardChangesOnline(SimpleCard card);
        void SaveGcifs(ICard[] masterCards, string batchId);
        void SaveGcif(ICard masterCard, string batchId);
        void SaveDuplicates(DupPackage[] duplicates, string batchId);
        void SaveDuplicate(DupPackage duplicate, string batchId);
        string SendCloseCard(string kf, decimal rnk, string dateOff);
        void DeleteGcif(string gcif);
        void DeleteGcifs(string[] gcifs);
        int SavePersonCardsFast(RequestFromEbkV2 request, int allowedCardsPerRequest);
        string SynchronizeCard(string kf, decimal rnk);
    }
}