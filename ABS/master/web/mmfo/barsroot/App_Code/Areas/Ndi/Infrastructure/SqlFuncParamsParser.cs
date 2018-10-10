using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using Bars.Classes;
using BarsWeb.Areas.Ndi.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using BarsWeb.Areas.Ndi.Models.DbModels;
using BarsWeb.Areas.Ndi.Infrastructure.Helpers.BarsWeb.Areas.Ndi.Infrastructure.Helpers;
using System.Text;
using Oracle.DataAccess.Types;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Implementation;

namespace BarsWeb.Areas.Ndi.Infrastructure
{

    /// <summary>
    /// Парсер строки, содержащей параметры в формате "... :par1 :par2 ... :parN ..."
    /// </summary>
    public static class SqlStatementParamsParser
    {
        /// <summary>
        /// Получить список параметров из SQL-выражения
        /// </summary>
        /// <param name="sqlStatement">SQL-выражение (например, "setmethod(:ACC, :ID_TARIF, :ID_RATE)")</param>
        /// <returns>Для строки "setmethod(:ACC, :ID_TARIF, :ID_RATE)" вернет список {ACC, ID_TARIF, ID_RATE}</returns>
        public static List<string> GetSqlStatementParams(string sqlStatement, string tableName = "")
        {
            string paramsString = !string.IsNullOrEmpty(tableName) && tableName.Contains(':') ? sqlStatement + "|" + tableName : sqlStatement;
            // список параметров будет результатом работы функции
            var paramsNames = new List<string>();
            if (string.IsNullOrEmpty(paramsString) && string.IsNullOrEmpty(tableName))
            {
                return paramsNames;
            }

            // ?<parName> - имя группы
            // (\w+) - Найти один или более символов (найдет слова, числа; проигнорирует арифметические операции, пунктуацию)
            const string pattern = @":(?<parName>\w+)";

            Match match = Regex.Match(paramsString, pattern);
            while (match.Success)
            {
                paramsNames.Add(match.Groups["parName"].Value);
                match = match.NextMatch();
            }
            return paramsNames;
        }

        public static OracleParameter GetOracleParamByField(FieldProperties field)
        {
            if (field.Value == null)
            {
                var param = new OracleParameter(field.Name, GetOracleDbType(field.Type));
                param.Value = null;
                return param;
            }
            else
            {
                var paramValue = Convert.ChangeType(field.Value, GetCsTypeCode(field.Type));
                var param = new OracleParameter(field.Name, paramValue);
                param.Value = paramValue;
                return param;
            }
        }

        public static List<string> GetParamNames(string paramsString)
        {
            List<string> listParams = null;
            const string pattern = @":\w+";
            Regex reg = new Regex(pattern);
            MatchCollection collParams = reg.Matches(paramsString);
            if (collParams.Count > 0)
            {
                listParams = new List<string>();
                foreach (Match item in collParams)
                {
                    listParams.Add(item.Value.Replace(":", ""));
                }
            }
            return listParams;


        }
        public static OracleDbType GetOracleDbType(string code)
        {
            switch (code)
            {
                case "N":
                    return OracleDbType.Decimal;
                case "C":
                    return OracleDbType.Varchar2;
                case "D":
                    return OracleDbType.Date;
                case "B":
                    return OracleDbType.Decimal;
                default:
                    return OracleDbType.Varchar2;
            }
        }

        /// <summary>
        /// Получить тип данных C#, по переданному коду типа данных (описываются в META_COLTYPES)
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static TypeCode GetCsTypeCode(string code)
        {
            switch (code)
            {
                case "N":
                    return TypeCode.Decimal;
                case "C":
                    return TypeCode.String;
                case "D":
                    return TypeCode.DateTime;
                case "B":
                    return TypeCode.Decimal;
                default:
                    return TypeCode.String;
            }
        }

