using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Ndi.Models;
/// <summary>
/// Summary description for DependencyModel
/// </summary>
public class DependencyModel
{
	public DependencyModel()
	{
		//
		// TODO: Add constructor logic here
		//
	}

   
    public int Id { get; set; }
    public int TabId { get; set; }
    public int ColId { get; set; }
    public string Event { get; set; }
    public int DepColId{get;set;}

    public string ActionName { get; set; }
    public string ActionType { get; set; }
    public string DefaultValue { get; set; }

    public string DepColName { get; set; }
    public string ColName { get; set; }

    public DependencyModel BuildFromDbModel(Dependency dependency, List<ColumnMetaInfo> colsInfo)
    {
        this.Id = dependency.ID;
        this.TabId = dependency.TABID;
        this.ColId = dependency.COLiD;
        this.DepColId = dependency.DEPCOLID;
        this.Event = dependency.EVENT;
        this.ActionName = dependency.ACTION_NAME;
        this.ActionType = dependency.ACTION_TYPE;
        this.DefaultValue = dependency.DEFAULT_VALUE;
        this.ColName = colsInfo.FirstOrDefault(u => u.COLID == dependency.COLiD).COLNAME;
        this.DepColName = colsInfo.FirstOrDefault(u => u.COLID == dependency.DEPCOLID).COLNAME;
        return this;
    }
    

}