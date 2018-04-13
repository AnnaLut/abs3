using System.Collections.Generic;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Reference.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Reference.Models;

namespace BarsWeb.Areas.Reference.Infrastructure.DI.Implamentation
{
    public class Utils : IUtils
    {
        public WebGrid MetadataToWebGrid(HandBook metadata, string[] columns = null)
        {
            if (metadata == null)
            {
                return new WebGrid();
            }
            var webGrid = new WebGrid
            {
                Id = metadata.Id,
                Name = metadata.Name,
                Semantic = metadata.Semantic,
                IsRelation = metadata.IsRelation
            };
            var field = new Dictionary<string, object>();
            var columnsList = new List<WebGridColumn>();
            foreach (var item in metadata.Columns.Where(r => r.IsShowInRow))
            {
                if (columns == null || columns.Contains(item.Name.ToUpper()))
                {
                    field.Add(item.Name, new {type = MetadataTypeToFieldType(item.Type)});
                    columnsList.Add(new WebGridColumn
                    {
                        field = item.Name,
                        title = item.Semantic.Replace("~", "<br>"),
                        template = string.Format("<div title=\"#= {0} #\"><nobr>#={0}#</nobr></div>", item.Name),
                        filterable = true,
                        sortable = true,
                        headerTemplate = string.Format("<div title=\"{0}\">{1}</div>",
                            item.Semantic.Replace("~", " "),
                            item.Semantic.Replace("~", "<br>"))
                    });
                }

            }
            webGrid.Fields = field;
            webGrid.Columns = columnsList;
            return webGrid;
        }

        public string GetHandBookQuery(HandBook metadata, string clause)
        {
            if (string.IsNullOrEmpty(clause) || clause.ToLower() == "null")
            {
                clause = "";
            }
            if (!string.IsNullOrEmpty(clause) &&  !clause.Trim().ToLower().StartsWith("where"))
            {
                clause = " where " + clause;
            }
            const string query = @"select 
                                        {0} 
                                    from 
                                        {1} 
                                    {2}";
            var columns = new StringBuilder("");
            var counter = 0;
            foreach (var item in metadata.Columns)
            {
                if (counter != 0)
                {
                    columns.Append(",");
                }
                if (item.IsShowRetVal)
                {
                    columns.Append(item.Name + " as \"PrimaryKeyColumn\",");
                }
                if (item.IsSemantic)
                {
                    columns.Append(item.Name + " as \"SemanticColumn\",");
                }
                columns.Append(item.Name);
                counter ++;
            }

            return string.Format(query, columns, metadata.Name, clause);
        }
        string MetadataTypeToFieldType(string type)
        {
            var result = "";
            switch (type)
            {
                case "N":
                case "E":
                    result = "number";
                    break;
                case "C":
                case "A":
                    result = "string";
                    break;
                case "D":
                    result = "date";
                    break;
                case "B":
                    result = "bool";
                    break;
            }
            return result;
        }
    }
}