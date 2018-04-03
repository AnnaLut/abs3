﻿//------------------------------------------------------------------------------
// <autogenerated>
//     This code was generated by a tool.
//     Runtime Version: 1.1.4322.2300
//
//     Changes to this file may cause incorrect behavior and will be lost if 
//     the code is regenerated.
// </autogenerated>
//------------------------------------------------------------------------------

namespace BarsWeb.BasicFunctions.DataSets {
    using System;
    using System.Data;
    using System.Xml;
    using System.Runtime.Serialization;
    
    
    [Serializable()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Diagnostics.DebuggerStepThrough()]
    [System.ComponentModel.ToolboxItem(true)]
    public class AcrInt : DataSet {
        
        private dataAcrIntDataTable tabledataAcrInt;
        
        public AcrInt() {
            this.InitClass();
            System.ComponentModel.CollectionChangeEventHandler schemaChangedHandler = new System.ComponentModel.CollectionChangeEventHandler(this.SchemaChanged);
            this.Tables.CollectionChanged += schemaChangedHandler;
            this.Relations.CollectionChanged += schemaChangedHandler;
        }
        
        protected AcrInt(SerializationInfo info, StreamingContext context) {
            string strSchema = ((string)(info.GetValue("XmlSchema", typeof(string))));
            if ((strSchema != null)) {
                DataSet ds = new DataSet();
                ds.ReadXmlSchema(new XmlTextReader(new System.IO.StringReader(strSchema)));
                if ((ds.Tables["dataAcrInt"] != null)) {
                    this.Tables.Add(new dataAcrIntDataTable(ds.Tables["dataAcrInt"]));
                }
                this.DataSetName = ds.DataSetName;
                this.Prefix = ds.Prefix;
                this.Namespace = ds.Namespace;
                this.Locale = ds.Locale;
                this.CaseSensitive = ds.CaseSensitive;
                this.EnforceConstraints = ds.EnforceConstraints;
                this.Merge(ds, false, System.Data.MissingSchemaAction.Add);
                this.InitVars();
            }
            else {
                this.InitClass();
            }
            this.GetSerializationData(info, context);
            System.ComponentModel.CollectionChangeEventHandler schemaChangedHandler = new System.ComponentModel.CollectionChangeEventHandler(this.SchemaChanged);
            this.Tables.CollectionChanged += schemaChangedHandler;
            this.Relations.CollectionChanged += schemaChangedHandler;
        }
        
        [System.ComponentModel.Browsable(false)]
        [System.ComponentModel.DesignerSerializationVisibilityAttribute(System.ComponentModel.DesignerSerializationVisibility.Content)]
        public dataAcrIntDataTable dataAcrInt {
            get {
                return this.tabledataAcrInt;
            }
        }
        
        public override DataSet Clone() {
            AcrInt cln = ((AcrInt)(base.Clone()));
            cln.InitVars();
            return cln;
        }
        
        protected override bool ShouldSerializeTables() {
            return false;
        }
        
        protected override bool ShouldSerializeRelations() {
            return false;
        }
        
        protected override void ReadXmlSerializable(XmlReader reader) {
            this.Reset();
            DataSet ds = new DataSet();
            ds.ReadXml(reader);
            if ((ds.Tables["dataAcrInt"] != null)) {
                this.Tables.Add(new dataAcrIntDataTable(ds.Tables["dataAcrInt"]));
            }
            this.DataSetName = ds.DataSetName;
            this.Prefix = ds.Prefix;
            this.Namespace = ds.Namespace;
            this.Locale = ds.Locale;
            this.CaseSensitive = ds.CaseSensitive;
            this.EnforceConstraints = ds.EnforceConstraints;
            this.Merge(ds, false, System.Data.MissingSchemaAction.Add);
            this.InitVars();
        }
        
        protected override System.Xml.Schema.XmlSchema GetSchemaSerializable() {
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            this.WriteXmlSchema(new XmlTextWriter(stream, null));
            stream.Position = 0;
            return System.Xml.Schema.XmlSchema.Read(new XmlTextReader(stream), null);
        }
        
