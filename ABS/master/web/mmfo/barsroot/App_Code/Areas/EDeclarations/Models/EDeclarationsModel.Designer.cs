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
namespace Areas.EDeclarations.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class EDeclarationsModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new EDeclarationsModel object using the connection string found in the 'EDeclarationsModel' section of the application configuration file.
        /// </summary>
        public EDeclarationsModel() : base("name=EDeclarationsModel", "EDeclarationsModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new EDeclarationsModel object.
        /// </summary>
        public EDeclarationsModel(string connectionString) : base(connectionString, "EDeclarationsModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new EDeclarationsModel object.
        /// </summary>
        public EDeclarationsModel(EntityConnection connection) : base(connection, "EDeclarationsModel")
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
