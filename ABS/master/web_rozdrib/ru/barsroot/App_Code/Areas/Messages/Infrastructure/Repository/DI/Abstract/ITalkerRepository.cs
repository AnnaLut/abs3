namespace BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Abstract
{
    public interface ITalkerRepository
    {
        int SetUserMessage(string userName, string message, int type);
    }
}
