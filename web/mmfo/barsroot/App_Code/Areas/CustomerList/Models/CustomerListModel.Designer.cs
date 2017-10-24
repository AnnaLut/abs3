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
namespace Areas.CustomerList.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class CustomerListModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new CustomerListModel object using the connection string found in the 'CustomerListModel' section of the application configuration file.
        /// </summary>
        public CustomerListModel() : base("name=CustomerListModel", "CustomerListModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new CustomerListModel object.
        /// </summary>
        public CustomerListModel(string connectionString) : base(connectionString, "CustomerListModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new CustomerListModel object.
        /// </summary>
        public CustomerListModel(EntityConnection connection) : base(connection, "CustomerListModel")
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
