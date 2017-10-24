﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CreateFilterModel
/// </summary>
public class CreateFilterModel
{
	public CreateFilterModel()
	{
     
	}


    public string Parameters { get; set; }
    public FilterType FilterType { get; set; }
    public List<FilterRowInfo> FilterRows { get; set; }
    public string FilterTypeDescription { get; set; }
    public int SaveFilter = 1;
    public string WhereClause { get; set; }

   
}

