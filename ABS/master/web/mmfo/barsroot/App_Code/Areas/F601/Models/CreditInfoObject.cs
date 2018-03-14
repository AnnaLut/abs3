using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.F601.Models
{
    /// <summary>
    /// Summary description for CreditInfoObject
    /// </summary>
    public class CreditInfoObject
    {
        public CreditInfoObject()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private long id;
        private string objectType;
        private string objectCode;
        private string name;
        private string dataLink;
        private string status;
        private DateTime packetCreationDate;
        private DateTime packetTransmissionDate;
        private string errorsDescription;

        public long Id
        {
            get
            {
                return id;
            }

            set
            {
                id = value;
            }
        }

        public string ObjectType
        {
            get
            {
                return objectType;
            }

            set
            {
                objectType = value;
            }
        }

        public string ObjectCode
        {
            get
            {
                return objectCode;
            }

            set
            {
                objectCode = value;
            }
        }

        public string Name
        {
            get
            {
                return name;
            }

            set
            {
                name = value;
            }
        }

        public string DataLink
        {
            get
            {
                return dataLink;
            }

            set
            {
                dataLink = value;
            }
        }

        public string Status
        {
            get
            {
                return status;
            }

            set
            {
                status = value;
            }
        }

        public DateTime PacketCreationDate
        {
            get
            {
                return packetCreationDate;
            }

            set
            {
                packetCreationDate = value;
            }
        }

        public DateTime PacketTransmissionDate
        {
            get
            {
                return packetTransmissionDate;
            }

            set
            {
                packetTransmissionDate = value;
            }
        }

        public string ErrorsDescription
        {
            get
            {
                return errorsDescription;
            }

            set
            {
                errorsDescription = value;
            }
        }
    }
}