

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TIPA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TIPA ***

  CREATE OR REPLACE PROCEDURE BARS.TIPA ( dat01_  in date) is

l_tipa    number;

begin
   for k in (select substr(n.id,1,4) ID, n.id idkod, n.nd, n.acc, n.ROWID RI from   nbu23_rez n
             where  n.fdat = dat01_ and n.acc is not null
             )
   LOOP

      if    k.id like 'CCK%' or k.ID like 'MBDK%' or k.ID like '150%' or k.id like '9020%'
         or k.id like '9122%' THEN
         l_tipa :=  3;
      elsif k.id like 'CACP%' THEN
         l_tipa :=  9;
      elsif k.id like 'W4%' or k.id like 'BPK%' THEN
         l_tipa :=  4;
      elsif k.id like 'OVER%' THEN
         l_tipa := 10;
      end if;

      if k.id in ('DEBF') THEN
         begin
            select nd into k.nd from nd_acc where acc=k.acc and rownum=1;
            begin
               select nd into k.nd from acc_over where nd=k.nd and rownum=1;
               l_tipa := 10;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               l_tipa := 3;
            end;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            begin
               select nd into k.nd from w4_acc where acc_3570=k.acc or acc_3579=k.acc and rownum=1;
               l_tipa := 4;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               begin
                  select nd into k.nd from bpk_acc where acc_3570=k.acc or acc_3579=k.acc and rownum=1;
                  l_tipa := 4;
               EXCEPTION WHEN NO_DATA_FOUND THEN l_tipa := 17;
               end;
            end;
         end;
      end if;
      update nbu23_rez set  tipa = l_tipa  where rowid = k.RI ;
   end LOOP;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TIPA.sql =========*** End *** ====
PROMPT ===================================================================================== 
