using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Subvention.Models
{
    public class Package
    {
        public string Id { set; get; }
        public int UnitTypeId { set; get; }
        public string ExternalFileId { set; get; }
        public string ReceiverUrl { set; get; }
        public byte[] RequestData { set; get; }
        public byte[] ResponseData { set; get; }
        public short StateId { set; get; }
        public short FailuresCount { set; get; }
        public string Kf { set; get; }
        public DateTime? SysTime { set; get; }
        public string StateText
        {
            get
            {
                if (_states.ContainsKey(StateId)) return _states[StateId];
                return "";
            }
        }

        private Dictionary<short, string> _states = new Dictionary<short, string> {
            { 1 , "Очікує обробки" },
            { 2 , "Помилка обробки" },
            { 6 , "Оброблено" }
        };
    }
}