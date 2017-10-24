using System;
using System.Collections;
using System.Security.Principal;

namespace BarsWeb.Areas.Security.Infrastructure
{
	[Serializable]
	public class CustomPrincipal: IPrincipal
	{
		
		private IIdentity _identity;
		private readonly ArrayList _roles;
		
		/// <summary>
		/// Initializes a new instance of the GenericPrincipal class 
		/// from a CustomIdentity and an ArrayList of role names 
		/// to which the user represented by that CustomIdentity belongs
		/// </summary>
		/// <param name="id"></param>
		/// <param name="rolesArray"></param>
		public CustomPrincipal(IIdentity id, ArrayList rolesArray)
		{
			_identity = id;
			_roles = rolesArray;
		}
		
		/// <summary>
		/// Determines whether the current CustomPrincipal belongs to the specified role.
		/// </summary>
		/// <param name="role">The name of the role for which to check membership</param>
		/// <returns>true if the current CustomPrincipal is a member of the specified role; 
		/// otherwise, false.</returns>
		public bool IsInRole(string role)
		{
			return _roles.Contains( role );
		}
		
		/// <summary>
		/// Gets the CustomIdentity of the user represented by the current CustomPrincipal.
		/// </summary>
		public IIdentity Identity
		{
			get { return _identity; }
			set { _identity = value; }
		}
	}
}
