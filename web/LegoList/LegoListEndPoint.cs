using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR;

namespace LegoList
{
    public class LegoListEndPoint : PersistentConnection
    {
        string retainedConnectionId;

        protected override Task OnConnected(IRequest request, string connectionId)
        {
            Console.WriteLine("Connection Id is {0}", connectionId);    
            
            return base.OnConnected(request, connectionId);
        }

        protected override Task OnReceived(IRequest request, string connectionId, string data)
        {
            this.retainedConnectionId = connectionId;

            // return base.OnReceived(request, connectionId, data);
            return Connection.Broadcast(data);
        }

        void SendMessage()
        {
            var MyMessage = "The time is now!  " + DateTime.Now.ToShortTimeString();

            if (null != Connection)
            {
                Connection.Broadcast(MyMessage);
            }
        }
    }
}