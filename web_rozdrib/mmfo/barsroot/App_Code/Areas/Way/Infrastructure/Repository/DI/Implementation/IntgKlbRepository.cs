using BarsWeb.Areas.WayKlb.Infrastructure.DI.Abstract;
using BarsWeb.Areas.WayKlb.Models;
using BarsWeb.Models;
using System.Linq;
using System;
using System.Text;
using System.Web;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using Bars.WebServices;
using System.Data;
using barsroot.core;

namespace BarsWeb.Areas.WayKlb.Infrastructure.DI.Implementation
{
    public class IntgKlbRepository : IIntgKlbRepository
    {
        public List<Product> GetProductList(OracleConnection connection, decimal? id = null)
        {
            List<Product> pr = new List<Product>();
            using (OracleCommand cmd = connection.CreateCommand())
            {
                string methodName = null == id ? "get_dpt_products" : "get_dpt_product(:p_id)";
                if (null != id)
                    cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Decimal, id, ParameterDirection.Input));

                cmd.CommandType = CommandType.Text;
                cmd.CommandText = string.Format("select id, sjson from table(bars.INTG_WB.{0})", methodName);

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Product p = new Product();
                        p.ID = Convert.ToInt32(reader.GetValue(0).ToString());
                        p.JSON = reader.GetValue(1).ToString();
                        pr.Add(p);
                    }
                }
            }
            return pr;
        }
    }
}