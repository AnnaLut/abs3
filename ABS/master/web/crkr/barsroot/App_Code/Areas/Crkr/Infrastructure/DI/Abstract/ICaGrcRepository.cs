namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface ICaGrcRepository
    {
        decimal CaMakeWiringData<T>(T requestData);
        decimal CaDropWiringData<T>(T requestData);
        decimal CaRebranDepositData<T>(T requestData);
        string PaymentsCompenData<T>(T requestData);
        decimal PaymentsActualData<T>(T requestData);
        decimal PaymentsDeActualData<T>(T requestData);
        string BackRefData<T>(T requestData);
        string GetSosRefData<T>(T requestData);
    }
}