using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AccessSettings
/// </summary>
public class AccessSettings
{
    public AccessSettings()
    {
        //
        // TODO: Add constructor logic here
        //
        
    }

    public static List<AccessParams> GetAll()
    {
        accessparamsList = new List<AccessParams>(){AccessParams.FullUpdate,AccessParams.WithoutUpdate,AccessParams.OnlyUpdate,AccessParams.Insert,AccessParams.Delete,AccessParams.InsertUpdate,AccessParams.DeleteUpdate,AccessParams.InsertDelete};
        return accessparamsList;
    }
    public static List<AccessParams>  accessparamsList;
}

public enum AccessParams
{
    FullUpdate,
    WithoutUpdate,
    OnlyUpdate,
    Insert,
    Delete,
    InsertUpdate,
    DeleteUpdate,
    InsertDelete
}