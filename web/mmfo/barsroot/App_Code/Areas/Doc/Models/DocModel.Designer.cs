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
#region EDM Relationship Metadata

[assembly: EdmRelationshipAttribute("BarsWeb.Areas.Doc.Model", "FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING", System.Data.Metadata.Edm.RelationshipMultiplicity.One, typeof(Areas.Doc.Models.TICKETS_ADVERTISING), "TICKETS_ADVERTISING_BRANCH", System.Data.Metadata.Edm.RelationshipMultiplicity.Many, typeof(Areas.Doc.Models.TICKETS_ADVERTISING_BRANCH), true)]

#endregion

namespace Areas.Doc.Models
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class DocEntities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new DocEntities object using the connection string found in the 'DocEntities' section of the application configuration file.
        /// </summary>
        public DocEntities() : base("name=DocEntities", "DocEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new DocEntities object.
        /// </summary>
        public DocEntities(string connectionString) : base(connectionString, "DocEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new DocEntities object.
        /// </summary>
        public DocEntities(EntityConnection connection) : base(connection, "DocEntities")
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
        public ObjectSet<TICKETS_ADVERTISING> TICKETS_ADVERTISING
        {
            get
            {
                if ((_TICKETS_ADVERTISING == null))
                {
                    _TICKETS_ADVERTISING = base.CreateObjectSet<TICKETS_ADVERTISING>("TICKETS_ADVERTISING");
                }
                return _TICKETS_ADVERTISING;
            }
        }
        private ObjectSet<TICKETS_ADVERTISING> _TICKETS_ADVERTISING;
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<TICKETS_ADVERTISING_BRANCH> TICKETS_ADVERTISING_BRANCH
        {
            get
            {
                if ((_TICKETS_ADVERTISING_BRANCH == null))
                {
                    _TICKETS_ADVERTISING_BRANCH = base.CreateObjectSet<TICKETS_ADVERTISING_BRANCH>("TICKETS_ADVERTISING_BRANCH");
                }
                return _TICKETS_ADVERTISING_BRANCH;
            }
        }
        private ObjectSet<TICKETS_ADVERTISING_BRANCH> _TICKETS_ADVERTISING_BRANCH;

        #endregion

        #region AddTo Methods
    
        /// <summary>
        /// Deprecated Method for adding a new object to the TICKETS_ADVERTISING EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToTICKETS_ADVERTISING(TICKETS_ADVERTISING tICKETS_ADVERTISING)
        {
            base.AddObject("TICKETS_ADVERTISING", tICKETS_ADVERTISING);
        }
    
        /// <summary>
        /// Deprecated Method for adding a new object to the TICKETS_ADVERTISING_BRANCH EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToTICKETS_ADVERTISING_BRANCH(TICKETS_ADVERTISING_BRANCH tICKETS_ADVERTISING_BRANCH)
        {
            base.AddObject("TICKETS_ADVERTISING_BRANCH", tICKETS_ADVERTISING_BRANCH);
        }

        #endregion

        #region Function Imports
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        /// <param name="p_ID">No Metadata Documentation available.</param>
        /// <param name="p_NAME">No Metadata Documentation available.</param>
        /// <param name="p_DAT_BEGIN">No Metadata Documentation available.</param>
        /// <param name="p_DAT_END">No Metadata Documentation available.</param>
        /// <param name="p_ACTIVE">No Metadata Documentation available.</param>
        /// <param name="p_DATA_BODY_HTML">No Metadata Documentation available.</param>
        /// <param name="p_DATA_BODY">No Metadata Documentation available.</param>
        /// <param name="p_DESCRIPTION">No Metadata Documentation available.</param>
        /// <param name="p_TRANSACTION_CODE_LIST">No Metadata Documentation available.</param>
        /// <param name="p_DEF_FLAG">No Metadata Documentation available.</param>
        /// <param name="p_WIDTH">No Metadata Documentation available.</param>
        /// <param name="p_HEIGHT">No Metadata Documentation available.</param>
        public int ADVT_PACK_SET_ADVT(ObjectParameter p_ID, global::System.String p_NAME, Nullable<global::System.DateTime> p_DAT_BEGIN, Nullable<global::System.DateTime> p_DAT_END, global::System.String p_ACTIVE, global::System.String p_DATA_BODY_HTML, global::System.Byte[] p_DATA_BODY, global::System.String p_DESCRIPTION, global::System.String p_TRANSACTION_CODE_LIST, global::System.String p_DEF_FLAG, Nullable<global::System.Decimal> p_WIDTH, Nullable<global::System.Decimal> p_HEIGHT)
        {
            ObjectParameter p_NAMEParameter;
            if (p_NAME != null)
            {
                p_NAMEParameter = new ObjectParameter("P_NAME", p_NAME);
            }
            else
            {
                p_NAMEParameter = new ObjectParameter("P_NAME", typeof(global::System.String));
            }
    
            ObjectParameter p_DAT_BEGINParameter;
            if (p_DAT_BEGIN.HasValue)
            {
                p_DAT_BEGINParameter = new ObjectParameter("P_DAT_BEGIN", p_DAT_BEGIN);
            }
            else
            {
                p_DAT_BEGINParameter = new ObjectParameter("P_DAT_BEGIN", typeof(global::System.DateTime));
            }
    
            ObjectParameter p_DAT_ENDParameter;
            if (p_DAT_END.HasValue)
            {
                p_DAT_ENDParameter = new ObjectParameter("P_DAT_END", p_DAT_END);
            }
            else
            {
                p_DAT_ENDParameter = new ObjectParameter("P_DAT_END", typeof(global::System.DateTime));
            }
    
            ObjectParameter p_ACTIVEParameter;
            if (p_ACTIVE != null)
            {
                p_ACTIVEParameter = new ObjectParameter("P_ACTIVE", p_ACTIVE);
            }
            else
            {
                p_ACTIVEParameter = new ObjectParameter("P_ACTIVE", typeof(global::System.String));
            }
    
            ObjectParameter p_DATA_BODY_HTMLParameter;
            if (p_DATA_BODY_HTML != null)
            {
                p_DATA_BODY_HTMLParameter = new ObjectParameter("P_DATA_BODY_HTML", p_DATA_BODY_HTML);
            }
            else
            {
                p_DATA_BODY_HTMLParameter = new ObjectParameter("P_DATA_BODY_HTML", typeof(global::System.String));
            }
    
            ObjectParameter p_DATA_BODYParameter;
            if (p_DATA_BODY != null)
            {
                p_DATA_BODYParameter = new ObjectParameter("P_DATA_BODY", p_DATA_BODY);
            }
            else
            {
                p_DATA_BODYParameter = new ObjectParameter("P_DATA_BODY", typeof(global::System.Byte[]));
            }
    
            ObjectParameter p_DESCRIPTIONParameter;
            if (p_DESCRIPTION != null)
            {
                p_DESCRIPTIONParameter = new ObjectParameter("P_DESCRIPTION", p_DESCRIPTION);
            }
            else
            {
                p_DESCRIPTIONParameter = new ObjectParameter("P_DESCRIPTION", typeof(global::System.String));
            }
    
            ObjectParameter p_TRANSACTION_CODE_LISTParameter;
            if (p_TRANSACTION_CODE_LIST != null)
            {
                p_TRANSACTION_CODE_LISTParameter = new ObjectParameter("P_TRANSACTION_CODE_LIST", p_TRANSACTION_CODE_LIST);
            }
            else
            {
                p_TRANSACTION_CODE_LISTParameter = new ObjectParameter("P_TRANSACTION_CODE_LIST", typeof(global::System.String));
            }
    
            ObjectParameter p_DEF_FLAGParameter;
            if (p_DEF_FLAG != null)
            {
                p_DEF_FLAGParameter = new ObjectParameter("P_DEF_FLAG", p_DEF_FLAG);
            }
            else
            {
                p_DEF_FLAGParameter = new ObjectParameter("P_DEF_FLAG", typeof(global::System.String));
            }
    
            ObjectParameter p_WIDTHParameter;
            if (p_WIDTH.HasValue)
            {
                p_WIDTHParameter = new ObjectParameter("P_WIDTH", p_WIDTH);
            }
            else
            {
                p_WIDTHParameter = new ObjectParameter("P_WIDTH", typeof(global::System.Decimal));
            }
    
            ObjectParameter p_HEIGHTParameter;
            if (p_HEIGHT.HasValue)
            {
                p_HEIGHTParameter = new ObjectParameter("P_HEIGHT", p_HEIGHT);
            }
            else
            {
                p_HEIGHTParameter = new ObjectParameter("P_HEIGHT", typeof(global::System.Decimal));
            }
    
            return base.ExecuteFunction("ADVT_PACK_SET_ADVT", p_ID, p_NAMEParameter, p_DAT_BEGINParameter, p_DAT_ENDParameter, p_ACTIVEParameter, p_DATA_BODY_HTMLParameter, p_DATA_BODYParameter, p_DESCRIPTIONParameter, p_TRANSACTION_CODE_LISTParameter, p_DEF_FLAGParameter, p_WIDTHParameter, p_HEIGHTParameter);
        }

        #endregion

    }

    #endregion

    #region Entities
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="BarsWeb.Areas.Doc.Model", Name="TICKETS_ADVERTISING")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class TICKETS_ADVERTISING : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new TICKETS_ADVERTISING object.
        /// </summary>
        /// <param name="id">Initial value of the ID property.</param>
        public static TICKETS_ADVERTISING CreateTICKETS_ADVERTISING(global::System.Decimal id)
        {
            TICKETS_ADVERTISING tICKETS_ADVERTISING = new TICKETS_ADVERTISING();
            tICKETS_ADVERTISING.ID = id;
            return tICKETS_ADVERTISING;
        }

        #endregion

        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Decimal ID
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
        private global::System.Decimal _ID;
        partial void OnIDChanging(global::System.Decimal value);
        partial void OnIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String NAME
        {
            get
            {
                return _NAME;
            }
            set
            {
                OnNAMEChanging(value);
                ReportPropertyChanging("NAME");
                _NAME = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("NAME");
                OnNAMEChanged();
            }
        }
        private global::System.String _NAME;
        partial void OnNAMEChanging(global::System.String value);
        partial void OnNAMEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public Nullable<global::System.DateTime> DAT_BEGIN
        {
            get
            {
                return _DAT_BEGIN;
            }
            set
            {
                OnDAT_BEGINChanging(value);
                ReportPropertyChanging("DAT_BEGIN");
                _DAT_BEGIN = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("DAT_BEGIN");
                OnDAT_BEGINChanged();
            }
        }
        private Nullable<global::System.DateTime> _DAT_BEGIN;
        partial void OnDAT_BEGINChanging(Nullable<global::System.DateTime> value);
        partial void OnDAT_BEGINChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public Nullable<global::System.DateTime> DAT_END
        {
            get
            {
                return _DAT_END;
            }
            set
            {
                OnDAT_ENDChanging(value);
                ReportPropertyChanging("DAT_END");
                _DAT_END = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("DAT_END");
                OnDAT_ENDChanged();
            }
        }
        private Nullable<global::System.DateTime> _DAT_END;
        partial void OnDAT_ENDChanging(Nullable<global::System.DateTime> value);
        partial void OnDAT_ENDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String ACTIVE
        {
            get
            {
                return _ACTIVE;
            }
            set
            {
                OnACTIVEChanging(value);
                ReportPropertyChanging("ACTIVE");
                _ACTIVE = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("ACTIVE");
                OnACTIVEChanged();
            }
        }
        private global::System.String _ACTIVE;
        partial void OnACTIVEChanging(global::System.String value);
        partial void OnACTIVEChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String DATA_BODY_HTML
        {
            get
            {
                return _DATA_BODY_HTML;
            }
            set
            {
                OnDATA_BODY_HTMLChanging(value);
                ReportPropertyChanging("DATA_BODY_HTML");
                _DATA_BODY_HTML = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("DATA_BODY_HTML");
                OnDATA_BODY_HTMLChanged();
            }
        }
        private global::System.String _DATA_BODY_HTML;
        partial void OnDATA_BODY_HTMLChanging(global::System.String value);
        partial void OnDATA_BODY_HTMLChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.Byte[] DATA_BODY
        {
            get
            {
                return StructuralObject.GetValidValue(_DATA_BODY);
            }
            set
            {
                OnDATA_BODYChanging(value);
                ReportPropertyChanging("DATA_BODY");
                _DATA_BODY = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("DATA_BODY");
                OnDATA_BODYChanged();
            }
        }
        private global::System.Byte[] _DATA_BODY;
        partial void OnDATA_BODYChanging(global::System.Byte[] value);
        partial void OnDATA_BODYChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String DESCRIPTION
        {
            get
            {
                return _DESCRIPTION;
            }
            set
            {
                OnDESCRIPTIONChanging(value);
                ReportPropertyChanging("DESCRIPTION");
                _DESCRIPTION = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("DESCRIPTION");
                OnDESCRIPTIONChanged();
            }
        }
        private global::System.String _DESCRIPTION;
        partial void OnDESCRIPTIONChanging(global::System.String value);
        partial void OnDESCRIPTIONChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String TRANSACTION_CODE_LIST
        {
            get
            {
                return _TRANSACTION_CODE_LIST;
            }
            set
            {
                OnTRANSACTION_CODE_LISTChanging(value);
                ReportPropertyChanging("TRANSACTION_CODE_LIST");
                _TRANSACTION_CODE_LIST = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("TRANSACTION_CODE_LIST");
                OnTRANSACTION_CODE_LISTChanged();
            }
        }
        private global::System.String _TRANSACTION_CODE_LIST;
        partial void OnTRANSACTION_CODE_LISTChanging(global::System.String value);
        partial void OnTRANSACTION_CODE_LISTChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String DEF_FLAG
        {
            get
            {
                return _DEF_FLAG;
            }
            set
            {
                OnDEF_FLAGChanging(value);
                ReportPropertyChanging("DEF_FLAG");
                _DEF_FLAG = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("DEF_FLAG");
                OnDEF_FLAGChanged();
            }
        }
        private global::System.String _DEF_FLAG;
        partial void OnDEF_FLAGChanging(global::System.String value);
        partial void OnDEF_FLAGChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String KF
        {
            get
            {
                return _KF;
            }
            set
            {
                OnKFChanging(value);
                ReportPropertyChanging("KF");
                _KF = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("KF");
                OnKFChanged();
            }
        }
        private global::System.String _KF;
        partial void OnKFChanging(global::System.String value);
        partial void OnKFChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public Nullable<global::System.Decimal> WIDTH
        {
            get
            {
                return _WIDTH;
            }
            set
            {
                OnWIDTHChanging(value);
                ReportPropertyChanging("WIDTH");
                _WIDTH = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("WIDTH");
                OnWIDTHChanged();
            }
        }
        private Nullable<global::System.Decimal> _WIDTH;
        partial void OnWIDTHChanging(Nullable<global::System.Decimal> value);
        partial void OnWIDTHChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public Nullable<global::System.Decimal> HEIGHT
        {
            get
            {
                return _HEIGHT;
            }
            set
            {
                OnHEIGHTChanging(value);
                ReportPropertyChanging("HEIGHT");
                _HEIGHT = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("HEIGHT");
                OnHEIGHTChanged();
            }
        }
        private Nullable<global::System.Decimal> _HEIGHT;
        partial void OnHEIGHTChanging(Nullable<global::System.Decimal> value);
        partial void OnHEIGHTChanged();

        #endregion

    
        #region Navigation Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [XmlIgnoreAttribute()]
        [SoapIgnoreAttribute()]
        [DataMemberAttribute()]
        [EdmRelationshipNavigationPropertyAttribute("BarsWeb.Areas.Doc.Model", "FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING_BRANCH")]
        public EntityCollection<TICKETS_ADVERTISING_BRANCH> TICKETS_ADVERTISING_BRANCH
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedCollection<TICKETS_ADVERTISING_BRANCH>("BarsWeb.Areas.Doc.Model.FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING_BRANCH");
            }
            set
            {
                if ((value != null))
                {
                    ((IEntityWithRelationships)this).RelationshipManager.InitializeRelatedCollection<TICKETS_ADVERTISING_BRANCH>("BarsWeb.Areas.Doc.Model.FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING_BRANCH", value);
                }
            }
        }

        #endregion

    }
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="BarsWeb.Areas.Doc.Model", Name="TICKETS_ADVERTISING_BRANCH")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class TICKETS_ADVERTISING_BRANCH : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new TICKETS_ADVERTISING_BRANCH object.
        /// </summary>
        /// <param name="aDVERTISING_ID">Initial value of the ADVERTISING_ID property.</param>
        /// <param name="bRANCH">Initial value of the BRANCH property.</param>
        public static TICKETS_ADVERTISING_BRANCH CreateTICKETS_ADVERTISING_BRANCH(global::System.Decimal aDVERTISING_ID, global::System.String bRANCH)
        {
            TICKETS_ADVERTISING_BRANCH tICKETS_ADVERTISING_BRANCH = new TICKETS_ADVERTISING_BRANCH();
            tICKETS_ADVERTISING_BRANCH.ADVERTISING_ID = aDVERTISING_ID;
            tICKETS_ADVERTISING_BRANCH.BRANCH = bRANCH;
            return tICKETS_ADVERTISING_BRANCH;
        }

        #endregion

        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Decimal ADVERTISING_ID
        {
            get
            {
                return _ADVERTISING_ID;
            }
            set
            {
                if (_ADVERTISING_ID != value)
                {
                    OnADVERTISING_IDChanging(value);
                    ReportPropertyChanging("ADVERTISING_ID");
                    _ADVERTISING_ID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("ADVERTISING_ID");
                    OnADVERTISING_IDChanged();
                }
            }
        }
        private global::System.Decimal _ADVERTISING_ID;
        partial void OnADVERTISING_IDChanging(global::System.Decimal value);
        partial void OnADVERTISING_IDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String BRANCH
        {
            get
            {
                return _BRANCH;
            }
            set
            {
                if (_BRANCH != value)
                {
                    OnBRANCHChanging(value);
                    ReportPropertyChanging("BRANCH");
                    _BRANCH = StructuralObject.SetValidValue(value, false);
                    ReportPropertyChanged("BRANCH");
                    OnBRANCHChanged();
                }
            }
        }
        private global::System.String _BRANCH;
        partial void OnBRANCHChanging(global::System.String value);
        partial void OnBRANCHChanged();

        #endregion

    
        #region Navigation Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [XmlIgnoreAttribute()]
        [SoapIgnoreAttribute()]
        [DataMemberAttribute()]
        [EdmRelationshipNavigationPropertyAttribute("BarsWeb.Areas.Doc.Model", "FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING")]
        public TICKETS_ADVERTISING TICKETS_ADVERTISING
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<TICKETS_ADVERTISING>("BarsWeb.Areas.Doc.Model.FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING").Value;
            }
            set
            {
                ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<TICKETS_ADVERTISING>("BarsWeb.Areas.Doc.Model.FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING").Value = value;
            }
        }
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [BrowsableAttribute(false)]
        [DataMemberAttribute()]
        public EntityReference<TICKETS_ADVERTISING> TICKETS_ADVERTISINGReference
        {
            get
            {
                return ((IEntityWithRelationships)this).RelationshipManager.GetRelatedReference<TICKETS_ADVERTISING>("BarsWeb.Areas.Doc.Model.FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING");
            }
            set
            {
                if ((value != null))
                {
                    ((IEntityWithRelationships)this).RelationshipManager.InitializeRelatedReference<TICKETS_ADVERTISING>("BarsWeb.Areas.Doc.Model.FK_TICKETS_ADVERTISING_ID", "TICKETS_ADVERTISING", value);
                }
            }
        }

        #endregion

    }

    #endregion

    
}
