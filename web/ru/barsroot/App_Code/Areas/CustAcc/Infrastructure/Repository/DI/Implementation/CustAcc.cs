using Areas.CustAcc.Models;
using BarsWeb.Areas.CustAcc.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.CustAcc.Infrastructure.Repository.DI.Implementation
{
    public class CustAcc : ICustAcc
    {
        private CustAccModel _entities;
        public CustAccModel CustAccModel
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("CustAccModel", "CustAcc");
                return _entities ?? new CustAccModel(connectionStr);
            }
        }
    }
}