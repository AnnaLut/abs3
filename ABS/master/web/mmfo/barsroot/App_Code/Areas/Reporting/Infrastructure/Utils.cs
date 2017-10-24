using System.Collections.Generic;
using System.Text;
using BarsWeb.Areas.Reporting.Models;
using MvcContrib.Sorting;
using System.Linq;

namespace BarsWeb.Areas.Reporting.Infrastructure
{
    public class Utils
    {
        public string ConvertReportStructureToFields(IEnumerable<RepStructure> structure)
        {

            var fields = new StringBuilder("\"fields\":{");
            var columns = new StringBuilder("\"columns\":[");
            
            var counter = 0;
            decimal lastAtrnUumber = 0;
            foreach (var item in structure)
            {
                if (counter != 0)
                {
                    fields.Append(",");
                    columns.Append(",");
                }                   
                fields.Append("\"Column" + item.SEGMENT_NUMBER + "\":{\"type\":\"string\", \"length\":\"" + 2 + "\", \"value\":\"" + item.SEGMENT_RULE + "\"}");
                var title =  item.SEGMENT_NAME.Replace("\"","\\\"");
                columns.Append("{\"field\":\"Column" + item.SEGMENT_NUMBER + "\",\"title\":\"" + title.Replace("~", "<br>") + "\" }");
                counter ++;
            }

            if (counter != 0)
            {
                fields.Append(",");
                columns.Append(",");

                fields.Append("\"FIELD_CODE" + "\":{\"type\":\"string\", \"length\":\"" + 255 + "\", \"value\":\"" +
                              "FIELD_CODE" + "\"}");
                string title2 = "FIELD_CODE";
                columns.Append("{\"field\":\"FIELD_CODE" + "\",\"title\":\"" + title2.Replace("~", "<br>") + "\" }");

                fields.Append("}");
                columns.Append("]");

                var strBuilder = new StringBuilder("{");
                strBuilder.Append(fields);
                strBuilder.Append(",");
                strBuilder.Append(columns);

                strBuilder.Append("}");

                return strBuilder.ToString();
            }
            return "данні відсутні";
        }
        
        public string CreateReportQuery(string isCon, List<RepStructure> structure, string viewName = null, string fileFmt = null)
        {
            const string query = @"select 
                                        {0}
                                    from 
                                        (select 
                                            {1} 
                                        from 
                                            {2}
                                        where
                                            {4}
                                            REPORT_DATE = to_date(:p_REPORT_DATE,'dd/mm/yyyy')
                                            and KF = :p_KF
                                            and VERSION_ID = :p_VERSION_ID
                                        {3}
                                        )";
            const string columnsTemplate = "{0} as Column{1}";
            var columns = new StringBuilder("");
            var inerColumns = new StringBuilder("");
            var counter = 0;
            var view = isCon == "1" ? "V_BANKS_REPORT" : (string.IsNullOrEmpty(viewName) ? "V_NBUR_AGG_PROTOCOLS" : viewName);

            foreach (var item in structure)
            {
                if (counter != 0)
                {
                    columns.Append(",");
                    inerColumns.Append(",");
                }
                columns.Append(string.Format(@"Column{0} as ""Column{0}""",item.SEGMENT_NUMBER));
                inerColumns.Append(string.Format(columnsTemplate,item.SEGMENT_RULE,item.SEGMENT_NUMBER));
                counter ++;
            }
            
            if (string.IsNullOrEmpty(fileFmt) || fileFmt == "TXT")
            {
                columns.Append(",");
                inerColumns.Append(",");

                columns.Append("Column_FIELD_CODE as \"Column_FIELD_CODE\"");
                inerColumns.Append("FIELD_CODE as Column_FIELD_CODE");
            }            

            var orderFields = structure.Where(i => i.SORT_ATTRIBUTE != null)
                .Select(i => new RepStructure
                {
                    SORT_ATTRIBUTE = i.SORT_ATTRIBUTE,
                    FILE_CODE = i.FILE_CODE,
                    FILE_ID = i.FILE_ID,
                    KEY_ATTRIBUTE = i.KEY_ATTRIBUTE,
                    SCHEME_CODE = i.SCHEME_CODE,
                    SEGMENT_NAME = i.SEGMENT_NAME,
                    SEGMENT_NUMBER = i.SEGMENT_NUMBER,
                    SEGMENT_RULE = i.SEGMENT_RULE
                }).OrderBy(i => i.SORT_ATTRIBUTE).ToList();
            var orderString = new StringBuilder();
            if (orderFields.Count > 0)
            {
                orderString.Append(" order by ");
                var lastOrderField = orderFields.Last();
                foreach (var item in orderFields)
                {
                    orderString.Append(item.SEGMENT_RULE);
                    if (!item.Equals(lastOrderField))
                    {
                        orderString.Append(",");
                    }
                }
            }
            var result = string.Format(query, columns, inerColumns, view, orderString, 
                isCon != "1" && !string.IsNullOrEmpty(viewName) ? "" : "REPORT_CODE = :p_REPORT_CODE and");
            return result;
        }
    }
}
