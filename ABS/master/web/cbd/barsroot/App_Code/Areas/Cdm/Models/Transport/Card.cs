using System.Collections.Generic;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class Card
    {
        public BatchParams Request { get; set; }
        public List<BufClientData> ClientCard { get; set; }
        public Card(string kf, string batchId, List<BufClientData> body)
        {
            Request = new BatchParams()
            {
                BatchId = batchId,
                Kf = kf
            };
            ClientCard = body;
        }

    }
}