using System.Linq;
using BarsWeb.Core.Models;

namespace BarsWeb.Core.Infrastructure.Repository
{
    public class UserInfoRepository : IUserInfoRepository
    {
        private readonly CoreDbContext _coreContext;
        public UserInfoRepository(ICoreModel coreModel)
        {
            _coreContext = coreModel.GetDbContext();
        }

        public IQueryable<UserInfo> GetAllUserInfo()
        {
            return _coreContext.UserInfos;
        }

        public UserInfo GetUserInfo(string userLogin)
        {
            return _coreContext.UserInfos.FirstOrDefault(i=>i.Login == userLogin);
        }

        public UserInfo GetUserInfo(decimal userId)
        {
            return _coreContext.UserInfos.FirstOrDefault(i => i.Id == userId);
        }
    }

    public interface IUserInfoRepository
    {
        IQueryable<UserInfo> GetAllUserInfo();
        UserInfo GetUserInfo(string userLogin);
        UserInfo GetUserInfo(decimal userId);
    }
}