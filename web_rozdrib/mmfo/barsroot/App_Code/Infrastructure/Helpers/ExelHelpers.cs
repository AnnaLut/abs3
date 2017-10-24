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
        public ExcelHelpers(IEnumerable<T> objects)
            : this(objects, null, false, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, string header)
            : this(objects, null, false, header)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, bool isAttributeName)
            : this(objects, null, isAttributeName, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, bool isAttributeName, string header)
            : this(objects, null, isAttributeName, header)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty)
            : this(objects, childrenProperty, false, null)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty, string header)
            : this(objects, childrenProperty, false, header)
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty, bool isAttributeName)
            : this(objects, childrenProperty, isAttributeName, "")
        {
        }
        public ExcelHelpers(IEnumerable<T> objects, Func<T, object> childrenProperty, bool isAttributeName, string header)
        {
            _objects = objects;
            _package = new ExcelPackage();

            Create(childrenProperty, isAttributeName, header);
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
                                var propertyInfo = item.GetType().GetProperty(i.Key) ?? item.GetType().GetProperty(i.Key.Replace("-","_"));
                                if (propertyInfo != null)
                                {
                                    var displayAttribute =
                                        (DisplayAttribute)
                                            Attribute.GetCustomAttribute(propertyInfo, typeof (DisplayAttribute));
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
                        row ++;
                    }
                    worksheet.InsertRow(row, col);
                    foreach (var i in dict)
                    {
                        worksheet.Cells[row, col++].Value = i.Value;
                    }
                    row++;
                }
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

