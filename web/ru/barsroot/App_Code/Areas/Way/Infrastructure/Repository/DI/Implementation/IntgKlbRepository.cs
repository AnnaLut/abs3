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

namespace BarsWeb.Areas.WayKlb.Infrastructure.DI.Implementation
{
    public class IntgKlbRepository : IIntgKlbRepository
    {
        public List<Product> GetProductList()
        {
            List<Product> pr = new List<Product>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select id, sjson from table(bars.INTG_WB.get_dpt_products)";
                /*OracleParameter oraP = new OracleParameter();
                oraP.OracleDbType = OracleDbType.RefCursor;
                oraP.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(oraP); */
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Product p = new Product();
                    p.ID = Convert.ToInt32(reader.GetValue(0).ToString());
                    p.JSON = reader.GetValue(1).ToString();
                    pr.Add(p);
                }
                reader.Close();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return pr;
        }

        public Product GetProductById(decimal id)
        {
            Product pr = new Product();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select id, sjson from table(bars.INTG_WB.get_dpt_product(:p_id))";
                cmd.Parameters.Add("p_id", OracleDbType.Decimal, id, System.Data.ParameterDirection.Input);
                /*OracleParameter oraP = new OracleParameter();
                oraP.OracleDbType = OracleDbType.RefCursor;
                oraP.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(oraP); */
                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    pr.ID = Convert.ToInt32(reader.GetValue(0).ToString());
                    pr.JSON = reader.GetValue(1).ToString();
                }
                reader.Close();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return pr;
        }
    }
}