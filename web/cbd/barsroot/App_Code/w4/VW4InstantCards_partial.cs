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

namespace Bars.W4
{
    public partial class VW4InstantCards
    {
        public List<VW4InstantCardsRecord> SelectCard(String CARDCODE)
        {
            this.Filter.CODE.Equal(CARDCODE);
            return this.Select("ACC ASC");
        }
    }
}