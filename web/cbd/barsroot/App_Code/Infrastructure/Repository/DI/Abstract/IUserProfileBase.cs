using BarsWeb.Models;

namespace BarsWeb.Infrastructure.Repository.DI.Abstract
{
    public interface IUserProfileProvider
    {
        UserProfileBase Profile { get; set; }
        void Save();
    }

}