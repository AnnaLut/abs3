using System.Linq;
using BarsWeb.Areas.CreditUi.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract
{
    public interface IProvideRepository
    {
        //get lists
        IQueryable<ProvideList> GetProvideList(decimal refID, decimal? tip);
        IQueryable<ExistProvide> GetProvidePerRef(decimal refID, decimal? tip);

        //CRUD
        void BindProvideGroup(decimal refID, List<decimal> ACC_list, int mode, int tip);
        void CreateOrEditGroupProvide(List<UpdateProvide> list_provide, decimal? id, decimal? accs);

        //get Dictionary
        List<PAWNList> GetPawn(string nls);
        List<KVList> GetKV();
        List<MPAWNList> GetMPAWN();
        List<RNKList> GetRNK();

        //get data to inputs
        ProvideStaticData GetStaticDataKredit(decimal refID);
        ProvideStaticData GetStaticDataBPK(decimal refID);

    }
}