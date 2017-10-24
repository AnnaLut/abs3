using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.Areas.DptSocial.Models
{
    public class PATH
    {
        public String path { get; set; }
        public Int32 id { get; set; }
        public PATH()
        {
        }
        public PATH(String _path, Int32 _id)
        {
            path = _path;
            id = _id;
        }
    }
}