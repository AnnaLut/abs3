using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using OfficeOpenXml;
using BarsWeb.Infrastructure.Extensions;

namespace BarsWeb.Infrastructure.Helpers
{
    public class ExcelHelpers<T> : IDisposable
    {
        ExcelPackage _package;
        private IEnumerable<T> _objects;
        public DataFormatModel dataFormat;
        public ExcelHelpers(IEnumerable<T> objects)
            : this(objects, null, false, null, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, string header)
            : this(objects, null, false, header, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, bool isAttributeName)
            : this(objects, null, isAttributeName, null, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, bool isAttributeName, string header)
            : this(objects, null, isAttributeName, header, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty)
            : this(objects, childrenProperty, false, null, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty, string header)
            : this(objects, childrenProperty, false, header, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty, bool isAttributeName)
            : this(objects, childrenProperty, isAttributeName, "", null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty, bool isAttributeName, string header)
            : this(objects, childrenProperty, isAttributeName, header, null)
        {

        }

        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty, bool isAttributeName, string header, DataFormatModel formatModel)
        {
            _objects = objects;
            _package = new ExcelPackage();
            this.dataFormat = formatModel;

            Create(childrenProperty, isAttributeName, header);
        }

        public ExcelHelpers(List<Dictionary<string, object>> objects, List<string[]> title, List<TableInfo> ti, string header)
        {
            _package = new ExcelPackage();

            AddWorksheetDict(objects, title, ti, "");
        }

        public ExcelHelpers(List<Dictionary<string, object>> objects, List<string[]> title, List<TableInfo> ti, string header, List<string> docHat, string query="")
        {
            _package = new ExcelPackage();

            AddWorksheetDict(objects, title, ti, "", docHat, query);
        }


        private void Create(Func<T, object> childrenProperty, bool isAttributeName, string header)
        {
            if (childrenProperty != null)
            {
                var groupedList = _objects
                    .GroupBy(childrenProperty)
                    .Select(grp => grp.ToList());
                //.OrderBy()
                //.ThenBy(g => g.Key.ProductId)
                //.ToList();
                foreach (List<T> item in groupedList.ToList())
                {
                    var list = item.ToList();
                    AddWorksheet(list, "", isAttributeName, header);
                }
            }
            else
            {
                AddWorksheet(_objects, "", isAttributeName, header);
            }



        }
        public int WorksheetCount()
        {
            return _package.Workbook.Worksheets.Count;
        }

