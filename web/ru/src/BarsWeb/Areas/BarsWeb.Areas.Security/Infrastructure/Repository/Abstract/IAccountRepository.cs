using System;
using System.Collections.Generic;
using BarsWeb.Areas.Security.Models;
using BarsWeb.Areas.Security.Models.Enums;

namespace BarsWeb.Areas.Security.Infrastructure.Repository.Abstract
{
    public interface IAccountRepository
    {
        /// <summary>
        /// ����������� �� ����� � ������
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        AuthorizedStatus Authorize(string userName, string password);
        /// <summary>
        /// ����������� �� ����� � ���� ������
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="hashPass"></param>
        /// <returns></returns>
        AuthorizedStatus AuthorizeByHash(string userName, string hashPass);
        /// <summary>
        /// ����������� ����������� �� �����
        /// </summary>
        /// <param name="userName">����</param>
        /// <returns>������ �����������</returns>
        AuthorizedStatusCode LoginUser(string userName);
        /// <summary>
        /// ����������� ����������� �� ��������������
        /// </summary>
        /// <param name="userId">�������������</param>
        /// <returns>������ �����������</returns>
        AuthorizedStatusCode LoginUser(decimal userId);
        /// <summary>
        /// ����������� ����������� � ���
        /// </summary>
        /// <param name="userId">�������������</param>
        /// <returns>������ �����������</returns>
        AuthorizedStatusCode BaseLoginUser(decimal userId);
        /// <summary>
        /// ������ �������� ���������� ���
        /// </summary>
        /// <param name="currentMonth">�������� �����</param>
        /// <returns></returns>
        List<DateTime> GetOpenBankDates(DateTime currentMonth);
        /// <summary>
        /// ������ ��������� ���� ��� ����������� 
        /// </summary>
        /// <param name="date">������� ����</param>
        void ChangeUserBankDate(DateTime date);
        /// <summary>
        /// ��"� WEB-�������
        /// </summary>
        /// <returns></returns>
        string GetHostName();
        /// <summary>
        /// ������� �������� ���������
        /// </summary>
        void ClearSessionTmpDir();
        /// <summary>
        /// �������� ������������� ���� �����������
        /// </summary>
        void LogOutUser();
    }
}