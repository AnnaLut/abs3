using System;
using System.Collections.Generic;
using Bars.Application;
using System.Threading;
using System.Web;

/// <summary>
/// Summary description for CometWaitHandlerStorage
/// </summary>
public static class CometClientProcessor
{
    private static Object _lockObj;
    private static List<CometAsyncRequestState> _clientStateList;

    static CometClientProcessor()
    {
        _lockObj = new Object();
        _clientStateList = new List<CometAsyncRequestState>();
    }

    public static void PushData(string UserLogin, String pushedData)
    {
        List<CometAsyncRequestState> currentStateList = new List<CometAsyncRequestState>();

        lock (_lockObj)
        {
            foreach (CometAsyncRequestState clientState in _clientStateList)
            {
                currentStateList.Add(clientState);
            }
        }

        foreach (CometAsyncRequestState clientState in currentStateList)
        {
            if (clientState.CurrentContext.Session != null && ((CustomIdentity)clientState.CurrentContext.User.Identity).Name.ToLower() == UserLogin.ToLower())
            {
                clientState.CurrentContext.Response.Write(pushedData);
                clientState.CompleteRequest();
            }
        }
    }

    public static void AddClient(CometAsyncRequestState state)
    {
        Guid newGuid;

        lock (_lockObj)
        {
            while (true)
            {
                newGuid = Guid.NewGuid();
                if (_clientStateList.Find(s => s.ClientGuid == newGuid) == null)
                {
                    state.ClientGuid = newGuid;
                    break;
                }
            }

            _clientStateList.Add(state);
        }
    }

    public static void UpdateClient(CometAsyncRequestState state, String clientGuidKey)
    {
        Guid clientGuid = new Guid(clientGuidKey);

        lock (_lockObj)
        {
            CometAsyncRequestState foundState = _clientStateList.Find(s => s.ClientGuid == clientGuid);

            if (foundState != null)
            {
                foundState.CurrentContext = state.CurrentContext;
                foundState.ExtraData = state.ExtraData;
                foundState.AsyncCallback = state.AsyncCallback;
            }
        }
    }

    public static void RemoveClient(CometAsyncRequestState state)
    {
        lock (_lockObj)
        {
            _clientStateList.Remove(state);
        }
    }
    public static void RemoveClient(CometAsyncRequestState state, String clientGuidKey)
    {
        Guid clientGuid = new Guid(clientGuidKey);
        lock (_lockObj)
        {
            CometAsyncRequestState foundState = _clientStateList.Find(s => s.ClientGuid == clientGuid);
            if (foundState != null)
            {
                _clientStateList.Remove(foundState);                
            }

        }
    }

}
