using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract
{
    public interface ITresholdRepository
    {
        IQueryable<Treshold> GetAllTresholds();
        List<Treshold> GetCurrentTresholds(string date); 
        Treshold GetTreshold(int id);
        List<Treshold> GetTresholdHistory(string type, string mfo, decimal curFlag);
        Treshold AddTreshold(Treshold treshold);
        Treshold EditTreshold(Treshold treshold);
        bool DeleteTreshold(int id);
    }
}
