using BarsWeb.Areas.LinkedGroupReference.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.LinkedGroupReference.Models;
using OfficeOpenXml;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace BarsWeb.Areas.LinkedGroupReference
{
    /// <summary>
    /// Summary description for LinkedGroupHelper
    /// </summary>
    public class LinkedGroupHelper
    {
        #region constants
        private readonly ILinkedGroupReferenceRepository _repo;

        //Номера колонок для відповідних значень у файлі довідника:
        private const int ILINK_GROUP = 1;
        private const int IGROUPNAME = 2;
        private const int IOKRO = 3;
        private const int IRNK = 5;
        private const int IKF = 6;

        private const int MAXGROUPNAMELENGTH = 250;
        private const int MAXOKPOLENGTH = 20;
        private const int MAXRNKLENGTH = 20;
        private const int MAXKFLENGTH = 6;

        private const string EDRPUO_COLUMN_NAME = "'Код ЄДРПОУ'";
        private const string LINKGROUP_COLUMN_NAME = "'Номер групи'";
        private const string GROUP_COLUMN_NAME = "'Умовна назва групи'";
        private const string KF_COLUMN_NAME = "'МФО'";
        private const string RNK_COLUMN_NAME = "'РНК'";
        #endregion

        private Dictionary<int, string> errors = new Dictionary<int, string>();
        private StreamWriter errorsResFile = null;
        private bool hasErrors = false;

        public LinkedGroupHelper(ILinkedGroupReferenceRepository repo)
        {
            InitializeErrorsDictionary();
            _repo = repo;
        }

        private void InitializeErrorsDictionary()
        {
            errors.Add(1, "Не обрано файл довідника.Оберіть файл з розширенням.xlsx для завантаження.");
            errors.Add(2, "Неправильний формат файлу довідника. Оберіть файл довідника з розширенням .xlsx .");
            errors.Add(3, "Неправильний формат файлу: у файлі має бути 6 колонок з даними.");
            errors.Add(4, "Поле {0} не є цілим числом.");
            errors.Add(5, "Довжина поля {0} перевищує {1} символів.");
            errors.Add(6, "Поле {0} не є числом.");
            errors.Add(7, "Поле {0} не може бути порожнім.");
            errors.Add(13, "Значення в полі 'МФО' не співпадає з наявними МФО Ощадбанку: {0}.");
            errors.Add(14, "Поле 'МФО' може містити тільки арабські цифри.");
            errors.Add(16, "Поле 'РНК' заповнене і не дорівнює полю 'Код ЄДРПОУ'.");
            errors.Add(17, "В даному рядку обидва поля 'РНК' та 'МФО' повинні бути або заповненими, або незаповненими.");
            errors.Add(21, "Поле 'МФО' заповнене, а поле 'РНК' - порожнє. Поля повинні бути обидва заповнені або обидва порожні.");
            errors.Add(22, "Рядки {0} мають дублюючі значення кодів ЄДРПОУ: {1}.");
            errors.Add(23, "Файл не містить жодного запису!");
        }

        /// <summary>
        /// Проверить корректность имени файла
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public string CheckFileName(string filename)
        {
            if (String.IsNullOrEmpty(filename))
            {
                return ErrText(1); // Empty file error
            }
            else
               if (Path.GetExtension(filename) != ".xlsx")
                {
                    return ErrText(2); // Wrong file format
                }
            // file has valid name, extention
            return "";
        }

        public bool ParseExcelFile(HttpPostedFileBase parsedFile, FileInfo parsingResultFile)
        {
            //List of records from file
            List<LinkGroup> refList = new List<LinkGroup>();
            //List of MFO's for ru's which can be used in excel:
            List<string> MFOList = _repo.GetMFOList();
            //flag showing that was found at least one error and no Insert should be done
            bool hasAllEmptyRows = true;

            using (ExcelPackage package = new ExcelPackage(parsedFile.InputStream))
            {
                OfficeOpenXml.ExcelWorksheet worksheet;
                // below is workaround on known issue: https://epplus.codeplex.com/workitem/14779 
                // issue causes Exception while accessing cell by address if header column has spesific filtering, sorting or other additional settings added
                // exception is raised only on first call of package.Workbook
                try
                {
                    worksheet = package.Workbook.Worksheets[1];
                }
                catch
                {
                    worksheet = package.Workbook.Worksheets[1];
                }

                //check if file has no data entered:
                if (worksheet.Dimension == null)
                {
                    throw new Exception(ErrText(23));
                }

                using (errorsResFile = parsingResultFile.CreateText())
                {
                    var start = worksheet.Dimension.Start;
                    var end = worksheet.Dimension.End;

                    // If file contains not 6 columns:
                    if ((end.Column - start.Column + 1) != 6)
                        throw new Exception(ErrText(3));

                    //Collection of unique EDRPUOs
                    Hashtable EDRPUOList = new Hashtable();
                    Regex intRegex = new Regex("^[0-9]+$");

                    // Read rows in Excel
                    // First in start.Row is Header row
                    for (int irow = start.Row + 1; irow <= end.Row; irow++)
                    {
                        try
                        {
                            //skip empty rows
                            if (!IsRowEmpty(worksheet, irow))
                            {
                                if (hasAllEmptyRows)
                                    hasAllEmptyRows = false;

                                LinkGroup lgroup = new LinkGroup();

                                //checking field EDRPUO:
                                string okpo = worksheet.Cells[irow, IOKRO].Text;
                                if (!IsCellEmpty(irow, okpo, EDRPUO_COLUMN_NAME , true))
                                {
                                    string digitString = IsCellANumberValue(irow, okpo, EDRPUO_COLUMN_NAME );
                                    if (digitString!="-1")
                                    {
                                        if (Convert.ToDecimal(digitString) == 0)
                                        {
                                            continue;   //we should skip records with EDRPUO = 0000..00 and go to process next row
                                        }
                                        else
                                        {
                                            if (IsStringLengthValid(irow, digitString, EDRPUO_COLUMN_NAME , MAXOKPOLENGTH))
                                            {
                                                lgroup.OKPO = digitString; //in case EDRPUO is in exp format
                                                                           //listing EDRPUO for searching duplicates on this field
                                                if (!EDRPUOList.Contains(okpo))
                                                {
                                                    EDRPUOList.Add(okpo, new List<int> { irow });
                                                }
                                                else
                                                    ((IList<int>)EDRPUOList[okpo]).Add(irow);
                                            }
                                        }
                                    }
                                }
                                
                                //checking Group number field:
                                string link_group = worksheet.Cells[irow, ILINK_GROUP].Text;
                                if (!IsCellEmpty(irow, link_group, LINKGROUP_COLUMN_NAME, true))
                                {
                                    string digitString = IsCellANumberValue(irow, link_group, LINKGROUP_COLUMN_NAME);
                                    if (digitString != "-1")
                                    {
                                        lgroup.Link_Group = Convert.ToDecimal(digitString);
                                    }
                                }

                                //checking field Conditional group name:
                                string groupName = worksheet.Cells[irow, IGROUPNAME].Text;
                                if (!IsCellEmpty(irow, groupName, GROUP_COLUMN_NAME, true))
                                {
                                    if(IsStringLengthValid(irow,groupName, GROUP_COLUMN_NAME, MAXGROUPNAMELENGTH))
                                        lgroup.GroupName = groupName;
                                }

                                //checking and filling KF field:
                                string kf = worksheet.Cells[irow, IKF].Text;
                                bool isKfEmpty = IsCellEmpty(irow, kf, string.Empty, false);
                                if (!isKfEmpty)
                                    if (IsStringLengthValid(irow, kf, KF_COLUMN_NAME, MAXKFLENGTH))
                                    {
                                        //checking that kf is integer number
                                        string digitString = IsCellANumberValue(irow, kf, KF_COLUMN_NAME);
                                        if (digitString != "-1")
                                        {
                                            //checking that current kf number is one of Oshadbank MFO's
                                            if (MFOList.Contains(digitString))
                                            {
                                                lgroup.KF = digitString;
                                            }
                                            else
                                                LogErrorToFile(irow, ErrText(13, kf));
                                        }
                                    }

                                //Checking RNK field
                                string rnk = worksheet.Cells[irow, IRNK].Text;
                                if (!IsCellEmpty(irow, rnk, string.Empty, false))
                                {
                                    string digitString = IsCellANumberValue(irow, rnk, RNK_COLUMN_NAME);
                                    if (digitString != "-1")
                                    {
                                        if (IsStringLengthValid(irow, rnk, RNK_COLUMN_NAME, MAXRNKLENGTH))
                                        {
                                            lgroup.RNK = digitString;
                                            if (!string.IsNullOrEmpty(lgroup.OKPO) && (rnk.Trim(' ') != lgroup.OKPO.Trim(' ')))
                                            {
                                                LogErrorToFile(irow, ErrText(16));
                                            }

                                            //checking that if RNK field is not empty then KF also should not be empty
                                            if (isKfEmpty)
                                            {
                                                LogErrorToFile(irow, ErrText(17));
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    //if only kf filled and rnk is empty = error, they must be filled together
                                    if (!isKfEmpty)
                                    {
                                        LogErrorToFile(irow, ErrText(21));
                                    }
                                }

                                if (!hasErrors)
                                    refList.Add(lgroup);
                            }
                        }
                        catch (Exception ex)
                        {
                            LogErrorToFile(irow, "Помилка: " + ex.Message);
                        }
                    }

                    foreach (var key in EDRPUOList.Keys)
                    {
                        IList<int> coll = (IList<int>)EDRPUOList[key];
                        if (coll.Count > 1)
                        {
                            if (!hasErrors)
                                hasErrors = true;
                            errorsResFile.WriteLine(ErrText(22, new string[] { String.Join(", ", coll.Select(irow => irow)), key.ToString() }));
                        }
                    }

                    if (hasAllEmptyRows)
                        throw new Exception(ErrText(23));
                    else
                        if (!hasErrors)
                    {
                        _repo.ClearLinkedGroups();
                        _repo.InsertLinkGroups(refList);
                    }
                }
            }
            return hasErrors;
        }

        //Checks if row has no values and should be skipped
        private bool IsRowEmpty(ExcelWorksheet worksheet, int irow)
        {
            var start = worksheet.Dimension.Start;
            var end = worksheet.Dimension.End;
            for (int icol = start.Column; icol <= end.Column; icol++)
                if (!String.IsNullOrEmpty(worksheet.Cells[irow, icol].Text))
                {
                    return false;
                }
            return true;
        }

        private bool IsCellEmpty(int irow, string cellValue, string columnName, bool isError)
        {
            bool result = string.IsNullOrEmpty(cellValue);
            if (result && isError)
            {
                LogErrorToFile(irow, ErrText(7, columnName));
            }
            return result;
        }

        private string IsCellANumberValue(int irow, string cellValue, string columnName)
        {
            Regex intRegex = new Regex("^[0-9]+$");

            if (intRegex.IsMatch(cellValue))
                return cellValue;
            else
            {
                LogErrorToFile(irow, ErrText(4, columnName));
                return "-1";
            }
        }

        private bool IsStringLengthValid(int irow, string cellValue, string columnName, int maxStringLength)
        {
            bool result = true;
            if (cellValue.Length > maxStringLength)
            {
                result = false;
                LogErrorToFile(irow, ErrText(5, new string[] { columnName, maxStringLength.ToString() }));
            }
            return result;
        }

        //we consider errorResFile already open for writing 
        //and that this method is used inside using(){} and try{} constructions
        private void LogErrorToFile(int rowNumber, string message)
        {
            if (!hasErrors)
                hasErrors = true;
            errorsResFile.WriteLine("Рядок " + rowNumber + ": " + message);
        }

        public String ErrText(int iErrorCode)
        {
            return errors[iErrorCode];
        }

        public String ErrText(int iErrorCode, string param)
        {
            string text = errors[iErrorCode];
            return text.Replace("{0}", param);
        }

        public String ErrText(int iErrorCode, string[] param)
        {
            string text = errors[iErrorCode];
            for (int i = 0; i < param.Length; i++)
            {
                text = text.Replace("{"+i+"}", param[i]);
            }
            return text;
        }
    }
}