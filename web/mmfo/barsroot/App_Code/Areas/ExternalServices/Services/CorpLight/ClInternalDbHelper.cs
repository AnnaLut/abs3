using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InternalDbHelper
/// </summary>
namespace BarsWeb.Areas.ExternalServices.Services.CorpLight
{
    public class ClInternalDbHelper
    {
        public ClInternalDbHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public ICurrencyOperations CurrencyRepo { get; set; }
    }
}