        /// <summary>
        /// Получить описание параметров вызова SQL-функции
        /// </summary>
        /// <param name="sqlStatement">Выражение вызова функции (например, "p_bmd(1, :Par1, :N2, :Par2, :C2, :Par3, :D2)")</param>
        /// <param name="paramsDescription">Строка описания параметров в виде Свойство=Значение (например, ":Par1(SEM=Число,TYPE=N,REF=DK,DEF=1), :Par2(SEM=Строка,TYPE=C),:Par3(SEM=Дата,TYPE=D)")</param>
        /// <returns></returns>
        public static List<T> GetSqlFuncCallParamsDescription<T>(string sqlStatement, string paramsDescription) where T : ParamMetaInfo, new()
        {
            List<T> paramsMetaInfo = new List<T>();
            List<string> inputParamNames;
            List<string> nonInputParamNames;
            if (typeof(T).Equals(typeof(ParamMetaInfo)))
            {
                // получим список вводимых параметров, для которых есть описание
                inputParamNames = GetSqlStatementParams(paramsDescription);

                // получим список невводимых параметров
                //
                // получим список всех параметров
                nonInputParamNames = GetSqlStatementParams(sqlStatement);
                // удалим те, которые есть в списке вводимых
                nonInputParamNames.RemoveAll(x => inputParamNames.Find(y => y.Equals(x)) != null);

                // создадим результирующий список инфы о параметрах и добавим инфу о невводимых параметрах
                paramsMetaInfo = nonInputParamNames.Select(par => new T
                {
                    ColName = par,
                    IsInput = false
                }).ToList();

            }

            // получим и добавим инфу о вводимых параметрах
            //
            if (!string.IsNullOrEmpty(paramsDescription))
            {
                // Получим из строки ...
                // :Par1(SEM=Число,TYPE=N,REF=DK,DEF=1), :Par2(SEM=Строка,TYPE=C),:Par3(SEM=Дата,TYPE=D)
                // ... такие строки:
                // SEM=Число,TYPE=N,REF=DK,DEF=1
                // SEM=Строка,TYPE=C
                // SEM=Дата,TYPE=D
                //
                // ?<parName> - группа имен параметров
                // (\w+) - Найти один или более символов (найдет слова, числа; проигнорирует арифметические операции, пунктуацию)
                // \s* - 0 или больше пробелов перед скобкой описания
                // \( - (
                // ?<parDescription> - группа описания параметров
                // [^)]* - 0 или больше любых символов, кроме )
                // \) - )
                const string pattern = @":(?<parName>\w+)\s*\((?<parDescription>[^)]*)\)";
                Match result = Regex.Match(paramsDescription, pattern);
                while (result.Success)
                {
                    string parName = result.Groups["parName"].Value;
                    string parDescription = result.Groups["parDescription"].Value;
                    Dictionary<string, string> parOptions = GetDictionary(parDescription);
                    T parMetaInfo = CallFuncParamsFactory<T>.GetParamByOptions(parOptions);
                    parMetaInfo.ColName = parName;
                    //ExecOptionsFromDictionary<T>(parMetaInfo, parOptions);
                    paramsMetaInfo.Add(parMetaInfo);
                    result = result.NextMatch();
                }
            }
            return paramsMetaInfo;
        }


