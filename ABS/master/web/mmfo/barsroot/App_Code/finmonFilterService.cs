using System.Web.Services;

/// <summary>
/// Summary description for finmonFilterService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class finmonFilterService : WebService
{
    const string FILTER_PARAMS_KEY = "FilterParams";

    private string FilterParams
    {
        set
        {
            Session[FILTER_PARAMS_KEY] = value;
        }
    }

    [WebMethod(EnableSession = true)]
    public void SetMetaFilterParams(string param)
    {
        FilterParams = param;
    }

}
