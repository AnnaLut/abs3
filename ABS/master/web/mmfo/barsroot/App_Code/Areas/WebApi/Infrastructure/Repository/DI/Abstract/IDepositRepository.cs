namespace BarsWeb.Areas.WebApi.Deposit.Infrastructure.DI.Abstract
{
    public interface IDepositRepository
    {
        string GetFileFromFileName(string fileName, out long fileSize);
    }
}