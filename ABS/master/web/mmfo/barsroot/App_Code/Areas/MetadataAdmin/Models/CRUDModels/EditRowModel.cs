﻿using BarsWeb.Areas.MetaDataAdmin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EditRowModel
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class EditRowModel
    {
        public EditRowModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        //public int RowNumber { get; set; }

        public List<FieldProperties> OldRow { get; set; }

        //public List<FieldProperties> NewRow { get; set; }

        //public List<FieldProperties> Keys { get; set; }

        public List<FieldProperties> Modified { get; set; }



    }
}