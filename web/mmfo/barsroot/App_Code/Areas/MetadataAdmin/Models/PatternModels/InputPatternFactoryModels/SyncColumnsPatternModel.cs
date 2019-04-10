using BarsWeb.Areas.MetaDataAdmin.Models.DbModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SyncColumnsPatternModel
/// </summary>

namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class SyncColumnsPatternModel : BaseInputFactoryModel
    {
        public SyncColumnsPatternModel()
        {
            //
            // TODO: Add constructor logic here
            //
            
        }

        public List<MetaColumnsDbModel> DbInfoCoumnsBySchema { get; set; }
        public List<MetaColumnsDbModel> MetaColumns { get; set; }
    }
}