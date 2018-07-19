using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Core.Models;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual
{
    public interface ICdmRepository
    {
        void SaveRequestToTempTable(string packName, string packBody);// kf не добавляем, нет нужды
        decimal PackAndSendClientCards(int? cardsCount, int packSize, string kf);// kf добавляем
        decimal PackAndSendRcifs(int? rcifsCount, int packSize, string kf);// kf добавляем
        ActionStatus PackAndSendSingleCard(decimal rnk); // kf не добавляем, там по РНК
        int SaveCardsAdvisoryFast(AdvisoryCards advisory);// kf не добавляем, нет нужды
        int SaveCardChangesOnline(SimpleCard card);// kf не добавляем, нет нужды
        void SaveGcifs(ICard[] cards, string batchId);// kf не добавляем, нет нужды
        void SaveGcif(ICard card, string batchId);// kf не добавляем, нет нужды
        void SaveDuplicates(DupPackage[] duplicates, string batchId);// kf не добавляем, нет нужды
        void SaveDuplicate(DupPackage duplicate, string batchId);// kf не добавляем, нет нужды
        string SendCloseCard(string kf, decimal rnk, string dateOff);// kf был
        void DeleteGcif(string gcif);// kf не добавляем, нет нужды
        void DeleteGcifs(string[] gcifs);// kf не добавляем, нет нужды
        int SavePersonCardsFast(RequestFromEbkV2 request, int allowedCardsPerRequest);
        string SynchronizeCard(string kf, decimal rnk);
    }
}