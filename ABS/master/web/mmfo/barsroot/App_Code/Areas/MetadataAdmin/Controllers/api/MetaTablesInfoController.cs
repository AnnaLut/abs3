using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb;
/// <summary>
/// Summary description for MetaTablesInfoController
/// </summary>

[Authorize]
[AuthorizeApi]
[CheckAccessPage]
public class MetaTablesInfoController
{
    public MetaTablesInfoController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}