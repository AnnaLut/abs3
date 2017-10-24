using Areas.Messages.Models;
using BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Implementation
{
    public class MessagesModel : IMessagesModel
    {
        private MessagesEntities _entities;
        public MessagesEntities MessagesEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("MessagesModel","Messages");
                return _entities ?? new MessagesEntities(connectionStr);
            }
        }
    }
}
