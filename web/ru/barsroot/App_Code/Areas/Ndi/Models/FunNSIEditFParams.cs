using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
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
        this.FunNSIEditFParamsInfo = new List<ParamMetaInfo>();
        this.DysplayParamNames = new List<string>();
        this.FunNSIEditFParamsArray = GetParamArrayByString(stringFunNSIEditFParams);
        this.ParsParams(this.FunNSIEditFParamsArray);
        
    }

    public string OUT_PARAM { get; set; }
    public int? CodeOper { get; set; }
    public string TableName { get; set; }
    public string[] FunNSIEditFParamsArray { get; set; }
    List<ParamMetaInfo> FunNSIEditFParamsInfo { get; set; }
    List<string> ConditionParamsNames { get; set; }
    public string SummVisibleRows { get; set; }
    public string RowParamsNames { get; set; }
    public bool IsInMeta_NSIFUNCTION { get; set; }
    public int? ACCESS_CODE { get; set; }
    public bool IsFuncOnly { get; set; }
    public string EXEC { get; set; }

    public string MSG { get; set; }

    public string PROC { get; set; }
    public string QST { get; set; }
    public string DESCR = "";
    public string PAR { get; set; }
    public string OutParams { get; set; }
    public string Conditions { get; set; }
    public string RenderFunctionsIn { get; set; }

    public string ShowDialogWindow = "true";
    public bool OpenInWindow { get; set; }
    public List<string> DysplayParamNames { get; set; }
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
        if(!string.IsNullOrEmpty(this.TableName) && this.TableName.Contains(":"))
            this.TableName = SqlStatementParamsParser.ReplaceParamsToValuesInSqlString(this.TableName, rowParams);
    }
    private void ParsParams(string[] paramsArray)
    {
        this.TableName = paramsArray[0];
        this.IsInMeta_NSIFUNCTION = !string.IsNullOrEmpty(paramsArray.FirstOrDefault(u => u.Contains("NSIFUNCTION")));
        string exec = paramsArray.FirstOrDefault(u => u.Contains("EXEC=>"));
        if (!string.IsNullOrEmpty(exec))
            this.EXEC = exec.Substring(exec.IndexOf("EXEC=>") + "EXEC=>".Length).Trim();

        string out_param = paramsArray.FirstOrDefault(u => u.Contains("OUT_PARAM=>"));
        if (!string.IsNullOrEmpty(out_param))
            OUT_PARAM = out_param.Substring(out_param.IndexOf("OUT_PARAM=>") + "OUT_PARAM=>".Length).Trim();

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
        //if (string.IsNullOrEmpty(descr) && !string.IsNullOrEmpty(this.PROC) && this.EXEC != "BEFORE")
        //    this.DESCR = this.PROC;
        string par = paramsArray.FirstOrDefault(u => u.Contains("PAR=>"));
        if (!string.IsNullOrEmpty(par))
            this.PAR = par.Substring(par.IndexOf("PAR=>") + "PAR=>".Length).Trim();
        string outParams = paramsArray.FirstOrDefault(u => u.Contains("OUT_PARAMS=>"));
            if(!string.IsNullOrEmpty(outParams))
                this.OutParams = outParams.Substring(outParams.IndexOf("OUT_PARAMS=>") + "OUT_PARAMS=>".Length).Trim();
        string code = paramsArray.FirstOrDefault(u => u.Contains("ACCESSCODE=>"));
        if (!string.IsNullOrEmpty(code))
            this.ACCESS_CODE = Convert.ToInt32(code.Substring(code.IndexOf("ACCESSCODE=>") + "ACCESSCODE=>".Length).Trim());
        string summaryVisibleRows = paramsArray.FirstOrDefault(u => u.Contains("SUMM_VISIBLE_ROWS=>"));
        if (!string.IsNullOrEmpty(summaryVisibleRows))
            this.SummVisibleRows = summaryVisibleRows.Substring(summaryVisibleRows.IndexOf("SUMM_VISIBLE_ROWS=>") + "SUMM_VISIBLE_ROWS=>".Length).Trim();
        string conditions = paramsArray.FirstOrDefault(u => u.Contains("CONDITIONS=>"));
        if (!string.IsNullOrEmpty(conditions))
        {
            int startIndex = conditions.IndexOf("CONDITIONS=>");
            int length = "CONDITIONS=>".Length;
            this.Conditions = conditions.Substring(startIndex + length).Trim();
            if(this.Conditions.Contains(':') || (!string.IsNullOrEmpty(this.TableName) && TableName.Contains(':')))
            this.ConditionParamsNames = SqlStatementParamsParser.GetSqlStatementParams(conditions,this.TableName);
            
        }
        string showDialogWindow = paramsArray.FirstOrDefault(u => u.Contains("showDialogWindow=>"));
        if (!string.IsNullOrEmpty(showDialogWindow))
            this.ShowDialogWindow = showDialogWindow.Substring(showDialogWindow.IndexOf("showDialogWindow=>") + "showDialogWindow=>".Length).Trim();
        OpenInWindow = !string.IsNullOrEmpty(paramsArray.FirstOrDefault(u => u.Contains("OpenInWindow")));
        if (!string.IsNullOrEmpty("FUNCTION_BUTTONS"))
            RenderFunctionsIn = RenderFunctions.renderInToolbar.ToString();
        if (string.IsNullOrEmpty(TableName) && !string.IsNullOrEmpty(this.PROC))
            this.IsFuncOnly = true;
        else
            this.IsFuncOnly = false;
        
        CollectConditionsParams();

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
        func.DysplayParamsNames = this.DysplayParamNames;
        List<ParamMetaInfo> paramsInfo = SqlStatementParamsParser.GetSqlFuncCallParamsDescription(func.PROC_NAME, func.PROC_PAR);
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
        func.PROC_NAME = string.IsNullOrEmpty(this.PROC) ? string.IsNullOrEmpty(func.PROC_NAME) ? "" : func.PROC_NAME : this.PROC; ;
        func.QST = string.IsNullOrEmpty(this.QST) ? string.IsNullOrEmpty(func.QST)  ? "" : func.QST : this.QST;
        func.MSG = string.IsNullOrEmpty(this.MSG) ? string.IsNullOrEmpty(func.MSG) ? "" : func.MSG : this.MSG;
        func.PROC_EXEC =  !string.IsNullOrEmpty(this.EXEC) ?  this.EXEC == "BEFORE" ? FuncProcNames.LINK_FUNC_BEFORE.ToString() : this.EXEC : func.PROC_EXEC;
        func.DESCR = string.IsNullOrEmpty(this.DESCR) ? string.IsNullOrEmpty(func.DESCR) ? "" : func.DESCR : this.DESCR;
        func.PROC_PAR = string.IsNullOrEmpty(this.PAR) ? string.IsNullOrEmpty(func.PROC_PAR) ? "" : func.PROC_PAR: this.PAR;
        func.isFuncOnly = this.IsFuncOnly;
        func.CodeOper = this.CodeOper;
        func.ConditionParamNames = this.ConditionParamsNames;
        func.OutParams = this.OutParams;
        func.OpenInWindow = this.OpenInWindow;

        if(string.IsNullOrEmpty(this.PROC))
        {
            if (this.ConditionParamsNames != null && this.ConditionParamsNames.Count > 0)
                func.PROC_EXEC = FuncProcNames.INTERNER_LINK_WITH_PARAMS.ToString();
            else
                func.PROC_EXEC = FuncProcNames.INTERNER_LINK.ToString();
        }
        return func;
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
                this.RowParamsNames += item.Value + "|";
            }
        }

        if (!string.IsNullOrEmpty(this.QST) && this.QST.Contains(':'))
        {
            MatchCollection collConditionsParams = reg.Matches(this.QST);
            foreach (Match item in collConditionsParams)
            {
                this.RowParamsNames += item.Value + "|";
                this.DysplayParamNames.Add(item.Value);
            }
        }

        if (!string.IsNullOrEmpty(this.DESCR) && this.DESCR.Contains(':'))
        {
            MatchCollection collConditionsParams = reg.Matches(this.DESCR);
            foreach (Match item in collConditionsParams)
            {
                this.RowParamsNames += item.Value + "|";
            }
        }

        if (!string.IsNullOrEmpty(this.MSG) && this.MSG.Contains(':'))
        {
            MatchCollection collConditionsParams = reg.Matches(this.MSG);
            foreach (Match item in collConditionsParams)
            {
                this.RowParamsNames += item.Value + "|";
            }
        }

        if (!string.IsNullOrEmpty(this.Conditions) && this.Conditions.Contains(":"))
        {
            MatchCollection collConditionsParams = reg.Matches(this.Conditions);
            foreach (Match item in collConditionsParams)
            {
                this.RowParamsNames += item.Value + "|";
            }
        }

        if (!string.IsNullOrEmpty(this.PROC) && this.PROC.Contains(":"))
        {
            MatchCollection collProcParams = reg.Matches(this.PROC + " " + this.MSG + " " + this.QST);
            foreach (Match item in collProcParams)
            {
                this.RowParamsNames += item.Value + "|";
            }

        }


    }

   
}

public enum RenderFunctions
{
    renderInToolbar,
    renderDropdown
}

public enum FuncProcNames
{
    LINK_FUNC_BEFORE,
    LINK,
    LINK_WITH_PARAMS,
    INTERNER_LINK,
    INTERNER_LINK_WITH_PARAMS
}