        public static void BuilFunctionParams(List<CallFunctionMetaInfo> callFunctions, MetaTable tableInfo = null)
        {
            foreach (var func in callFunctions)
            {
                // парсим строку вызова sql-функции и заполняем информацию о параметрах
                List<ParamMetaInfo> paramsInfo = GetSqlFuncCallParamsDescription<ParamMetaInfo>(func.PROC_NAME, func.PROC_PAR);

                if (!string.IsNullOrEmpty(func.SysPar))
                    func.SystemParamsInfo = GetSqlFuncCallParamsDescription<ParamMetaInfo>(func.PROC_NAME, func.SysPar);

                if (!string.IsNullOrEmpty(func.UploadParams))
                {
                    func.UploadParamsInfo = GetSqlFuncCallParamsDescription<UploadParamsInfo>(func.PROC_NAME, func.UploadParams);
                    paramsInfo = paramsInfo.Where(x => !func.UploadParamsInfo.Select(b => b.Name).Contains(x.Name)).ToList();
                    paramsInfo.AddRange(func.UploadParamsInfo);
                }

                if (!string.IsNullOrEmpty(func.ConvertParams))
                {
                    func.ConvertParamsInfo = GetSqlFuncCallParamsDescription<ConvertParams>(func.PROC_NAME, func.ConvertParams);
                }
                if (!string.IsNullOrEmpty(func.OutParams))
                {
                    func.OutParamsInfo = GetSqlFuncCallParamsDescription<OutParamsInfo>(func.PROC_NAME, func.OutParams);
                    if (func.OutParamsInfo != null && func.OutParamsInfo.Count() > 0)
                    {
                        if (paramsInfo != null && paramsInfo.Count() > 0)
                            paramsInfo.RemoveAll(x => func.OutParamsInfo.Find(y => y.ColName == x.ColName) != null);


                        if (func.OutParamsInfo.FirstOrDefault(x => x.Kind == "GET_FILE") != null)
                            func.HasFileResult = true;


                    }

                }

                if (!string.IsNullOrEmpty(func.MultiParams))
                {
                    func.MultiRowsParams = GetSqlFuncCallParamsDescription<MultiRowsParams>(func.PROC_NAME, func.MultiParams);
                    if (func.MultiRowsParams != null && func.MultiRowsParams.Count() > 0)
                    {
                        List<ColMultiRowParam> colRowParams = new List<ColMultiRowParam>();
                        paramsInfo.RemoveAll(x => func.MultiRowsParams.Find(y => y.ColName == x.ColName) != null);
                        if(func.MultiRowsParams.Find(x => x.ListColumnNames != null && x.ListColumnNames.Count() > 0) != null)
                        {
                            func.MultiRowsParams.ForEach(x => colRowParams.AddRange(x.ListColumnNames.
                            Select(y => new ColMultiRowParam() { ColName = y })));
                            if (colRowParams.Count() > 0)
                                paramsInfo.AddRange(colRowParams.Distinct());
                        }
                        
                    }


                }
                if (func.PROC_EXEC == "BEFORE" && tableInfo != null && tableInfo.SemanticParamNames.Count > 0)
                    paramsInfo.ForEach(item =>
                    {
                        if (tableInfo.SemanticParamNames.Contains(item.ColName))
                        {
                            item.AdditionalUse.Add("ReplaseTableSemantic");
                        }

                    });


                // преобразуем список информации о параметрах к формату, который ожидает клиент
                func.ParamsInfo = paramsInfo.Select(x => new
                {
                    IsInput = x.IsInput,
                    DefaultValue = x.DefaultValue,
                    Kind = x.Kind,
                    AdditionalUse = x.AdditionalUse,
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


                //func.PROC_EXEC = "BEFORE";
            }

        }

        public static void AddUploadParameters(CallFunctionMetaInfo callFunction, OracleDbModel oracleConnector, List<FieldProperties> funcParams, List<FieldProperties> additionalParams)
        {
            List<UploadParamsInfo> uploadParams = GetSqlFuncCallParamsDescription<UploadParamsInfo>(callFunction.PROC_NAME, callFunction.UploadParams);
            if (uploadParams == null || uploadParams.Count() == 0)
                return;
            foreach (var item in uploadParams)
            {
                if (item.ColType == "CLOB")
                {
                    FieldProperties clobProp = funcParams.FirstOrDefault(x => x.Name == item.ColName);
                    oracleConnector.GetCommand.Parameters.Add(new OracleParameter(item.ColName, OracleDbType.Clob, clobProp.Value, ParameterDirection.Input));
                }
                if (item.ColType == "BLOB")
                {
                    FieldProperties blobProp = funcParams.FirstOrDefault(x => x.Name == item.ColName);
                    oracleConnector.GetCommand.Parameters.Add(new OracleParameter(item.ColName, OracleDbType.Blob, blobProp.ByteBody, ParameterDirection.Input));
                }


                if (item.ColType == "S" && item.GetFrom == "FILE_NAME")
                {
                    UploadFileName fileName = item as UploadFileName;
                    FieldProperties fileNameProp = additionalParams.FirstOrDefault(x => x.Name == "FileName");
                    if (fileNameProp != null && !string.IsNullOrEmpty(fileNameProp.Value))
                    {
                        if (fileNameProp.Value.Contains('.') && fileName != null && fileName.WithoutExt)
                            fileNameProp.Value = fileNameProp.Value.Substring(0, fileNameProp.Value.LastIndexOf('.'));
                        oracleConnector.GetCommand.Parameters.Add(new OracleParameter(item.ColName, OracleDbType.Varchar2, 4000, fileNameProp.Value, ParameterDirection.Input));
                    }

                }


            }
            //command.Parameters.Add(new OracleParameter("p_name", OracleDbType.Varchar2, "TEST", ParameterDirection.Input));
            //command.Parameters.Add( new OracleParameter("p_pob", OracleDbType.Int32, 0, ParameterDirection.Input));
        }
        public static List<FieldProperties> GetFieldsFromString(string sqlStatement, List<FieldProperties> rowData)
        {
            //List<FieldProperties> fieldProperties = new List<FieldProperties>();
            //List<string> paramsInfo = GetSqlStatementParams(sqlStatement);
            //return rowData.Where(x => paramsInfo.Contains(x.Name));
            return null;
        }

        public static OracleParameterCollection ConvertFieldsToOraParams(List<FieldProperties> fields)
        {
            //        OracleParameterCollection oracleParams = new OracleParameterCollection();
            //        foreach (var item in fields)
            //{

            //}
            return null;
        }
        /// <summary>
        /// Получить словарь из строки вида "ключ1 = значение1, ключ2 = значение2..."
        /// </summary>
        /// <param name="keyValuePairs">Входящая строка (наличие пробелов перед/после [,=] не принципиально)</param>
        /// <returns>Словарь значений</returns>
        private static Dictionary<string, string> GetDictionary(string keyValuePairs)
        {
            var resultDictionary = new Dictionary<string, string>();
            // ?<key> - группа ключей
            // ?<value> - группа значений
            // (\w+) - Найти один или более символов (найдет слова, числа; проигнорирует арифметические операции, пунктуацию)
            // \s* - 0 или больше пробелов
            const string pattern = @"(?<key>\w+)\s*=\s*(?<value>[\w\s\/\'_\-}{=;]+)";
            Match matchResult = Regex.Match(keyValuePairs, pattern);
            while (matchResult.Success)
            {
                string key = matchResult.Groups["key"].Value;
                string value = matchResult.Groups["value"].Value;
                resultDictionary.Add(key, value);
                matchResult = matchResult.NextMatch();
            }
            return resultDictionary;
        }
        public static void ExecOptionsFromDictionary<T>(T paramMetaInfo, Dictionary<string, string> options) where T : ParamMetaInfo, new()
        {
            if (paramMetaInfo is UploadParamsInfo)
                AddOptionsFromDictionary(paramMetaInfo as UploadParamsInfo, options);
            else if (paramMetaInfo is OutParamsInfo)
                AddOptionsFromDictionary(paramMetaInfo as OutParamsInfo, options);
            else if (paramMetaInfo is ConvertParams)
                AddOptionsFromDictionary(paramMetaInfo as ConvertParams, options);
            else if (paramMetaInfo is MultiRowsParams)
                AddOptionsFromDictionary(paramMetaInfo as MultiRowsParams, options);
            else if (paramMetaInfo is ComplexParams)
                AddOptionsFromDictionary(paramMetaInfo as ComplexParams, options);
            else
                AddOptionsFromDictionary(paramMetaInfo, options);

        }

        /// <summary>
        /// Для ParamMetaInfo добавить инфу о свойствах из словаря 
        /// </summary>
        /// <param name="paramMetaInfo">Параметр вызова функции (добавляются свойства)</param>
        /// <param name="options">Словарь свойств</param>
        private static void AddOptionsFromDictionary(ParamMetaInfo paramMetaInfo, Dictionary<string, string> options)
        {
            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "SEM":
                        paramMetaInfo.Semantic = option.Value;
                        break;
                    case "TYPE":
                        paramMetaInfo.ColType = option.Value;
                        break;
                    case "REF":
                        // вытянем информацию для построения выпадающего списка
                        string tabName = option.Value;
                        IReferenceBookRepository repository = new ReferenceBookRepository();
                            // получить tabId
                            //
                        MetaTable table = repository.GetMetaTableByName(tabName);
                            if (table == null)
                                throw new Exception(string.Format("таблиця за іменем {0} не описана в метаопису", tabName));
                            var tabId = table.TABID;
                            // получить имя первой колонки-первичного ключа
                            //
                            var pkColumn = repository.GetFirstKeyName(tabId);

                            // получить имя колонки-наименования
                            //
                            var nameColumn = repository.GetSelectName(tabId);

                            paramMetaInfo.SrcTableName = tabName;
                            paramMetaInfo.SrcColName = pkColumn;
                            paramMetaInfo.SrcTextColName = nameColumn;
                        
                        break;
                    case "DEF":
                        paramMetaInfo.DefaultValue = option.Value;
                        break;
                }
                paramMetaInfo.IsInput = true;
            }
        }


