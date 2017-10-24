using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using Areas.InsUi.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.InsUi.Infrastructure.DI.Implementation
{
    public class InsModel : IInsModel
    {
        private InsuranceEntities _entities;
        public InsuranceEntities InsuranceEntities
        {
            get
            {
                if (_entities == null)
                {
                    var connectionStr = EntitiesConnection.ConnectionString("InsuranceModel", "InsUi");
                    _entities = new InsuranceEntities(connectionStr);
                }
                return _entities;
            }
        }
    }
}
