<%@ WebHandler Language="C#" Class="metahandler" %>

using System;
using barsroot.cim;
using System.Web;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Web;
using System.Web.SessionState;
using System.Web.Script.Serialization;

public struct JQGridResults
{
    public int page;
    public int total;
    public int records;
    public JQGridRow[] rows;
}
public struct JQGridRow
{
    public int id;
    public string[] cell;
}

public class metahandler : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;

        //string actionPage = request["ActionPage"];
        string action = request["action"];
        string method = request["method"];
        string contrId = request["contrId"];

        switch (action)
        {
            case "fill":
                string numberOfRows = request["rows"];
                string pageIndex = request["page"];
                string sortColumnName = request["sidx"];
                string sortOrderBy = request["sord"];
                string search = request["isSearch"];
                string filters = request["filters"];
                bool isSearch = search != null && String.Compare(search, "true", StringComparison.Ordinal) == 0;
                string output = BuildJqGridResults(method, contrId, Convert.ToInt32(numberOfRows), Convert.ToInt32(pageIndex), sortColumnName, sortOrderBy, isSearch, filters);
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

    private static string BuildJqGridResults(string method, string contrId, int numberOfRows, int pageIndex, string sortColumnName, string sortOrderBy, bool isSearch, string filters)
    {
        DataTable dt = new DataTable();
        if (!string.IsNullOrEmpty(contrId))
        {
            if (method == "BuildCredGraph")
            {
                CreditContractClass ccc = new CreditContractClass();
                dt = ccc.BuildCredGraph(Convert.ToDecimal(contrId));
            }
        }  
        
        //cim.VCimBeneficiaries cb = new cim.VCimBeneficiaries();
        //List<cim.VCimBeneficiariesRecord> list = cb.Select();

        int totalRecords = dt.Rows.Count;
        var result = new JqGridResults
        {
            page = pageIndex,
            total = (totalRecords + numberOfRows - 1) / numberOfRows,
            records = totalRecords,
            //rows = dt.Rows.Cast<DataRow>();
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