        public void AddWorksheet(IEnumerable<T> objects, string name = "", bool isAttributeName = false, string header = "")
        {
            if (string.IsNullOrEmpty(name))
            {
                name = "worksheet" + WorksheetCount();
            }
            ExcelWorksheet worksheet = _package.Workbook.Worksheets.Add(name);
            bool setNumberFormat = dataFormat != null && !string.IsNullOrEmpty(dataFormat.NumberFormat);

            if (objects != null)
            {
                int row = 1;
                foreach (var item in objects)
                {
                    int col = 1;
                    // we have our total formula on row 7, so push them down so we can insert more data


                    var dict = item.ObjectToDictionary();

                    if (row == 1)
                    {
                        if (!string.IsNullOrEmpty(header))
                        {
                            worksheet.InsertRow(row, 1);
                            worksheet.Cells[row++, 1].Value = header;
                        }
                        int firstRowCol = 1;
                        worksheet.InsertRow(row, col);

                        var type = typeof(T);
                        var metadataType = type.GetCustomAttributes(typeof(MetadataTypeAttribute), true)
                                            .OfType<MetadataTypeAttribute>().FirstOrDefault();
                        var metaData = (metadataType != null)
                                ? ModelMetadataProviders.Current.GetMetadataForType(null, metadataType.MetadataClassType)
                                : ModelMetadataProviders.Current.GetMetadataForType(null, type);



                        foreach (var i in dict)
                        {
                            if (isAttributeName)
                            {
                                var propertyInfo = item.GetType().GetProperty(i.Key) ?? item.GetType().GetProperty(i.Key.Replace("-", "_"));

                                if (propertyInfo != null)
                                {

                                    var displayAttribute =
                                        (DisplayAttribute)
                                            Attribute.GetCustomAttribute(propertyInfo, typeof(DisplayAttribute));
                                    if (displayAttribute != null)
                                    {
                                        worksheet.Cells[row, firstRowCol++].Value = displayAttribute.Name;
                                    }
                                    else
                                    {
                                        worksheet.Cells[row, firstRowCol++].Value = i.Key;
                                    }
                                }
                                else
                                {
                                    worksheet.Cells[row, firstRowCol++].Value = i.Key;
                                }
                            }
                            else
                            {


                                worksheet.Cells[row, firstRowCol++].Value = i.Key;
                            }

                        }
                        row++;
                    }
                    worksheet.InsertRow(row, col);
                    if (setNumberFormat)
                    {
                        foreach (var i in dict)
                        {
                            worksheet.Cells[row, col].Value = i.Value;
                            var propertyInfo = item.GetType().GetProperty(i.Key) ?? item.GetType().GetProperty(i.Key.Replace("-", "_"));

                            bool isNumber = propertyInfo.PropertyType.Name == "Decimal" || (propertyInfo.PropertyType.GetGenericArguments().Length > 0 &&
                                    propertyInfo.PropertyType.GetGenericArguments()[0].Name == "Decimal");

                            if (isNumber == true)
                            {
                                if (i.Value == "")
                                    worksheet.Cells[row, col].Style.Numberformat.Format = "@";
                                else
                                    worksheet.Cells[row, col].Style.Numberformat.Format = dataFormat.NumberFormat;
                            }

                            col++;
                        }
                    }
                    else
                    {
                        foreach (var i in dict)
                            worksheet.Cells[row, col++].Value = i.Value;
                    }

                    row++;
                }
            }
        }

        public void AddWorksheetDict(List<Dictionary<string, object>> objects, List<string[]> title, List<TableInfo> ti, string name = "")
        {
            WorksheetDict(objects, title, ti, name, null);
        }

        public void AddWorksheetDict(List<Dictionary<string, object>> objects, List<string[]> title, List<TableInfo> ti, string name = "", List<string> headers = null, string query="")
        {
            WorksheetDict(objects, title, ti, name, headers, query);
        }

