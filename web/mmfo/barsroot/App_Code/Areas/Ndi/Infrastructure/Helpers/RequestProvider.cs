using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using  BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Abstract;
using  BarsWeb.Core;
using BarsWeb.Core.Logger;
using Ninject;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Ndi.Infrastructure
{
    /// <summary>
    /// Summary description for RequestProvider
    /// </summary>
    public class RequestProvider
    {
        [Inject]
        public IDbLogger Logger { get; set; }
        private IReferenceBookRepository _repository;
        public RequestProvider()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public RequestProvider(IReferenceBookRepository repository)
        {
            this._repository = repository;
        }
        public MainOptionsViewModel BuildResponseViewModel(RequestMolel requestModel)
        {
            FunNSIEditFParams nsiEditParams = null;


            List<FieldProperties> RowParams = string.IsNullOrEmpty(requestModel.JsonSqlParams) || requestModel.JsonSqlParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(requestModel.JsonSqlParams) as List<FieldProperties>;
            bool isFuncOnly = false;
            List<FieldProperties> defParams = string.IsNullOrEmpty(requestModel.InsertDefParams) || requestModel.InsertDefParams == "undefined" ? new List<FieldProperties>() : JsonConvert.DeserializeObject<List<FieldProperties>>(requestModel.InsertDefParams) as List<FieldProperties>;
           

            //if (!string.IsNullOrEmpty(requestModel.Code))
            //    return BuildByCode(requestModel.Code);
            if (requestModel.NsiFuncId.HasValue  && requestModel.NativeTabelId == null && requestModel.TableName != null)
            {
                var table = _repository.GetMetaTableByName(requestModel.TableName);
                if (table != null)
                    requestModel.NsiTableId = Convert.ToInt32(table.TABID);
            }
            string FunNSIEditParamsString = _repository.GetFunNSIEditFParamsString(null, requestModel.Spar, requestModel.SparColumn, requestModel.NativeTabelId, requestModel.NsiTableId, requestModel.NsiFuncId);
            if (!string.IsNullOrEmpty(FunNSIEditParamsString))
            {
                nsiEditParams = _repository.GetNsiParams(FunNSIEditParamsString, requestModel.BaseCodeOper, RowParams);
                if (requestModel.BaseCodeOper == null && requestModel.Spar != null && nsiEditParams.BaseOptionsNames != null && nsiEditParams.BaseOptionsNames.Count > 0)
                    requestModel.BaseCodeOper = requestModel.Spar;

            }

            requestModel.TableName = nsiEditParams == null || string.IsNullOrEmpty(nsiEditParams.TableName) ? requestModel.TableName : nsiEditParams.TableName;
            if (string.IsNullOrEmpty(requestModel.TableName) && nsiEditParams != null && nsiEditParams.IsFuncOnly)
            {
                return BuildFunctionOnlyRequest(requestModel);
            }

            var metaTable = _repository.GetMetaTableByName(requestModel.TableName.Trim().ToUpper());
            MainOptionsViewModel tableViwModel = new MainOptionsViewModel();

            if (defParams.Count > 0)
            {
                tableViwModel.DefParamModel = new DefParamModel();
                tableViwModel.DefParamModel.InsertDefParams = defParams;
                tableViwModel.DefParamModel.Base64InsertDefParamsString = requestModel.InsertDefParams;
            }
              

            tableViwModel.TableId = metaTable != null ? Convert.ToInt32(metaTable.TABID) : (requestModel.NativeTabelId != null && requestModel.NativeTabelId.HasValue ? requestModel.NativeTabelId : null);
            tableViwModel.CodeOper = requestModel.Spar;
            tableViwModel.SParColumn = requestModel.SparColumn;
            string accessLevel = AccessParams.WithoutUpdate.ToString();


            //custom access level
            if (requestModel.AccessCode != null && requestModel.AccessCode.HasValue)
                accessLevel = AccessSettings.GetAll().FirstOrDefault(u => (int)u == requestModel.AccessCode).ToString();

            if (nsiEditParams != null && nsiEditParams.ACCESS_CODE.HasValue)
                accessLevel = AccessSettings.GetAll().FirstOrDefault(u => (int)u == nsiEditParams.ACCESS_CODE).ToString();
            tableViwModel.FilterCode = requestModel.FilterCode;
            tableViwModel.HasCallbackFunction = requestModel.HasCallbackFunction;
            tableViwModel.NativeTabelId = requestModel.NativeTabelId != null && requestModel.NativeTabelId.HasValue ? requestModel.NativeTabelId : null;
            tableViwModel.TableMode = accessLevel;
            tableViwModel.Base64jsonSqlProcParams = FormatConverter.ConvertToUrlBase4UTF8(requestModel.JsonSqlParams);
            tableViwModel.DefParamModel.Base64InsertDefParamsString = FormatConverter.ConvertToUrlBase4UTF8(requestModel.InsertDefParams);
            tableViwModel.IsFuncOnly = isFuncOnly;
            tableViwModel.NsiTableId = requestModel.NsiTableId;
            tableViwModel.NsiFuncId = requestModel.NsiFuncId;
            tableViwModel.GetFiltersOnly = requestModel.GetFiltersOnly;
            tableViwModel.BaseCodeOper = requestModel.BaseCodeOper;
            tableViwModel.SaveFilterLocal = nsiEditParams != null ? nsiEditParams.SaveFiltersLocal : requestModel.SaveFilterLocal;

            return tableViwModel;
        }

        //public MainOptionsViewModel BuildByCode(string code)
        //{
        //    MetaCallSettings metaCallSettings = _repository.GetMetaCallSettingsByCode(code);
        //    return null;
        //}
        public FuncOnlyViewModel BuildFunctionOnlyRequest(RequestMolel requestModel)
        {
            FuncOnlyViewModel funcOnlyViewModel = new  FuncOnlyViewModel();
            funcOnlyViewModel.CodeOper = requestModel.Spar;
            return funcOnlyViewModel;
        }

    }
}