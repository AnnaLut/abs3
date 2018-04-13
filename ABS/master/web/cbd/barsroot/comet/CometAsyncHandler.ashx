<%@ WebHandler Language="C#" Class="CometAsyncHandler" %>

using System;
using System.Web;

using DevelopMentor;

public class CometAsyncHandler : IHttpAsyncHandler, System.Web.SessionState.IReadOnlySessionState
{
    static private ThreadPool _threadPool;

    static CometAsyncHandler()
    {
        _threadPool = new ThreadPool(2, 100, "Comet Pool");
        _threadPool.PropogateCallContext = true;
        _threadPool.PropogateThreadPrincipal = true;
        _threadPool.PropogateHttpContext = true;
        _threadPool.Start();
    }

    public IAsyncResult BeginProcessRequest(HttpContext ctx, AsyncCallback cb, Object obj)
    {
        CometAsyncRequestState currentAsyncRequestState = new CometAsyncRequestState(ctx, cb, obj);
        _threadPool.PostRequest(new WorkRequestDelegate(ProcessServiceRequest), currentAsyncRequestState);

        return currentAsyncRequestState;
    }

    private void ProcessServiceRequest(Object state, DateTime requestTime)
    {
        CometAsyncRequestState currentAsyncRequestState = state as CometAsyncRequestState;

        if (currentAsyncRequestState.CurrentContext.Request.QueryString[ConnectionProtocol.PROTOCOL_GET_PARAMETER_NAME] ==
            ConnectionCommand.CONNECT.ToString())
        {
            CometClientProcessor.AddClient(currentAsyncRequestState);
            currentAsyncRequestState.CurrentContext.Response.Write(currentAsyncRequestState.ClientGuid.ToString());
            currentAsyncRequestState.CompleteRequest();
        }
        else if (currentAsyncRequestState.CurrentContext.Request.QueryString[ConnectionProtocol.PROTOCOL_GET_PARAMETER_NAME] ==
            ConnectionCommand.DISCONNECT.ToString())
        {
            CometClientProcessor.RemoveClient(currentAsyncRequestState,
                currentAsyncRequestState.CurrentContext.Request.QueryString[ConnectionProtocol.CLIENT_GUID_PARAMETER_NAME].ToString());
            currentAsyncRequestState.CompleteRequest();
        }
        else
        {
            if (currentAsyncRequestState.CurrentContext.Request.QueryString[ConnectionProtocol.CLIENT_GUID_PARAMETER_NAME] != null)
            {
                CometClientProcessor.UpdateClient(currentAsyncRequestState, 
                    currentAsyncRequestState.CurrentContext.Request.QueryString[ConnectionProtocol.CLIENT_GUID_PARAMETER_NAME].ToString());
            }
        }
    }

    public void EndProcessRequest(IAsyncResult ar)
    {
    }

    public void ProcessRequest(HttpContext context)
    {
    }

    public bool IsReusable
    {
        get
        {
            return true;
        }
    }
}