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
namespace Areas.SuperVisor.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class SVEntities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new SVEntities object using the connection string found in the 'SVEntities' section of the application configuration file.
        /// </summary>
        public SVEntities() : base("name=SVEntities", "SVEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SVEntities object.
        /// </summary>
        public SVEntities(string connectionString) : base(connectionString, "SVEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SVEntities object.
        /// </summary>
        public SVEntities(EntityConnection connection) : base(connection, "SVEntities")
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
