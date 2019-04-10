using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Summary description for ExcelImporter
/// </summary>
public static class ExcelWorksheetExtension
{
    public static string[] GetHeaderColumns(this ExcelWorksheet sheet)
    {
        List<string> columnNames = new List<string>();
        foreach (var firstRowCell in sheet.Cells[sheet.Dimension.Start.Row, sheet.Dimension.Start.Column, 1, sheet.Dimension.End.Column])
            columnNames.Add(firstRowCell.Text);
        return columnNames.ToArray();
    }
}

public class ExcelImporter
{
    public ExcelImporter(OracleDbModel oraConnector)
    {
        this.connector = oraConnector;
        //resParams = new List<CallFuncRowParam>();
        colExcelSemantics = new List<string>();
        unicode = Encoding.Unicode;
        startxmlBytes = new List<byte>(unicode.GetBytes(xmlHeader));
        startRowBytges = new List<byte>(unicode.GetBytes(beginRow));
        endRowBytges = new List<byte>(unicode.GetBytes(endRow));
        startTagBytes = new List<byte>(unicode.GetBytes(startTag));
        startValueBytes = new List<byte>(unicode.GetBytes(startValue));
        endValueBytes = new List<byte>(unicode.GetBytes(endValue));
        endXmlBytes = new List<byte>(unicode.GetBytes(endXml));
    }
    public ExcelImporter()
        : this(null)
    {

    }

    private int dataStartsFromRow = 1;//по умолчани
    private int dataStartFromCol = 1;
    private int finishToRow;
    private int finishToCol;
    //private List<CallFuncRowParam> resParams;
    private List<string> colExcelSemantics;
    private Encoding unicode;
    private const string xmlHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><root><body>";
    private const string startTag = "<Column><Tag>";
    private const string startValue = "</Tag><Value>";
    private const string endValue = "</Value></Column>";
    private const string endXml = "</body></root>";

    private const string beginRow = "<Row>";
    private const string endRow = "</Row>";

    List<byte> resBytes = new List<byte>();
    private StringBuilder xmlStart = new StringBuilder();
    private List<byte> startxmlBytes;
    private List<byte> startRowBytges;
    private List<byte> endRowBytges;
    private List<byte> startTagBytes;
    private List<byte> startValueBytes;
    private List<byte> endValueBytes;
    private List<byte> endXmlBytes;

    //работаем с соединение с бд. Получаем и используем
    //Открываем и закрываем в вызывающих методах.
    private OracleDbModel connector;
    private string path;

    public string Path
    {
        get
        {
            if (string.IsNullOrEmpty(path))
                SetTempPath();
            return path;
        }

        set
        {
            path = value;
        }
    }


    /// <summary>
    /// Данные после парсина Excel. Удобно, но затратно по ресурсам.
    /// </summary>
    /// <param name="parsedFile"></param>
    /// <param name="func"></param>
    /// <returns></returns>
    public void WriteWholFilesByBites(HttpPostedFileBase parsedFile, CallFunctionMetaInfo func)
    {
        int curCol;
        using (ExcelPackage package = new ExcelPackage(parsedFile.InputStream))
        {
            ExcelWorksheet worksheet = package.Workbook.Worksheets[1];

            dataStartsFromRow = worksheet.Dimension.Start.Row;
            dataStartFromCol = worksheet.Dimension.Start.Column;
            finishToRow = worksheet.Dimension.End.Row;
            finishToCol = worksheet.Dimension.End.Column;

            StringBuilder xmlRes = new StringBuilder();
            worksheet = package.Workbook.Worksheets[1];
            var startFrom = worksheet.Dimension.Start;
            var finishTo = worksheet.Dimension.End;



            resBytes.AddRange(startxmlBytes);
            for (int irow = dataStartsFromRow; irow <= finishTo.Row; irow++)
            {
                resBytes.AddRange(startRowBytges);
                //  xmlRes.Append(beginRow);
                // Row rowFields = new Row();
                curCol = dataStartFromCol;
                for (int col = dataStartFromCol; col <= finishToCol; col++)
                {
                    //decimal? resPersent;
                    //if (item.ColNum == 9)
                    //    worksheet.Cells[irow, item.ColNum.Value].Style.Numberformat.Format = "###,##%";
                    ExcelRange resObject = worksheet.Cells[irow, col];
                    string res = worksheet.Cells[irow, col].Text ?? "";
                    string fullAdress = resObject.Address;
                    string colAdress = Regex.Replace(fullAdress, @"[\d-]", string.Empty);
                    //string resString = res.ToString();
                    //string format = worksheet.Cells[irow, item.ColNum.Value].Style.Numberformat.Format;
                    //if (!string.IsNullOrEmpty(format) && format.Contains('%') && !string.IsNullOrEmpty(resString))
                    //{
                    //    resPersent = (decimal)res ;
                    //    if (resPersent != null)
                    //        resPersent = resPersent * 100;
                    //    resString = resPersent.ToString() + '%';
                    //}
                    //else
                    //    resString = res.ToString();
                    resBytes.AddRange(startTagBytes);
                    resBytes.AddRange(unicode.GetBytes(colAdress));
                    resBytes.AddRange(startValueBytes);
                    resBytes.AddRange(unicode.GetBytes(res));
                    resBytes.AddRange(endValueBytes);

                }
                resBytes.AddRange(endRowBytges);
            }
            resBytes.AddRange(endXmlBytes);
            //int countBytes = resBytes.Length;
            connector.CommandClob.Write(resBytes.ToArray(), 0, resBytes.Count);


        }
    }


