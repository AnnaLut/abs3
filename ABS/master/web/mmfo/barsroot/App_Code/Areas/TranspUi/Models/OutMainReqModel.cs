using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OutMainReqModel
/// </summary>
namespace Areas.TranspUi.Models
{
    public class OutMainReqModel
    {
        public string Id { get; set; }
        public string SendType { get; set; }
        public DateTime? InsDate { get; set; }
        public string Status { get; set; } 
        public DateTime? DoneDate { get; set; }
        public decimal? UserId { get; set; }
        public string UserKf { get; set; }
    }
}