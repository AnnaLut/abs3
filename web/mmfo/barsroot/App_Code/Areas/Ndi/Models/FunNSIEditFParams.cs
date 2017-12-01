using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
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
public class FunNSIEditFParams
{
    public FunNSIEditFParams(string stringFunNSIEditFParams)
    {
        
        this.FunNSIEditFParamsArray = GetParamArrayByString(stringFunNSIEditFParams);
        this.ParsParams(this.FunNSIEditFParamsArray);
        BuildParams();
    }

    public FunNSIEditFParams(MetaCallSettings settings)
    {
        this.ACCESS_CODE = settings.ACCESSCODE ?? 1;
        this.TableName = settings.TABNAME ?? "";
        this.SaveColumns = settings.SAVE_COLUMN ?? "";
        this.ExcelParam = settings.EXCEL_OPT ?? "";
        this.OpenInWindow = settings.LINK_TYPE == "OPEN_IN_WINDOW";
        this.ShowDialogWindow = settings.SHOW_DIALOG ?? this.ShowDialogWindow;
        this.ShowRecordsCount = settings.SHOW_COUNT == 1;
        this.InsertRowAfter = settings.INSERT_AFTER == 1;
        this.EditMode = settings.EDIT_MODE?? this.EditMode;
        this.SummVisibleRows = settings.SUMM_VISIBLE == 1 ? "TRUE" : "FALSE";
        this.Conditions = settings.CONDITIONS ?? "";
        BuildParams();
    }
    public string EditMode = "ROW_EDIT"; //"MULTI_EDIT"; // 

    [MainOptionAttribute("INSERT_ROW_AFTER", true)]
    public bool InsertRowAfter { get; set; }

    public AddEditRowsInform addEditRowsInform { get; set; }
    public bool ShowRecordsCount { get; set; }
    public string SaveColumns { get; set; }
    public int? CodeOper { get; set; }
    public string TableName { get; set; }
    public string[] FunNSIEditFParamsArray { get; set; }
    List<ParamMetaInfo> FunNSIEditFParamsInfo { get; set; }
    List<string> ConditionParamsNames { get; set; }

    [MainOptionAttribute("SUMM_VISIBLE_ROWS", true)]
    public string SummVisibleRows { get; set; }
    //public string RowParamsNames { get; set; }
    public List<string> ParamsNames { get; set; }
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

    private string[] GetParamArrayByString(string procString)
    {
        string tempStr = procString.Replace("]", "");
        string[] arrayStr = tempStr.Split('[');
        return arrayStr;
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

    }
    private void ParsParams(string[] paramsArray)
    {
        this.TableName = paramsArray[0];
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
        if (!string.IsNullOrEmpty("FUNCTION_BUTTONS"))
            RenderFunctionsIn = RenderFunctions.RenderInToolbar.ToString();
        if (string.IsNullOrEmpty(TableName) && !string.IsNullOrEmpty(this.PROC))
            this.IsFuncOnly = true;
        else
            this.IsFuncOnly = false;

    }

    private void BuildParams()
    {
        this.FunNSIEditFParamsInfo = new List<ParamMetaInfo>();
        this.ParamsNames = new List<string>();
        this.RowParamNames = new List<string>();
        this.InputParamaNames = new List<string>();

        CollectConditionsParams();

        BuildAddEditInform();

        BuildBaseOptions();
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
        if(this.EditMode.Contains(","))
        {
            editInformList = this.EditMode.Split(',').ToList();
            addEditRowsInform.EditorMode = editInformList[0];
            addEditRowsInform.CarriageRollback = editInformList.Contains("CARRIAGE_RALLBACK");
            this.EditMode = addEditRowsInform.EditorMode;
        }
    }
    public CallFunctionMetaInfo BuildToCallFunctionMetaInfo(CallFunctionMetaInfo func)
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
        List<ParamMetaInfo> paramsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<ParamMetaInfo>(func.PROC_NAME, func.PROC_PAR);
        List<UploadParamsInfo> uploadParamsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<UploadParamsInfo>(func.PROC_NAME, func.PROC_PAR);
        
