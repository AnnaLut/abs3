

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BALN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BALN ***

  CREATE OR REPLACE PROCEDURE BARS.P_BALN (p_id int,  p_DAT date ) is
l_b1   number(38);
l_k    integer;
l_r    integer;
l_g    integer;
l_sk   varchar2(90);
l_sr   varchar2(90);
l_sg   varchar2(90);
l_sb1  varchar2(40);
l_kv   number(38);
l_namv varchar2(35);
/*
версии
      13-04-2009   QWA      Через V_GL с разрезом по ОБ22
      13-02-2009   процедура формирования баланса  в номиналах
                   через кат.запросы
*/
begin
delete from tmp_bal;
for p in (
      SELECT KV,NBS, OB22, sum(dos)     DOS,  sum(kos) KOS,
         -sum(decode(sign(ost),-1,ost,0))        OSTD,
          sum(decode(sign(ost), 1,ost,0))        OSTK
       FROM (select a.kv,a.NBS,nvl(o.OB22,'00') ob22, s.ostf-s.dos+s.kos OST,
             DECODE(s.fdat,p_dat,s.dos,0)        DOS,
             DECODE(s.fdat,p_dat,s.kos,0)        KOS
          FROM v_gl a, saldoA s, specparam_int o
          WHERE  a.acc=s.acc and A.nbs is not null and a.acc=o.acc(+) and substr(a.nbs,1,1)<>'8'
              AND (s.acc,s.fdat)=(SELECT acc,MAX (fdat) FROM saldoA
                                WHERE acc=A.acc AND fdat <= p_dat GROUP BY acc)
          )
     WHERE (DOS>0 or KOS>0 or OST<>0) GROUP BY KV,NBS, OB22
)
LOOP
l_b1:=0;
l_k :=0;
l_r :=0;
l_g :=0;
l_sk:=' ';
l_sr:=' ';
l_sg:=' ';
l_sb1 :=' ';
l_kv :=0;
l_namv:=' ';
-- внебаланс-баланс-управл.
  if    substr(p.nbs,1,1)='9'
  then
       l_sB1:='Позабалансовий облiк';
       l_b1:=9;
  elsif substr(p.nbs,1,1)='8'
  then l_sB1:='Управлiнський облiк';
       l_b1:=8;
  else l_sB1:='Балансовий облiк';
       l_b1:=7;
  end if;
-- название класса, раздела, группы
  begin
     select    to_number(nbs),substr(name,1,90)
       into      l_k     ,l_sk
       from ps  where trim(nbs)       =substr(p.nbs,1,1);
  exception when NO_DATA_FOUND THEN   l_k:=to_number(substr(p.nbs,1,1)); l_sk:=substr(p.nbs,1,1);
   end;
  begin
   select to_number(nbs),substr(name,1,90)
       into      l_r, l_sr
       from ps  where ltrim(rtrim(nbs))       =substr(p.nbs,1,2);
  exception when NO_DATA_FOUND THEN   l_r:=to_number(substr(p.nbs,1,2)); l_sr:=substr(p.nbs,1,2);
  end;
  begin
    select to_number(nbs),substr(name,1,90)
       into      l_g, l_sg
       from ps  where ltrim(rtrim(nbs))       =substr(p.nbs,1,3);
  exception when NO_DATA_FOUND THEN   l_g:=to_number(substr(p.nbs,1,3)); l_sg:=substr(p.nbs,1,3);
  end;
  -- название валюты
  begin
   select name   into      l_namv
       from tabval where kv=p.kv;
  exception when NO_DATA_FOUND THEN   l_namv:=to_char(p.kv);
  end;
--ID B1 K  R G NBS DOS KOS OSTD OSTK SK SR SG SB1 DAT
--    INTO :NBS,:DOS,:KOS,:OSTD,:OSTK
 --logger.info('baln1='||p_id||'='||l_b1||'='||l_k||'='||l_r||'='||l_g||'='||p.nbs);
 --logger.info('baln2='||p.dos||'='||p.kos||'='||p.ostd||'='||p.ostk);
 --logger.info('baln3='||l_sk||'='||l_sr||'='||l_sg||'='||l_sb1||'='||p_dat);
  insert into tmp_bal
      (ID,     KV, B1,   K,    R,  G,    NBS,
      DOS,     KOS,  OSTD, OSTK,
      SK,      SR,   SG,   SB1,  NAMV,    DAT)
      values
      (p_id,  p.kv, l_b1,  l_k,   l_r, l_g, p.nbs||' '||p.OB22,
       p.dos, p.kos, p.ostd,p.ostk,
       l_sk,  l_sr,  l_sg,  l_sb1,  l_namv, p_dat);
  --logger.info('baln4=');
END LOOP;
commit;
end  P_BALN;
/
show err;

PROMPT *** Create  grants  P_BALN ***
grant EXECUTE                                                                on P_BALN          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BALN          to RPBN001;
grant EXECUTE                                                                on P_BALN          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BALN.sql =========*** End *** ==
PROMPT ===================================================================================== 
