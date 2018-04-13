using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Region
{
    public interface IAccountRepository
    {
        /// <summary>
        /// �������� ������ ���������� ����
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_FDAT> GetBankDates();

        /// <summary>
        /// �������� ���������� ����
        /// </summary>
        /// <exception cref="Exception"></exception>
        DateTime? GetBankDate();

        /// <summary>
        /// �������� ������ ���� �������� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACCOUNTS> GetAccounts();

        /// <summary>
        /// �������� ����� �������� ��������
        /// </summary>
        /// <param name="bankDate"></param>
        /// <returns></returns>
        IEnumerable<RegionAccountRest> GetAccountRests(DateTime bankDate);

        /// <summary>
        /// �������� ������ ���� ��������� (�������)
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_BRANCH> GetBranches();
        /// <summary>
        /// �������� ������ ����������
        /// </summary>
        /// <param name="bankDate"></param>
        /// <returns></returns>
        IEnumerable<RegionTransaction> GetTransactions(DateTime bankDate);
    }
}