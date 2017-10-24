﻿using Bars.Oracle;
using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OraTypesHelper
/// </summary>
public class OraTypesHelper
{
    public OraTypesHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    static public List<OraDictionary> BuildRowsDataDict(List<CallFuncRowParam> RowsData, MultiRowsParams multiParam)
    {

        List<OraDictionary> dictionaryList = new List<OraDictionary>();
        foreach (var row in RowsData)
        {
            List<OraDictionaryItem> dictionary = new List<OraDictionaryItem>();
            foreach (var item in row.RowParams)
            {
                if (multiParam.ListColumnNames.Contains(item.Name))
                {
                    if (item.Type == "D")
                    {
                        DateTime date = new DateTime();
                        bool isDate = DateTime.TryParse(item.Value, out date);
                        if (isDate)
                            item.Value = date.ToString("ddMMyyyy");
                    }
                    dictionary.Add(new OraDictionaryItem() { Key = item.Name, Value = item.Value });
                }
            }
            dictionaryList.Add((OraDictionary)dictionary);

        }
        return dictionaryList;
    }

    static public void AddListDictionaryParam(CallFunctionMetaInfo callFunction,
        MultiRowParamsDataModel dataModel, OracleCommand command)
    {
        foreach (var item in callFunction.MultiRowsParams)
        {
            OracleParameter dictionaryParameter = new OracleParameter(item.ColName, OracleDbType.Array, ParameterDirection.Input);
            List<OraDictionary> oraDictionary = OraTypesHelper.BuildRowsDataDict(dataModel.RowsData, item);
            dictionaryParameter.Value = (OraDictionaryList)oraDictionary;
            dictionaryParameter.UdtTypeName = "BARS.T_DICTIONARY_LIST";
            command.Parameters.Add(dictionaryParameter);
        }
    }

    static public void AddMessageToComand(OracleCommand callFunctionCmd, CallFunctionMetaInfo callFunction)
    {

        if (callFunction != null && !string.IsNullOrEmpty(callFunction.OutParams))
        {
            List<ParamMetaInfo> outParameters = null;
            ParamMetaInfo outMessageParam = null;
            string funcOutMessage = string.Empty;
            outParameters = SqlStatementParamsParser.GetSqlFuncCallParamsDescription<ParamMetaInfo>(callFunction.PROC_NAME, callFunction.OutParams);
            outMessageParam = outParameters.FirstOrDefault(x => x.ColType.ToUpper() == "MESSAGE");
            if (outMessageParam != null)
                callFunctionCmd.Parameters.Add(outMessageParam.ColName, OracleDbType.Varchar2, 4000, funcOutMessage, ParameterDirection.Output);
        }
    }

    static public void AddParamsToCommand(List<FieldProperties> inputParams, OracleCommand callFunctionCmd)
    {
        foreach (var par in inputParams)
        {
            if (callFunctionCmd.CommandText.Contains(":" + par.Name))
            {
                var paramName = par.Name;
                if (par.Type != "C" && string.IsNullOrEmpty(par.Value))
                    par.Value = null;
                var paramValue = par.Value == null
                    ? null
                    : Convert.ChangeType(par.Value, SqlStatementParamsParser.GetCsTypeCode(par.Type));
                // Logger.Info("add parameter in: " + callFunctionCmd.CommandText + "parameter name:  " + paramName + "Value:  " + paramValue);
                var param = new OracleParameter(paramName, paramValue);
                callFunctionCmd.Parameters.Add(param);
            }
        }
    }



}