namespace BarsWeb.Areas.WebApi.OnlineWay4.Infrastructure.DI.Abstract
{
    public interface IOnlineWay4ApiRepository
    {
        string SendRequestToWay4(string type, string requestData, string header);
    }
}