﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.ComponentModel;
using System.Data.EntityClient;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Runtime.Serialization;
using System.Xml.Serialization;

[assembly: EdmSchemaAttribute()]
namespace Areas.AccessToAccounts.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class AccessToAccountsEntities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new AccessToAccountsEntities object using the connection string found in the 'AccessToAccountsEntities' section of the application configuration file.
        /// </summary>
        public AccessToAccountsEntities() : base("name=AccessToAccountsEntities", "AccessToAccountsEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new AccessToAccountsEntities object.
        /// </summary>
        public AccessToAccountsEntities(string connectionString) : base(connectionString, "AccessToAccountsEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new AccessToAccountsEntities object.
        /// </summary>
        public AccessToAccountsEntities(EntityConnection connection) : base(connection, "AccessToAccountsEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        #endregion
    
        #region Partial Methods
    
        partial void OnContextCreated();
    
        #endregion
    
    }

    #endregion

    
}