using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EditRowModel
/// </summary>
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