using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DataFormatModel
/// </summary>
public class DataFormatModel
{
	public DataFormatModel()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public DataFormatModel(string numberFormat = "",string dateFormat = "")
    {
        this.NumberFormat = numberFormat;
        this.DateFormat = dateFormat; 
    }
    
    public string NumberFormat{get;set;}
    public string DateFormat{get;set;}


}