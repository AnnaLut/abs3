using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UrlTamplates
/// </summary>
public class UrlTamplates
{
    public static string BaseUrlTemplate = "/barsroot/ndi/";
    public static string MainUrlTemplate = BaseUrlTemplate + "referencebook/GetRefBookData/";
    public static string CallFunctionUrl = BaseUrlTemplate + "referencebook/CallRefFunction/";
    public static string CallFuncWithMultypleRowsUrl = BaseUrlTemplate + "referencebook/CallFuncWithMultypleRows/";

    public UrlTamplates()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static List<string> GetAllUrlTamplates()
    {
        List<string> allTemplates = new List<string>()
        {
            BaseUrlTemplate,
            MainUrlTemplate,
            CallFunctionUrl,
            CallFuncWithMultypleRowsUrl
        };
        return allTemplates;
    }
}