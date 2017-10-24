using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepDirectionRepository
    {
        void SetDirection(DataSourceRequest request, string answer);
    }
}