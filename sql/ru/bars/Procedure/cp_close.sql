

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_CLOSE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_CLOSE ***

  CREATE OR REPLACE PROCEDURE BARS.CP_CLOSE ( mode_ int, p_dat date) is

 -- ver 1.8 23/02-16   -- 9/02-15

 -- 23/02-16 DAZS - нові варіанти для сторнованих та в статусі моделей
 --          Включено аналіз рах-в - нових складових пакета
 --  3/02-15 KDI визначення dazs через OPLDOK замість CP_ARCH
 --              були проблеми при погашенні багатьох пакетів одним документом
 -- 26/11-14 KDI уточнено аналіз всіх залишків, фіксація завершення договору (active=-1)
 --              фіксація критичних моментів в журнал по logger.error
 -- 21-03-2011 Sta + Danil
 -- Проверка на =0 всех видов ост
 -- alter table CP_deal add (dazs date);

  PR_ int;
  fl_a int:=0;
  l_dat date;  l_dat_z date;
  ------------------------------------------------------------------
  function ACC1_CLOSE (P_acc IN accounts.acc%type ,
                         l_dat IN accounts.DAZS%type
                         ) return int is
     P_PR int := 0;
  begin
    If P_ACC is null then  P_PR := 1;
    else
       begin
         select 1 into P_PR from accounts
         where nvl(dapp,daos) <= l_dat
           and ostc = 0
           and ostb = 0
           and ostf = 0
           and acc  = P_ACC
           and nbs is null;
         update accounts set dazs = gl.BDATE where acc=P_ACC and dazs is null;
       EXCEPTION WHEN NO_DATA_FOUND THEN P_PR := 0;
       end;
    end if;
    RETURN P_PR;
  end ACC1_CLOSE;
------------------------------------------------------------------

BEGIN
l_dat:=nvl(p_dat,gl.bd);
l_dat_z:=gl.bd;
logger.info('CP_CLOSE started');
  for k in
  (select * from cp_deal
        where dazs is null and active in (0,1,-1,-2)
              and acc in
        (select acc from accounts
         where nvl(dapp,daos) <= l_dat
           and ostc = 0
           and ostb = 0
           and ostf = 0
           and nbs is null)
)
  loop
     fl_a:=0;
     SAVEPOINT REF_DAZS;
     --------------------
     PR_:= 0;
     If ACC1_CLOSE (k.ACC, l_dat) = 1 then   fl_a:=1;
        If ACC1_CLOSE (k.ACCd, l_dat) = 1 then
           If ACC1_CLOSE (k.ACCp, l_dat) = 1 then
              If ACC1_CLOSE (k.ACCr, l_dat) = 1 then
                 If ACC1_CLOSE (k.ACCp, l_dat) = 1 then
                    If ACC1_CLOSE (k.ACCr, l_dat) = 1 then
                       If ACC1_CLOSE (k.ACCr2, l_dat) = 1 then
                          If ACC1_CLOSE (k.ACCs, l_dat) = 1 then
                             If ACC1_CLOSE (k.ACCexpn, l_dat) = 1 then
                                If ACC1_CLOSE (k.ACCexpr, l_dat) = 1 then
                                   If ACC1_CLOSE (k.ACCr3, l_dat) = 1 then
                                      If ACC1_CLOSE (k.ACCunrec, l_dat) = 1 then

                             PR_ := 1 ;

  for d in (select * from cp_ref_acc where ref=k.REF)
  loop
     PR_ := PR_ * ACC1_CLOSE (d.ACC, l_dat);
  end loop;

                                      end if;
                                   end if;
                                end if;
                             end if;
                          end if;
                       end if;
                    end if;
                 end if;
              end if;
           end if;
        end if;
     end if;

     If PR_ = 1 then
        begin
          if k.active in (1,-1) then
             select max(fdat) into l_dat_z from opldok where acc=k.acc and dk=1;
          elsif k.active in (0,-2) then  null;
             l_dat_z:=k.dat_ug;
          end if;
      --  EXCEPTION WHEN NO_DATA_FOUND THEN l_dat_z := gl.bd;
        end;
        Update cp_deal set dazs= l_dat_z, active=decode(active,1,-1,active)
        where ref=k.REF;
        commit;
        logger.info('CP_CLOSE Закрито рах-ки по пакету ЦП реф='||k.ref||' ID='||k.id);
     else
        if fl_a = 1 then null;
        logger.error('CP_CLOSE ! тел. 48-10 перевірити залишки по рах-х купонів реф='||k.ref);
        end if;
        ROLLBACK TO REF_DAZS;
     end if;
  end loop;
logger.info('CP_CLOSE ended');
end cp_close;
/
show err;

PROMPT *** Create  grants  CP_CLOSE ***
grant EXECUTE                                                                on CP_CLOSE        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_CLOSE.sql =========*** End *** 
PROMPT ===================================================================================== 
