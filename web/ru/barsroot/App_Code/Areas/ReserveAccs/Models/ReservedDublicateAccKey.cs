using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.ReserveAccs.Models.Bases
{
	public class ReservedDublicateAccKey
	{
		public decimal acc { get; set; }
		public List<decimal> kv { get; set; }
	}
}