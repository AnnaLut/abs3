

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_KLF00_1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_KLF00_1 ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_KLF00_1 
instead of insert or update or delete ON BARS.KL_F00_1 for each row
begin
    if         inserting then
        insert into kl_f00$local(kodf,a017,uuu,zzz,path_o,datf,nom)
        values(:new.kodf,:new.a017,:new.uuu,:new.zzz,:new.path_o,:new.datf,:new.nom);
    elsif    updating  then
        update kl_f00$local set
            uuu     = :new.uuu,
            zzz     = :new.zzz,
            path_o  = :new.path_o,
            datf    = :new.datf,
            nom      = :new.nom
        where kodf=:old.kodf and a017=:old.a017;
    elsif   deleting  then
        delete from kl_f00$local where kodf=:old.kodf and a017=:old.a017;
    end if;
end tiud_klf00_1;
/
ALTER TRIGGER BARS.TIUD_KLF00_1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_KLF00_1.sql =========*** End **
PROMPT ===================================================================================== 
