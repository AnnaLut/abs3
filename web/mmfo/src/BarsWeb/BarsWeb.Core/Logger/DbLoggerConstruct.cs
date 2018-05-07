using BarsWeb.Core.Infrastructure.Repository;

namespace BarsWeb.Core.Logger
{
    public static class DbLoggerConstruct
    {
        public static IDbLogger NewDbLogger()
        {
            var coreModel = new CoreModel();
            return new DbLogger(coreModel, new UserInfoRepository(coreModel));
        }
    }
}