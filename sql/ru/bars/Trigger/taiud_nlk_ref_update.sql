

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_NLK_REF_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_NLK_REF_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_NLK_REF_UPDATE 
after insert or update of ref1, ref2, acc, ref2_state  or delete on NLK_REF
for each row
-- version 1.1 30.12.2013
declare
            l_otm    NLK_REF_update.chgaction%type := 0;
            l_idupd  NLK_REF_update.idupd%type;

            l_REF1          NLK_REF.REF1%type;
            l_REF2          NLK_REF.REF2%type;
            l_ACC           NLK_REF.ACC%type;
            l_REF2STATE     NLK_REF.REF2_STATE%type;
            l_KF            NLK_REF.KF%type;

begin
  if deleting then
     l_otm         := 3;
     l_REF1        := :old.REF1;
     l_REF2        := :old.REF2;
     l_ACC         := :old.ACC;
     l_REF2STATE   := :old.REF2_STATE;
     l_KF          := :old.KF;

  else
    if inserting then
      l_otm := 1;
    elsif UPDATING then
      l_otm := 2;
    end if;
    if l_otm>0 then
                 l_REF1        := :new.REF1;
                 l_REF2        := :new.REF2;
                 l_ACC         := :new.ACC;
                 l_REF2STATE   := :new.REF2_STATE;
                 l_KF          := :new.KF;

    end if;
  end if;

  if l_otm>0 then
    select S_NLK_REF_UPDATE.nextval
    into   l_idupd
    from   dual;



    insert
    into   NLK_REF_UPDATE (        REF1        ,
                                   REF2        ,
                                   ACC         ,
                                   KF          ,
                                   REF2_STATE  ,
                                   CHGDATE     ,
                                   CHGACTION   ,
                                   DONEBY      ,
                                   IDUPD         )
                     values (      l_REF1,
                                   l_REF2,
                                   l_ACC ,
                                   l_KF,
                                   l_REF2STATE,
                                   sysdate  ,
                                   l_otm    ,
                                   user_name,
                                   l_idupd);
  end if;
end;
/
ALTER TRIGGER BARS.TAIUD_NLK_REF_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_NLK_REF_UPDATE.sql =========**
PROMPT ===================================================================================== 
