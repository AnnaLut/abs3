using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.Attributes;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Summary description for FunNSIEditFParams
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class FunNSIEditFParams
    {
 private string WebFormName;
        public FunNSIEditFParams()
        {
        }
        public FunNSIEditFParams(string webFormName)
        {
            if(string.IsNullOrEmpty(webFormName))
            throw new Exception("строка параметрів порожня");
            this.WebFormName = webFormName;
            BuildParams();
        }

        public FunNSIEditFParams(MetaCallSettings settings)
        {
            this.WebFormName = settings.WEB_FORM_NAME;
            this.ACCESS_CODE = settings.ACCESSCODE ?? 1;
            this.TableName = settings.TABNAME ?? "";
            this.SaveColumns = settings.SAVE_COLUMN ?? "";
            this.ExcelParam = settings.EXCEL_OPT ?? "";
            this.OpenInWindow = settings.LINK_TYPE == "OPEN_IN_WINDOW";
            this.ShowDialogWindow = settings.SHOW_DIALOG ?? this.ShowDialogWindow;
            this.ShowRecordsCount = settings.SHOW_COUNT == 1;
            this.InsertRowAfter = settings.INSERT_AFTER == 1;
            this.EditMode = settings.EDIT_MODE ?? this.EditMode;
            this.SummVisibleRows = settings.SUMM_VISIBLE == 1 ? "TRUE" : "FALSE";
            this.Conditions = settings.CONDITIONS ?? "";
            this.CustomOprions = settings.CUSTOM_OPTIONS ?? "";
            this.Code = settings.CODE;
            BuildParams();


        }
        const string patternForParamsNames = @":\w+";
        Regex regForParamsNames;

        public string EditMode = "ROW_EDIT"; //"MULTI_EDIT"; // 

        [MainOptionAttribute("INSERT_ROW_AFTER", true)]
        public bool InsertRowAfter { get; set; }
        
        public AddEditRowsInform addEditRowsInform { get; set; }
        public string Code { get; set; }
        public Type TargetType { get; set; }
        public CallFunctionMetaInfo TargetObject { get; set; }
        public string CustomOprions { get; set; }
        public bool ShowRecordsCount { get; set; }
        public string SaveColumns { get; set; }
        public int? CodeOper { get; set; }
        public string TableName { get; set; }
        public string TableSemantic { get; set; }
        public string[] FunNSIEditFParamsArray { get; set; }
        List<ParamMetaInfo> FunNSIEditFParamsInfo { get; set; }
        ThrowParams ThrowNsiParams { get; set; }
        public string ThrowNsiParamsString { get; set; }
        List<string> ConditionParamsNames { get; set; }

        [MainOptionAttribute("SUMM_VISIBLE_ROWS", true)]
        public string SummVisibleRows { get; set; }
        //public string RowParamsNames { get; set; }
        public List<string> ParamsNames { get; set; }
        List<FieldProperties> RowParams { get; set; }
        public bool IsInMeta_NSIFUNCTION { get; set; }

        [MainOptionAttribute("ACCESSCODE", true)]
        public int? ACCESS_CODE { get; set; }
        public bool IsFuncOnly { get; set; }
        public string EXEC { get; set; }

        public string MSG { get; set; }

        public string PROC { get; set; }
        public string QST { get; set; }
        public string DESCR = "";
        public string PAR { get; set; }
        public string OutParams { get; set; }
        public string SystemParams { get; set; }
        public string UploadParams { get; set; }
        public string ConvertParams { get; set; }
        public string Conditions { get; set; }
        public string RenderFunctionsIn { get; set; }

        public string ShowDialogWindow = "true";
        public bool OpenInWindow { get; set; }
        public string BaseOptions { get; set; }
        public bool SaveFiltersLocal = true;
        public List<string> RowParamNames { get; set; }
        public List<string> InputParamaNames { get; set; }

        public List<string> BaseOptionsNames { get; set; }

        public string ExcelParam { get; set; }

        public string MultiParams { get; set; }
        public string CustomOptionsToClass { get; set; }

        private string[] GetParamArrayByString(string procString)
        {
            string tempStr = procString.Replace("]", "");
            string[] arrayStr = tempStr.Split('[');
            return arrayStr;
        }

        private void ParsWebFormName()
        {
            if (string.IsNullOrEmpty(this.WebFormName))
                return;

            this.FunNSIEditFParamsArray = GetParamArrayByString(this.WebFormName);
            this.ParsParams(this.FunNSIEditFParamsArray);
        }
        public void ReplaceParams(List<FieldProperties> rowParams)
        {
            if (!string.IsNullOrEmpty(this.QST))
                this.QST = SqlStatementParamsParser.ReplaceParamsToValuesInSqlString(this.QST, rowParams);
            if (!string.IsNullOrEmpty(this.DESCR))
                this.DESCR = SqlStatementParamsParser.ReplaceParamsToValuesInSqlString(this.DESCR, rowParams);
            if (!string.IsNullOrEmpty(this.MSG))
                this.MSG = SqlStatementParamsParser.ReplaceParamsToValuesInSqlString(this.MSG, rowParams);
            if (!string.IsNullOrEmpty(this.TableName) && this.TableName.Contains(":"))
                this.TableName = SqlStatementParamsParser.ReplaceParamsToValuesInSqlString(this.TableName, rowParams);
            if (!string.IsNullOrEmpty(this.Conditions) && this.Conditions.Contains("|:"))
                this.Conditions = SqlStatementParamsParser.ReplaceParamsInSqlSelect(this.Conditions, rowParams);
            if (!string.IsNullOrEmpty(this.TableSemantic) && this.TableSemantic.Contains("|:"))
                this.TableSemantic = SqlStatementParamsParser.ReplaceParamsToValuesInSqlString(this.TableSemantic, rowParams);

        }
        private void ParsParams(string[] paramsArray)
        {
            this.TableName = paramsArray[0];
            string optionsToClass = paramsArray.FirstOrDefault(u => u.Contains("CUSTOM_OPTIONS_TO_CLASS=>"));
            if (!string.IsNullOrEmpty(optionsToClass))
            {
                this.CustomOptionsToClass = optionsToClass.Substring(optionsToClass.IndexOf("CUSTOM_OPTIONS_TO_CLASS=>") + "CUSTOM_OPTIONS_TO_CLASS=>".Length).Trim();
                this.TargetType = Type.GetType(this.CustomOptionsToClass);
                this.TargetObject = FormatConverter.JsonToObject<CallFunctionMetaInfo>(this.CustomOprions);
                this.IsFuncOnly = this.TargetObject.isFuncOnly;
                this.TargetObject.Code = this.Code;
                return;
            }


            this.IsInMeta_NSIFUNCTION = !string.IsNullOrEmpty(paramsArray.FirstOrDefault(u => u.Contains("NSIFUNCTION")));
            string exec = paramsArray.FirstOrDefault(u => u.Contains("EXEC=>"));
            if (!string.IsNullOrEmpty(exec))
                this.EXEC = exec.Substring(exec.IndexOf("EXEC=>") + "EXEC=>".Length).Trim();

            string msg = paramsArray.FirstOrDefault(u => u.Contains("MSG=>"));
            if (!string.IsNullOrEmpty(msg))
                this.MSG = msg.Substring(msg.IndexOf("MSG=>") + "MSG=>".Length).Trim();

            string proc = paramsArray.FirstOrDefault(u => u.Contains("PROC=>"));
            if (!string.IsNullOrEmpty(proc))
                this.PROC = proc.Substring(proc.IndexOf("PROC=>") + "PROC=>".Length).Trim();
            string qst = paramsArray.FirstOrDefault(u => u.Contains("QST=>"));
            if (!string.IsNullOrEmpty(qst))
                this.QST = qst.Substring(qst.IndexOf("QST=>") + "QST=>".Length).Trim();
            string descr = paramsArray.FirstOrDefault(u => u.Contains("DESCR=>"));
            if (!string.IsNullOrEmpty(descr))
                this.DESCR = descr.Substring(descr.IndexOf("DESCR=>") + "DESCR=>".Length).Trim();
            string par = paramsArray.FirstOrDefault(u => u.Contains("PAR=>"));
            if (!string.IsNullOrEmpty(par))
            {
                this.PAR = par.Substring(par.IndexOf("PAR=>") + "PAR=>".Length).Trim();
                this.InputParamaNames = SqlStatementParamsParser.GetSqlStatementParams(this.PAR);
            }

            string outParams = paramsArray.FirstOrDefault(u => u.Contains("OUT_PARAMS=>"));
            if (!string.IsNullOrEmpty(outParams))
                this.OutParams = outParams.Substring(outParams.IndexOf("OUT_PARAMS=>") + "OUT_PARAMS=>".Length).Trim();

            string systemParams = paramsArray.FirstOrDefault(u => u.Contains("SYSTEM_PARAMS"));
            if (!string.IsNullOrEmpty(systemParams))
                this.SystemParams = systemParams.Substring(systemParams.IndexOf("SYSTEM_PARAMS=>") + "SYSTEM_PARAMS=>".Length).Trim();

            string uploadPrams = paramsArray.FirstOrDefault(u => u.Contains("UPLOAD_PARAMS"));
            if (!string.IsNullOrEmpty(uploadPrams))
                this.UploadParams = uploadPrams.Substring(uploadPrams.IndexOf("UPLOAD_PARAMS=>") + "UPLOAD_PARAMS=>".Length).Trim();

            string convertParams = paramsArray.FirstOrDefault(u => u.Contains("CONVERT_PARAMS"));
            if (!string.IsNullOrEmpty(convertParams))
                this.ConvertParams = convertParams.Substring(convertParams.IndexOf("CONVERT_PARAMS=>") + "CONVERT_PARAMS=>".Length).Trim();

            string multiParam = paramsArray.FirstOrDefault(u => u.Contains("MULTI_ROW_PARAMS=>"));
            if (!string.IsNullOrEmpty(multiParam))
                this.MultiParams = multiParam.Substring(multiParam.IndexOf("MULTI_ROW_PARAMS=>") + "MULTI_ROW_PARAMS=>".Length).Trim();

            string code = paramsArray.FirstOrDefault(u => u.Contains("ACCESSCODE=>"));
            if (!string.IsNullOrEmpty(code))
                this.ACCESS_CODE = Convert.ToInt32(code.Substring(code.IndexOf("ACCESSCODE=>") + "ACCESSCODE=>".Length).Trim());

            string summaryVisibleRows = paramsArray.FirstOrDefault(u => u.Contains("SUMM_VISIBLE_ROWS=>"));
            if (!string.IsNullOrEmpty(summaryVisibleRows))
                this.SummVisibleRows = summaryVisibleRows.Substring(summaryVisibleRows.IndexOf("SUMM_VISIBLE_ROWS=>") + "SUMM_VISIBLE_ROWS=>".Length).Trim();

            string editMode = paramsArray.FirstOrDefault(u => u.Contains("EDIT_MODE=>"));
            if (!string.IsNullOrEmpty(editMode))
                this.EditMode = editMode.Substring(editMode.IndexOf("EDIT_MODE=>") + "EDIT_MODE=>".Length).Trim();

            string insertRowAfter = paramsArray.FirstOrDefault(u => u.Contains("INSERT_ROW_AFTER=>"));
            if (!string.IsNullOrEmpty(insertRowAfter))
                this.InsertRowAfter = insertRowAfter.Substring(insertRowAfter.IndexOf("INSERT_ROW_AFTER=>") + "INSERT_ROW_AFTER=>".Length).Trim().ToUpper() == "TRUE";

            string baseOptions = paramsArray.FirstOrDefault(u => u.Contains("BASE_OPTIONS=>"));
            if (!string.IsNullOrEmpty(baseOptions))
            {
                this.BaseOptions = baseOptions.Substring(baseOptions.IndexOf("BASE_OPTIONS=>") + "BASE_OPTIONS=>".Length).Trim();
                this.BaseOptionsNames = this.BaseOptions.Split(',').ToList();
            }

            string excelParam = paramsArray.FirstOrDefault(u => u.Contains("EXCEL=>"));
            if (!string.IsNullOrEmpty(excelParam))
                this.ExcelParam = excelParam.Substring(excelParam.IndexOf("EXCEL=>") + "EXCEL=>".Length).Trim();

            string saveFiltersLocal = paramsArray.FirstOrDefault(u => u.Contains("SAVE_FILTERS=>"));
            if (!string.IsNullOrEmpty(saveFiltersLocal))
                this.SaveFiltersLocal = saveFiltersLocal.Substring(saveFiltersLocal.IndexOf("SAVE_FILTERS=>") + "SAVE_FILTERS=>".Length).Trim().ToUpper() == "TRUE";

            string saveColumns = paramsArray.FirstOrDefault(u => u.Contains("SAVE_COLUMNS=>"));
            if (!string.IsNullOrEmpty(saveColumns))
                this.SaveColumns = saveColumns.Substring(saveColumns.IndexOf("SAVE_COLUMNS=>") + "SAVE_COLUMNS=>".Length).Trim();

            string conditions = paramsArray.FirstOrDefault(u => u.Contains("CONDITIONS=>"));
            if (!string.IsNullOrEmpty(conditions))
            {
                int startIndex = conditions.IndexOf("CONDITIONS=>");
                int length = "CONDITIONS=>".Length;
                this.Conditions = conditions.Substring(startIndex + length).Trim();
                if (this.Conditions.Contains(':') || (!string.IsNullOrEmpty(this.TableName) && TableName.Contains(':')))
                    this.ConditionParamsNames = SqlStatementParamsParser.GetSqlStatementParams(conditions, this.TableName);

            }


            string showRecordsCount = paramsArray.FirstOrDefault(u => u.Contains("SHOW_COUNT=>"));
            if (!string.IsNullOrEmpty(showRecordsCount))
                if (showRecordsCount.Length > showRecordsCount.IndexOf("SHOW_COUNT=>") + "SHOW_COUNT=>".Length)
                    this.ShowRecordsCount = showRecordsCount.Substring(showRecordsCount.IndexOf("SHOW_COUNT=>") + "SHOW_COUNT=>".Length).Trim().ToUpper() == "TRUE";

            string showDialogWindow = paramsArray.FirstOrDefault(u => u.Contains("showDialogWindow=>"));
            if (!string.IsNullOrEmpty(showDialogWindow))
                if (showDialogWindow.Length > showDialogWindow.IndexOf("showDialogWindow=>") + "showDialogWindow=>".Length)
                    this.ShowDialogWindow = showDialogWindow.Substring(showDialogWindow.IndexOf("showDialogWindow=>") + "showDialogWindow=>".Length).Trim();
            OpenInWindow = !string.IsNullOrEmpty(paramsArray.FirstOrDefault(u => u.Contains("OpenInWindow")));
            string throwParams = paramsArray.FirstOrDefault(x => x.Contains("THROW_PARAMS=>"));
            if (!string.IsNullOrEmpty(throwParams))
                if (throwParams.Length > throwParams.IndexOf("THROW_PARAMS=>") + "THROW_PARAMS=>".Length)
                    this.ThrowNsiParamsString = throwParams.Substring(throwParams.IndexOf("THROW_PARAMS=>") + "THROW_PARAMS=>".Length).Trim();
            
            if (string.IsNullOrEmpty(TableName) && !string.IsNullOrEmpty(this.PROC))
                this.IsFuncOnly = true;
            else
                this.IsFuncOnly = false;

        }



        private void BuildParams()
        {
            this.ParamsNames = new List<string>();
            this.RowParamNames = new List<string>();
            this.InputParamaNames = new List<string>();
            ParsWebFormName();
            this.FunNSIEditFParamsInfo = new List<ParamMetaInfo>();

            regForParamsNames = new Regex(patternForParamsNames);

            CollectConditionsParams();

            BuildAddEditInform();

            BuildBaseOptions();


            BuildThrowParams();
        }

        private void BuildThrowParams()
        {
            if (string.IsNullOrEmpty(this.ThrowNsiParamsString))
                return;
            List<ComplexParams> complexParams = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<ComplexParams>(ThrowNsiParamsString, ThrowNsiParamsString);
            List<DefParam> defParams = complexParams.Where(x => x.Kind == "DEF_VAL_BY_INSERT" && x is DefParam).Select(y => y as DefParam).ToList();
            if (defParams != null && defParams.Count > 0)
            {
                this.ThrowNsiParams = new ThrowParams();
                this.ThrowNsiParams.DefParams.AddRange(defParams);
            }

        }

        public void BuildBaseOptions()
        {
            if (!string.IsNullOrEmpty(this.BaseOptions))
                this.BaseOptionsNames = this.BaseOptions.Split(',').ToList();
        }

        private void BuildAddEditInform()
        {
            List<string> editInformList;
            this.addEditRowsInform = new AddEditRowsInform();
            this.addEditRowsInform.AddAfter = InsertRowAfter;
            this.addEditRowsInform.EditorMode = EditMode;
            if (this.EditMode.Contains(","))
            {
                editInformList = this.EditMode.Split(',').ToList();
                addEditRowsInform.EditorMode = editInformList[0];
                addEditRowsInform.CarriageRollback = editInformList.Contains("CARRIAGE_RALLBACK");
                this.EditMode = addEditRowsInform.EditorMode;
            }
        }
        public CallFunctionMetaInfo BuildToCallFunctionMetaInfo(CallFunctionMetaInfo func = null)
        {
            if (func == null)
                func = new CallFunctionMetaInfo();
            func.TableName = this.TableName;
            func.PROC_NAME = this.PROC;
            func.QST = this.QST;
            func.MSG = this.MSG;
            func.PROC_EXEC = this.EXEC;
            func.DESCR = this.DESCR;
            func.PROC_PAR = this.PAR;
            func.isFuncOnly = this.IsFuncOnly;
            func.CodeOper = this.CodeOper;
            func.ConditionParamNames = this.ConditionParamsNames;
            func.RowParamsNames = this.ParamsNames;
            func.SysPar = this.SystemParams;
            func.UploadParams = UploadParams;
            func.ThrowNsiParams = this.ThrowNsiParams;
            func.ConvertParams = this.ConvertParams;
            func.MultiParams = this.MultiParams;
            func.CUSTOM_OPTIONS = this.CustomOprions;
            func.OutParams = this.OutParams;
            List<ParamMetaInfo> paramsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<ParamMetaInfo>(func.PROC_NAME, func.PROC_PAR);
            //List<UploadParamsInfo> uploadParamsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<UploadParamsInfo>(func.PROC_NAME, func.PROC_PAR);

            // преобразуем список информации о параметрах к формату, который ожидает клиент
            func.ParamsInfo = paramsInfo.Select(x => new ParamMetaInfo
            {
                IsInput = x.IsInput,
                DefaultValue = x.DefaultValue,
                ColumnInfo = new ColumnViewModel
                {
                    COLNAME = x.ColName,
                    COLTYPE = x.ColType,
                    SEMANTIC = x.Semantic,
                    SrcColName = x.SrcColName,
                    SrcTableName = x.SrcTableName,
                    SrcTextColName = x.SrcTextColName
                }
            }).ToList();
            return func;
        }

        public CallFunctionMetaInfo BuildNsiWebFormName(CallFunctionMetaInfo func)
        {

            //CallFunctionsMetaInfo newFunctionInfo = new CallFunctionsMetaInfo();
            func.TableName = this.TableName;
            func.PROC_NAME = string.IsNullOrEmpty(this.PROC) ? string.IsNullOrEmpty(func.PROC_NAME) ? "" : func.PROC_NAME : this.PROC;
            func.QST = string.IsNullOrEmpty(this.QST) ? string.IsNullOrEmpty(func.QST) ? "" : func.QST : this.QST;
            func.MSG = string.IsNullOrEmpty(this.MSG) ? string.IsNullOrEmpty(func.MSG) ? "" : func.MSG : this.MSG;

            func.DESCR = string.IsNullOrEmpty(this.DESCR) ? string.IsNullOrEmpty(func.DESCR) ? "" : func.DESCR : this.DESCR;
            func.PROC_PAR = string.IsNullOrEmpty(this.PAR) ? string.IsNullOrEmpty(func.PROC_PAR) ? "" : func.PROC_PAR : this.PAR;
            func.isFuncOnly = this.IsFuncOnly;
            func.CodeOper = this.CodeOper;
            func.ConditionParamNames = this.ConditionParamsNames;
            func.RowParamsNames = this.RowParamNames;
            //if ( this.EXEC == "BEFORE" &&  this.RowParamNames != null && this.RowParamNames.Count > 0)
            //{
            //    func.ConditionParamNames.AddRange(this.RowParamNames);
            //}


            func.OutParams = this.OutParams;
            func.SysPar = this.SystemParams;
            func.MultiParams = this.MultiParams;
            func.OpenInWindow = this.OpenInWindow;
            func.UploadParams = this.UploadParams;
            func.PROC_EXEC = GetProcExec(func, this);
            func.ThrowNsiParams = this.ThrowNsiParams;
            func.ConvertParams = this.ConvertParams;
            return func;
        }

        public string GetProcExec(CallFunctionMetaInfo func, FunNSIEditFParams nsiParams)
        {

            if (!string.IsNullOrEmpty(nsiParams.EXEC))
            {
                if (this.EXEC == "BEFORE" && !string.IsNullOrEmpty(func.WEB_FORM_NAME) && func.WEB_FORM_NAME.IndexOf("sPar=[") < 0)
                {
                    if (nsiParams.RowParamNames != null && nsiParams.RowParamNames.Count > 0)
                        func.PROC_EXEC = FuncProcNames.INTERNER_LINK_WITH_PARAMS.ToString();
                    else
                        func.PROC_EXEC = FuncProcNames.LINK_FUNC_BEFORE.ToString();
                }
                else
                    if(func.MultiRowsParams != null && func.MultiRowsParams.Count() > 0 && func.MultiRowsParams.FirstOrDefault(x => x.Kind == "FROM_UPLOAD_EXCEL") != null)
                {
                    func.PROC_EXEC ="FROM_UPLOAD_EXCEL";
                }
                else
                    func.PROC_EXEC = this.EXEC;
            }


            //string procExec = !string.IsNullOrEmpty(this.EXEC) ?
            //    this.EXEC == "BEFORE" ?
            //    FuncProcNames.LINK_FUNC_BEFORE.ToString()
            //    : this.EXEC
            //    : func.PROC_EXEC;
            if (string.IsNullOrEmpty(nsiParams.PROC) && this.EXEC != "BEFORE")
            {
                if (this.ConditionParamsNames != null && this.ConditionParamsNames.Count > 0)
                    func.PROC_EXEC = FuncProcNames.INTERNER_LINK_WITH_PARAMS.ToString();
                else
                    func.PROC_EXEC = FuncProcNames.INTERNER_LINK.ToString();
            }
            return func.PROC_EXEC;

        }

        public void CollectConditionsParams()
        {
            AddItemToParamsNames(this.TableName, this.TableSemantic, this.QST, this.DESCR, this.MSG, this.Conditions, this.PROC);

            if (this.ParamsNames.Count > 0)
                this.ParamsNames = this.ParamsNames.Distinct().ToList();
            if (this.ParamsNames != null && this.ParamsNames.Count > 0 && this.InputParamaNames != null)
                this.RowParamNames = this.ParamsNames.Where(x => !this.InputParamaNames.Contains(x)).ToList();


        }

        public void AddItemToParamsNames(params string[] param)
        {
            foreach (var item in param)
            {
                if (!string.IsNullOrEmpty(item) && item.Contains(':'))
                {
                    MatchCollection collConditionsParams = regForParamsNames.Matches(item);
                    foreach (Match i in collConditionsParams)
                    {
                        //this.RowParamsNames += item.Value + "|";
                        this.ParamsNames.Add(i.Value.Replace(":", ""));
                    }
                }
            }
         
        }

    }

    public enum RenderFunctions
    {
        RenderInToolbar,
        RenderDropdown
    }

    public enum FuncProcNames
    {
        LINK_FUNC_BEFORE,
        LINK,
        LINK_WITH_PARAMS,
        INTERNER_LINK,
        INTERNER_LINK_WITH_PARAMS
    }
}