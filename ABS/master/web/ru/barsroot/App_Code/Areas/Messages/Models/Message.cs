using System;

namespace BarsWeb.Areas.Messages.Models
{
    public class Message
    {
        public int? Id { get; set; }
        public string UserName { get; set; }
        public string SenderName { get; set; }
        public int? TypeId { get; set; }
        public string Text { get; set; }
        public DateTime SendDate { get; set; }
        public DateTime ReadDate { get; set; }

    }

}