        internal void InitVars() {
            this.tabledataAcrInt = ((dataAcrIntDataTable)(this.Tables["dataAcrInt"]));
            if ((this.tabledataAcrInt != null)) {
                this.tabledataAcrInt.InitVars();
            }
        }
        
        private void InitClass() {
            this.DataSetName = "AcrInt";
            this.Prefix = "";
            this.Namespace = "http://tempuri.org/AcrInt.xsd";
            this.Locale = new System.Globalization.CultureInfo("en-US");
            this.CaseSensitive = false;
            this.EnforceConstraints = true;
            this.tabledataAcrInt = new dataAcrIntDataTable();
            this.Tables.Add(this.tabledataAcrInt);
        }
        
        private bool ShouldSerializedataAcrInt() {
            return false;
        }
        
        private void SchemaChanged(object sender, System.ComponentModel.CollectionChangeEventArgs e) {
            if ((e.Action == System.ComponentModel.CollectionChangeAction.Remove)) {
                this.InitVars();
            }
        }
        
        public delegate void dataAcrIntRowChangeEventHandler(object sender, dataAcrIntRowChangeEvent e);
        
        [System.Diagnostics.DebuggerStepThrough()]
        public class dataAcrIntDataTable : DataTable, System.Collections.IEnumerable {
            
            private DataColumn columnID;
            
            private DataColumn columnLCV;
            
            private DataColumn columnTYPNACH;
            
            private DataColumn columnVALNAME;
            
            private DataColumn columnNBS;
            
            private DataColumn columnNLS;
            
            private DataColumn columnNMS;
            
            private DataColumn columnFDAT;
            
            private DataColumn columnTDAT;
            
            private DataColumn columnIR;
            
            private DataColumn columnBR;
            
            private DataColumn columnOSTS;
            
            private DataColumn columnACRD;
            
            private DataColumn columnKV_NAME;
            
            internal dataAcrIntDataTable() : 
                    base("dataAcrInt") {
                this.InitClass();
            }
            
            internal dataAcrIntDataTable(DataTable table) : 
                    base(table.TableName) {
                if ((table.CaseSensitive != table.DataSet.CaseSensitive)) {
                    this.CaseSensitive = table.CaseSensitive;
                }
                if ((table.Locale.ToString() != table.DataSet.Locale.ToString())) {
                    this.Locale = table.Locale;
                }
                if ((table.Namespace != table.DataSet.Namespace)) {
                    this.Namespace = table.Namespace;
                }
                this.Prefix = table.Prefix;
                this.MinimumCapacity = table.MinimumCapacity;
                this.DisplayExpression = table.DisplayExpression;
            }
            
            [System.ComponentModel.Browsable(false)]
            public int Count {
                get {
                    return this.Rows.Count;
                }
            }
            
            internal DataColumn IDColumn {
                get {
                    return this.columnID;
                }
            }
            
            internal DataColumn LCVColumn {
                get {
                    return this.columnLCV;
                }
            }
            
            internal DataColumn TYPNACHColumn {
                get {
                    return this.columnTYPNACH;
                }
            }
            
            internal DataColumn VALNAMEColumn {
                get {
                    return this.columnVALNAME;
                }
            }
            
            internal DataColumn NBSColumn {
                get {
                    return this.columnNBS;
                }
            }
            
            internal DataColumn NLSColumn {
                get {
                    return this.columnNLS;
                }
            }
            
            internal DataColumn NMSColumn {
                get {
                    return this.columnNMS;
                }
            }
            
            internal DataColumn FDATColumn {
                get {
                    return this.columnFDAT;
                }
            }
            
            internal DataColumn TDATColumn {
                get {
                    return this.columnTDAT;
                }
            }
            
            internal DataColumn IRColumn {
                get {
                    return this.columnIR;
                }
            }
            
            internal DataColumn BRColumn {
                get {
                    return this.columnBR;
                }
            }
            
