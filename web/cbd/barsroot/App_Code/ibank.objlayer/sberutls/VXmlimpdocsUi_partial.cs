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
using ibank.objlayer;
using Bars.Classes;

namespace ibank.core
{
    public partial class VXmlimpdocsUi
    {
        public List<VXmlimpdocsUiRecord> SelectVXmlimpdocsUi(Decimal? IMPREF)
        {
            this.Filter.IMPREF.Equal(IMPREF);
            return Select();
        }
        public new void Update(VXmlimpdocsUiRecord Item)
        {
            BbConnection con = new BbConnection();
            con.RoleName = "OPER000";
            BarsXmlklbImp pack = new BarsXmlklbImp(con);
            pack.UPDATE_DOC(Item.IMPREF, Item.MFOA, Item.NLSA, Item.ID_A, Item.NAM_A, Item.MFOB, 
                Item.NLSB, Item.ID_B, Item.NAM_B, Item.NAZN, Item.S * 100, Item.SK, Item.KV);
        }
    }
}