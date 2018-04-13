namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public partial class masterCard
    {

        private string gcifField;

        private Client[] slaveClientField;

        private string rnkField;

        private string kfField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string gcif
        {
            get { return this.gcifField; }
            set { this.gcifField = value; }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("slaveClient")]
        public Client[] slaveClient
        {
            get { return this.slaveClientField; }
            set { this.slaveClientField = value; }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute(DataType = "integer")]
        public string rnk
        {
            get { return this.rnkField; }
            set { this.rnkField = value; }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute(DataType = "integer")]
        public string kf
        {
            get { return this.kfField; }
            set { this.kfField = value; }
        }
    }

}