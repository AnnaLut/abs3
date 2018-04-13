using System;

namespace EasySMPP
{
    public class KernelParameters
    {
        public const int MaxBufferSize = 1048576; // 1MB

        public const int MaxPduSize = 131072;

        public const int ReconnectTimeout = 60000; // miliseconds

        public const int WaitPacketResponse = 30; //seconds

        public const int CanBeDisconnected = 180; //seconds - BETTER TO BE MORE THAN TryToReconnectTimeOut

        public const int NationalNumberLength = 8;

        public const int MaxUndeliverableMessages = 30;

        public const int AskDeliveryReceipt = 0; //NoReceipt = 0;

        public const bool SplitLongText = true;

        public const bool UseEnquireLink = false;

        public const int EnquireLinkTimeout = 60000; //miliseconds
    }
}
