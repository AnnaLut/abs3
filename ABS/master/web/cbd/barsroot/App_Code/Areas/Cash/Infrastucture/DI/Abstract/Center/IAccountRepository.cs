using System;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface IAccountRepository
    {
        /// <summary>
        /// ���� ������, �� ����������� �������� � ������ Connection, �� �������� ����� � �� ��������� ������
        /// </summary>
        OracleConnection Connection { get; set; }

        /// <summary>
        /// �������� ������ ���� �������� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACC> GetAccounts();

        /// <summary>
        /// �������� ����� �������� �� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACC_ARC> GetAccountsRest();

        /// <summary>
        /// ��������� ���� �� �����
        /// </summary>
        /// <param name="mfo">������ �� mfo</param>
        /// <returns></returns>
        bool HasAccounts(string mfo = null);

        /// <summary>
        /// �������� ���� � ������� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void AddAccountData(RegionAccount regionAccount);

        /// <summary>
        /// �������� �������� ���� � ������� �������� ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void AddAccountRestData(RegionAccountRest accountRest);

        /// <summary>
        /// �������� ��������� (�����)
        /// </summary>
        /// <exception cref="Exception"></exception>
        void AddBranchData(RegionBranch regionBranch);

        void AddTransactionData(RegionTransaction regionTransaction);

        DateTime GetLoadTransactionDate(string mfo);
    }
}