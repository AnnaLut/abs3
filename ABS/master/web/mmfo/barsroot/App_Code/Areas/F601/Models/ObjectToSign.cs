using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ObjectToSign
/// </summary>
public class ObjectToSign
{
    public ObjectToSign()
    {
    }

    private int sessionId;

    private string payloadInBase64Url;

    private string protectedInBase64Url;

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

    public string PayloadInBase64Url
    {
        get
        {
            return payloadInBase64Url;
        }

        set
        {
            payloadInBase64Url = value;
        }
    }

    public string ProtectedInBase64Url
    {
        get
        {
            return protectedInBase64Url;
        }

        set
        {
            protectedInBase64Url = value;
        }
    }
}