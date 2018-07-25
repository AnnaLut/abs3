using System.Collections.Generic;
using BarsWeb.Areas.Mbdk.Models;
using System.Linq;

namespace BarsWeb.Areas.Mbdk.Infrastructure.DI.Abstract
{
    public interface INostroRepository
    {
        List<NostroPortfolioRow> GetNostroList();
        void InsertNostro(InsertNostroPortfolioRow row);
        void UpdateNostro(UpdateNostroPortfolioRow row);
        void DeleteNostro(decimal nd);
        void PulSetMasIni(string nd);
        NostroDataList GetDataList();
    }
}
