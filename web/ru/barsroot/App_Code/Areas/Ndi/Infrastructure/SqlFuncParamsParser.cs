using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using Bars.Classes;
using BarsWeb.Areas.Ndi.Models;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Implementation;
using System;

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



        /// <summary>
        /// Получить описание параметров вызова SQL-функции
        /// </summary>
        /// <param name="sqlStatement">Выражение вызова функции (например, "p_bmd(1, :Par1, :N2, :Par2, :C2, :Par3, :D2)")</param>
        /// <param name="paramsDescription">Строка описания параметров в виде Свойство=Значение (например, ":Par1(SEM=Число,TYPE=N,REF=DK,DEF=1), :Par2(SEM=Строка,TYPE=C),:Par3(SEM=Дата,TYPE=D)")</param>
        /// <returns></returns>
        public static List<ParamMetaInfo> GetSqlFuncCallParamsDescription(string sqlStatement, string paramsDescription)
        {
            // получим список вводимых параметров, для которых есть описание
            List<string> inputParamNames = GetSqlStatementParams(paramsDescription);

            // получим список невводимых параметров
            //
            // получим список всех параметров
            List<string> nonInputParamNames = GetSqlStatementParams(sqlStatement);
            // удалим те, которые есть в списке вводимых
            nonInputParamNames.RemoveAll(x => inputParamNames.Find(y => y.Equals(x)) != null);

            // создадим результирующий список инфы о параметрах и добавим инфу о невводимых параметрах
            var paramsMetaInfo = nonInputParamNames.Select(par => new ParamMetaInfo
            {
                ColName = par,
                IsInput = false
            }).ToList();

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
                    var parMetaInfo = new ParamMetaInfo
                    {
                        ColName = parName,
                        IsInput = true,
                    };
                    AddOptionsFromDictionary(parMetaInfo, parOptions);
                    paramsMetaInfo.Add(parMetaInfo);
                    result = result.NextMatch();
                }
            }
            return paramsMetaInfo;
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
            const string pattern = @"(?<key>\w+)\s*=\s*(?<value>[\w\s\/\'_\-}{=]+)";
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
                        OracleConnection connection = OraConnector.Handler.UserConnection;
                        try
                        {
                            // получить tabId
                            //
                            OracleCommand selectTabId = connection.CreateCommand();
                            selectTabId.BindByName = true;
                            selectTabId.CommandText = "select tabid from meta_tables where tabname=:tabName";
                            selectTabId.Parameters.Add(new OracleParameter("tabName", tabName));
                            var tabId = (decimal)selectTabId.ExecuteScalar();

                            // получить имя первой колонки-первичного ключа
                            //
                            OracleCommand selectPkColumn = connection.CreateCommand();
                            selectPkColumn.BindByName = true;
                            selectPkColumn.CommandText = "select colname from meta_columns where tabid=:tabid and showretval=:showretval";
                            selectPkColumn.Parameters.Add(new OracleParameter("tabid", tabId));
                            selectPkColumn.Parameters.Add(new OracleParameter("showretval", 1));
                            var pkColumn = (string)selectPkColumn.ExecuteScalar();

                            // получить имя колонки-наименования
                            //
                            OracleCommand selectNameColumn = connection.CreateCommand();
                            selectNameColumn.BindByName = true;
                            selectNameColumn.CommandText = "select colname from meta_columns where tabid=:tabid and instnssemantic=:instnssemantic";
                            selectNameColumn.Parameters.Add(new OracleParameter("tabid", tabId));
                            selectNameColumn.Parameters.Add(new OracleParameter("instnssemantic", 1));
                            var nameColumn = (string)selectNameColumn.ExecuteScalar();

                            paramMetaInfo.SrcTableName = tabName;
                            paramMetaInfo.SrcColName = pkColumn;
                            paramMetaInfo.SrcTextColName = nameColumn;
                        }
                        finally
                        {
                            connection.Close();
                        }
                        break;
                    case "DEF":
                        paramMetaInfo.DefaultValue = option.Value;
                        break;
                }
            }
        }

        public static ParamMetaInfo GetDefaultRelatedData(string SrcTabName)
        {
            string srcTabName = SrcTabName;
            ParamMetaInfo refParam = new ParamMetaInfo();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                // получить tabId
                //
                OracleCommand selectTabId = connection.CreateCommand();
                selectTabId.BindByName = true;
                selectTabId.CommandText = "select tabid from meta_tables where tabname=:tabName";
                selectTabId.Parameters.Add(new OracleParameter("tabName", srcTabName));
                var tabId = (decimal)selectTabId.ExecuteScalar();

                // получить имя первой колонки-первичного ключа
                //
                OracleCommand selectPkColumn = connection.CreateCommand();
                selectPkColumn.BindByName = true;
                selectPkColumn.CommandText = "select colname from meta_columns where tabid=:tabid and showretval=:showretval";
                selectPkColumn.Parameters.Add(new OracleParameter("tabid", tabId));
                selectPkColumn.Parameters.Add(new OracleParameter("showretval", 1));
                var pkColumn = (string)selectPkColumn.ExecuteScalar();

                // получить имя колонки-наименования
                //
                OracleCommand selectNameColumn = connection.CreateCommand();
                selectNameColumn.BindByName = true;
                selectNameColumn.CommandText = "select colname from meta_columns where tabid=:tabid and instnssemantic=:instnssemantic";
                selectNameColumn.Parameters.Add(new OracleParameter("tabid", tabId));
                selectNameColumn.Parameters.Add(new OracleParameter("instnssemantic", 1));
                var nameColumn = (string)selectNameColumn.ExecuteScalar();

                refParam.SrcTableName = srcTabName;
                refParam.SrcColName = pkColumn;
                refParam.SrcTextColName = nameColumn;
                return refParam;

            }
            finally
            {
                connection.Close();
            }
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
                var resValue = Convert.ChangeType(item.Value, ReferenceBookRepository.GetCsTypeCode(item.Type));
                sqlString = sqlString.Replace("|:" + item.Name + "|", resValue.ToString());
                sqlString = sqlString.Replace(":" + item.Name, resValue.ToString());
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


    }
}