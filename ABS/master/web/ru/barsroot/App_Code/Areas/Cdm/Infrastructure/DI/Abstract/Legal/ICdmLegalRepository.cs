using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal
{
    public interface ICdmLegalRepository
    {
        void SaveRequestToTempTable(string packName, string packBody);
        decimal PackAndSendClientCards(int? cardsCount, int packSize, string kf);// kf добавляем
        decimal PackAndSendRcifs(int? rcifsCount, int packSize, string kf);// kf добавляем
        ActionStatus PackAndSendSingleCard(decimal rnk);
        int SaveCardsAdvisoryFast(AdvisoryCards advisory);
        int SaveCardChangesOnline(SimpleCard card);
        void SaveGcifs(ICard[] cards, string batchId);
        void SaveGcif(ICard card, string batchId);
        void SaveDuplicates(DupPackage[] duplicates, string batchId);
        void SaveDuplicate(DupPackage duplicate, string batchId);
        string SendCloseCard(string kf, decimal rnk, string dateOff);
        void DeleteGcif(string gcif);
        void DeleteGcifs(string[] gcifs);
        int SavePersonCardsFast(RequestFromEbkV2 request, int allowedCardsPerRequest);
        string SynchronizeCard(string kf, decimal rnk);
    }
}