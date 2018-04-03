using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Messaging;


/// <summary>
/// Класс для возможности обмена сообщениями между пользователями веб 
/// </summary>
public class BarsMessaging
{
    public BarsMessaging(){}

    private const string queueAdminPath = @".\private$\barsroot";
    private const string queuePath = @".\private$\barsroot#";

    public static void CreateMessage(string usersName, Message message, bool copyAdmin)
    {
        MessageQueue messageQueue;

        foreach (string userName in usersName.Split(';'))
        {
            string userQueuePath = queuePath + userName;

            if (MessageQueue.Exists(userQueuePath))
                messageQueue = new MessageQueue(userQueuePath);
            else
                messageQueue = MessageQueue.Create(userQueuePath);

            messageQueue.Send(message);
        }
        if(copyAdmin)
        {
            if (MessageQueue.Exists(queueAdminPath))
                messageQueue = new MessageQueue(queueAdminPath);
            else
                messageQueue = MessageQueue.Create(queueAdminPath);

            messageQueue.Send(message);
        }
    }
}
