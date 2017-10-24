using System.Collections.Generic;
using BarsWeb.Areas.Crkr.Models;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface IDoposProfileRepository
    {
        DepositProfile GetProfile(decimal id);
        List<TrustedPerson> GetTrustedPersons(decimal id);
        List<TrustedPerson> GetHeirsPersons(decimal ID_COMPEN);
        List<History> GetHistories(decimal ID_COMPEN);

        ClientProfile ClientInfo(string rnk);
    }
}