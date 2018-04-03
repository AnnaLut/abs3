<%@ WebHandler Language="C#" Class="metahandler" %>

using System;
using System.Linq;
using System.Web;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Web;
using System.Web.SessionState;
using System.Web.Script.Serialization;

public struct JqGridResults
{
    public int page;
    public int total;
    public int records;
    public List<string[]> rows;
}

public class metahandler : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;

        string actionPage = request["ActionPage"];
        string action = request["Action"];

        if (actionPage != "TransportType")
            return;

        switch (action)
        {
            case "Fill":
                string numberOfRows = request["rows"];
                string pageIndex = request["page"];
                string sortColumnName = request["sidx"];
                string sortOrderBy = request["sord"];
                string search = request["isSearch"];
                string filters = request["filters"];
                bool isSearch = search != null && String.Compare(search, "true", StringComparison.Ordinal) == 0;
                string output = BuildJqGridResults(Convert.ToInt32(numberOfRows), Convert.ToInt32(pageIndex), sortColumnName, sortOrderBy, isSearch, filters);
                response.Cache.SetMaxAge(new TimeSpan(0));
                response.ContentType = "application/json";
                response.Write(output);
                break;
            case "Update":
                {
                    /*int id = int.Parse(request["id"], CultureInfo.InvariantCulture);
                    User user = MyRepository.users[id];
                    user.UserName = request["UserName"];
                    user.FirstName = request["FirstName"];
                    user.MiddleName = request["MiddleName"];
                    user.LastName = request["LastName"];
                    user.Email = request["Email"];*/
                    break;
                }
            case "Insert":
                {
                    /*int newId = ++MyRepository.maxUserId;
                    MyRepository.users.Add(new User
                    {
                        UserId = newId,
                        UserName = request["UserName"],
                        FirstName = request["FirstName"],
                        MiddleName = request["MiddleName"],
                        LastName = request["LastName"],
                        Email = request["Email"]
                    });
                    response.Write(newId.ToString(CultureInfo.InvariantCulture));*/
                    break;
                }
            case "Delete":
                {
                    /*int id = int.Parse(request["id"], CultureInfo.InvariantCulture);
                    MyRepository.users.Remove(id);*/
                    break;
                }
        }
    }

    private static string BuildJqGridResults(int numberOfRows, int pageIndex,
                                                string sortColumnName, string sortOrderBy,
                                                bool isSearch, string filters)
    {
        //barsroot.cim.BeneficiarClass bc = new barsroot.cim.BeneficiarClass();
        //var users = bc.GetBeneficiares();
        cim.VCimBeneficiaries cb = new cim.VCimBeneficiaries();
        List<cim.VCimBeneficiariesRecord> list = cb.Select();

        int totalRecords = list.Count;
        var result = new JqGridResults
        {
            page = pageIndex,
            total = (totalRecords + numberOfRows - 1) / numberOfRows,
            records = totalRecords,
            rows = (from item in list
                    select new[] {
                            item.BENEF_ID.ToString(),
                            item.BENEF_NAME,
                            item.COUNTRY_NAME,
                            item.BENEF_ADR,
                            item.COMMENTS
                        }).ToList()
        };
        
        return new JavaScriptSerializer().Serialize(result);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}