using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.CustAcc.Models;

/// <summary>
/// Summary description for ExecuteRepository
/// </summary>
public interface IExecuteRepository
{
    CheckResult NbsReservCheck(decimal acc, string nbs);
}