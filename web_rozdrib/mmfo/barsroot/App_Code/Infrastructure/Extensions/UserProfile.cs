using System.Web;
using System.Web.Profile;

namespace BarsWeb.Infrastructure.Extensions
{
    /// <summary>
    /// Summary description for UserProfile
    /// </summary>
    public abstract class UserProfileProvider : ProfileProvider
    {
        public UserProfileProvider()
        {
            var profile = new ProfileBase();
        }

        public void Save()
        {
            //base..Save();
        }
    }

}
