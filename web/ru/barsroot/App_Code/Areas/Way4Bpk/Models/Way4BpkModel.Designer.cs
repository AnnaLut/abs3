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
namespace Areas.Way4Bpk.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class Way4BpkModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new Way4BpkModel object using the connection string found in the 'Way4BpkModel' section of the application configuration file.
        /// </summary>
        public Way4BpkModel() : base("name=Way4BpkModel", "Way4BpkModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new Way4BpkModel object.
        /// </summary>
        public Way4BpkModel(string connectionString) : base(connectionString, "Way4BpkModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new Way4BpkModel object.
        /// </summary>
        public Way4BpkModel(EntityConnection connection) : base(connection, "Way4BpkModel")
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
