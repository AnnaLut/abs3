namespace BarsWeb.Areas.Security.Models.Abstract
{
    public interface ISecurityModel
    {
        SecurityDbContext GetDbContext();
    }
}