using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AddEditInformModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{

    public class AddEditRowsInform
    {
        public AddEditRowsInform()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public bool AddAfter = false;
        public string EditorMode = "ROW_EDIT"; // "MULTI_EDIT";
        public bool CarriageRollback = false;
    }

}