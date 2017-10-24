using BarsWeb.Areas.Reference.Models;

namespace BarsWeb.Areas.Reference.Infrastructure.DI.Abstract
{
    public interface IUtils
    {
        WebGrid MetadataToWebGrid(HandBook metadata,string[] columns = null);
        string GetHandBookQuery(HandBook metadata, string clause);
    }
}
