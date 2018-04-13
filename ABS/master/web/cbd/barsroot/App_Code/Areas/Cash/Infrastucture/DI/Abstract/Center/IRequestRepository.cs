using System;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface IRequestRepository
    {
        /// <summary>
        /// ѕолучить список за€вок на изменение лимитов
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_REQUEST> GetRequests();

        Request GetRequestById(int id);

        string GetAtmCode(int accId);
        /// <summary>
        /// —оздать за€вку на изменение лимита
        /// </summary>
        /// <param name="accId"></param>
        /// <param name="currentLimit"></param>
        /// <param name="maxLimit"></param>
        /// <param name="maxLoadLimit"></param>
        /// <returns></returns>
        Request CreateRequest(decimal accId, decimal? currentLimit, decimal? maxLimit, decimal? maxLoadLimit);
        /// <summary>
        /// —оздать за€вку на изменение лимита
        /// </summary>
        /// <exception cref="Exception"></exception>
        Request CreateRequest(Request request);

        Request UpdateRequest(decimal requestId, decimal? currentLimit, decimal? maxLimit, decimal? maxLoadLimit);
        /// <summary>
        /// ќбновить за€вку на изменение лимита
        /// </summary>
        /// <exception cref="Exception"></exception>
        void UpdateRequest(Request request);

        /// <summary>
        /// ”далить за€вку на изменение лимита
        /// </summary>
        /// <exception cref="Exception"></exception>
        void DeleteRequest(decimal id);

        /// <summary>
        /// ѕодтвердить за€вку на изменение лимита
        /// <param name="requestId">ID за€вки</param>
        /// </summary>
        /// <exception cref="Exception"></exception>
        void ApproveRequest(decimal requestId);

        /// <summary>
        /// ќтклонить за€вку на изменение лимита
        /// <param name="requestId">ID за€вки</param>
        /// </summary>
        /// <exception cref="Exception"></exception>
        void RejectRequest(decimal requestId);
    }
}