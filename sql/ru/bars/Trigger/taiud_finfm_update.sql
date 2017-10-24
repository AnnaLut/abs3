

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINFM_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_FINFM_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_FINFM_UPDATE 
after insert or update or delete on FIN_FM
for each row
declare
  l_otm      FIN_FM_UPDATE.chgaction%type := 0;
  l_idupd    FIN_FM_UPDATE.idupd%type;
  l_OKPO     FIN_FM_UPDATE.OKPO%type;
  l_FDAT     FIN_FM_UPDATE.FDAT%type;
  l_FM       FIN_FM_UPDATE.FM%type;
  l_DATE_F1  FIN_FM_UPDATE.DATE_F1%type;
  l_DATE_F2  FIN_FM_UPDATE.DATE_F2%type;

begin
  if DELETING then
    l_otm         := 3;

	l_OKPO        := :old.OKPO;
    l_FDAT        := :old.FDAT;
    l_FM          := :old.FM;
    l_DATE_F1     := :old.DATE_F1;
    l_DATE_F2     := :old.DATE_F2;

  else
    if INSERTING then
      l_otm := 1;
    elsif UPDATING then
      l_otm := 2;
    end if;
    if l_otm>0 then
	l_OKPO        := :new.OKPO;
    l_FDAT        := :new.FDAT;
    l_FM          := :new.FM;

	if :new.DATE_F1 <> :old.DATE_F1 then   l_DATE_F1     := :new.DATE_F1;
	else                                   l_DATE_F1    := null;
	end if;

	if :new.DATE_F2 <> :old.DATE_F2 then   l_DATE_F2     := :new.DATE_F2;
	else                                   l_DATE_F2    := null;
	end if;


    end if;
  end if;

  if l_otm>0 then
    select S_FIN_FM_UPDATE.nextval
      into   l_idupd
      from   dual;
insert into fin_fm_update (     OKPO ,
							   	FDAT  ,
								FM      ,
								DATE_F1 ,
								DATE_F2,
                                chgdate  ,
                                chgaction,
                                doneby   ,
                                idupd)
                     values (   l_OKPO ,
								l_FDAT  ,
								l_FM      ,
								l_DATE_F1 ,
								l_DATE_F2,
                                sysdate  ,
                                l_otm    ,
                                user_name,
                                l_idupd);
  end if;
end;
/
ALTER TRIGGER BARS.TAIUD_FINFM_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINFM_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
