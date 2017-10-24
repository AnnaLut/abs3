

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_D8_CUST_LINK_GROUPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_D8_CUST_LINK_GROUPS ***

  CREATE OR REPLACE TRIGGER BARS.TI_D8_CUST_LINK_GROUPS 
after insert or update ON BARS.D8_CUST_LINK_GROUPS for each row
declare
   id_upd     int;
   chg_act    varchar2(1);
   l_bankdate date;
   g_bankdate date;
begin
    select s_d8_cust_link_groups.NEXTVAL
    into   id_upd
    from dual;

    g_bankdate := glb_bankdate;

    l_bankdate := bars.gl.bd;
    if ( l_bankdate is null ) then
      l_bankdate := glb_bankdate;
    end if;

    if inserting then chg_act := 'I';
    elsif updating then  chg_act := 'U';
    end if;

   insert into  d8_cust_link_groups_update (okpo,
                                             link_group,
                                             s_main,
                                             link_code,
                                             chgdate,
                                             chgaction,
                                             doneby,
                                             idupd,
                                             effectdate,
                                             globalbd )
                    VALUES (:new.okpo,
                            :new.link_group,
                            :new.s_main,
                            :new.link_code,
                            sysdate,
                            chg_act,
                            user_name,
                            id_upd,
                            l_bankdate,
                            g_bankdate);

end ti_d8_cust_link_groups;
/
ALTER TRIGGER BARS.TI_D8_CUST_LINK_GROUPS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_D8_CUST_LINK_GROUPS.sql =========
PROMPT ===================================================================================== 
