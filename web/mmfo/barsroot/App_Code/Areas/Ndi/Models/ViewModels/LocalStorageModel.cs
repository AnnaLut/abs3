using barsroot.core;
using BarsWeb.Areas.Ndi.Models.DbModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LocalStorageModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    public class LocalStorageModel
    {
        public LocalStorageModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public LocalStorageModel(MetaTable tableInfo,UserMap user)
        {
            HiddenColumnsViewModel  = new HiddenColumnsViewModel(tableInfo, user);
            FiltersStorageKey = user.user_id + "_" + tableInfo.TABID;
        }


        public string FiltersStorageKey { get; set; }
        public HiddenColumnsViewModel HiddenColumnsViewModel;
        

    }
}