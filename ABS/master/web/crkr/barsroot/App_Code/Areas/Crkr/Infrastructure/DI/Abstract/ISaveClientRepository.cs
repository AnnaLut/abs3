using System;
using BarsWeb.Areas.Crkr.Controllers.Api;
using BarsWeb.Areas.Crkr.Models;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface ISaveClientRepository
    {
        string ClientAccounts(AccountInfo model);

        long CreateClient(ClientProfile megamodel);
        long CreateBenef(BenefProfile model);
    }
}
