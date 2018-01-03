using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars;
using Bars.Classes;
using BarsWeb.Core.Logger;

public partial class docinput_editPropsVal : BarsPage
{

    private readonly IDbLogger DBLogger;
    public docinput_editPropsVal()
    {
        DBLogger = DbLoggerConstruct.NewDbLogger();
    }

    protected override void OnPreInit(EventArgs e)
    {
        FillData();
        base.OnPreInit(e);
    }

    private void FillData()
    {

        string reference = Request["ref"];
		//string reference = Request["kodf"];

        sdsProps.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        switch (Request.Params.Get("kodf"))
            {
                case "D3": {
                   sdsProps.SelectParameters.Add("REF", DbType.Decimal, reference);
                   sdsProps.SelectCommand =
                   @"select case when tag = 'D1#70' then  'D1#D3' else TAG end AS TAG, case when tag = 'D1#70' then 'Код мети продажу валюти' else  name end as NAME, value, rel, ref
                          from(with doc as (select o.ref, o.tt, o.nlsa, o.mfoa, o.kv, o.s, o.nlsb, o.mfob, o.kv2, o.s2, o.nazn from oper o where ref = :REF ),
                       alltags as (  select f.tag, f.name, f.browser, trim(f.chkr) chkr
                           from  op_field f, doc
                          where   f.tag in ('D1#70','DD#70' )             
                          union all
                          select w.tag, f.name, f.browser, trim(f.chkr) chkr
                           from operw w, op_field f, doc
                          where w.ref = doc.ref  
                            and w.tag = f.tag
							and f.tag in ('D1#D3','DD#70' )
                            and nvl(f.nomodify,0)=0)
                    select distinct t.tag, t.name,(select nvl(value,'') from operw where ref = doc.ref and tag = t.tag) as value, 
                    decode(t.browser,null,0,1) REL, ref 
                    from doc, alltags t  order by decode(trim(t.tag), 'N', null, 'n', null, t.tag) nulls first)";
                            }
                 break;
				 case "C9": {
                   sdsProps.SelectParameters.Add("REF", DbType.Decimal, reference);
                   sdsProps.SelectCommand =
                   @"select tag, name, value, rel, ref 
                          from(with doc as (select o.ref, o.tt, o.nlsa, o.mfoa, o.kv, o.s, o.nlsb, o.mfob, o.kv2, o.s2, o.nazn from oper o where ref = :REF ),
                       alltags as (  select f.tag, f.name, f.browser, trim(f.chkr) chkr
                           from  op_field f, doc
                          where   f.tag in ('D1#C9','DD#70','KOD_G')            
                          union all
                          select w.tag, f.name, f.browser, trim(f.chkr) chkr
                           from operw w, op_field f, doc
                          where w.ref = doc.ref  
                            and w.tag = f.tag
							and f.tag in ('D1#C9','DD#70','KOD_G') 
                            and nvl(f.nomodify,0)=0)
                    select distinct t.tag, t.name,(select nvl(value,'') from operw where ref = doc.ref and tag = t.tag) as value, 
                    decode(t.browser,null,0,1) REL, ref 
                    from doc, alltags t  order by decode(trim(t.tag), 'N', null, 'n', null, t.tag) nulls first)";
                            }
                break;
				case "70": {
                   sdsProps.SelectParameters.Add("REF", DbType.Decimal, reference);
                   sdsProps.SelectCommand =
                   @"select tag, name, value, rel, ref 
                          from(with doc as (select o.ref, o.tt, o.nlsa, o.mfoa, o.kv, o.s, o.nlsb, o.mfob, o.kv2, o.s2, o.nazn from oper o where ref = :REF ),
                       alltags as (  select f.tag, f.name, f.browser, trim(f.chkr) chkr
                           from  op_field f, doc
                          where   f.tag in ('D7#70', 'D8#70', 'D9#70', 'DA#70', 'DB#70', 'D6#70','D5#70','D4#70','D3#70','D2#70', 'D1#70')          
                          union all
                          select w.tag, f.name, f.browser, trim(f.chkr) chkr
                           from operw w, op_field f, doc
                          where w.ref = doc.ref  
                            and w.tag = f.tag
							and f.tag in ('D7#70', 'D8#70', 'D9#70', 'DA#70', 'DB#70', 'D6#70','D5#70','D4#70','D3#70','D2#70', 'D1#70' )
                            and nvl(f.nomodify,0)=0)
                    select distinct t.tag, t.name,(select nvl(value,'') from operw where ref = doc.ref and tag = t.tag) as value, 
                    decode(t.browser,null,0,1) REL, ref 
                    from doc, alltags t  order by decode(trim(t.tag), 'N', null, 'n', null, t.tag) nulls first)";
                            }
                break;
				case "E2": {
                   sdsProps.SelectParameters.Add("REF", DbType.Decimal, reference);
                   sdsProps.SelectCommand =
                   @"select tag, name, value, rel, ref 
                          from(with doc as (select o.ref, o.tt, o.nlsa, o.mfoa, o.kv, o.s, o.nlsb, o.mfob, o.kv2, o.s2, o.nazn from oper o where ref = :REF ),
                       alltags as (  select f.tag, f.name, f.browser, trim(f.chkr) chkr
                           from  op_field f, doc
                          where   f.tag in ('D1#E2','KOD_G', 'D9#70', 'DA#70','DA#E2','12_2C','D2#70','D3#70','59F  ')             
                          union all
                          select w.tag, f.name, f.browser, trim(f.chkr) chkr
                           from operw w, op_field f, doc
                          where w.ref = doc.ref  
                            and w.tag = f.tag
							and f.tag in ('D1#E2','KOD_G', 'D9#70', 'DA#70','DA#E2','12_2C','D2#70','D3#70','59F  ') 
                            and nvl(f.nomodify,0)=0)
                    select distinct t.tag, t.name,(select nvl(value,'') from operw where ref = doc.ref and tag = t.tag) as value, 
                    decode(t.browser,null,0,1) REL, ref 
                    from doc, alltags t  order by decode(trim(t.tag), 'N', null, 'n', null, t.tag) nulls first)";
                            }
                break;
				case "2D": {
                   sdsProps.SelectParameters.Add("REF", DbType.Decimal, reference);
                   sdsProps.SelectCommand =
                   @"select tag, name, value, rel, ref 
                          from(with doc as (select o.ref, o.tt, o.nlsa, o.mfoa, o.kv, o.s, o.nlsb, o.mfob, o.kv2, o.s2, o.nazn from oper o where ref = :REF ),
                       alltags as (  select f.tag, f.name, f.browser, trim(f.chkr) chkr
                           from  op_field f, doc
                          where   f.tag in ('D1#2D ','KOD_G', 'D9#70', 'DA#70')           
                          union all
                          select w.tag, f.name, f.browser, trim(f.chkr) chkr
                           from operw w, op_field f, doc
                          where w.ref = doc.ref  
                            and w.tag = f.tag
							and f.tag in ('D1#2D ','KOD_G', 'D9#70', 'DA#70')
                            and nvl(f.nomodify,0)=0)
                    select distinct t.tag, t.name,(select nvl(value,'') from operw where ref = doc.ref and tag = t.tag) as value, 
                    decode(t.browser,null,0,1) REL, ref 
                    from doc, alltags t  order by decode(trim(t.tag), 'N', null, 'n', null, t.tag) nulls first)";
                            }
                break;
				case "2C": {
                   sdsProps.SelectParameters.Add("REF", DbType.Decimal, reference);
                   sdsProps.SelectCommand =
                   @"select tag, name, value, rel, ref 
                          from(with doc as (select o.ref, o.tt, o.nlsa, o.mfoa, o.kv, o.s, o.nlsb, o.mfob, o.kv2, o.s2, o.nazn from oper o where ref = :REF ),
                       alltags as (  select f.tag, f.name, f.browser, trim(f.chkr) chkr
                           from  op_field f, doc
                          where   f.tag in ('D7#70','DA#70','D9#70','D2#E2','D2#E2','D3#E2','12#2C')             
                          union all
                          select w.tag, f.name, f.browser, trim(f.chkr) chkr
                           from operw w, op_field f, doc
                          where w.ref = doc.ref  
                            and w.tag = f.tag
							and  f.tag in ('D7#70','DA#70','D9#70','D2#E2','D2#E2','D3#E2','12#2C')
                            and nvl(f.nomodify,0)=0)
                    select distinct t.tag, t.name,(select nvl(value,'') from operw where ref = doc.ref and tag = t.tag) as value, 
                    decode(t.browser,null,0,1) REL, ref 
                    from doc, alltags t  order by decode(trim(t.tag), 'N', null, 'n', null, t.tag) nulls first)";
                            }
                break;
            }
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvProps_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        e.Cancel = true;
        gvProps.EditIndex = -1;
        try
        {
            InitOraConnection();
            string refDoc = Request["ref"];
            string newValue = Convert.ToString(e.NewValues["VALUE"]);
            string oldValue = Convert.ToString(e.OldValues["VALUE"]);
            string tag = Convert.ToString(e.Keys[1]);
            // Update or delete
			DBLogger.Info(
                "Keys1 =" + e.Keys[1] + ", Keys0 = " + e.Keys[0] + "oldValue = "+ oldValue, "DOCINPUT");

			SetParameters("P_REF", DB_TYPE.Decimal, e.Keys[0], DIRECTION.Input);
			SetParameters("P_TAG", DB_TYPE.Varchar2, tag, DIRECTION.Input);
			SetParameters("P_VALUE", DB_TYPE.Varchar2, newValue, DIRECTION.Input);
            SQL_PROCEDURE("BARS.set_operw_otcn_70");
            /*if (!string.IsNullOrEmpty(oldValue))
            {
                //delete
                if (string.IsNullOrEmpty(newValue))
                {
                    SetParameters("ref", DB_TYPE.Decimal, e.Keys[0], DIRECTION.Input);
                    SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                    SQL_NONQUERY("delete from operw where ref=:ref and tag=:tag");
                }
                // update
                else
                {
                    SetParameters("value", DB_TYPE.Varchar2, newValue, DIRECTION.Input);
                    SetParameters("ref", DB_TYPE.Decimal, e.Keys[0], DIRECTION.Input);
                    SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);

                    SQL_NONQUERY("update operw set value=:value where ref=:ref and tag=:tag");
                    // COBUSUPABS-4641 
                    if (tag == "D9#70")
                    {
                        ClearParameters();
                        SetParameters("b010", DB_TYPE.Varchar2, newValue, DIRECTION.Input);
                        var name = Convert.ToString(SQL_SELECT_scalar("select name from rc_bnk where b010=:b010"));

                        ClearParameters();
                        SetParameters("value", DB_TYPE.Varchar2, name, DIRECTION.Input);
                        SetParameters("ref", DB_TYPE.Decimal, e.Keys[0], DIRECTION.Input);
                        SetParameters("tag", DB_TYPE.Varchar2, "DA#70", DIRECTION.Input);

                        SQL_NONQUERY("update operw set value=:value where ref=:ref and tag=:tag");
                    }
                }
            }
            // Insert
            else
            {
                SetParameters("ref", DB_TYPE.Decimal, refDoc, DIRECTION.Input);
                SetParameters("tag", DB_TYPE.Varchar2, tag, DIRECTION.Input);
                SetParameters("value", DB_TYPE.Varchar2, newValue, DIRECTION.Input);
                SQL_NONQUERY("insert into operw (ref, tag, value)  values (:ref, :tag, :value)");
            }*/
            ArrayList reader = SQL_reader("select id, fio from staff$base where id=user_id");
            DBLogger.Info(
                "Изменение доп. реквизита [" + e.OldValues["NAME"] + "(TAG=" + tag.Trim() + ")] в документе ref=" +
                Request["ref"] + " пользователем [" + reader[1] + "(ID=" + reader[0] + ")],\n старое значение :" +
                oldValue + "\n новое значение  :" + newValue, "DOCINPUT");
        }
        finally
        {
            DisposeOraConnection();
        }
    }

    protected void gvProps_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            Control ctrl = e.Row.Cells[2].Controls[1];
            if (ctrl is TextBox)
                hEditBoxId.Value = ctrl.ClientID;
        }
    }
}