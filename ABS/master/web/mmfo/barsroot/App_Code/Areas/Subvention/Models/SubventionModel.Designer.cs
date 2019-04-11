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
namespace Areas.Subvention.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class SubventionMonitoringModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new SubventionMonitoringModel object using the connection string found in the 'SubventionMonitoringModel' section of the application configuration file.
        /// </summary>
        public SubventionMonitoringModel() : base("name=SubventionMonitoringModel", "SubventionMonitoringModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SubventionMonitoringModel object.
        /// </summary>
        public SubventionMonitoringModel(string connectionString) : base(connectionString, "SubventionMonitoringModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SubventionMonitoringModel object.
        /// </summary>
        public SubventionMonitoringModel(EntityConnection connection) : base(connection, "SubventionMonitoringModel")
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
