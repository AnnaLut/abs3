using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface ICrkrRepository
    {
        decimal TransportData<T>(OracleConnection connection, T requestData);
        decimal UpdateCompenData<T>(T requestData);
        decimal MakeWiringData<T>(T requestData);
        decimal DropCompenData<T>(T requestData);
        decimal FixCompenData<T>(T requestData);
        decimal DropWiringData<T>(T requestData);
        decimal CountCompenData<T>(T requestData);
        string VerifyCompenData<T>(T requestData);
    }
}