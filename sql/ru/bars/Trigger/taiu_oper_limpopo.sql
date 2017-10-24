

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_OPER_LIMPOPO.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_OPER_LIMPOPO ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_OPER_LIMPOPO 
after insert or update on oper for each row
 WHEN (new.tt like 'IB%') declare
  isp_       number;
  rnk_       number;
  nextvisa_  number;
  branch_    varchar2(30);
  txt_       varchar2(1024);
begin
  nextvisa_ := (instr('0123456789ABCDEF',substr(:new.nextvisagrp,1,1))-1)*16+
                instr('0123456789ABCDEF',substr(:new.nextvisagrp,2,1))-1;
--bars_audit.info('TAIU_OPER_LIMPOPO: ref='||:new.ref||
--                ', newsos='||:new.sos||
--                ', oldsos='||:old.sos||
--                ', newnextvisagrp='||:new.nextvisagrp||
--                ', oldnextvisagrp='||:old.nextvisagrp);
  if (:old.sos>0 and :old.sos<5 and :new.sos<0) or :new.sos>=5 or
     nextvisa_ not in (25,5) then
--  удалить из tmp_ref
    delete
    from   tmp_ref
    where  ref=:new.ref;
  end if;
--if :new.sos>0 and :new.sos<5 and :old.sos<>:new.sos and
--   :new.nextvisagrp<>'XX' and :new.nextvisagrp<>'!!' then
  if :new.sos>0 and :new.sos<5 and nextvisa_ in (25,5) and
     (:new.sos<>:old.sos or :new.nextvisagrp<>:old.nextvisagrp) then
--  вставить в tmp_ref
    select rnk,
           branch,
           isp
    into   rnk_,
           branch_,
           isp_
    from   accounts
    where  nls=:new.nlsa and
           kv=:new.kv;
    begin
    insert
    into   tmp_ref (rnk,ref,nextvisa,branch,isp)
            values (rnk_,:new.ref,nextvisa_,branch_,isp_);
    exception when dup_val_on_index then
      update tmp_ref
      set    rnk=rnk_          ,
             nextvisa=nextvisa_,
             branch=branch_    ,
             isp=isp_
      where  ref=:new.ref;
    end;
--  bms.enqueue_msg('Надійшов документ '||:new.tt,
--                  dbms_aq.no_delay             ,
--                  dbms_aq.never                ,
--                  isp_);
--
--  выбрать по userid пользователей с группой визирования nextvisa
--  сгруппировать по: rnk,nextvisa,
--  затем "выплюнуть" сообщение тем у кого есть соответствующая nextvisa
--
--  25
    begin
      for k in (select s.id,s.branch
                from   staff$base s,
                       staff_chk  c
                where  c.id=s.id and
                       c.chkid=25)
      loop
        select 'Надійшли платіжні документи: '||replace(replace(
               f_comma('(select t.nextvisa                ,
                                c.nmk||'' - ''||t.cnt elem,
                                t.branch
                         from   customer                        c,
                                (select count(*) cnt,rnk,nextvisa,branch
                                 from   tmp_ref
                                 where  nextvisa=25
                                 group  by rnk,nextvisa,branch) t
                         where  c.rnk=t.rnk)','elem||'',, ''','branch='''||k.branch||'''','')
                         ,',,,',', '),',,')
        into   txt_
        from   dual;
        if txt_<>'Надійшли платіжні документи: ' then
          begin
            insert
            into   tmp_notification (text,
                                     id)
                             values (txt_,
                                     k.id);
          exception when dup_val_on_index then
            null;
          end;
        end if;
      end loop;
    end;
--  5
    begin
      for k in (select s.id
                from   staff$base s,
                       staff_chk  c
                where  c.id=s.id and
                       c.chkid=5)
      loop
        select 'Надійшли платіжні документи: '||replace(replace(
               f_comma('(select t.nextvisa,
                                c.nmk||'' - ''||t.cnt elem,
                                t.isp
                         from   customer                     c,
                                (select count(*) cnt,rnk,nextvisa,isp
                                 from   tmp_ref
                                 where  nextvisa=5
                                 group  by rnk,nextvisa,isp) t
                         where  c.rnk=t.rnk)','elem||'',, ''','isp='||to_char(k.id),'')
                         ,',,,',', '),',,')
        into   txt_
        from   dual;
        if txt_<>'Надійшли платіжні документи: ' then
          begin
            insert
            into   tmp_notification (text,
                                     id)
                             values (txt_,
                                     k.id);
          exception when dup_val_on_index then
            null;
          end;
        end if;
      end loop;
    end;
/*
    ”Надійшли платіжні документи
    ДППЗ Укрпошта – 500
    Придніпровська залізниці – 480”
*/
/*
    insert
    into   tmp_notification (text,
                             id)
                     values ('Надійшли документи '||:new.tt,
                             isp_);
*/
  end if;
end taiu_oper_limpopo;
/
ALTER TRIGGER BARS.TAIU_OPER_LIMPOPO DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_OPER_LIMPOPO.sql =========*** E
PROMPT ===================================================================================== 
