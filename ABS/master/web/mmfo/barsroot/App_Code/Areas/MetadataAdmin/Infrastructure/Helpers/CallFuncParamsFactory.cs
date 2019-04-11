using System.Collections.Generic;
using BarsWeb.Areas.MetaDataAdmin.Models;
using BarsWeb.Areas.MetaDataAdmin.Infrastructure;

/// <summary>
/// Summary description for CallFuncParamsFactory
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Infrastructure.Helpers
{

    namespace BarsWeb.Areas.MetaDataAdmin.Infrastructure.Helpers
    {

        public static class CallFuncParamsFactory<T> where T : ParamMetaInfo, new()
        {
            public static List<string> acceptableFileTypes = new List<string>() { "CLOB", "BLOB" };

            public static T GetParamByOptions(Dictionary<string, string> parOptions)
            {
                string kind;
                string type;
                T parMetaInfo = new T();
                parOptions.TryGetValue("KIND", out kind);
                parOptions.TryGetValue("TYPE", out type);
                if (typeof(T).Equals(typeof(UploadParamsInfo)) || typeof(T).Equals(typeof(GetParamsInfo)) ||
                    typeof(T).Equals(typeof(ComplexParams)))
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
                    case "GET_FILE_FROM_TABLE":
                        parMetaInfo = new GetFileFromTable() as T;
                        break;
                    case "UNIQUE_NAME":
                        parMetaInfo = new GenerateParamInfo() as T;
                        break;
                    case "DEF_VAL_BY_INSERT":
                        DefParam e = new DefParam();
                        e.Kind = "DEF_VAL_BY_INSERT";
                        return e as T;
                    case "CONVERT_PARAMS":
                        return new ConvertParams() as T;
                    default:
                        parMetaInfo = new T();
                        break;
                }
                parMetaInfo.Kind = kind;
                return parMetaInfo;
            }

            public static T GetParamByTypeParam(string type)
            {
                if (typeof(T).Equals(typeof(GetParamsInfo)))
                    return GetOutParamByTypeParam(type) as T;
                if (typeof(T).Equals(typeof(UploadParamsInfo)))
                    return GetUploadByTypeParam(type) as T;
                else
                    return new T();
            }
            public static GetParamsInfo GetOutParamByTypeParam(string type)
            {
                GetParamsInfo param;
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

            public static void BuildComplexParams(ComplexParams param)
            {

            }


        }
    }
}
