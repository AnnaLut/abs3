using System;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface ISyncRepository
    {
        /// <summary>
        /// ���� ������, �� ����������� �������� � ������ Connection, �� �������� ����� � �� ��������� ������
        /// </summary>
        OracleConnection Connection { get; set; }

        /// <summary>
        /// �������� ������ ��������� � ������������ �����
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<CLIM_SYNC_PARAMS> GetConnectionOptions();

        /// <summary>
        /// ������� ���������
        /// </summary>
        /// <exception cref="Exception"></exception>
        ConnectionOption CreateConnectionOption(ConnectionOption connectionOption);

        /// <summary>
        /// �������� ���������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void UpdateConnectionOption(ConnectionOption connectionOption);

        /// <summary>
        /// ���������� ������ ��������� "� ��������"
        /// </summary>
        /// <param name="mfo">��� ���</param>
        /// <exception cref="Exception"></exception>
        bool MarkConnectionOptionAsInProcess(string mfo);

        /// <summary>
        /// ������� ���������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void DeleteConnectionOption(string mfoCode);

        /// <summary>
        /// �������� ������ � �������� (���� ������� Id, �� ��������� ������������ ������ � ���������)
        /// </summary>
        /// <param name="syncResult">��������� ��������� ������ �������</param>
        /// <param name="updateConnectionOptionStatus">��������� ������ � ������� ��������</param>
        /// <returns>Id ������</returns>
        decimal WriteLog(SyncResult syncResult, bool updateConnectionOptionStatus);

        /// <summary>
        /// �������� ������ ������� � ������
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<CLIM_PROTOCOL> GetLog();

        /// <summary>
        /// �������� ������ ����������
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<CLIM_PARAMS> GetParams();

        /// <summary>
        /// ������� ��������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void CreateParam(Param param);

        /// <summary>
        /// �������� ��������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void UpdateParam(Param param);

        /// <summary>
        /// ������� ��������
        /// </summary>
        /// <exception cref="Exception"></exception>
        void DeleteParam(string name);

    }
}