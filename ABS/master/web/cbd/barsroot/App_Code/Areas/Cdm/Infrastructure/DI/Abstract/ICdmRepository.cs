namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract
{
    public interface ICdmRepository
    {
        void SaveRequestToTempTable(string packName, string packBody);
        int PackAndSendClientCards(int? cardsCount, int packSize);
    }
}