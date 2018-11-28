using BarsWeb.Areas.Bills.Model;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for IKendoBillsSqlTransformer
    /// </summary>
    public interface IKendoBillsSqlTransformer
    {
        BillsSql TransformSql(BillsSql sql, DataSourceRequest request, string[] dateFieldsNames = null, string extraConditions = "");
    }
}