using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ToSignObject
/// </summary>
public class ToSignObject
{
    public ToSignObject()
    {
    }

    private int sessionId;

    private string payloadToSign;

    public int SessionId
    {
        get
        {
            return sessionId;
        }

        set
        {
            sessionId = value;
        }
    }

    public string PayloadToSign
    {
        get
        {
            return payloadToSign;
        }

        set
        {
            payloadToSign = value;
        }
    }
}