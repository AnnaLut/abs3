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
namespace Areas.DynamicLayoutLegalEntities.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class DynamicLayoutLegalEntitiesModel : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new DynamicLayoutLegalEntitiesModel object using the connection string found in the 'DynamicLayoutLegalEntitiesModel' section of the application configuration file.
        /// </summary>
        public DynamicLayoutLegalEntitiesModel() : base("name=DynamicLayoutLegalEntitiesModel", "DynamicLayoutLegalEntitiesModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new DynamicLayoutLegalEntitiesModel object.
        /// </summary>
        public DynamicLayoutLegalEntitiesModel(string connectionString) : base(connectionString, "DynamicLayoutLegalEntitiesModel")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new DynamicLayoutLegalEntitiesModel object.
        /// </summary>
        public DynamicLayoutLegalEntitiesModel(EntityConnection connection) : base(connection, "DynamicLayoutLegalEntitiesModel")
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