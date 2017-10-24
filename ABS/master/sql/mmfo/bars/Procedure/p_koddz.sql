

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KODDZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KODDZ ***

  CREATE OR REPLACE PROCEDURE BARS.P_KODDZ (p_mode int) is

  --13-11-2016 - додано уточнення по KF
              --стр. № 45 --substr(value ,1,15) змінено на substr(value ,1,10) бо l_KODDZ не більше 10 символів
              --
  --20-06-2012 Добавлена таблица реф (REF_KODDZ)

  -- p_mode = 0  - тек год = 1  - прош.год   n-прош.год

  l_dat1 date;  l_dat2 date;
  l_KODDZ KOD_DZR.KOD%type ;
  l_n1    KOD_DZR.n1%type  ;

  l_sumDZ KOD_DZR.fact_cur%type;
  l_value operw.value%type ;
begin

 If p_mode = 0 then
    l_dat1 := trunc (sysdate,'YYYY' );
    l_dat2 := add_months(l_dat1, 12) ;
    update KOD_DZR set fact_cur  = 0 ;
 else
    l_dat2 := trunc (sysdate , 'YYYY' );
    l_dat1 := add_months(l_dat2, -12);
    update KOD_DZR set fact_prev = 0 ;
 end if;

  --execute immediate   'truncate table TMP_AN_KL';
 --очищуємо інформацію по KF
 execute immediate   'delete from TMP_AN_KL where KF=sys_context('||chr(39)||'bars_context'||chr(39)||','||chr(39)||'user_mfo'||chr(39)||')';

-----------
for k in (select o.ref,o.S/100 S , o.vdat, o.sos
          from oper o, ref_koddz z
          where z.ref = o.ref and o.KF=sys_context('bars_gl','mfo') --додано уточнення по KF
--  where sos=5 and vdat > l_dat1 and vdat < l_dat2
-- and exists (select 1 from operw where tag like 'K_DZ_' and ref=oper.REF)
           )
loop

  -- этот док нам не нужен
  If k.sos  <> 5      OR
     k.vdat <= l_dat1 OR
     k.vdat >= l_dat2     then
     goto HETK;
  end if;
  -------------------------------------
  for kk in ( select ref,tag, substr(value ,1,10) value --substr(value ,1,15) змінено на substr(value ,1,10) бо l_KODDZ не більше 10 символів
              from operw
              where ref=k.ref and tag like 'K_DZ_' and KF=sys_context('bars_gl','mfo') --додано уточнення по KF
             )
  loop
     l_value := trim(kk.value);
     l_KODDZ := replace(replace(replace(l_value ,',',''),'.',''),'/','' );
     begin
       l_n1 := to_number(l_KODDZ) ;
       if l_KODDZ <> l_value then
          update operw set value = l_KODDZ where ref = k.REF and tag = kk.TAG and KF=sys_context('bars_gl','mfo'); --додано уточнення по KF ;
       end if;
     exception  when others then l_n1 := 0;
       --logger.info ('KODZ '|| k.ref) ;
     end;

     l_sumDZ := k.S;

     If kk.tag <>'KODDZ'  then
        begin
          select trim(value) into l_value from operw
          where tag = 'S_DZ' || substr(kk.tag,-1) and ref = k.ref and KF=sys_context('bars_gl','mfo'); --додано уточнення по KF ;

          l_value :=
          replace(
          replace(
          replace(
          replace(
          replace(l_value ,',',''), '.',''), '-',''), '/',''), ' ','');

          begin
            l_sumDZ := to_number(l_value)/100;
          exception  when others then l_sumDZ :=0 ;
          end;

        exception when no_data_found then null;
        end;
     end if;

 logger.info ('KODZ* '|| k.ref || ' ' || l_n1||' '|| l_KODDZ ||' '||l_sumDZ ) ;
     begin
       insert into TMP_AN_KL (RNK,  ID,    NLS,  S_980, KF ) values --додано уточнення по КF
                           (k.ref,l_n1,l_KODDZ,l_sumDZ,sys_context('bars_gl','mfo')  ); --додано уточнення по KF ;
     exception  when others then
       --ORA-00001: unique constraint (BARS.XPK_TMP_AN_KL) violated
       if sqlcode = -00001 then
          raise_application_error(-(20203),
          '      Дубль кода='|| l_KODDZ ||
          ', реф док=' || k.ref ||
          ', дата='|| to_char(k.vdat, 'dd.mm.yyyy'),  TRUE);
       else raise;
       end if;
     end;

     If p_mode > 0 then
        update KOD_DZR set fact_prev = fact_prev + l_sumDZ ,
                           kod       = nvl(kod, l_KODDZ)
               where n1 = l_n1
               and KF=sys_context('bars_context','user_mfo'); --додано уточнення по KF ;
     else
        update KOD_DZR set fact_cur  = fact_cur  + l_sumDZ ,
                           kod       = nvl(kod, l_KODDZ)
               where n1 = l_n1
                and KF=sys_context('bars_context','user_mfo'); --додано уточнення по KF ;
     end if;

     if SQL%rowcount = 0 then
        If p_mode > 0 then
           insert into KOD_DZR (n1,fact_prev,fact_cur,kod, kf)
                values (l_n1, l_sumDZ, 0, l_KODDZ, sys_context('bars_context','user_mfo')  );  --додано уточнення по KF ;
        else
           insert into KOD_DZR (n1,fact_prev,fact_cur,kod, kf)
                values (l_n1, 0, l_sumDZ, l_KODDZ, sys_context('bars_context','user_mfo') ); --додано уточнення по KF ;
        end if;
     end if;

     <<HET>> null;

  end loop;
  ---------

  <<HETK>> null;

end loop;
  delete from KOD_DZR where nvl ( PLAN_PREV, 0 ) = 0 and
                            nvl ( PLAN_CUR , 0 ) = 0 and
                            nvl ( FACT_PREV, 0 ) = 0 and
                            nvl ( FACT_CUR , 0 ) = 0 and
                            KF = sys_context('bars_context','user_mfo');  --додано уточнення по KF ;
end P_KODDZ ;
/
show err;

PROMPT *** Create  grants  P_KODDZ ***
grant EXECUTE                                                                on P_KODDZ         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KODDZ         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KODDZ.sql =========*** End *** =
PROMPT ===================================================================================== 
