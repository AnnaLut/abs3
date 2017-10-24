

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTOMER_EXTERN_UPDATE.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CUSTOMER_EXTERN_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CUSTOMER_EXTERN_UPDATE 
after insert or delete or update
 on bars.customer_extern for each row
declare
   l_bankdate date;
   -- триггер предполагает только одну запись за один банковский день
   -- если в один банк. день было несколько изменений, то они перезаписывают пердидущее за этот банковский день
   l_chgaction char(1);
   l_idupd	   number;
begin
   l_bankdate := gl.bd;
   if l_bankdate is null then
      select to_date(val,'dd/mm/yyyy') into l_bankdate from params$base where par= 'BANKDATE';
   end if;
   if  deleting   then
       l_chgaction:= 'D';
       insert into bars.customer_extern_update
                                     (idupd, chgaction, effectdate, chgdate, doneby,
                                      id, name,
                                      doc_type,
                                      doc_serial,
                                      doc_number,
                                      doc_date,
                                      doc_issuer,
                                      birthday,
                                      birthplace,
                                      sex,
                                      adr,
                                      tel,
                                      email,
                                      custtype,
                                      okpo,
                                      country,
                                      region,
                                      fs,
                                      ved,
                                      sed,
                                      ise)
       values( s_customer_extern_update.nextval,
                                      l_chgaction, l_bankdate, sysdate, user_id,
                                      :old.id,         :old.name,       :old.doc_type,
                                      :old.doc_serial, :old.doc_number,
                                      :old.doc_date,   :old.doc_issuer,
                                      :old.birthday,   :old.birthplace, :old.sex,  :old.adr, :old.tel,
                                      :old.email,      :old.custtype,   :old.okpo, :old.country,
                                      :old.region,     :old.fs,         :old.ved,  :old.sed, :old.ise);
   else
       if  updating then
           l_chgaction:= 'U';
       else
          l_chgaction:= 'I';
       end if;
       insert into customer_extern_update(idupd, chgaction, effectdate, chgdate, doneby,
                                      id, name, doc_type,
                                      doc_serial, doc_number,
                                      doc_date, doc_issuer,
                                      birthday, birthplace,
                                      sex,      adr,
                                      tel,      email,
                                      custtype  ,
                                      okpo      , country,
                                      region    , fs,
                                      ved       , sed, ise)
       values( s_customer_extern_update.nextval,  l_chgaction, l_bankdate, sysdate, user_id,
                                      :new.id, :new.name, :new.doc_type, :new.doc_serial,
                                      :new.doc_number, :new.doc_date, :new.doc_issuer,
                                      :new.birthday, :new.birthplace, :new.sex, :new.adr,
                                      :new.tel, :new.email, :new.custtype, :new.okpo, :new.country,
                                      :new.region, :new.fs, :new.ved, :new.sed, :new.ise);
   end if;
end;
/
ALTER TRIGGER BARS.TAIU_CUSTOMER_EXTERN_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CUSTOMER_EXTERN_UPDATE.sql ====
PROMPT ===================================================================================== 
