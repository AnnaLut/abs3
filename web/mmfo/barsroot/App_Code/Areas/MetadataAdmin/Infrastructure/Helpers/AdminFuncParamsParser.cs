using BarsWeb.Areas.MetaDataAdmin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.MetaDataAdmin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AdminFuncParamsParser
/// </summary>
public class AdminFuncParamsParser
{
    
    public AdminFuncParamsParser()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public AdminFuncParamsParser(IReferenceBookRepository _repository)
    {
        
    }

    static public void BuildSyncParamsFuncInfo(CallFunctionMetaInfo callFunction, List<ParamMetaInfo> parameters)
    {
        if (parameters != null && parameters.Count() > 0)
            parameters.Clear();
        else
            parameters = new List<ParamMetaInfo>();
        parameters.Add(new SysColParams()
        {
            ColName = "TABNAME",
            ColType = "S",
            Name = "TabNameForColSync"
        });

        parameters.Add(new SysColParams()
        {
            ColName = "TABID",
            ColType = "N",
            Name = "TabIdForColSync"
        });
        callFunction.RowParamsNames = new List<string>();
        callFunction.RowParamsNames.Add("TABNAME");
        callFunction.RowParamsNames.Add("TABID");
    }

    public static void BuildSyncParamsFunc(CallFunctionMetaInfo callFunction, string tabname)
    {
        //if (callFunction.ParamsInfo != null && parameters.Count() > 0)
        //    parameters.Clear();
        //else
        //    parameters = new List<ParamMetaInfo>();
        //parameters.Add(new SysColParams()
        //{
        //    ColName = "TABNAME",
        //    ColType = "S",
        //    Name = "TabNameForColSync"
        //});
        //callFunction.RowParamsNames = new List<string>();
        //callFunction.RowParamsNames.Add("TABNAME");
    }

    
}