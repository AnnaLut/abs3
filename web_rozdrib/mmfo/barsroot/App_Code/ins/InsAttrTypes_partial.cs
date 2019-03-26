/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using Bars.Classes;
using System.Web.UI.WebControls;

namespace Bars.Ins
{
    public partial class InsAttrTypes
    {
        public List<InsAttrTypesRecord> SelectAttrTypes()
        {
            return Select();
        }
        public InsAttrTypesRecord SelectAttrType(String ID)
        {
            this.Filter.ID.Equal(ID);

            List<InsAttrTypesRecord> tmp = this.Select();

            if (tmp.Count == 0)
                throw new Bars.Exception.BarsException(String.Format("�� �������� ������ ({0})", ID));

            return tmp[0];
        }
    }
}