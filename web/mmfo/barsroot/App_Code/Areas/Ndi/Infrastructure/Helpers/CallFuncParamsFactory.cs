using System.Collections.Generic;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Infrastructure;

/// <summary>
/// Summary description for CallFuncParamsFactory
/// </summary>
public static class CallFuncParamsFactory<T> where  T : ParamMetaInfo ,new()
{
    public static List<string> acceptableFileTypes = new List<string>() {"CLOB","BLOB"};

    public static T GetParamByOptions(Dictionary<string, string> parOptions)
    {
        string kind;
        string type;
        T parMetaInfo = new T();
        parOptions.TryGetValue("KIND", out kind);
        parOptions.TryGetValue("TYPE", out type);
        if (typeof(T).Equals(typeof(UploadParamsInfo)))
        {
            if (!string.IsNullOrEmpty(kind))
                parMetaInfo = GetByKindParam(kind);
            else if (!string.IsNullOrEmpty(type))
                parMetaInfo = GetParamByTypeParam(type);
            else
                parMetaInfo = new T();
        }
        if(typeof(T).Equals(typeof(OutParamsInfo)))
        {
            if (!string.IsNullOrEmpty(kind))
                parMetaInfo = GetByKindParam(kind);
            else if (!string.IsNullOrEmpty(type))
                parMetaInfo = GetParamByTypeParam(type);
            else
                parMetaInfo = new T();
        }

        SqlStatementParamsParser.ExecOptionsFromDictionary<T>(parMetaInfo, parOptions);
        return parMetaInfo;
    }
    
    public static T GetByKindParam(string kind)
    {
        T parMetaInfo;
        switch (kind)
        {
            case "UPLOAD_FILE_NAME":
                parMetaInfo = new UploadFileName() as T;
                break;
            case "UPLOAD_FILE":
                parMetaInfo = new UploadFileInfo() as T;
                break;
            case "GET_FILE":
                parMetaInfo = new GetFileParInfo() as T;
                break;
            default:
                parMetaInfo = new T();
                break;
        }
        parMetaInfo.Kind = kind;
        return parMetaInfo;
    }

    public static T GetParamByTypeParam(string type)
    {
        if (typeof(T).Equals(typeof(OutParamsInfo)))
            return GetOutParamByTypeParam(type) as T;
        if (typeof(T).Equals(typeof(UploadParamsInfo)))
            return GetUploadByTypeParam(type) as T;
        else
            return new T();
    }
    public static OutParamsInfo GetOutParamByTypeParam(string type)
    {
        OutParamsInfo param;
        switch (type)
        {
            case "CLOB":
                    param = new GetFileParInfo();
                break;
            case "fileName":
                param = new OutFileNameParInfo();
                break;
            default:
                param = new OutParamsInfo();
                break;
        }
        return param;
    }

    public static UploadParamsInfo GetUploadByTypeParam(string type)
    {
        UploadParamsInfo param;
        switch (type)
        {
            case "CLOB":
                    param = new UploadFileInfo();
                break;
            default:
                param = new UploadParamsInfo();
                break;
        }
        return param;
    }
}