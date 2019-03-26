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
    public partial class VWcsSurveyGroups : BbTable<VWcsSurveyGroupsRecord, VWcsSurveyGroupsFilters>
    {
        public List<VWcsSurveyGroupsRecord> SelectSurveyGroups(String SURVEY_ID)
        {
            this.Filter.SURVEY_ID.Equal(SURVEY_ID);
            return this.Select();
        }
        public List<VWcsSurveyGroupsRecord> SelectSurveyGroup(String SURVEY_ID, String GROUP_ID)
        {
            this.Filter.SURVEY_ID.Equal(SURVEY_ID);
            this.Filter.GROUP_ID.Equal(GROUP_ID);
            return Select();
        }
        public new void Insert(VWcsSurveyGroupsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.SURVEY_GROUP_SET(Item.SURVEY_ID, Item.GROUP_ID, Item.GROUP_NAME, Item.DNSHOW_IF);
        }
        public new void Update(VWcsSurveyGroupsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.SURVEY_GROUP_SET(Item.SURVEY_ID, Item.GROUP_ID, Item.GROUP_NAME, Item.DNSHOW_IF);
        }
        public new void Delete(VWcsSurveyGroupsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.SURVEY_GROUP_DEL(Item.SURVEY_ID, Item.GROUP_ID);
        }
    }
}