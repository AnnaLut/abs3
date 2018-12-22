using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Bars.CommonModels;

/// <summary>
/// Model for execute sql in other process
/// </summary>
namespace Bars.CommonModels.ExternUtilsModels
{

    public class SelectModel
    {
        public SelectModel()
        {
           SqlParams = new List<SqlParamModel>();
        }

        public string SelectString { get; set; }

        public List<SqlParamModel> SqlParams { get; set; }

    }
}