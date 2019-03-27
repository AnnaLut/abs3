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

namespace credit
{
    public partial class VWcsScoringQuestions
    {
        public List<VWcsScoringQuestionsRecord> SelectScoringQuestions(String SCORING_ID)
        {
            this.Filter.SCORING_ID.Equal(SCORING_ID);
            return Select();
        }
        public new void Insert(VWcsScoringQuestionsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            // wp.SCOR_SET(Item.SCORING_ID, Item.SCORING_NAME);
        }
        public new void Update(VWcsScoringQuestionsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            // wp.SCOR_SET(Item.SCORING_ID, Item.SCORING_NAME);
        }
        public new void Delete(VWcsScoringQuestionsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            // wp.SCOR_DEL(Item.SCORING_ID);
        }
    }
}