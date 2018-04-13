using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public enum ConnectionCommand
{
    CONNECT,
    DISCONNECT
}

/// <summary>
/// Summary description for ConnectionProtocol
/// </summary>
public static class ConnectionProtocol
{
    public static String PROTOCOL_GET_PARAMETER_NAME = "cpsp";
    public static String CLIENT_GUID_PARAMETER_NAME = "cid";
}
