using System.Collections.Generic;
using System.Text;
using BarsWeb.Areas.Reporting.Models;

namespace BarsWeb.Areas.Reporting.Infrastructure
{
    public class Utils
    {
        public string ConvertReportStructureToFields(IEnumerable<ReportStructure> structure)
        {

            var fields = new StringBuilder("\"fields\":{");
            var columns = new StringBuilder("\"columns\":[");

            var counter = 0;
            foreach (var item in structure)
            {
                if (counter != 0)
                {
                    fields.Append(",");
                    columns.Append(",");
                }
                fields.Append("\"Column" + item.AttrNum + "\":{\"type\":\"string\"}");
                var title =  item.AttrName.Replace("\"","\\\"");
                columns.Append("{\"field\":\"Column" + item.AttrNum + "\",\"title\":\"" + title.Replace("~","<br>") + "\" }");
                counter ++;
            }
            fields.Append("}");
            columns.Append("]");

            var strBuilder = new StringBuilder("{");
            strBuilder.Append(fields);
            strBuilder.Append(",");
            strBuilder.Append(columns);

            strBuilder.Append("}");
            return strBuilder.ToString();
        }

        public string CreateReportQuery(string kod, string date, IEnumerable<ReportStructure> structure)
        {
            const string query = @"select 
                                        {0}
                                    from 
                                        (select 
                                            {1} 
                                        from 
                                            tmp_nbu
                                        where
                                            kodf = '{2}'
                                            and datf = to_date('{3}','dd/mm/yyyy')
                                        )";
            const string columnsTemplate = "{0} as Column{1}";
            var columns = new StringBuilder("");
            var inerColumns = new StringBuilder("");
            var counter = 0;
            foreach (var item in structure)
            {
                if (counter != 0)
                {
                    columns.Append(",");
                    inerColumns.Append(",");
                }
                columns.Append(string.Format(@"Column{0} as ""Column{0}""",item.AttrNum));
                inerColumns.Append(string.Format(columnsTemplate,item.Value,item.AttrNum));
                counter ++;
            }
            return string.Format(query,columns,inerColumns,kod,date);
        }
    }
}
