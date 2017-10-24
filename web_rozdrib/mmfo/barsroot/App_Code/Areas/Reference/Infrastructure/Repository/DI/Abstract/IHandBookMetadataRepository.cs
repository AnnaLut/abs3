using System.Linq;
using BarsWeb.Areas.Reference.Models;

namespace BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract
{
    public interface IHandBookMetadataRepository
    {
        IQueryable<HandBook> GetHandBookList();
        HandBook GetHandBook(int id);
        HandBook GetHandBookByName(string name); 
        IQueryable<HandBookColumn> GetHandBookColumns(int handBookId);
    }
}
