using System.Data;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract
{
    public interface IHandBookRepository
    {
        //List<HandBookData> GetBookData(string tableName, string clause);
        DataSet GetHandBookData(string tableName, string clause, DataSourceRequest request);
        int GetHandBookDataCount(string tableName, string clause, DataSourceRequest request);
    }
}