        // преобразуем список информации о параметрах к формату, который ожидает клиент
        func.ParamsInfo = paramsInfo.Select(x => new
        {
            IsInput = x.IsInput,
            DefaultValue = x.DefaultValue,
            ColumnInfo = new
            {
                COLNAME = x.ColName,
                COLTYPE = x.ColType,
                SEMANTIC = x.Semantic,
                SrcColName = x.SrcColName,
                SrcTableName = x.SrcTableName,
                SrcTextColName = x.SrcTextColName
            }
        });
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
        func.OutParams = this.OutParams;
        func.SysPar = this.SystemParams;
        func.MultiParams = this.MultiParams;
        func.OpenInWindow = this.OpenInWindow;
        func.UploadParams = this.UploadParams;
        func.PROC_EXEC = GetProcExec(func, this);
        return func;
    }

    public string GetProcExec(CallFunctionMetaInfo func, FunNSIEditFParams nsiParams)
    {

        if (!string.IsNullOrEmpty(nsiParams.EXEC))
        {
            if (this.EXEC == "BEFORE" && !string.IsNullOrEmpty(func.WEB_FORM_NAME) &&  func.WEB_FORM_NAME.IndexOf("sPar=[") < 0)
            {
                if (nsiParams.RowParamNames != null && nsiParams.RowParamNames.Count > 0)
                    func.PROC_EXEC = FuncProcNames.INTERNER_LINK_WITH_PARAMS.ToString();
                else
                    func.PROC_EXEC = FuncProcNames.LINK_FUNC_BEFORE.ToString();
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
        const string pattern = @":\w+";
        Regex reg = new Regex(pattern);
        if (this.TableName.Contains(':'))
        {
            MatchCollection collConditionsParams = reg.Matches(this.TableName);
            foreach (Match item in collConditionsParams)
            {
                //this.RowParamsNames += item.Value + "|";
                this.ParamsNames.Add(item.Value.Replace(":", ""));
            }
        }

        if (!string.IsNullOrEmpty(this.QST) && this.QST.Contains(':'))
        {
            MatchCollection collConditionsParams = reg.Matches(this.QST);
            foreach (Match item in collConditionsParams)
            {
                //this.RowParamsNames += item.Value + "|";
                this.ParamsNames.Add(item.Value.Replace(":", ""));
            }
        }

        if (!string.IsNullOrEmpty(this.DESCR) && this.DESCR.Contains(':'))
        {
            MatchCollection collConditionsParams = reg.Matches(this.DESCR);
            foreach (Match item in collConditionsParams)
            {
                //this.RowParamsNames += item.Value + "|";
                this.ParamsNames.Add(item.Value.Replace(":", ""));
            }
        }

        if (!string.IsNullOrEmpty(this.MSG) && this.MSG.Contains(':'))
        {
            MatchCollection collConditionsParams = reg.Matches(this.MSG);
            foreach (Match item in collConditionsParams)
            {
                //this.RowParamsNames += item.Value + "|";
                this.ParamsNames.Add(item.Value.Replace(":", ""));
            }
        }

        if (!string.IsNullOrEmpty(this.Conditions) && this.Conditions.Contains(":"))
        {
            MatchCollection collConditionsParams = reg.Matches(this.Conditions);
            foreach (Match item in collConditionsParams)
            {
                //this.RowParamsNames += item.Value + "|";
                this.ParamsNames.Add(item.Value.Replace(":", ""));
            }
        }

        if (!string.IsNullOrEmpty(this.PROC) && this.PROC.Contains(":"))
        {
            MatchCollection collProcParams = reg.Matches(this.PROC + " " + this.MSG + " " + this.QST);
            foreach (Match item in collProcParams)
            {
                //this.RowParamsNames += item.Value + "|";
                this.ParamsNames.Add(item.Value.Replace(":", ""));
            }

        }
        if (this.ParamsNames.Count > 0)
            this.ParamsNames = this.ParamsNames.Distinct().ToList();
        if (this.ParamsNames != null && this.ParamsNames.Count > 0 && this.InputParamaNames != null)
            this.RowParamNames = this.ParamsNames.Where(x => !this.InputParamaNames.Contains(x)).ToList();


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
