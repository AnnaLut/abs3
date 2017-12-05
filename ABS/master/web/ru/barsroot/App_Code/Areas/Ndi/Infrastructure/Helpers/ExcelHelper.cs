using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for ExcelHelper
/// </summary>
public class ExcelHelper
{
    public ExcelHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static ExcelResulModel ExcelExport(string tableSemantic, GetDataResultInfo dataResult,List<ColumnMetaInfo> allColumnsInfo,
        ExcelDataModel excelDataModel, GridFilter[] filterParams)
    {
        List<string> values = excelDataModel.ColumnsVisible == null ? new List<string>() : excelDataModel.ColumnsVisible.Split(',').ToList();
        List<ColumnMetaInfo> allShowColumns = new List<ColumnMetaInfo>();
        // СКРЫТЬ НЕОТОБРАЖАЕМЫЕ КОЛОНКИ:
        foreach (var item in allColumnsInfo)
        {
            if (item.NOT_TO_SHOW != 1 && !values.Contains(item.COLNAME))
            {
                allShowColumns.Add(item);
            }
        }
        if (dataResult is ResultForExcel)
        {
            ResultForExcel excelResult = dataResult as ResultForExcel;
            if (excelResult.ExcelParam == "ALL_CSV")
                return ExcelExportToCSV('|', tableSemantic, dataResult, allShowColumns, excelDataModel.TableName);
        }
           
       
            
        var package = new ExcelPackage();
        MemoryStream result = new MemoryStream();
        try
        {
            ExcelWorksheet worksheet = package.Workbook.Worksheets.Add(tableSemantic);
            worksheet.Cells[1, 1].Value = tableSemantic;
           

            // добавим данные 
            const int dataStartsFromRow = 3;
            int curRow = dataStartsFromRow;
            int curCol;
            int startColumn = 1;
            bool hasFontPainter = true;
            bool hasBackgrouondPainter = true;

            foreach (var item in dataResult.DataRecords)
            {

                // заполнить значения всех столбцов строки
                curCol = 1;
                foreach (var colTitle in allShowColumns)
                {
                    worksheet.Cells[curRow, curCol++].Value = item[colTitle.COLNAME.ToUpper()];
                }
                //Array sheetArray = worksheet.Cells.Value as Array;
                if (hasFontPainter)
                {
                    // если форматирование не задано - для следующих строк не выполняем раскраску
                    hasFontPainter = ConditionalPainting.PaintFont(item, worksheet, curRow, allShowColumns);
                }
                if (hasBackgrouondPainter)
                {
                    // если форматирование не задано - для следующих строк не выполняем раскраску
                    hasBackgrouondPainter = ConditionalPainting.PaintBackground(item, worksheet, curRow, allShowColumns);
                }
                curRow++;

            }

            if(dataResult.TotalRecord != null && dataResult.TotalRecord.Count() > 0)
            {
                curRow++;
                worksheet.Cells[curRow, startColumn].Value = "Підсумок: ";
                foreach (var item in dataResult.TotalRecord)
                {

                    int currCol = allShowColumns.FindIndex(x => x.COLNAME == item.Key);
                    if (currCol == -1)
                        continue;
                        currCol = currCol + startColumn;
                    worksheet.Cells[curRow, currCol].Value = item.Value;
                }
            }
            

            //}

            bool hasData = curRow != dataStartsFromRow;
            // последняя строка на листе
            int lastRow = (hasData ? curRow : dataStartsFromRow) - 1;
            // формат границ таблицы
            using (var range = worksheet.Cells[2, 1, lastRow, allShowColumns.Count])
            {
                range.Style.Border.BorderAround(ExcelBorderStyle.Thin);
                range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                range.Style.Border.Right.Style = ExcelBorderStyle.Thin;
            }
            // формат заголовка
            using (var range = worksheet.Cells[2, 1, 2, allShowColumns.Count])
            {
                range.Style.Font.Bold = true;
                range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                range.Style.Fill.BackgroundColor.SetColor(Color.CadetBlue);
                range.Style.Border.BorderAround(ExcelBorderStyle.Thick);
                range.Style.WrapText = true;
            }

            if(dataResult.TotalRecord != null && dataResult.TotalRecord.Count() > 0)
            using (var range = worksheet.Cells[curRow, 1, curRow, allShowColumns.Count])
            {
                range.Style.Font.Bold = true;
                range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                range.Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                range.Style.Border.BorderAround(ExcelBorderStyle.Thick);
                range.Style.WrapText = true;
            }

                //Process Columns
                curCol = 1;
            foreach (var colTitle in allShowColumns)
            {
                string lineBreak = "" + (char)13 + (char)10;
                //Add the headers
                worksheet.Cells[2, curCol].RichText.Add(colTitle.SEMANTIC != null ? colTitle.SEMANTIC.Replace("~", lineBreak) : "");
                double widthInInches = 1.5;
                if (colTitle.SHOWWIDTH != null && colTitle.SHOWWIDTH.Value > 1)
                {
                    widthInInches = (double)colTitle.SHOWWIDTH.Value;
                }
                worksheet.Column(curCol).Width = widthInInches * 10;
                //Mark filtered and sorted columns --sorting not supported now in EPPlus
                if (filterParams != null &&
                   filterParams.Any(p => p.Field == colTitle.COLNAME))
                {
                    worksheet.Cells[2, curCol].Style.Font.Bold = true;
                    worksheet.Cells[2, curCol].Style.Font.Italic = true;
                }
                if (hasData)
                {
                    //Formatting columns
                    switch (colTitle.COLTYPE)
                    {
                        case "N":
                        case "B":
                            //worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                            //!String.IsNullOrEmpty(colTitle.SHOWFORMAT) ? colTitle.SHOWFORMAT : "#";
                            worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                           !String.IsNullOrEmpty(colTitle.SHOWFORMAT) &&
                           worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Value.ToString() != "0" ? colTitle.SHOWFORMAT : "@";
                            break;
                        case "D":
                            worksheet.Cells[dataStartsFromRow, curCol, lastRow, curCol].Style.Numberformat.Format =
                            !String.IsNullOrEmpty(colTitle.SHOWFORMAT) ? colTitle.SHOWFORMAT : @"dd/mm/yyyy";
                            break;
                    }
                }
                curCol++;
                //Debug.WriteLine(curCol.ToString());
            }
            // save our new workbook and we are done!                       
            package.SaveAs(result);
            ExcelResulModel excelResult = new ExcelResulModel();
            excelResult.FileName = string.IsNullOrEmpty(excelDataModel.TableName) ? "data.xlsx" : excelDataModel.TableName + "-data.xlsx";
            excelResult.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            excelResult.ContentResult = result.ToArray();
            return excelResult;
            //return result;
        }

        
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            package.Dispose();
            result.Dispose();
            package = null;
            result = null;
        }
    }

    public static ExcelResulModel ExcelExportToCSV(char columnSeparator, string tableSemantic, GetDataResultInfo resultInfo, List<ColumnMetaInfo> ColumnsInfo,
        string fileName)
    {
        IEnumerable<Dictionary<string, object>> dataRecords = resultInfo.DataRecords;
       Dictionary<string, int> headerLen = new Dictionary<string, int>();
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        Encoding windows = Encoding.GetEncoding("windows-1251");
        Encoding unicode = Encoding.Unicode;
        try
        {
        //sb.Append("sep=|");
        //foreach (Dictionary<string, object> rowData in dataRecords)
        //{
        //    foreach (KeyValuePair<string, object> r in rowData)
        //    {
        //        if (!headerLen.ContainsKey(r.Key)) { headerLen.Add(r.Key, r.Key.Length); }
        //        headerLen[r.Key] = Math.Max(headerLen[r.Key], r.Value.ToString().Length);
        //    }
        //}
        foreach (Dictionary<string, object> rowData in dataRecords)
        {
            System.Text.StringBuilder sbRow = new System.Text.StringBuilder();
          
         
            foreach (KeyValuePair<string, object> r in rowData)
            {
                string v = r.Value.ToString();
                var colInfo = ColumnsInfo.FirstOrDefault(x => x.COLNAME == r.Key);
                if (colInfo == null)
                    continue;
                //hack for A7 report
                if (colInfo.COLTYPE == "D")
                {
                        if(!string.IsNullOrEmpty(v))
                    v = ((DateTime)r.Value).ToString(string.IsNullOrEmpty(colInfo.SHOWFORMAT) ? "ddMMyyyy" : colInfo.SHOWFORMAT);
                }
                sbRow.Append(v);
                sbRow.Append(columnSeparator);
            }
            sbRow.Remove(sbRow.Length - 1, 1);  // remove last 'columnSeparator' symbol
            sbRow.AppendLine();

            sb.Append(sbRow);
        }

        
            // add file header
            System.Text.StringBuilder sbHeaders = new System.Text.StringBuilder();
            foreach (var colInfo in ColumnsInfo)
            {
                sbHeaders.Append(colInfo.SEMANTIC);
                sbHeaders.Append(columnSeparator);
            }
            sbHeaders.Remove(sbHeaders.Length - 1, 1);  // remove last 'columnSeparator' symbol
            sbHeaders.AppendLine();
            sb.Insert(0, sbHeaders);
            sb.Insert(0, "sep=" + columnSeparator + "\n");
        ExcelResulModel excelResult = new ExcelResulModel();
        excelResult.FileName = fileName + ".csv";
        excelResult.ContentType = "application/ms-excel";// "text/csv";

        byte[] unicodeBytes = unicode.GetBytes(sb.ToString());
        byte[] asciiBytes = Encoding.Convert(unicode, windows, unicodeBytes);
        //char[] asciiChars = new char[ascii.GetCharCount(asciiBytes, 0, asciiBytes.Length)];
        //ascii.GetChars(asciiBytes, 0, asciiBytes.Length, asciiChars, 0);
        //string resStr = new string(asciiChars);
        excelResult.ContentResult = asciiBytes;


        return excelResult;


        }
        catch (Exception e)
        {

            throw e;
        }
    }
}