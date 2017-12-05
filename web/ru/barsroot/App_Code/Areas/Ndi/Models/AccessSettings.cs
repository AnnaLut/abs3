using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Ndi.Models
{
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
            AccessparamsList = new List<AccessParams>(){AccessParams.FullUpdate,AccessParams.WithoutUpdate,AccessParams.OnlyUpdate,AccessParams.Insert,AccessParams.Delete,AccessParams.InsertUpdate,AccessParams.DeleteUpdate,AccessParams.InsertDelete};
            return AccessparamsList;
        }
        public static List<AccessParams>  AccessparamsList;
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
}