

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_RNK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FIN_REZ_RNK ***

  CREATE OR REPLACE PROCEDURE BARS.P_FIN_REZ_RNK 
(p_kor int , -- =10 - кол-во дней корр.пров.
 DAT1_ date,  -- дата "С"
 DAT2_ date, -- дата "По"
 p_mode int
 ) Is

 --02.02.2014 - Сухова Оптимизация
 -- финансовые результаты по реальным клиентам
 kor_ int := p_kor; RNK_ number; a_NAME1 varchar2(17) ; b_NAME1 varchar2(17) ; oo oper%rowtype;
 n1_  number; n2_ number ;
----------------------------------------------------
 TYPE r1 IS RECORD ( n1 number, n2 number); TYPE  m1 IS TABLE OF r1 INDEX BY VARCHAR2(15);
 tmp  m1 ; ind_ VARCHAR2(15);
-----------------------------------------------------
begin
  -- корр за декабрь
  If to_char(DAT2_,'MM') = '12' then kor_ := 20 ; end if;
  a_NAME1 := 'F' || to_char ( DAT1_, 'YYYYMMDD' ) || to_char ( DAT2_, 'YYYYMMDD' ) ;
  -- дважды не пересчитываем. т.к.разница только в сортировке
  begin
    select NAME1 into b_NAME1 from CCK_AN_TMP where rownum=1;
    If b_NAME1 = a_NAME1 then return ;  else  EXECUTE IMMEDIATE 'TRUNCATE TABLE  CCK_AN_TMP '  ;  end if;
  exception when no_data_found then NULL;
  end;

  tmp.DELETE;
logger.info('FIN-1');
  for k in (select a.NBS, a.ob22, o.fdat, o.dk, o.s, o.ref , a.rnk    from opldok o, accounts a
            where o.tt not in ('PVP','REV' )  and o.tt not like 'ZG_'   and a.acc   = o.acc
              and a.nbs > '5999' and a.nbs < '8000' and o.fdat >= DAT1_ and o.fdat <= (DAT2_+ kor_)  )
  loop
     select * into oo from oper where ref = k.ref;
     If oo.vob in (96,99) then If oo.vdat < DAT1_ then  goto NextRec; end if;  -- это коррект прошлого периода
     else                      If k.fdat  > DAT2_ then  goto NextRec; end if;  -- это обычные будущего периода
     end if;

     -- надо определить RNK, кому принадлежат эти дох/расх !!!!!
     begin
       select rnk into RNK_ from accounts where kv = oo.kv and nls = oo.nlsa and RNK not in (k.RNK, gl.aRNK) and oo.mfoa = gl.amfo;
     exception when no_data_found then
       begin
         select rnk into RNK_ from accounts where kv = oo.kv2 and nls = oo.nlsb and RNK not in (k.RNK, gl.aRNK) and oo.mfob = gl.amfo;
       exception when no_data_found then goto NextRec;
       end;
      end;

     If k.dk=0 then n1_ := k.S ; n2_ := 0; else  n1_ := 0 ; n2_ := k.s ;  end if;
     -- заполним колонки сумм внутренней табл-протокола
     ind_ := k.nbs||k.ob22||RNK_;
     if tmp.EXISTS (ind_) then tmp(ind_).n1 := tmp(ind_).n1 + n1_; tmp(ind_).n2 := tmp(ind_).n2 + n2_;
     else                      tmp(ind_).n1 :=                n1_; tmp(ind_).n2 :=              + n2_;
     end if;

     <<NextRec>> NULL;
  end loop; ---
logger.info('FIN-2');

  -- выгрузим все во внешнюю табл-протокол
  ind_ := tmp.FIRST; -- установить курсор на  первую запись
  WHILE ind_  IS NOT NULL
  LOOP
    insert into CCK_AN_TMP (nls, nd, n1, n2, NAME1  )
      values (substr(ind_,1,6), to_number(substr(ind_,7,9)), tmp(ind_).n1, tmp(ind_).n2, a_NAME1 ) ;
    ind_ := tmp.NEXT(ind_); -- установить курсор на след.вниз запись
  end loop;
  --------------
logger.info('FIN-3');

end p_fin_rez_RNK;
/
show err;

PROMPT *** Create  grants  P_FIN_REZ_RNK ***
grant EXECUTE                                                                on P_FIN_REZ_RNK   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FIN_REZ_RNK   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_RNK.sql =========*** End
PROMPT ===================================================================================== 
