using Areas.PRVN.Models;
using Bars.Classes;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.PRVN.Infrastructure.DI.Abstract;
using BarsWeb.Models;
using OfficeOpenXml;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;

namespace BarsWeb.Areas.PRVN.Infrastructure.DI.Implementation
{
    public class SrrCostRepository : ISrrCostRepository
    {
        readonly PRVNModel _PRVN;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public SrrCostRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _PRVN = new PRVNModel(EntitiesConnection.ConnectionString("PRVNModel", "PRVN"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        public List<InsertRowResult> UploadSrrCostFile(HttpPostedFile file)
        {
            List<InsertRowResult> errors = new List<InsertRowResult>();
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                List<SrrCostRow> parsedData = ParseExcelFile(file);

                DeleteOldRecords(con, parsedData);

                foreach (SrrCostRow row in parsedData)
                {
                    InsertRowResult tmpRes = InsertRow(row, con);
                    if (!string.IsNullOrWhiteSpace(tmpRes.ErrorText))
                        errors.Add(tmpRes);
                }
            }

            return errors;
        }

        #region parse and process file
        private Dictionary<string, int> cellsHeaders = new Dictionary<string, int>();

        private void DeleteOldRecords(OracleConnection con, List<SrrCostRow> newRecords)
        {
            List<SrrCostRow> distinct = newRecords.GroupBy(r => r.ID_BRANCH + r.ID_CALC_SET).Select(g => g.First()).ToList();

            using (OracleCommand cmd = con.CreateCommand())
            {
                foreach (SrrCostRow item in distinct)
                {
                    cmd.CommandText = "delete from bars.srr_xls where id_calc_set = :P_ID_CALC_SET and id_branch = :P_ID_BRANCH";

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new OracleParameter("P_ID_CALC_SET", OracleDbType.Decimal, item.ID_CALC_SET, ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("P_ID_BRANCH", OracleDbType.Varchar2, item.ID_BRANCH, ParameterDirection.Input));

                    cmd.ExecuteNonQuery();
                }
            }
        }

        private InsertRowResult InsertRow(SrrCostRow row, OracleConnection con)
        {
            try
            {
                CheckRowRequiredFields(row);

                string insertSql = "insert into bars.srr_xls ({0}) values ({1})";

                List<string> colNames = new List<string>();
                List<string> paramsNames = new List<string>();
                List<OracleParameter> paramsValues = new List<OracleParameter>();

                foreach (KeyValuePair<string, int> item in cellsHeaders)
                {
                    PropertyInfo prop = row.GetType().GetProperty(item.Key, BindingFlags.Public | BindingFlags.Instance);
                    object val = prop.GetValue(row, null);
                    if (null != val)
                    {
                        colNames.Add(prop.Name);
                        paramsNames.Add(":P_" + prop.Name);

                        paramsValues.Add(new OracleParameter("P_" + prop.Name, PropTypeToOracleDbType(prop), val, System.Data.ParameterDirection.Input));
                    }
                }

                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = string.Format(insertSql, string.Join(",", colNames), string.Join(",", paramsNames));
                    cmd.Parameters.AddRange(paramsValues.ToArray());
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            {
                return new InsertRowResult(row) { ErrorText = e.Message };
            }
            return new InsertRowResult();
        }

        private void CheckRowRequiredFields(SrrCostRow row)
        {
            List<string> emptyFields = new List<string>();

            if (0 == row.ID_CALC_SET) emptyFields.Add("ID_CALC_SET");
            if (string.IsNullOrWhiteSpace(row.UNIQUE_BARS_IS)) emptyFields.Add("UNIQUE_BARS_IS");

            if (string.IsNullOrWhiteSpace(row.ID_BRANCH)) emptyFields.Add("ID_BRANCH");
            if (string.IsNullOrWhiteSpace(row.ID_CURRENCY)) emptyFields.Add("ID_BRANCH");
            if (emptyFields.Count > 0) throw new ArgumentException("Не заповнено обов'язкові поля : " + string.Join(" , ", emptyFields));
        }

        private OracleDbType PropTypeToOracleDbType(PropertyInfo prop)
        {
            TypeCode typeCode = Type.GetTypeCode(prop.PropertyType);
            switch (typeCode)
            {
                case TypeCode.Int32: return OracleDbType.Decimal;
                case TypeCode.Int64: return OracleDbType.Decimal;
                case TypeCode.String: return OracleDbType.Varchar2;
                case TypeCode.Decimal: return OracleDbType.Decimal;
                case TypeCode.Double: return OracleDbType.Decimal;
                case TypeCode.DateTime: return OracleDbType.Date;
                default: return OracleDbType.Varchar2;
            }
        }
        private bool IsCellInRow(string cellAdress, int rowNumber)
        {
            int num = Convert.ToInt32(new String(cellAdress.Where(Char.IsDigit).ToArray()));

            return num == rowNumber;
        }
        public List<SrrCostRow> ParseExcelFile(HttpPostedFile file)
        {
            List<SrrCostRow> result = new List<SrrCostRow>();

            using (ExcelPackage package = new ExcelPackage(file.InputStream))
            {
                OfficeOpenXml.ExcelWorksheet worksheet;
                // below is workaround on known issue: https://epplus.codeplex.com/workitem/14779 
                // issue causes Exception while accessing cell by address if header column has spesific filtering, sorting or other additional settings added
                // exception is raised only on first call of package.Workbook
                try { worksheet = package.Workbook.Worksheets[1]; }
                catch { worksheet = package.Workbook.Worksheets[1]; }

                //check if file has no data entered:
                if (worksheet.Dimension == null)
                    throw new Exception("Файл не містить жодного запису!");

                var start = worksheet.Dimension.Start;
                var end = worksheet.Dimension.End;

                cellsHeaders = GetHeaders(worksheet);
                for (int irow = start.Row + 1; irow <= end.Row; irow++)
                {
                    if (IsRowEmpty(worksheet, irow)) continue;

                    SrrCostRow obj = new SrrCostRow();
                    foreach (KeyValuePair<string, int> item in cellsHeaders)
                    {
                        PropertyInfo prop = obj.GetType().GetProperty(item.Key, BindingFlags.Public | BindingFlags.Instance);

                        ExcelRange cell = worksheet.Cells[irow, item.Value];
                        object val = worksheet.Cells[irow, item.Value].Value;

                        if (null != val)
                        {
                            System.TypeCode typeCode = Type.GetTypeCode(prop.PropertyType);
                            switch (typeCode)
                            {
                                case TypeCode.Int32:
                                    prop.SetValue(obj, Convert.ToInt32(val), null);
                                    break;
                                case TypeCode.Int64:
                                    prop.SetValue(obj, Convert.ToInt64(val), null);
                                    break;
                                case TypeCode.String:
                                    prop.SetValue(obj, Convert.ToString(val), null);
                                    break;
                                case TypeCode.Decimal:
                                    prop.SetValue(obj, Convert.ToDecimal(val), null);
                                    break;
                                case TypeCode.Double:
                                    prop.SetValue(obj, Convert.ToDouble(val), null);
                                    break;
                                case TypeCode.DateTime:
                                    prop.SetValue(obj, Convert.ToDateTime(val), null);
                                    break;
                                default:
                                    prop.SetValue(obj, val, null);
                                    break;
                            }
                        }
                    }
                    result.Add(obj);
                }
            }
            return result;
        }

        private Dictionary<string, int> GetHeaders(ExcelWorksheet worksheet)
        {
            Dictionary<string, int> res = new Dictionary<string, int>();
            int index = 1;
            foreach (ExcelRangeBase cell in worksheet.Cells)
            {
                if (IsCellInRow(cell.Address, 1))
                {
                    res.Add(cell.Text, index);
                    index++;
                }
                else break;
            }
            return res;
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
        #endregion
    }
}
