using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure
{
    partial class ModelConverter
    {
        public static CLIM_PARAMS ToDbModel(Param viewModel)
        {
            var dbModel = new CLIM_PARAMS
            {
                COMM = viewModel.Comment,
                PARAM = viewModel.Name,
                VAL = viewModel.Value
            };
            return dbModel;
        }

        public static IQueryable<Param> ToViewModel(IQueryable<CLIM_PARAMS> dbModel)
        {
            return dbModel.Select(x => new Param
            {
                Comment = x.COMM,
                Name = x.PARAM,
                Value = x.VAL
            });
        }
    }
}