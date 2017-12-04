using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Dependency
/// </summary>
public class Dependency
{
	public Dependency()
	{
        
	}

    public int ID { get; set; }
    public int TABID { get; set; }
    public int COLiD { get; set; }
    public string EVENT { get; set; }
    public int DEPCOLID { get; set; }
    public string ACTION_NAME { get; set; }
    public string ACTION_TYPE { get; set; }
    public string DEFAULT_VALUE { get; set; }

    public string CONDITION { get; set; }

}