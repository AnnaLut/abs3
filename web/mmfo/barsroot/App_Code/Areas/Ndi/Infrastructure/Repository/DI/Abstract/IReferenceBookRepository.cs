using System;
using System.Collections.Generic;
using System.IO;
using BarsWeb.Areas.Ndi.Models;
using Areas.Ndi.Models;
using System.Data;
using Microsoft.Data.OData.Query.SemanticAst;
using BarsWeb.Areas.Ndi.Models.FilterModels;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using barsroot.core;
using BarsWeb.Areas.Ndi.Models.DbModels;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers.ViewModels;

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
        /// <param name="columnsVisible"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="getAllRecords">������� ���� �����. ���� �������, �� ������������ ��������� <see cref="start"/>, <see cref="limit"/></param>
        /// <returns></returns>
        ExcelResulModel ExportToExcel(ExcelDataModel excelDataModel);

       
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
        bool EditData(int tableId, string tableName, EditRowModel editDataModel, bool multipleUse = false);


        bool InsertUpdateRows(int tableId, string tableName, List<EditRowModel> EditingRowsModels, List<AddRowModel> AddingRowsModels);


        bool DeleteRows(int tableId, string tableName, List<DeleteRowModel> deleteRowsModels);
        /// <summary>
        /// �������� ������ � ����������
        /// </summary>
        /// <param name="tableId">��� �����������</param>
        /// <param name="tableName">�������� ������� �������</param>
        /// <param name="insertableRow">������ ��� ������� ��� �������</param>
        /// <exception cref="Exception"></exception>
        /// <returns>������� �������� ��������</returns>
        bool InsertData(int tableId, string tableName, List<FieldProperties> insertableRow, bool isMultipleProcedure = false);

        GetFileResult CallFunctionWithFileResult(int? tableId, int? funcId, int? codeOper, 
            List<FieldProperties> jsonFuncParams, string procName = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "");

        string InsertFilter(List<FilterRowInfo> filterRows,string filterStructure, int tableid,
            string filterName, int saveFilter,string whereClause = null);


        string UpdateFilter(EditFilterModel editFilterModel);

        string InsertFilters(List<CreateFilterModel> filterModels);

        FiltersMetaInfo GetFiltersInfo(int tableId, IEnumerable<ColumnMetaInfo> columnsInfo = null);
        //string GetFilterStructure(int dynFilterId);
        /// <summary>
        /// ������� ������ �� �����������
        /// </summary>
        /// <param name="tableId">��� �����������</param>
        /// <param name="tableName">�������� ������� �������</param>
        /// <param name="deletableRow">������ ��� ��������</param>
        /// <exception cref="Exception"></exception>
        /// <returns>������� �������� ��������</returns>
        bool DeleteData(int tableId, string tableName, List<FieldProperties> deletableRow, bool isMultipleProcedure = false);

        /// <summary>
        /// ������� ������������ ��������� ��������� � ������� META_NSIFUNCTION
        /// </summary>
        /// <param name="tableId">ID �������</param>
        /// <param name="funcId">ID �������</param>
        /// <param name="funcParams">��������� ��������� � �� ��������</param>
        /// <exception cref="Exception"></exception>
        /// <returns>��������� � ����������</returns>
       string CallRefFunction(int? tableId, int? funcId,int? codeOper,int? columnId, List<FieldProperties> jsonFuncParams, 
            string procName = "", string msg = "", string web_form_name = "", string jsonSqlProcParams = "", List<FieldProperties> addParams = null);

        string CallEachFuncWithMultypleRows(int? tableId, int? funcId, int? codeOper, int? columnId, MultiRowParamsDataModel dataModel, string funcText = "", string msg = "", string web_form_name = "", string ListjsonSqlProcParams = "");
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
        List<Dictionary<string, object>> GetRelatedReferenceData(int? nativeTableId, string tableName, string fieldForId,
            string fieldForName, string query,string tableName2 = null, int start = 0, int limit = 10);

        ParamMetaInfo GetDefaultRelatedData(MetaTable srcTable);
        List<Dictionary<string, object>> GetSrcQueryResult(SrcQueryModel srcQueryModel, string query, int start, int limit);
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
        GetDataResultInfo GetData(DataModel data);

       // DataSet ArchiveGrid(string kodf);
        
        /// <summary>
        /// �������� ��������� �������� sPar(������ �������), �� ���� funcName � �������operlist
        /// </summary>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        string GetFunNSIEditFParamsString(int? tableId, int? codeOper, int? metacolumnId, int? nativeTabelId,int? nsiTableId, int? nsiFuncId= null,string code = null);

        /// <summary>
        /// �������� ���������� ������������
        /// </summary>
        /// <param name="tableId">Id �������</param>
        /// <param name="data">������ ��� ��������� ����������</param>
        /// <exception cref="Exception"></exception>
        /// <returns></returns>
        object GetMetaData(GetMetadataModel data);

        MetaCallSettings GetMetaCallSettingsByCode(string code);

        MetaCallSettings GetMetaCallSettingsByAppCodeAndTabid(string appCode,int tabId);
        FunNSIEditFParams GetNsiParams(string nsiParamString, int? baseCodeOper = null, List<FieldProperties> rowParams = null);
        CallFunctionMetaInfo GetFunctionsMetaInfo(int? codeOper, string code = "");
        MetaTable GetMetaTableByName(string name);

        MetaTable GetMetaTableById(int id);
    }
}