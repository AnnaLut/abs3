using System;
using System.Data;
using System.Web;
using System.Web.Profile;
using Bars.Oracle;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;

namespace BarsWeb.Infrastructure.Repository.DI.Implementation
{
   
    public class UserProfileProvider : IUserProfileProvider
    {
        private ProfileBase _aspnetProfile
        {
            get
            {
                return HttpContext.Current.Profile;
            }
        }

        public UserProfileBase Profile
        {
            get
            {
                var session = HttpContext.Current.Session;
                if (session["UserProfileBase"] == null)
                {
                    session["UserProfileBase"] = new UserProfileBase();/* GetUserProfileFromBase(HttpContext.Current.User.Identity.Name);*/
                }
                return (UserProfileBase)session["UserProfileBase"];
            }
            set
            {
                _aspnetProfile.SetPropertyValue("UserProfileBase", value);
            }
        }

        public UserProfileBase GetProfile()
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                throw new System.Security.Authentication.AuthenticationException("The user is not logged in");
            }
            return Profile;
        }
        public UserProfileBase GetProfile(string userName)
        {
            return GetUserProfileFromBase(userName);
        }
        private UserProfileBase GetUserProfileFromBase(string userName)
        {
            //var conn = new OracleConnection(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString());
            var connection = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleConnection conn = connection.GetUserConnection(HttpContext.Current);

            var command = conn.CreateCommand();
            command.Parameters.Add("p_username", OracleDbType.Varchar2, userName, ParameterDirection.Input);
            const string sql = @"select 
                                        w.username,
                                        w.profile,
                                        w.lastupdateddate,
                                        w.lastactivitydate
                                from 
                                        web_userprofile w 
                                where 
                                        lower(username) = lower(:p_username)";
            command.CommandText = sql;
            UserProfileBase profile = null;
            try
            {
                if (conn.State== ConnectionState.Closed) conn.Open();
                var reader = command.ExecuteReader();
                if (reader.Read())
                {
                    var profileBase = Convert.ToString(reader["profile"]) ;
                    profile = JsonConvert.DeserializeObject<UserProfileBase>(profileBase);
                }
            }
            finally
            {
                command.Dispose();
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
            return profile ?? new UserProfileBase();
        }

        public void Save()
        {
            HttpContext.Current.Profile.Save();
        }
    }

    public class ProfileCommon : ProfileBase
    {
        private ProfileBase _profile;
        public UserProfileBase UserProfileBase
        {
            get
            {
                return ((UserProfileBase)(_profile.GetPropertyValue("UserProfileBase")));
            }
            set
            {
                _profile.SetPropertyValue("UserProfileBase", value);
            }
        }

        public ProfileCommon GetProfile(string userName)
        {
            _profile = Create(userName);
            return this;
        }
        public override void Save()
        {
            _profile.Save();
        }
    }


}