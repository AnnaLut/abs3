using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.SelectModels;
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
namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers
{
    public class ExcelHelper
    {
        public ExcelHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static ExcelResulModel ExcelExport(string tableSemantic, GetDataResultInfo dataResult, List<ColumnMetaInfo> allColumnsInfo,
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

                if (dataResult.TotalRecord != null && dataResult.TotalRecord.Count() > 0)
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

                if (dataResult.TotalRecord != null && dataResult.TotalRecord.Count() > 0)
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
            StringBuilder sb = new StringBuilder();
            Encoding windows = Encoding.GetEncoding("windows-1251");
            Encoding unicode = Encoding.Unicode;
            byte[] unicodeBytes;
            byte[] asciiBytes;
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
                    string v = string.Empty;
                    foreach (var colInfo in ColumnsInfo)
                    {
                        object o = rowData[colInfo.COLNAME];
                        if (o != null)
                        {
                             v = o.ToString();
                            if (colInfo == null)
                                continue;
                            //hack for A7 report
                            if (colInfo.COLTYPE == "D")
                            {
                                if (!string.IsNullOrEmpty(v))
                                    v = ((DateTime)o).ToString(string.IsNullOrEmpty(colInfo.SHOWFORMAT) ? "ddMMyyyy" : colInfo.SHOWFORMAT);
                            }
                            sbRow.Append(v);
                        }
                        else
                            sbRow.Append("");
                        sbRow.Append(columnSeparator);
                    }
                    //foreach (KeyValuePair<string, object> r in rowData)
                    //{

                    //    string v = r.Value.ToString();
                    //    var colInfo = ColumnsInfo.FirstOrDefault(x => x.COLNAME == r.Key);
                    //    if (colInfo == null)
                    //        continue;
                    //    //hack for A7 report
                    //    if (colInfo.COLTYPE == "D")
                    //    {
                    //        if (!string.IsNullOrEmpty(v))
                    //            v = ((DateTime)r.Value).ToString(string.IsNullOrEmpty(colInfo.SHOWFORMAT) ? "ddMMyyyy" : colInfo.SHOWFORMAT);
                    //    }
                    //    sbRow.Append(v);
                    //    sbRow.Append(columnSeparator);
                    //}
                    sbRow.Remove(sbRow.Length - 1, 1);  // remove last 'columnSeparator' symbol
                    sbRow.AppendLine();

                    sb.Append(sbRow);
                }
                string lineBreak = "" + (char)13 + (char)10;
               

                // add file header
                StringBuilder sbHeaders = new StringBuilder();
                foreach (var colInfo in ColumnsInfo)
                {
                    sbHeaders.Append(colInfo.SEMANTIC != null ? colInfo.SEMANTIC.Replace("~", " ") : "");
                    sbHeaders.Append(columnSeparator);
                }
                sbHeaders.Remove(sbHeaders.Length - 1, 1);  // remove last 'columnSeparator' symbol
                sbHeaders.AppendLine();
                sb.Insert(0, sbHeaders);
                sb.Insert(0, "sep=" + columnSeparator + "\n");
                ExcelResulModel excelResult = new ExcelResulModel();
                excelResult.FileName = fileName + ".csv";
                excelResult.ContentType = "application/ms-excel";// "text/csv";

                unicodeBytes = unicode.GetBytes(sb.ToString());
                asciiBytes = Encoding.Convert(unicode, windows, unicodeBytes);
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
            finally
            {
                asciiBytes = null;
                unicodeBytes = null;

            }
        }

        public List<CallFuncRowParam>  ParseExcelFile(HttpPostedFileBase parsedFile, CallFunctionMetaInfo func)
        {
            List<CallFuncRowParam> resParams = new List<CallFuncRowParam>();
            List<ColumnMetaInfo> refList = new List<ColumnMetaInfo>();
            List<string> excelColSemanticList = new List<string>();
            int dataStartsFromRow = 4;
            int dataStartFromCol = 1;
            int curCol;
            using (ExcelPackage package = new ExcelPackage(parsedFile.InputStream))
            {
                ExcelWorksheet worksheet;
                try
                {
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
                    for (int irow = dataStartsFromRow; irow <= finishTo.Row; irow++)
                    {
                        List<FieldProperties> rowFields = new List<FieldProperties>();
                        curCol = dataStartFromCol;
                        foreach (var item in SemanticFields)
                        {
                            //decimal? resPersent;
                            //if (item.ColNum == 9)
                            //    worksheet.Cells[irow, item.ColNum.Value].Style.Numberformat.Format = "###,##%";
                            string res = worksheet.Cells[irow, item.ColNum.Value].Text ?? "";
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

                              
                            rowFields.Add(new FieldProperties() { Name = item.Value, Value = res });
                        }
                        resParams.Add(new CallFuncRowParam() { RowIndex = irow, RowParams = rowFields });




                    }
                   
                    return resParams;
                }
                catch(Exception ex)
                {
                    throw ex;
                }



            }
        }

        public void ParsExcelAndWriteToClob(HttpPostedFileBase parsedFile, CallFunctionMetaInfo func, Oracle.DataAccess.Types.OracleClob clob)
        {
            Encoding unicode = Encoding.Unicode;
            byte[] unicodeBytes;
            byte[] asciiBytes;
            List<ColumnMetaInfo> refList = new List<ColumnMetaInfo>();
            List<string> excelColSemanticList = new List<string>();
            int dataStartsFromRow = 4;
            int dataStartFromCol = 1;
            int curCol;

            
            
            using (ExcelPackage package = new ExcelPackage(parsedFile.InputStream))
            {
                ExcelWorksheet worksheet;
                try
                {
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
                    string beginRow = "<Row>";
                    string endRow = "</Row>";
                    List<byte> resBytes = new List<byte>();
                    Models.Column columnPars = new Models.Column();
                    StringBuilder xmlStart = new StringBuilder();
                    List<byte> startxmlBytes = new List<byte>( unicode.GetBytes("<?xml version=\"1.0\" encoding=\"UTF-8\"?><root><body>"));
                    List<byte> startRowBytges = new List<byte>(unicode.GetBytes(beginRow));
                    List<byte> endRowBytges = new List<byte>(unicode.GetBytes(endRow));
                    List<byte> startTagBytes = new List<byte>(unicode.GetBytes("<Column><Tag>"));
                    List<byte> startValueBytes = new List<byte>(unicode.GetBytes("</Tag><Value>"));
                    List<byte> endValueBytes = new List<byte>(unicode.GetBytes("</Value></Column>"));
                    List<byte> endXmlBytes = new List<byte>(unicode.GetBytes("</body></root>"));
                    resBytes.AddRange(startxmlBytes);
                    for (int irow = dataStartsFromRow; irow <= finishTo.Row; irow++)
                    {
                        resBytes.AddRange(startRowBytges);
                        //  xmlRes.Append(beginRow);
                        // Row rowFields = new Row();
                        curCol = dataStartFromCol;
                        foreach (var item in SemanticFields)
                        {
                            //decimal? resPersent;
                            //if (item.ColNum == 9)
                            //    worksheet.Cells[irow, item.ColNum.Value].Style.Numberformat.Format = "###,##%";
                            string res = worksheet.Cells[irow, item.ColNum.Value].Text ?? "";
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
                            resBytes.AddRange(unicode.GetBytes(item.Value));
                            resBytes.AddRange(startValueBytes);
                            resBytes.AddRange(unicode.GetBytes(res));
                            resBytes.AddRange(endValueBytes);
                           
                        }
                       resBytes.AddRange(endRowBytges);
                        //xmlRes.Append(endRow);
                        //if(irow % 10000 == 0)
                        //{
                        //     rowBytes.AddRange(unicode.GetBytes(xmlRes.);

                        //    xmlRes.Clear();
                        //}




                    }
                    //xmlRes.Append("</body></root>");
                    resBytes.AddRange(endXmlBytes);
                    //resBytes = unicode.GetBytes(xmlRes.ToString());
                    //int countBytes = resBytes.Length;
                    clob.Write(resBytes.ToArray(), 0, resBytes.Count);
                    resBytes = null;

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public void GetExcelResByBytes(HttpPostedFileBase parsedFile, CallFunctionMetaInfo func, OracleDbModel connector)
        {
            Encoding windows = Encoding.GetEncoding("windows-1251");
            string fileName = "FileForExcel";
            string _tempDir = Path.GetTempPath();
            string fileNameWithExt = "FileForExcell.txt";
            string dirPath = _tempDir + "__" + HttpContext.Current.Session.SessionID + "__" + fileName;
            CreateNewDirectoryAndFile(dirPath);
            string path = dirPath + "\\" + fileNameWithExt;
            StreamWriter sw = GetStreamWriterToFile(path, Encoding.Unicode);
            Encoding unicode = Encoding.Unicode;
            byte[] unicodeBytes;
            byte[] asciiBytes;
            List<ColumnMetaInfo> refList = new List<ColumnMetaInfo>();
            List<string> excelColSemanticList = new List<string>();
            int dataStartsFromRow = 4;
            int dataStartFromCol = 1;
            int curCol;



            using (ExcelPackage package = new ExcelPackage(parsedFile.InputStream))
            {
                ExcelWorksheet worksheet;
                try
                {
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
                    string beginRow = "<Row>";
                    string endRow = "</Row>";
                    byte[] resBytes;
                    Models.Column columnPars = new Models.Column();
                    StringBuilder xmlStart = new StringBuilder();
                    string xmlHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><root><body>";
                    string startTag = "<Column><Tag>";
                    string startValue = "</Tag><Value>";
                    string endValue = "</Value></Column>";
                    string endXml = "</body></root>";
                    sw.Write(xmlHeader);
                    
                    for (int irow = dataStartsFromRow; irow <= finishTo.Row; irow++)
                    {
                        sw.Write(beginRow);
                        //  xmlRes.Append(beginRow);
                        // Row rowFields = new Row();
                        curCol = dataStartFromCol;
                        foreach (var item in SemanticFields)
                        {
                            //decimal? resPersent;
                            //if (item.ColNum == 9)
                            //    worksheet.Cells[irow, item.ColNum.Value].Style.Numberformat.Format = "###,##%";
                            string res = worksheet.Cells[irow, item.ColNum.Value].Text ?? "";
                            var objRes = worksheet.Cells[irow, item.ColNum.Value];
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
                            sw.Write(startTag);
                            sw.Write(item.Value);
                            sw.Write(startValue);
                            sw.Write(res);
                            sw.Write(endValue);

                        }
                        sw.Write(endRow);
                        //xmlRes.Append(endRow);
                        //if(irow % 10000 == 0)
                        //{
                        //     rowBytes.AddRange(unicode.GetBytes(xmlRes.);

                        //    xmlRes.Clear();
                        //}




                    }
                    //xmlRes.Append("</body></root>");
                    sw.Write(endXml);
                    sw.Close();
                    sw.Dispose();
                    sw = null;
                    connector.ParmeterBytes = File.ReadAllBytes(path);
                    //resBytes = unicode.GetBytes(xmlRes.ToString());
                    //int countBytes = resBytes.Length;
                    connector.CommandClob.Write(connector.ParmeterBytes, 0, connector.ParmeterBytes.Length);
                   

                }
                finally
                {
                    if (sw != null)
                    {
                        sw.Close();
                        sw.Dispose();
                        sw = null;
                    }
                    File.Delete(path);
                }
                

            }
        }
        public static StreamWriter GetStreamWriterToFile(string path, Encoding encoding)
        {
            return new StreamWriter(File.Open(path, FileMode.Create), encoding);
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
}