    public void ParsExcelAndWriteToClob(HttpPostedFileBase parsedFile, CallFunctionMetaInfo func)
    {
        Encoding unicode = Encoding.Unicode;
        List<ColumnMetaInfo> refList = new List<ColumnMetaInfo>();
        List<string> excelColSemanticList = new List<string>();
        int? semanticRow = func.MultiRowsParams.FirstOrDefault().SemanticRowNumber;
        dataStartsFromRow = semanticRow != null ? semanticRow.Value : 4;
        int curCol;



        using (ExcelPackage package = new ExcelPackage(parsedFile.InputStream))
        {
            ExcelWorksheet worksheet;

            StringBuilder xmlRes = new StringBuilder();
            worksheet = package.Workbook.Worksheets[1];
            bool emptyData = true;
            var startFrom = worksheet.Dimension.Start;
            var finishTo = worksheet.Dimension.End;
            bool semanticEmpty = IsRowEmpty(worksheet, dataStartsFromRow);
            List<string> colExcelSemantics = new List<string>();
            if (semanticEmpty)
                throw new Exception("рядок {0} з семантикою колонок - порожній");
            for (int col = dataStartFromCol; col <= finishTo.Column; col++)
            {
                object colSemantic = worksheet.Cells[dataStartsFromRow, col].Value ?? "";
                if (string.IsNullOrEmpty(colSemantic.ToString()))
                    break;
                colExcelSemantics.Add(colSemantic.ToString());
            }
            dataStartsFromRow++;
            if (colExcelSemantics.Count() == 0)
                throw new Exception("семантика в першому стовбці не заповнена");
            List<FieldProperties> SemanticFields = SqlStatementParamsParser.ParsConvertParams(func, colExcelSemantics);

            List<byte> resBytes = new List<byte>();
            StringBuilder xmlStart = new StringBuilder();

            resBytes.AddRange(startxmlBytes);
            for (int irow = dataStartsFromRow; irow <= finishTo.Row; irow++)
            {
                resBytes.AddRange(startRowBytges);
                //  xmlRes.Append(beginRow);
                // Row rowFields = new Row();
                curCol = dataStartFromCol;
                foreach (var item in SemanticFields)
                {
                    var objRes = worksheet.Cells[irow, item.ColNum.Value];
                    string res = string.IsNullOrEmpty(objRes.Text) ? "" : objRes.Text.ToString();
                    string format = worksheet.Cells[irow, item.ColNum.Value].Style.Numberformat.Format;
                    if (!string.IsNullOrEmpty(format) && format.Contains('#') && !string.IsNullOrEmpty(res))
                    {
                        double decRes = (double)objRes.Value;
                        res = decRes.ToString();
                    }
                    resBytes.AddRange(startTagBytes);
                    resBytes.AddRange(unicode.GetBytes(item.Value));
                    resBytes.AddRange(startValueBytes);
                    resBytes.AddRange(unicode.GetBytes(res));
                    resBytes.AddRange(endValueBytes);

                }
                resBytes.AddRange(endRowBytges);
            }
            resBytes.AddRange(endXmlBytes);
            connector.CommandClob.Write(resBytes.ToArray(), 0, resBytes.Count);
            resBytes = null;

        }
    }