            internal DataColumn OSTSColumn {
                get {
                    return this.columnOSTS;
                }
            }
            
            internal DataColumn ACRDColumn {
                get {
                    return this.columnACRD;
                }
            }
            
            internal DataColumn KV_NAMEColumn {
                get {
                    return this.columnKV_NAME;
                }
            }
            
            public dataAcrIntRow this[int index] {
                get {
                    return ((dataAcrIntRow)(this.Rows[index]));
                }
            }
            
            public event dataAcrIntRowChangeEventHandler dataAcrIntRowChanged;
            
            public event dataAcrIntRowChangeEventHandler dataAcrIntRowChanging;
            
            public event dataAcrIntRowChangeEventHandler dataAcrIntRowDeleted;
            
            public event dataAcrIntRowChangeEventHandler dataAcrIntRowDeleting;
            
            public void AdddataAcrIntRow(dataAcrIntRow row) {
                this.Rows.Add(row);
            }
            
            public dataAcrIntRow AdddataAcrIntRow(string ID, short LCV, string TYPNACH, string VALNAME, string NBS, string NLS, string NMS, string FDAT, string TDAT, string IR, string BR, System.Decimal OSTS, System.Decimal ACRD, string KV_NAME) {
                dataAcrIntRow rowdataAcrIntRow = ((dataAcrIntRow)(this.NewRow()));
                rowdataAcrIntRow.ItemArray = new object[] {
                        ID,
                        LCV,
                        TYPNACH,
                        VALNAME,
                        NBS,
                        NLS,
                        NMS,
                        FDAT,
                        TDAT,
                        IR,
                        BR,
                        OSTS,
                        ACRD,
                        KV_NAME};
                this.Rows.Add(rowdataAcrIntRow);
                return rowdataAcrIntRow;
            }
            
            public System.Collections.IEnumerator GetEnumerator() {
                return this.Rows.GetEnumerator();
            }
            
            public override DataTable Clone() {
                dataAcrIntDataTable cln = ((dataAcrIntDataTable)(base.Clone()));
                cln.InitVars();
                return cln;
            }
            
            protected override DataTable CreateInstance() {
                return new dataAcrIntDataTable();
            }
            
            internal void InitVars() {
                this.columnID = this.Columns["ID"];
                this.columnLCV = this.Columns["LCV"];
                this.columnTYPNACH = this.Columns["TYPNACH"];
                this.columnVALNAME = this.Columns["VALNAME"];
                this.columnNBS = this.Columns["NBS"];
                this.columnNLS = this.Columns["NLS"];
                this.columnNMS = this.Columns["NMS"];
                this.columnFDAT = this.Columns["FDAT"];
                this.columnTDAT = this.Columns["TDAT"];
                this.columnIR = this.Columns["IR"];
                this.columnBR = this.Columns["BR"];
                this.columnOSTS = this.Columns["OSTS"];
                this.columnACRD = this.Columns["ACRD"];
                this.columnKV_NAME = this.Columns["KV_NAME"];
            }
            
            private void InitClass() {
                this.columnID = new DataColumn("ID", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnID);
                this.columnLCV = new DataColumn("LCV", typeof(short), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnLCV);
                this.columnTYPNACH = new DataColumn("TYPNACH", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnTYPNACH);
                this.columnVALNAME = new DataColumn("VALNAME", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnVALNAME);
                this.columnNBS = new DataColumn("NBS", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnNBS);
                this.columnNLS = new DataColumn("NLS", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnNLS);
                this.columnNMS = new DataColumn("NMS", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnNMS);
                this.columnFDAT = new DataColumn("FDAT", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnFDAT);
                this.columnTDAT = new DataColumn("TDAT", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnTDAT);
                this.columnIR = new DataColumn("IR", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnIR);
                this.columnBR = new DataColumn("BR", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnBR);
                this.columnOSTS = new DataColumn("OSTS", typeof(System.Decimal), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnOSTS);
                this.columnACRD = new DataColumn("ACRD", typeof(System.Decimal), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnACRD);
                this.columnKV_NAME = new DataColumn("KV_NAME", typeof(string), null, System.Data.MappingType.Element);
                this.Columns.Add(this.columnKV_NAME);
                this.columnTYPNACH.AllowDBNull = false;
                this.columnVALNAME.AllowDBNull = false;
                this.columnNBS.AllowDBNull = false;
                this.columnNLS.AllowDBNull = false;
                this.columnNMS.AllowDBNull = false;
                this.columnFDAT.AllowDBNull = false;
                this.columnTDAT.AllowDBNull = false;
                this.columnIR.AllowDBNull = false;
                this.columnBR.AllowDBNull = false;
                this.columnOSTS.AllowDBNull = false;
                this.columnACRD.AllowDBNull = false;
            }
            
