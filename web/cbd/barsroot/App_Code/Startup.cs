using System.Web.Routing;
using Microsoft.Owin;
using Owin;
using System.Threading.Tasks;

//using Microsoft.AspNet.SignalR;

[assembly: OwinStartup(typeof(BarsWeb.Startup))]
namespace BarsWeb
{
    
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //RouteTable.Routes.MapHubs();
            //RouteTable.Routes.MapConnection<MyConnection>("echo", "/echo");
            //RouteTable.Routes.MapHubs(new HubConfiguration { EnableCrossDomain = true });
        }
    }
    /*public class MyConnection : PersistentConnection
    {
        protected override Task OnReceived(IRequest request, string connectionId, string data)
        {
            // Broadcast data to all clients
            return Connection.Broadcast(data);
        }
    }*/
}