        void WorksheetDict(List<Dictionary<string, object>> objects, List<string[]> title, List<TableInfo> ti, string name = "", List<string> headers = null, string query="")
        {


            if (string.IsNullOrEmpty(name))
            {
                name = "worksheet" + WorksheetCount();
            }
            ExcelWorksheet worksheet = _package.Workbook.Worksheets.Add(name);

            // записываем шапку документа (не таблицы)
            int verticalOffset = 1;
            if (null != headers)
            {
                for (int i = 0; i < headers.Count; i++)
                {
                    worksheet.Cells[1 + i, 1].Value = headers[i];

                    verticalOffset++;
                }
            }

            if (objects != null)
            {
                for (int x = 0; x < title.Count; x++)
                {
                    worksheet.Cells[1 + verticalOffset, x + 1].Value = title[x][1];
                    worksheet.Cells[1 + verticalOffset, x + 1].Style.WrapText = true;
                    worksheet.Cells[1 + verticalOffset, x + 1].Style.Font.Bold = true;
                    worksheet.Cells[1 + verticalOffset, x + 1].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                    worksheet.Cells[1 + verticalOffset, x + 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                    worksheet.Cells[1 + verticalOffset, x + 1].Style.Border.BorderAround(OfficeOpenXml.Style.ExcelBorderStyle.Thin);
                }

                for (int i = 0; i < title.Count; i++)
                {
                    string columnType = string.Empty;
                    foreach (TableInfo tabInfo in ti)
                    {
                        if (tabInfo.ColumnName==title[i][0])
                        {
                            columnType = tabInfo.DataType;
                            break;
                        }
                    }

                    string columnFormat = string.Empty;

                    switch (columnType)
                    {
                        case "System.Decimal":
                            columnFormat = "";
                            break;
                        case "System.DateTime":
                            columnFormat= "dd.MM.yyyy";
                            break;
                        case "Money":
                            columnFormat= "#,##0.00";
                            break;
                        default:
                            break;
                    }

                    worksheet.Column(i + 1).Style.Numberformat.Format = columnFormat;
                }

                for (int y = 0; y < objects.Count(); y++)
                {
                    for (int x = 0; x < title.Count; x++)
                    {
                        object value = objects[y][title[x][0]];
                        worksheet.Cells[y + 1 + 1 + verticalOffset, x + 1].Value = value;
                        worksheet.Cells[y + 1 + 1 + verticalOffset, x + 1].Style.Border.BorderAround(OfficeOpenXml.Style.ExcelBorderStyle.Thin);
                    }
                }

                worksheet.Column(1).Width = 19.29;

                for (int i = 2; i <= title.Count; i++)
                {
                    
                    worksheet.Column(i).AutoFit();
                }
            }

            if (!string.IsNullOrWhiteSpace(query))
            {
                ExcelWorksheet worksheetQuery = _package.Workbook.Worksheets.Add("worksheet" + WorksheetCount());
                worksheetQuery.Cells[1, 1].Value = query;
                worksheetQuery.Hidden = eWorkSheetHidden.Hidden;
            }
        }


        public MemoryStream ExportToMemoryStream()
        {
            // создадим и наполним книгу Excel    
            // добавим новый лист в пустую книгу
            var result = new MemoryStream();
            _package.SaveAs(result);
            result.Position = 0;
            return result;
            //return CreateXls();
        }

        public void SaveAs(FileInfo fileInfo)
        {
            _package.SaveAs(fileInfo);
        }
        public void SaveAs(FileInfo fileInfo, string password)
        {
            _package.SaveAs(fileInfo, password);
        }

        public void Dispose()
        {
            _package.Dispose();
        }

        /*public MemoryStream CreateXls()
        {
            //create new xls file
            
            var workbook = new Workbook();
            var worksheet = new Worksheet("First Sheet");
            worksheet.Cells[0, 0] = new Cell((short)1);
            worksheet.Cells[1, 0] = new Cell((short)1);
            worksheet.Cells[2, 0] = new Cell(9999999);
            worksheet.Cells[3, 0] = new Cell((decimal)3.45);
            worksheet.Cells[4, 0] = new Cell("Text string");
            worksheet.Cells[5, 0] = new Cell("Second string");
            worksheet.Cells[6, 0] = new Cell(32764.5, "#,##0.00");
            worksheet.Cells[7, 0] = new Cell(DateTime.Now, @"YYYY\-MM\-DD");
            //worksheet.Cells.ColumnWidth[0, 1] = 3000;
            workbook.Worksheets.Add(worksheet);
            
            var result = new MemoryStream();
            workbook.Save(result);
            result.Position = 0;

            return result;

            /* // open xls file
            Workbook book = Workbook.Load(file);
            Worksheet sheet = book.Worksheets[0];

            // traverse cells
            foreach (Pair<Pair<int, int>, Cell> cell in sheet.Cells)
            {
                dgvCells[cell.Left.Right, cell.Left.Left].Value = cell.Right.Value;
            }

            // traverse rows by Index
            for (int rowIndex = sheet.Cells.FirstRowIndex;
                   rowIndex <= sheet.Cells.LastRowIndex; rowIndex++)
            {
                Row row = sheet.Cells.GetRow(rowIndex);
                for (int colIndex = row.FirstColIndex;
                   colIndex <= row.LastColIndex; colIndex++)
                {
                    Cell cell = row.GetCell(colIndex);
                }
            }* /
        }*/
    }
}



