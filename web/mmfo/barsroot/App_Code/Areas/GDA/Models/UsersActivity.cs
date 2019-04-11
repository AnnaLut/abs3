using System;
using System.Xml.Serialization;
using System.Collections.Generic;
namespace Xml2CSharp
{
    [XmlRoot(ElementName = "ROOT")]
    public class UsersActivity
    {
        [XmlElement(ElementName = "OperatorSysTime")]
        public string OperatorSysTime { get; set; }
        [XmlElement(ElementName = "OperatorFullName")]
        public string OperatorFullName { get; set; }
        [XmlElement(ElementName = "ControllerSysTime")]
        public string ControllerSysTime { get; set; }
        [XmlElement(ElementName = "ControllerFullName")]
        public string ControllerFullName { get; set; }
    }

}