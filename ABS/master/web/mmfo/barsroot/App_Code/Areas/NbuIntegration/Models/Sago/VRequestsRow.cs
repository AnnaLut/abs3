using System;

namespace Areas.NbuIntegration.Models
{
    public class VRequestsRow
    {
        public VRequestsRow()
        {
            CreateDate = DateTime.Now;
        }

        public decimal? Id { get; set; }

        public int State { get; set; }

        public decimal? UserId { get; set; }

        public int DocCount { get; set; }

        public int DocCountPayed { get; set; }

        public string Comment { get; set; }

        public string UserName { get; set; }

        public DateTime? CreateDate { get; set; }

        public string Data { get; set; }
    }

    public class ReqSaveRes
    {
        public ReqSaveRes()
        {
            CountDocs = 0;
            CountDocsInserted = 0;
            TotalSum = 0M;
        }

        /// <summary>
        /// sago_requests.id
        /// </summary>
        public decimal? Id { get; set; }
        public string ErrMsg { get; set; }
        public int CountDocs { get; set; }
        public int CountDocsInserted { get; set; }
        public decimal TotalSum { get; set; }
    }
}