using System;
using System.Collections.Generic;
using System.IO;
using BarsWeb.Areas.Ndi.Models;

namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Abstract
{
    public interface IReferenceBookRepository
    {
        /// <summary>
        /// ��������� ������� ������ � Excel
        /// </summary>
        /// <param name="tableId"></param>
        /// <param name="tableName"></param>
        /// <param name="sort"></param>
        /// <param name="gridFilter"></param>
        /// <param name="externalFilter"></param>
        /// <param name="fallDownFilter"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="getAllRecords">������� ���� �����. ���� �������, �� ������������ ��������� <see cref="start"/>, <see cref="limit"/></param>
        /// <returns></returns>
        MemoryStream ExportToExcel(int tableId, string tableName, SortParam[] sort, GridFilter[] gridFilter, ExtFilter[] externalFilter, FallDownFilterInfo fallDownFilter, int start = 0, int limit = 10, bool getAllRecords = false);

        /// <summary>
        /// �������� ������ �����������
        /// </summary>
        /// <param name="tableId">��� �����������</param>
        /// <param name="tableName">�������� ������� �������</param>
        /// <param name="updatableRowKeys">���������� �������� ����� �� ������� ��������� update (������������ ��������������� ����������)</param>
        /// <param name="updatableRowData">����� �������� �����, ������� ���� ��������</param>
        /// <exception cref="Exception"></exception>
        /// <returns>������� �������� ��������</returns>
        bool UpdateData(int tableId, string tableName, List<FieldProperties> updatableRowKeys, List<FieldProperties> updatableRowData);

        /// <summary>
        /// �������� ������ � ����������
        /// </summary>
        /// <param name="tableId">��� �����������</param>
        /// <param name="tableName">�������� ������� �������</param>
        /// <param name="insertableRow">������ ��� ������� ��� �������</param>
        /// <exception cref="Exception"></exception>
        /// <returns>������� �������� ��������</returns>
        bool InsertData(int tableId, string tableName, List<FieldProperties> insertableRow);

        /// <summary>
        /// ������� ������ �� �����������
        /// </summary>
        /// <param name="tableId">��� �����������</param>
        /// <param name="tableName">�������� ������� �������</param>
        /// <param name="deletableRow">������ ��� ��������</param>
        /// <exception cref="Exception"></exception>
        /// <returns>������� �������� ��������</returns>
        bool DeleteData(int tableId, string tableName, List<FieldProperties> deletableRow);

        /// <summary>
        /// ������� ������������ ��������� ��������� � ������� META_NSIFUNCTION
        /// </summary>
        /// <param name="tableId">ID �������</param>
        /// <param name="funcId">ID �������</param>
        /// <param name="funcParams">��������� ��������� � �� ��������</param>
        /// <exception cref="Exception"></exception>
        /// <returns>��������� � ����������</returns>
        string CallRefFunction(int tableId, int funcId, List<FieldProperties> funcParams);

        /// <summary>
        /// �������� ������ ������������ � ������� ����������� ��� ����������� extjs ������
        /// </summary>
        /// <param name="appId">��� ���������� (REFAPP.CODEAPP)</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        List<ReferenceTreeGroupNode> GetReferenceTree(string appId);

        /// <summary>
        /// �������� ������ ��� ������ �� ���������� �����������
        /// </summary>
        /// <param name="tableName">������� �� ������� ����� ������� ������</param>
        /// <param name="fieldForId">���� ������� � �����</param>
        /// <param name="fieldForName">���� ������� � �������������</param>
        /// <param name="query">������ ��� ������ �� ���+������������</param>
        /// <param name="start">��������� ������� (��� ���������)</param>
        /// <param name="limit">���������� ������� ��� ������ (��� ���������)</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        List<Dictionary<string, object>> GetRelatedReferenceData(string tableName, string fieldForId,
            string fieldForName, string query, int start = 0, int limit = 10);

        /// <summary>
        /// �������� ������� ������� �� ������� meta_filtercodes
        /// </summary>
        /// <param name="filterCode">��� �������</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        string GetFallDownCondition(string filterCode);

        /// <summary>
        /// �������� ������ �����������, ������� ����� ��������� � ����
        /// </summary>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        GetDataResultInfo GetData(GetDataStartInfo startInfo);

        /// <summary>
        /// �������� ���������� ������������
        /// </summary>
        /// <param name="tableId">Id �������</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        object GetMetaData(int tableId);
    }
}