            public dataAcrIntRow NewdataAcrIntRow() {
                return ((dataAcrIntRow)(this.NewRow()));
            }
            
            protected override DataRow NewRowFromBuilder(DataRowBuilder builder) {
                return new dataAcrIntRow(builder);
            }
            
            protected override System.Type GetRowType() {
                return typeof(dataAcrIntRow);
            }
            
            protected override void OnRowChanged(DataRowChangeEventArgs e) {
                base.OnRowChanged(e);
                if ((this.dataAcrIntRowChanged != null)) {
                    this.dataAcrIntRowChanged(this, new dataAcrIntRowChangeEvent(((dataAcrIntRow)(e.Row)), e.Action));
                }
            }
            
            protected override void OnRowChanging(DataRowChangeEventArgs e) {
                base.OnRowChanging(e);
                if ((this.dataAcrIntRowChanging != null)) {
                    this.dataAcrIntRowChanging(this, new dataAcrIntRowChangeEvent(((dataAcrIntRow)(e.Row)), e.Action));
                }
            }
            
            protected override void OnRowDeleted(DataRowChangeEventArgs e) {
                base.OnRowDeleted(e);
                if ((this.dataAcrIntRowDeleted != null)) {
                    this.dataAcrIntRowDeleted(this, new dataAcrIntRowChangeEvent(((dataAcrIntRow)(e.Row)), e.Action));
                }
            }
            
            protected override void OnRowDeleting(DataRowChangeEventArgs e) {
                base.OnRowDeleting(e);
                if ((this.dataAcrIntRowDeleting != null)) {
                    this.dataAcrIntRowDeleting(this, new dataAcrIntRowChangeEvent(((dataAcrIntRow)(e.Row)), e.Action));
                }
            }
            
            public void RemovedataAcrIntRow(dataAcrIntRow row) {
                this.Rows.Remove(row);
            }
        }
        
        [System.Diagnostics.DebuggerStepThrough()]
        public class dataAcrIntRow : DataRow {
            
            private dataAcrIntDataTable tabledataAcrInt;
            
            internal dataAcrIntRow(DataRowBuilder rb) : 
                    base(rb) {
                this.tabledataAcrInt = ((dataAcrIntDataTable)(this.Table));
            }
            
            public string ID {
                get {
                    try {
                        return ((string)(this[this.tabledataAcrInt.IDColumn]));
                    }
                    catch (InvalidCastException e) {
                        throw new StrongTypingException("Cannot get value because it is DBNull.", e);
                    }
                }
                set {
                    this[this.tabledataAcrInt.IDColumn] = value;
                }
            }
            
            public short LCV {
                get {
                    try {
                        return ((short)(this[this.tabledataAcrInt.LCVColumn]));
                    }
                    catch (InvalidCastException e) {
                        throw new StrongTypingException("Cannot get value because it is DBNull.", e);
                    }
                }
                set {
                    this[this.tabledataAcrInt.LCVColumn] = value;
                }
            }
            
            public string TYPNACH {
                get {
                    return ((string)(this[this.tabledataAcrInt.TYPNACHColumn]));
                }
                set {
                    this[this.tabledataAcrInt.TYPNACHColumn] = value;
                }
            }
            
