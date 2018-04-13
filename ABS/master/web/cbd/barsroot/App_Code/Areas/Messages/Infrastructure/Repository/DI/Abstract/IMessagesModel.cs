using Areas.Messages.Models;

namespace BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Abstract
{
    public interface IMessagesModel
    {
        MessagesEntities MessagesEntities { get; }
    }
}
