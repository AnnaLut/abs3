using System;
using System.Net.Sockets;

namespace EasySMPP
{
    class StateObject
    {
        public Socket workSocket = null;								// Client socket.
        public const int BufferSize = KernelParameters.MaxBufferSize;      // Size of receive buffer.
        public int Position = 0;										// Size of receive buffer.
        public byte[] buffer = new byte[BufferSize];					// receive buffer.
    }
}
