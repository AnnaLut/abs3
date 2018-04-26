using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.WayKlb.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.WayKlb.Infrastructure.DI.Abstract
{
    public interface IIntgKlbRepository
    {
        //List<Product> GetProductList();
        //Product GetProductById(decimal id);
        List<Product> GetProductList(OracleConnection connection, decimal? id = null);
    }
}