        private static void AddOptionsFromDictionary(ComplexParams paramMetaInfo, Dictionary<string, string> options)
        {

            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "GET_FROM":
                        paramMetaInfo.GetFrom = option.Value;
                        break;
                }
            }

        }
        private static void AddOptionsFromDictionary(UploadParamsInfo paramMetaInfo, Dictionary<string, string> options)
        {
            if (paramMetaInfo is UploadFileName)
            {
                AddOptionsFromDictionary(paramMetaInfo as UploadFileName, options);
                return;
            }
            if (paramMetaInfo is UploadFileInfo)
            {
                AddOptionsFromDictionary(paramMetaInfo as UploadFileInfo, options);
                return;
            }
        }

        private static void AddOptionsFromDictionary(UploadFileName paramMetaInfo, Dictionary<string, string> options)
        {
            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "WITHOUT_EXT":
                        paramMetaInfo.WithoutExt = !string.IsNullOrEmpty(option.Value) && option.Value == "TRUE";
                        break;
                    case "GET_FROM":
                        paramMetaInfo.GetFrom = option.Value;
                        break;
                }
            }
        }

        private static void AddOptionsFromDictionary(UploadFileInfo paramMetaInfo, Dictionary<string, string> options)
        {
            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "SEM":
                        paramMetaInfo.Semantic = option.Value;
                        break;
                    case "TYPE":
                        paramMetaInfo.ColType = option.Value;
                        break;
                    case "GET_FROM":
                        paramMetaInfo.GetFrom = option.Value;
                        break;
                }
            }
        }

        private static void AddOptionsFromDictionary(OutParamsInfo paramMetaInfo, Dictionary<string, string> options)
        {

            if (paramMetaInfo is GetFileParInfo)
            {
                AddOptionsFromDictionary(paramMetaInfo as GetFileParInfo, options);
                return;
            }
            if (paramMetaInfo is OutMessageParInfo)
            {
                return;
            }
            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "SEM":
                        paramMetaInfo.Semantic = option.Value;
                        break;
                    case "TYPE":
                        paramMetaInfo.ColType = option.Value;
                        break;
                    case "DEF":
                        paramMetaInfo.DefaultValue = option.Value;
                        break;
                }
            }
        }

        private static void AddOptionsFromDictionary(MultiRowsParams paramMetaInfo, Dictionary<string, string> options)
        {
            if (options == null || options.Count < 1)
                return;

            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "COLUMNS":
                        paramMetaInfo.ColumnNames = option.Value;
                        break;
                    case "DEF":
                        paramMetaInfo.DefaultValue = option.Value;
                        break;
                }
            }
            if (!string.IsNullOrEmpty(paramMetaInfo.ColumnNames))
                paramMetaInfo.ListColumnNames = paramMetaInfo.ColumnNames.Split(';').ToList();

        }

        private static void AddOptionsFromDictionary(ConvertParams paramMetaInfo, Dictionary<string, string> options)
        {
            if (options == null || options.Count < 1)
                return;

            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "GET_FROM":
                        paramMetaInfo.GetFrom = option.Value;
                        break;
                    case "DEF":
                        paramMetaInfo.DefaultValue = option.Value;
                        break;
                }
            }


        }
        

        private static void AddOptionsFromDictionary(GetFileParInfo paramMetaInfo, Dictionary<string, string> options)
        {
            foreach (var option in options)
            {
                switch (option.Key)
                {
                    case "EXT":
                        paramMetaInfo.Extention = "." + option.Value;
                        break;
                    case "FILE_NAME_GET_FROM":
                        paramMetaInfo.FileNameGetFrom = option.Value;
                        break;
                    case "SRC_FILE_NAME":
                        paramMetaInfo.SrcFileName = option.Value;
                        break;
                    case "TYPE":
                        paramMetaInfo.ColType = option.Value;
                        break;
                }
            }
        }

        public static string GetFileNameParam(List<OutParamsInfo> outparams, List<FieldProperties> funcParams, bool withExtention)
        {
            string fileName = string.Empty;
            OutParamsInfo getFileParam = outparams.FirstOrDefault(x => x.ColType == "CLOB" || x.Kind == "GET_FILE");
            if (getFileParam == null)
                return fileName;
            GetFileParInfo getfilrPar = getFileParam as GetFileParInfo;
            if (getfilrPar != null && getfilrPar.FileNameGetFrom == "COL" && !string.IsNullOrEmpty(getfilrPar.SrcFileName))
            {
                FieldProperties fileNameCol = funcParams.FirstOrDefault(x => x.Name == getfilrPar.SrcFileName);
                fileName = fileNameCol == null || string.IsNullOrEmpty(fileNameCol.Value) ? null : fileNameCol.Value;
            }
            if (!string.IsNullOrEmpty(fileName) && withExtention)
            {
                fileName = fileName.Contains('.') ? fileName : fileName + getfilrPar.Extention;
            }
            return fileName;
        }


        /// <summary>
        /// Заменить в строке NULL-константы центуры на значение Oracle null (NUMBER_Null -> null, STRING_Null -> null ...)
        /// </summary>
        /// <param name="centuraFuncCallText">Строка вызова sql-функции</param>
        /// <returns>Для строки "setmethod(:ACC, NUMBER_Null, STRING_Null)" вернет строку "setmethod(:ACC, null, null)"</returns>
        public static string ReplaceCenturaNullConstants(string centuraFuncCallText)
        {
            string[] centuraConstants = { "NUMBER_Null", "STRING_Null", "DATETIME_Null" };
            foreach (string centuraConst in centuraConstants)
            {
                centuraFuncCallText = centuraFuncCallText.Replace(centuraConst, "null");
            }
            return centuraFuncCallText;
        }

        public static string ReplaceParamsToValuesInSqlString(string sqlString, List<FieldProperties> paramValues)
        {

            foreach (var item in paramValues)
            {
                string resValue = FormatConverter.ConvertFieldValueFromJsToSharpFormat(item);
                sqlString = sqlString.Replace("|:" + item.Name + "|", resValue);
                sqlString = sqlString.Replace(":" + item.Name, resValue);
            }
            return sqlString;
        }
        public static string ReplaceParamsInSqlSelect(string sqlString, List<FieldProperties> paramValues)
        {

            foreach (var item in paramValues)
            {
                var resValue = Convert.ChangeType(item.Value, SqlStatementParamsParser.GetCsTypeCode(item.Type));
                sqlString = sqlString.Replace("|:" + item.Name + "|", resValue.ToString());

            }
            return sqlString;
        }

        public static IEnumerable<CallFunctionMetaInfo> BuildFunctions(IEnumerable<CallFunctionMetaInfo> functions)
        {
            if (functions == null || functions.Count() <= 0)
                return functions;
            foreach (var item in functions)
            {
                BuildFunction(item);
            }
            return functions;
        }

        public static void BuildFunction(CallFunctionMetaInfo function)
        {

            if (!string.IsNullOrEmpty(function.WEB_FORM_NAME) && function.WEB_FORM_NAME.Contains("sPar="))
            {
                string nsiString = function.WEB_FORM_NAME.Substring("sPar=".Length);
                if (string.IsNullOrEmpty(nsiString))
                    return;
                new FunNSIEditFParams(nsiString).BuildNsiWebFormName(function);

                if (!function.WEB_FORM_NAME.Contains("sPar=["))
                {
                    function.WEB_FORM_NAME = "/barsroot/ndi/referencebook/GetRefBookData/?" + "nsiTableId=" + function.TABID + "&nsiFuncId=" + function.FUNCID;

                }
                else
                    function.WEB_FORM_NAME = "";
            }
            else
                if (!string.IsNullOrEmpty(function.WEB_FORM_NAME) && function.WEB_FORM_NAME.Contains("/") && !function.WEB_FORM_NAME.Contains("ndi/referencebook/GetRefBookData/"))
            {
                if (!string.IsNullOrEmpty(function.PROC_NAME))
                {
                    function.LinkWebFormName = function.WEB_FORM_NAME;
                    function.WEB_FORM_NAME = "";
                }
                else
                {


                    if (function.WEB_FORM_NAME.Contains(":"))
                        function.PROC_EXEC = FuncProcNames.LINK_WITH_PARAMS.ToString();
                    else
                        function.PROC_EXEC = FuncProcNames.LINK.ToString();
                    if (function.WEB_FORM_NAME.Contains("OpenInWindow=true"))
                    {
                        function.OpenInWindow = true;
                    }

                }
            }


        }


        public static List<FieldProperties> ParsConvertParams(CallFunctionMetaInfo func,List<string> semantics)
        {
            char[] denied = new[] { ' ', '\n', '\t', '\r' };
            List<string> semWithoutChs = new List<string>();
            foreach (string item in semantics)
            {
                StringBuilder newString = new StringBuilder();
                foreach (var ch in item)
                {
                    if (!denied.Contains(ch))
                        newString.Append(ch);
                }
                semWithoutChs.Add( newString.ToString());
                
            }

            List<FieldProperties> convertProp = FormatConverter.JsonToObject<List<FieldProperties>>(func.CUSTOM_OPTIONS);
            List<FieldProperties> res = new List<FieldProperties>();
            foreach (FieldProperties item in convertProp)
            {
                StringBuilder newString = new StringBuilder();
                foreach (var ch in item.Name)
                {
                    if (!denied.Contains(ch))
                        newString.Append(ch);
                }
                item.Name = newString.ToString();

            }
            for (int i = 0; i < semWithoutChs.Count(); i++)
            {
                FieldProperties field = convertProp.Find(x => x.Name == semWithoutChs[i]);
                if (field != null)
                {
                    field.ColNum = i +1;
                    res.Add(field);
                }
            }

            return res;
        }
    }
}