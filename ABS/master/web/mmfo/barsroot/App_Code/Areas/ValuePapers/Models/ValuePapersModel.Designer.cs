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
namespace Areas.ValuePapers.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class ValuePapersModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new ValuePapersModel object using the connection string found in the 'ValuePapersModel' section of the application configuration file.
        /// </summary>
        public ValuePapersModel() : base("name=ValuePapersModel", "ValuePapersModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new ValuePapersModel object.
        /// </summary>
        public ValuePapersModel(string connectionString) : base(connectionString, "ValuePapersModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new ValuePapersModel object.
        /// </summary>
        public ValuePapersModel(EntityConnection connection) : base(connection, "ValuePapersModel")
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