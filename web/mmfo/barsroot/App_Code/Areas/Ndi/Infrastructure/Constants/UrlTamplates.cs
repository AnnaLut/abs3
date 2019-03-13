using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UrlTamplates
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Constants
{
    public class UrlTamplates
    {
        public const string BaseUrlTemplate = "/barsroot/ndi/";
        public const string MainUrlTemplate = BaseUrlTemplate + "referencebook/GetRefBookData/";
        public const string CallFunctionUrl = BaseUrlTemplate + "referencebook/CallRefFunction/";
        public const string CallFuncWithMultypleRowsUrl = BaseUrlTemplate + "referencebook/CallFuncWithMultypleRows/";
        public const string ExternalUrlParam = "ExternalApiUrl";
        public UrlTamplates()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static readonly IList<string> AllTemplates = new ReadOnlyCollection<string>(
            new List<string>() {
            BaseUrlTemplate,
            MainUrlTemplate,
            CallFunctionUrl,
            CallFuncWithMultypleRowsUrl,
            ExternalUrlParam
             });

    }
}