            public string VALNAME {
                get {
                    return ((string)(this[this.tabledataAcrInt.VALNAMEColumn]));
                }
                set {
                    this[this.tabledataAcrInt.VALNAMEColumn] = value;
                }
            }
            
            public string NBS {
                get {
                    return ((string)(this[this.tabledataAcrInt.NBSColumn]));
                }
                set {
                    this[this.tabledataAcrInt.NBSColumn] = value;
                }
            }
            
            public string NLS {
                get {
                    return ((string)(this[this.tabledataAcrInt.NLSColumn]));
                }
                set {
                    this[this.tabledataAcrInt.NLSColumn] = value;
                }
            }
            
            public string NMS {
                get {
                    return ((string)(this[this.tabledataAcrInt.NMSColumn]));
                }
                set {
                    this[this.tabledataAcrInt.NMSColumn] = value;
                }
            }
            
            public string FDAT {
                get {
                    return ((string)(this[this.tabledataAcrInt.FDATColumn]));
                }
                set {
                    this[this.tabledataAcrInt.FDATColumn] = value;
                }
            }
            
            public string TDAT {
                get {
                    return ((string)(this[this.tabledataAcrInt.TDATColumn]));
                }
                set {
                    this[this.tabledataAcrInt.TDATColumn] = value;
                }
            }
            
            public string IR {
                get {
                    return ((string)(this[this.tabledataAcrInt.IRColumn]));
                }
                set {
                    this[this.tabledataAcrInt.IRColumn] = value;
                }
            }
            
            public string BR {
                get {
                    return ((string)(this[this.tabledataAcrInt.BRColumn]));
                }
                set {
                    this[this.tabledataAcrInt.BRColumn] = value;
                }
            }
            
            public System.Decimal OSTS {
                get {
                    return ((System.Decimal)(this[this.tabledataAcrInt.OSTSColumn]));
                }
                set {
                    this[this.tabledataAcrInt.OSTSColumn] = value;
                }
            }
            
            public System.Decimal ACRD {
                get {
                    return ((System.Decimal)(this[this.tabledataAcrInt.ACRDColumn]));
                }
                set {
                    this[this.tabledataAcrInt.ACRDColumn] = value;
                }
            }
            
            public string KV_NAME {
                get {
                    try {
                        return ((string)(this[this.tabledataAcrInt.KV_NAMEColumn]));
                    }
                    catch (InvalidCastException e) {
                        throw new StrongTypingException("Cannot get value because it is DBNull.", e);
                    }
                }
                set {
                    this[this.tabledataAcrInt.KV_NAMEColumn] = value;
                }
            }
            
            public bool IsIDNull() {
                return this.IsNull(this.tabledataAcrInt.IDColumn);
            }
            
            public void SetIDNull() {
                this[this.tabledataAcrInt.IDColumn] = System.Convert.DBNull;
            }
            
            public bool IsLCVNull() {
                return this.IsNull(this.tabledataAcrInt.LCVColumn);
            }
            
            public void SetLCVNull() {
                this[this.tabledataAcrInt.LCVColumn] = System.Convert.DBNull;
            }
            
            public bool IsKV_NAMENull() {
                return this.IsNull(this.tabledataAcrInt.KV_NAMEColumn);
            }
            
            public void SetKV_NAMENull() {
                this[this.tabledataAcrInt.KV_NAMEColumn] = System.Convert.DBNull;
            }
        }
        
        [System.Diagnostics.DebuggerStepThrough()]
        public class dataAcrIntRowChangeEvent : EventArgs {
            
            private dataAcrIntRow eventRow;
            
            private DataRowAction eventAction;
            
            public dataAcrIntRowChangeEvent(dataAcrIntRow row, DataRowAction action) {
                this.eventRow = row;
                this.eventAction = action;
            }
            
            public dataAcrIntRow Row {
                get {
                    return this.eventRow;
                }
            }
            
            public DataRowAction Action {
                get {
                    return this.eventAction;
                }
            }
        }
    }
}
