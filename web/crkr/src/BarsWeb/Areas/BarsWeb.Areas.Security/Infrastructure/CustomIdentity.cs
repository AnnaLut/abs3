using System;
using System.Security.Principal;

namespace BarsWeb.Areas.Security.Infrastructure
{
	/// <summary>
	/// Represents the Identity of a User. 
	/// Stores the details of a User. 
	/// Implements the IIDentity interface.
	/// </summary>
	[Serializable]
	public class CustomIdentity : IIdentity
	{
		private string _userId;
		private int _userPk;
		private bool _login;
		private bool _isSuperUser;
		private string _fullName;
		private string _userEmail;
		private string _roles;
		
		/// <summary>
		/// The default constructor initializes any fields to their default values.
		/// </summary>
		public CustomIdentity()
		{
			_userPk			= 0;
			_userId			= string.Empty;
			_login			= false;
			_isSuperUser	= false;
			_fullName		= string.Empty;
			_userEmail		= string.Empty;
			_roles			= string.Empty;
		}

	    /// <summary>
	    /// Initializes a new instance of the CustomIdentity class 
	    /// with the passed parameters
	    /// </summary>
	    /// <param name="uId">User ID of the user</param>
	    /// <param name="upk">Primary Key of the User record in User table</param>
	    /// <param name="islogin">Flag that indicates whether the user has been authenticated</param>
	    /// <param name="isAdmin">Flag that indicates whether the user is an Administrator</param>
	    /// <param name="userName">Full name of the User</param>
	    /// <param name="email">Email of the User</param>
	    /// <param name="uRoles"></param>
	    public CustomIdentity(string uId, int upk, bool islogin, bool isAdmin, string userName, string email, string uRoles)
		{
			_userPk			= upk;
			_userId			= uId;
			_login			= islogin;
			_isSuperUser	= isAdmin;
			_fullName		= userName;
			_userEmail		= email;
			_roles			= uRoles;
		}
		
		// Properties
		/// <summary>
		/// Gets the Authentication Type
		/// </summary>
		public string AuthenticationType 
		{
			get { return "Custom"; }
		}

		/// <summary>
		/// Indicates whether the User is authenticated
		/// </summary>
		public bool IsAuthenticated  
		{
			get { return _login; }
			set { _login = value; }
		}

		/// <summary>
		/// Gets or sets the UserID of the User
		/// </summary>
		public string Name 
		{
			get { return _userId; }
			set { _userId = value; }
		}

		/// <summary>
		/// Gets or sets the Primary Key for the User record
		/// </summary>
		public int UserPk 
		{
			get { return _userPk; }
			set { _userPk = value; }
		}

		/// <summary>
		/// Indicates whether the User is an Administrator
		/// </summary>
		public bool IsSuperUser
		{
			get { return _isSuperUser; }
			set { _isSuperUser = value; }
		}

		/// <summary>
		/// Gets or sets the Full Name of the User
		/// </summary>
		public string UserFullName
		{
			get { return _fullName; }
			set { _fullName = value; }
		}

		/// <summary>
		/// Gets or sets the Email of the User
		/// </summary>
		public string UserEmail
		{
			get { return _userEmail; }
			set { _userEmail = value; }
		}

		/// <summary>
		/// Gets or sets the Roles of the User
		/// The roles are stored in a pipe "|" separated string
		/// </summary>
		public string UserRoles
		{
			get { return _roles; }
			set { _roles = value; }
		}
	}
}
