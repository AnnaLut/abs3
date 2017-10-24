using System;
using System.Collections.Generic;
using System.IO;
using BarsWeb.Areas.Ndi.Models;
using Areas.Ndi.Models;
using System.Data;

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
        MemoryStream ExportToExcel(int tableId, string tableName, string sort, string gridFilter, string startFilter, string dynamicFilter, string externalFilter,
            string columnsVisible, int start = 0, int limit = 10, int? nativeTabelId = null, int? codeOper = null, int? sParColumn = null, int? nsiTableId = null, int? nsiFuncId = null, string jsonSqlProcParams = "", string base64jsonSqlProcParams = "", string executeBeforFunc = "");


        byte [] GetCustomImage();
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

        GetFileResult CallFunctionWithFileResult(int? tableId, int? funcId, int? codeOper, List<FieldProperties> jsonFuncParams, string procName = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "");

        string InsertFilter(List<FilterRowInfo> filterRows, int tableid, string filterName, int saveFilter,string whereClause = null);

        string InsertFilters(List<CreateFilterModel> filterModels);
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
        string CallRefFunction(int? tableId, int? funcId,int? codeOper, List<FieldProperties> jsonFuncParams, string procName = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "");

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
        GetDataResultInfo GetData(int tableId, string tableName, string gridFilter, string externalFilter, string startFilter, string dynamicFilter, string sort, int limit = 10, int start = 0, int? nativeTabelId = null, int? codeOper = null, int? sParColumn = null, int? nsiTableId = null,
            int? nsiFuncId = null, string jsonSqlProcParams = "", string base64jsonSqlProcParams = "", string executeBeforFunc = "", int? filterTblId = null, string kindOfFilter = "", string filterCode = "",  bool isReserPages = false);

       // DataSet ArchiveGrid(string kodf);
        
        /// <summary>
        /// �������� ��������� �������� sPar(������ �������), �� ���� funcName � �������operlist
        /// </summary>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        string GetFunNSIEditFParamsString(int? tableId, int? codeOper, int? metacolumnId, int? nativeTabelId,int? nsiTableId, int? nsiFuncId= null);
        /// <summary>
        /// �������� ���������� ������������
        /// </summary>
        /// <param name="tableId">Id �������</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        object GetMetaData(int tableId, int? codeOper, int? sParColumn, int? nativeTabelId, int? nsiTableId, int? nsiFuncId,string base64jsonSqlProcParams = "");

        
        CallFunctionsMetaInfo GetFunctionsMetaInfo(int? codeOper);
        META_TABLES GetMetaTableByName(string name);

        META_TABLES GetMetaTableById(int id);
    }
}