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
namespace Areas.NbuIntegration.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class NbuIntegrationModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new NbuIntegrationModel object using the connection string found in the 'NbuIntegrationModel' section of the application configuration file.
        /// </summary>
        public NbuIntegrationModel() : base("name=NbuIntegrationModel", "NbuIntegrationModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new NbuIntegrationModel object.
        /// </summary>
        public NbuIntegrationModel(string connectionString) : base(connectionString, "NbuIntegrationModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new NbuIntegrationModel object.
        /// </summary>
        public NbuIntegrationModel(EntityConnection connection) : base(connection, "NbuIntegrationModel")
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
