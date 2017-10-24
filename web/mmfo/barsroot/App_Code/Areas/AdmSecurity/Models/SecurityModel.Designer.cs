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
namespace Areas.AdmSecurity.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class Entities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new Entities object using the connection string found in the 'Entities' section of the application configuration file.
        /// </summary>
        public Entities() : base("name=Entities", "Entities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new Entities object.
        /// </summary>
        public Entities(string connectionString) : base(connectionString, "Entities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new Entities object.
        /// </summary>
        public Entities(EntityConnection connection) : base(connection, "Entities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        #endregion
    
        #region Partial Methods
    
        partial void OnContextCreated();
    
        #endregion
    
        #region ObjectSet Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<V_APPROVABLE_RESOURCE> V_APPROVABLE_RESOURCE
        {
            get
            {
                if ((_V_APPROVABLE_RESOURCE == null))
                {
                    _V_APPROVABLE_RESOURCE = base.CreateObjectSet<V_APPROVABLE_RESOURCE>("V_APPROVABLE_RESOURCE");
                }
                return _V_APPROVABLE_RESOURCE;
            }
        }
        private ObjectSet<V_APPROVABLE_RESOURCE> _V_APPROVABLE_RESOURCE;
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<V_APPROVABLE_RESOURCE_GROUP> V_APPROVABLE_RESOURCE_GROUP
        {
            get
            {
                if ((_V_APPROVABLE_RESOURCE_GROUP == null))
                {
                    _V_APPROVABLE_RESOURCE_GROUP = base.CreateObjectSet<V_APPROVABLE_RESOURCE_GROUP>("V_APPROVABLE_RESOURCE_GROUP");
                }
                return _V_APPROVABLE_RESOURCE_GROUP;
            }
        }
        private ObjectSet<V_APPROVABLE_RESOURCE_GROUP> _V_APPROVABLE_RESOURCE_GROUP;

        #endregion

        #region AddTo Methods
    
        /// <summary>
        /// Deprecated Method for adding a new object to the V_APPROVABLE_RESOURCE EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToV_APPROVABLE_RESOURCE(V_APPROVABLE_RESOURCE v_APPROVABLE_RESOURCE)
        {
            base.AddObject("V_APPROVABLE_RESOURCE", v_APPROVABLE_RESOURCE);
        }
    
        /// <summary>
        /// Deprecated Method for adding a new object to the V_APPROVABLE_RESOURCE_GROUP EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToV_APPROVABLE_RESOURCE_GROUP(V_APPROVABLE_RESOURCE_GROUP v_APPROVABLE_RESOURCE_GROUP)
        {
            base.AddObject("V_APPROVABLE_RESOURCE_GROUP", v_APPROVABLE_RESOURCE_GROUP);
        }

        #endregion

    }

    #endregion

    #region Entities
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="SecurityModel", Name="V_APPROVABLE_RESOURCE")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class V_APPROVABLE_RESOURCE : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new V_APPROVABLE_RESOURCE object.
        /// </summary>
        /// <param name="id">Initial value of the ID property.</param>
        /// <param name="gRANTEE_TYPE_ID">Initial value of the GRANTEE_TYPE_ID property.</param>
        /// <param name="rESOURCE_TYPE_NAME">Initial value of the RESOURCE_TYPE_NAME property.</param>
        /// <param name="aCTION_TIME">Initial value of the ACTION_TIME property.</param>
        public static V_APPROVABLE_RESOURCE CreateV_APPROVABLE_RESOURCE(global::System.Int64 id, global::System.Int32 gRANTEE_TYPE_ID, global::System.String rESOURCE_TYPE_NAME, global::System.DateTime aCTION_TIME)
        {
            V_APPROVABLE_RESOURCE v_APPROVABLE_RESOURCE = new V_APPROVABLE_RESOURCE();
            v_APPROVABLE_RESOURCE.ID = id;
            v_APPROVABLE_RESOURCE.GRANTEE_TYPE_ID = gRANTEE_TYPE_ID;
            v_APPROVABLE_RESOURCE.RESOURCE_TYPE_NAME = rESOURCE_TYPE_NAME;
            v_APPROVABLE_RESOURCE.ACTION_TIME = aCTION_TIME;
            return v_APPROVABLE_RESOURCE;
        }

        #endregion

        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int64 ID
        {
            get
            {
                return _ID;
            }
            set
            {
                if (_ID != value)
                {
                    OnIDChanging(value);
                    ReportPropertyChanging("ID");
                    _ID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("ID");
                    OnIDChanged();
                }
            }
        }
        private global::System.Int64 _ID;
        partial void OnIDChanging(global::System.Int64 value);
        partial void OnIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 GRANTEE_TYPE_ID
        {
            get
            {
                return _GRANTEE_TYPE_ID;
            }
            set
            {
                if (_GRANTEE_TYPE_ID != value)
                {
                    OnGRANTEE_TYPE_IDChanging(value);
                    ReportPropertyChanging("GRANTEE_TYPE_ID");
                    _GRANTEE_TYPE_ID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("GRANTEE_TYPE_ID");
                    OnGRANTEE_TYPE_IDChanged();
                }
            }
        }
        private global::System.Int32 _GRANTEE_TYPE_ID;
        partial void OnGRANTEE_TYPE_IDChanging(global::System.Int32 value);
        partial void OnGRANTEE_TYPE_IDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String GRANTEE_CODE
        {
            get
            {
                return _GRANTEE_CODE;
            }
            set
            {
                OnGRANTEE_CODEChanging(value);
                ReportPropertyChanging("GRANTEE_CODE");
                _GRANTEE_CODE = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("GRANTEE_CODE");
                OnGRANTEE_CODEChanged();
            }
        }
        private global::System.String _GRANTEE_CODE;
        partial void OnGRANTEE_CODEChanging(global::System.String value);
        partial void OnGRANTEE_CODEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String GRANTEE_NAME
        {
            get
            {
                return _GRANTEE_NAME;
            }
            set
            {
                OnGRANTEE_NAMEChanging(value);
                ReportPropertyChanging("GRANTEE_NAME");
                _GRANTEE_NAME = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("GRANTEE_NAME");
                OnGRANTEE_NAMEChanged();
            }
        }
        private global::System.String _GRANTEE_NAME;
        partial void OnGRANTEE_NAMEChanging(global::System.String value);
        partial void OnGRANTEE_NAMEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String RESOURCE_TYPE_NAME
        {
            get
            {
                return _RESOURCE_TYPE_NAME;
            }
            set
            {
                if (_RESOURCE_TYPE_NAME != value)
                {
                    OnRESOURCE_TYPE_NAMEChanging(value);
                    ReportPropertyChanging("RESOURCE_TYPE_NAME");
                    _RESOURCE_TYPE_NAME = StructuralObject.SetValidValue(value, false);
                    ReportPropertyChanged("RESOURCE_TYPE_NAME");
                    OnRESOURCE_TYPE_NAMEChanged();
                }
            }
        }
        private global::System.String _RESOURCE_TYPE_NAME;
        partial void OnRESOURCE_TYPE_NAMEChanging(global::System.String value);
        partial void OnRESOURCE_TYPE_NAMEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String RESOURCE_CODE
        {
            get
            {
                return _RESOURCE_CODE;
            }
            set
            {
                OnRESOURCE_CODEChanging(value);
                ReportPropertyChanging("RESOURCE_CODE");
                _RESOURCE_CODE = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("RESOURCE_CODE");
                OnRESOURCE_CODEChanged();
            }
        }
        private global::System.String _RESOURCE_CODE;
        partial void OnRESOURCE_CODEChanging(global::System.String value);
        partial void OnRESOURCE_CODEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String RESOURCE_NAME
        {
            get
            {
                return _RESOURCE_NAME;
            }
            set
            {
                OnRESOURCE_NAMEChanging(value);
                ReportPropertyChanging("RESOURCE_NAME");
                _RESOURCE_NAME = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("RESOURCE_NAME");
                OnRESOURCE_NAMEChanged();
            }
        }
        private global::System.String _RESOURCE_NAME;
        partial void OnRESOURCE_NAMEChanging(global::System.String value);
        partial void OnRESOURCE_NAMEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String NEW_ACCESS_MODE
        {
            get
            {
                return _NEW_ACCESS_MODE;
            }
            set
            {
                OnNEW_ACCESS_MODEChanging(value);
                ReportPropertyChanging("NEW_ACCESS_MODE");
                _NEW_ACCESS_MODE = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("NEW_ACCESS_MODE");
                OnNEW_ACCESS_MODEChanged();
            }
        }
        private global::System.String _NEW_ACCESS_MODE;
        partial void OnNEW_ACCESS_MODEChanging(global::System.String value);
        partial void OnNEW_ACCESS_MODEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String CURRENT_ACCESS_MODE
        {
            get
            {
                return _CURRENT_ACCESS_MODE;
            }
            set
            {
                OnCURRENT_ACCESS_MODEChanging(value);
                ReportPropertyChanging("CURRENT_ACCESS_MODE");
                _CURRENT_ACCESS_MODE = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("CURRENT_ACCESS_MODE");
                OnCURRENT_ACCESS_MODEChanged();
            }
        }
        private global::System.String _CURRENT_ACCESS_MODE;
        partial void OnCURRENT_ACCESS_MODEChanging(global::System.String value);
        partial void OnCURRENT_ACCESS_MODEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.DateTime ACTION_TIME
        {
            get
            {
                return _ACTION_TIME;
            }
            set
            {
                if (_ACTION_TIME != value)
                {
                    OnACTION_TIMEChanging(value);
                    ReportPropertyChanging("ACTION_TIME");
                    _ACTION_TIME = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("ACTION_TIME");
                    OnACTION_TIMEChanged();
                }
            }
        }
        private global::System.DateTime _ACTION_TIME;
        partial void OnACTION_TIMEChanging(global::System.DateTime value);
        partial void OnACTION_TIMEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String ACTION_USER
        {
            get
            {
                return _ACTION_USER;
            }
            set
            {
                OnACTION_USERChanging(value);
                ReportPropertyChanging("ACTION_USER");
                _ACTION_USER = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("ACTION_USER");
                OnACTION_USERChanged();
            }
        }
        private global::System.String _ACTION_USER;
        partial void OnACTION_USERChanging(global::System.String value);
        partial void OnACTION_USERChanged();

        #endregion

    
    }
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="SecurityModel", Name="V_APPROVABLE_RESOURCE_GROUP")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class V_APPROVABLE_RESOURCE_GROUP : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new V_APPROVABLE_RESOURCE_GROUP object.
        /// </summary>
        /// <param name="id">Initial value of the ID property.</param>
        /// <param name="rESOURCE_CODE">Initial value of the RESOURCE_CODE property.</param>
        /// <param name="rESOURCE_NAME">Initial value of the RESOURCE_NAME property.</param>
        public static V_APPROVABLE_RESOURCE_GROUP CreateV_APPROVABLE_RESOURCE_GROUP(global::System.Int32 id, global::System.String rESOURCE_CODE, global::System.String rESOURCE_NAME)
        {
            V_APPROVABLE_RESOURCE_GROUP v_APPROVABLE_RESOURCE_GROUP = new V_APPROVABLE_RESOURCE_GROUP();
            v_APPROVABLE_RESOURCE_GROUP.ID = id;
            v_APPROVABLE_RESOURCE_GROUP.RESOURCE_CODE = rESOURCE_CODE;
            v_APPROVABLE_RESOURCE_GROUP.RESOURCE_NAME = rESOURCE_NAME;
            return v_APPROVABLE_RESOURCE_GROUP;
        }

        #endregion

        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 ID
        {
            get
            {
                return _ID;
            }
            set
            {
                if (_ID != value)
                {
                    OnIDChanging(value);
                    ReportPropertyChanging("ID");
                    _ID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("ID");
                    OnIDChanged();
                }
            }
        }
        private global::System.Int32 _ID;
        partial void OnIDChanging(global::System.Int32 value);
        partial void OnIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String RESOURCE_CODE
        {
            get
            {
                return _RESOURCE_CODE;
            }
            set
            {
                if (_RESOURCE_CODE != value)
                {
                    OnRESOURCE_CODEChanging(value);
                    ReportPropertyChanging("RESOURCE_CODE");
                    _RESOURCE_CODE = StructuralObject.SetValidValue(value, false);
                    ReportPropertyChanged("RESOURCE_CODE");
                    OnRESOURCE_CODEChanged();
                }
            }
        }
        private global::System.String _RESOURCE_CODE;
        partial void OnRESOURCE_CODEChanging(global::System.String value);
        partial void OnRESOURCE_CODEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String RESOURCE_NAME
        {
            get
            {
                return _RESOURCE_NAME;
            }
            set
            {
                if (_RESOURCE_NAME != value)
                {
                    OnRESOURCE_NAMEChanging(value);
                    ReportPropertyChanging("RESOURCE_NAME");
                    _RESOURCE_NAME = StructuralObject.SetValidValue(value, false);
                    ReportPropertyChanged("RESOURCE_NAME");
                    OnRESOURCE_NAMEChanged();
                }
            }
        }
        private global::System.String _RESOURCE_NAME;
        partial void OnRESOURCE_NAMEChanging(global::System.String value);
        partial void OnRESOURCE_NAMEChanged();

        #endregion

    
    }

    #endregion

    
}
