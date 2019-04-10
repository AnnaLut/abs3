using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetFileFromTable
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class GetFileFromTable : GetFileParInfo
    {
        public GetFileFromTable()
        {
            this.GetFrom = "SELECT_FROM_TABLE";
            this.Kind = "GET_FILE_FROM_TABLE";

        }
        public string ColNameGetFrom { get; set; }
        public string TableNameFrom { get; set; }
        public string ExecSelect { get; set; }
    }
}