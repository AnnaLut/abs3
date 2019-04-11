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
        public const string HiddenColumnsKeyPrefix = "hiddenColumnsKey";
        public string FiltersStorageKey { get; set; }

        public string HiddenColumnsKey { get; set; }

    }
}