    //public void WriteWholeFileToClob(HttpPostedFileBase parsedFile, CallFunctionMetaInfo func, StreamWriter sw)
    //{
    //    int curCol;
    //    using (ExcelPackage package = new ExcelPackage(parsedFile.InputStream))
    //    {
    //        ExcelWorksheet worksheet;

    //        worksheet = package.Workbook.Worksheets[1];
    //        dataStartsFromRow = worksheet.Dimension.Start.Row;
    //        dataStartFromCol = worksheet.Dimension.Start.Column;
    //        finishToRow = worksheet.Dimension.End.Row;
    //        finishToCol = worksheet.Dimension.End.Column;



    //        List<FieldProperties> SemanticFields = SqlStatementParamsParser.ParsConvertParams(func, colExcelSemantics);
    //        for (int irow = dataStartsFromRow; irow <= finishToRow; irow++)
    //        {
    //            sw.Write(beginRow);
    //            curCol = dataStartFromCol;
    //            for (int col = dataStartFromCol; col <= finishToCol; col++)
    //            {
    //                //decimal? resPersent;
    //                //if (item.ColNum == 9)
    //                //    worksheet.Cells[irow, item.ColNum.Value].Style.Numberformat.Format = "###,##%";
    //                ExcelRange resObject = worksheet.Cells[irow, col];
    //                string res = worksheet.Cells[irow, col].Text ?? "";
    //                string fullAdress = resObject.Address;
    //                string colAdress = Regex.Replace(fullAdress, @"[\d-]", string.Empty);
    //                WriteTag(sw, colAdress, res);
    //            }
    //            sw.Write(endRow);
    //        }
    //    }
    //    EndFileAndWrite(sw);
    //}
    private void SetTempPath()
    {
        Encoding windows = Encoding.GetEncoding("windows-1251");
        string fileName = "FileForExcel";
        string _tempDir = System.IO.Path.GetTempPath();
        string fileNameWithExt = "FileForExcell.txt";
        string dirPath = _tempDir + "__" + HttpContext.Current.Session.SessionID + "__" + fileName;
        CreateNewDirectoryAndFile(dirPath);
        Path = dirPath + "\\" + fileNameWithExt;
    }
    public void WriteExcelFileToClob(HttpPostedFileBase parsedFile, CallFunctionMetaInfo func, OracleDbModel connector)
    {
        this.connector = connector;
        //StreamWriter sw = GetStreamWriterToFile(Encoding.Unicode);
        var multiParam = func.MultiRowsParams.FirstOrDefault() as UploadExcelParams;

        if (multiParam != null && multiParam.ColNameGetFrom == "EXCEL_HEADERS")
        {
            // ParsExcelAndWriteToClob(parsedFile, func);
            WriteWholFilesByBites(parsedFile, func);
            return;
        }
        ParsExcelAndWriteToClob(parsedFile, func);


    }
    private void WriteTag(StreamWriter sw, string tag, string value)
    {
        sw.Write(startTag);
        sw.Write(tag);
        sw.Write(startValue);
        sw.Write(value);
        sw.Write(endValue);

    }
    private void EndFileAndWrite(StreamWriter sw)
    {
        sw.Write(endXml);
        sw.Close();
        sw.Dispose();
        sw = null;
        WriteToClobe();
    }

    /// <summary>
    /// вспомогательный метод. 
    /// </summary>
    private void WriteToClobe()
    {
        connector.ParmeterBytes = File.ReadAllBytes(Path);
        string result = System.Text.Encoding.UTF8.GetString(connector.ParmeterBytes);
        connector.CommandClob.Write(connector.ParmeterBytes, 0, connector.ParmeterBytes.Length);
    }
    public StreamWriter GetStreamWriterToFile(Encoding encoding)
    {
        return new StreamWriter(File.Open(Path, FileMode.Create), encoding);
    }
    public static void CreateNewDirectoryAndFile(string path)
    {
        if (!Directory.Exists(path))
            Directory.CreateDirectory(path);


    }
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
}
