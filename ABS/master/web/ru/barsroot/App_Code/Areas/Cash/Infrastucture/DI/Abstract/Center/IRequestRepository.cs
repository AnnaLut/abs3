using System;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface IRequestRepository
    {
        /// <summary>
        /// �������� ������ ������ �� ��������� �������
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_REQUEST> GetRequests();

        Request GetRequestById(int id);

        string GetAtmCode(int accId);
        /// <summary>
        /// ������� ������ �� ��������� ������
        /// </summary>
        /// <param name="accId"></param>
        /// <param name="currentLimit"></param>
        /// <param name="maxLimit"></param>
        /// <param name="maxLoadLimit"></param>
        /// <returns></returns>
        Request CreateRequest(decimal accId, decimal? currentLimit, decimal? maxLimit, decimal? maxLoadLimit);
        /// <summary>
        /// ������� ������ �� ��������� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        Request CreateRequest(Request request);

        Request UpdateRequest(decimal requestId, decimal? currentLimit, decimal? maxLimit, decimal? maxLoadLimit);
        /// <summary>
        /// �������� ������ �� ��������� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void UpdateRequest(Request request);

        /// <summary>
        /// ������� ������ �� ��������� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void DeleteRequest(decimal id);

        /// <summary>
        /// ����������� ������ �� ��������� ������
        /// <param name="requestId">ID ������</param>
        /// </summary>
        /// <exception cref="Exception"></exception>
        void ApproveRequest(decimal requestId);

        /// <summary>
        /// ��������� ������ �� ��������� ������
        /// <param name="requestId">ID ������</param>
        /// </summary>
        /// <exception cref="Exception"></exception>
        void RejectRequest(decimal requestId);
    }
}