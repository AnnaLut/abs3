using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract
{
    public interface ICdmRepository
    {
        void SaveRequestToTempTable(string packName, string packBody);
        decimal PackAndSendClientCards(int? cardsCount, int packSize);
        decimal PackAndSendRcifs(int? rcifsCount, int packSize);
        ActionStatus PackAndSendSingleCard(decimal rnk, string httpMethod = "POST");
        int SaveCardsAdvisoryFast(AdvisoryCards advisory);
        int SaveCardChangesOnline(SimpleCard card);
        void SaveGcifs(MasterCard[] masterCards, string batchId);
        void SaveGcif(MasterCard masterCard, string batchId);
        void SaveDuplicates(DupPackage[] duplicates, string batchId);
        void SaveDuplicate(DupPackage duplicate, string batchId);
        void SendCloseCard(string kf, decimal rnk, string dateOff);
        void DeleteGcif(string gcif);
        void DeleteGcifs(string[] gcifs);
    }
}