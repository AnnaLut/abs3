using Areas.KFiles.Models;
using BarsWeb.Areas.KFiles.Infrastructure.DI.Abstract;
using BarsWeb.Areas.KFiles.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Implementation
{
    public class KFilesModel : IKFilesModel
    {
        private KFilesEntities _entities;
        public KFilesEntities KFilesEntities
        {
            get
            {
                if (_entities == null)
                {
                    var connectionStr = EntitiesConnection.ConnectionString("KFilesModel", "KFiles");
                    _entities = new KFilesEntities(connectionStr);
                }
                return _entities;
            }
        }
    }
}
