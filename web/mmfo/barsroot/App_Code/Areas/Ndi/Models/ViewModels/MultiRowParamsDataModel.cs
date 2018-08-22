﻿using BarsWeb.Areas.Ndi.Models;
using BarsWeb.Areas.Ndi.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


/// <summary>
/// Summary description for MultiParamsDataModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Helpers.ViewModels
{
    public class MultiRowParamsDataModel : ParamMetaInfo
    {
        public MultiRowParamsDataModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public List<FieldProperties> InputParams { get; set; }



        public List<CallFuncRowParam> RowsData { get; set; }

        public HttpPostedFileBase UploadedFile { get; set; }


    }
}