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
namespace Areas.SWCompare.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class SWCompareModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new SWCompareModel object using the connection string found in the 'SWCompareModel' section of the application configuration file.
        /// </summary>
        public SWCompareModel() : base("name=SWCompareModel", "SWCompareModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SWCompareModel object.
        /// </summary>
        public SWCompareModel(string connectionString) : base(connectionString, "SWCompareModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SWCompareModel object.
        /// </summary>
        public SWCompareModel(EntityConnection connection) : base(connection, "SWCompareModel")
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
