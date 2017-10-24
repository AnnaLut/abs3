

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BAL1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BAL1 ***

  CREATE OR REPLACE PROCEDURE BARS.P_BAL1 (p_id number,  p_DAT varchar2 ) is
  l_b1   number(38); l_k    integer   ; l_r       integer; l_g         integer;
  l_sk varchar2(90); l_sr varchar2(90); l_sg varchar2(90); l_sb1  varchar2(40);
  l_3929    char(4); l_980  number;

/*
  STA 01.03.2009 - по политикам на V_GL
  QWA 22-12-2008   проц формир баланса  шаблон BZ001S.qrd через кат.запросы
*/

begin
  l_980:=gl.baseval;
--delete from tmp_bal;
--============================ По БС+branch
  FOR p in (
  /* гривна */
     SELECT NBS,  OB22, sum(dos)     DOS,  sum(kos) KOS,
         -sum(decode(sign(ost),-1,ost,0))        OSTD,
          sum(decode(sign(ost), 1,ost,0))        OSTK
     FROM (select a.NBS,substr(substr(a.branch,1,15),-4) OB22, s.ostf-s.dos+s.kos OST,
             DECODE(s.fdat,p_dat,s.dos,0)        DOS,
             DECODE(s.fdat,p_dat,s.kos,0)        KOS
         FROM V_GL a, saldoA s, specparam_int o
         WHERE a.kv=l_980 AND a.acc=s.acc and A.nbs is not null and a.acc=o.acc(+)
           AND (s.acc,s.fdat)=(SELECT acc,MAX (fdat) FROM saldoA
                                WHERE acc=A.acc AND fdat <= p_dat GROUP BY acc)
          )
       WHERE (DOS>0 or KOS>0 or OST<>0) GROUP BY NBS, OB22
  /* эквивалент валюты */
     UNION ALL
     SELECT NBS, OB22, sum(dos)     DOS,  sum(kos) KOS,
         -sum(decode(sign(ost),-1,ost,0))        OSTD,
          sum(decode(sign(ost), 1,ost,0))        OSTK
     FROM (select a.NBS,substr(substr(a.branch,1,15),-4) OB22, s.ostf-s.dos+s.kos OST,
             DECODE(s.fdat,p_dat,s.dos,0)        DOS,
             DECODE(s.fdat,p_dat,s.kos,0)        KOS
         FROM V_GL a, saldoB s
         WHERE a.kv<>l_980 AND a.acc=s.acc and A.nbs is not null
           AND (s.acc,s.fdat)=(SELECT acc,MAX (fdat) FROM saldoB
                               WHERE  acc=A.acc AND fdat <= p_dat GROUP BY acc)
         )
      WHERE  (dos>0 or kos>0 or ost<>0) GROUP BY NBS, OB22
      ORDER BY 1
        )
  LOOP
      l_b1:=0;l_k :=0;l_r :=0;l_g :=0;l_sk:=' ';l_sr:=' ';l_sg:=' ';l_sb1 :=' ';
      -- внебаланс-баланс-управл.
      if    substr(p.nbs,1,1)='9'  then l_sB1:='Позабалансовий облiк'; l_b1:=9;
      elsif substr(p.nbs,1,1)='8'  then l_sB1:='Управлiнський облiк' ; l_b1:=8;
      else                              l_sB1:='Балансовий облiк'    ; l_b1:=7;
      end if;
    -- название класса
      begin
         select to_number(nbs),substr(name,1,90)  into l_k,l_sk
         from ps where trim(nbs)=substr(p.nbs,1,1);
      exception when NO_DATA_FOUND THEN
         l_k:=to_number(substr(p.nbs,1,1)); l_sk:=substr(p.nbs,1,1);
      end;
    -- название раздела, группы
      begin
         select to_number(nbs),substr(name,1,90)  into  l_r,l_sr
         from ps  where trim(nbs)=substr(p.nbs,1,2);
      exception when NO_DATA_FOUND THEN
         l_r:=to_number(substr(p.nbs,1,2)); l_sr:=substr(p.nbs,1,2);
      end;
    -- название группы
      begin
         select to_number(nbs),substr(name,1,90)  into  l_g, l_sg
         from ps where trim(nbs)=substr(p.nbs,1,3);
      exception when NO_DATA_FOUND THEN
         l_g:=to_number(substr(p.nbs,1,3)); l_sg:=substr(p.nbs,1,3);
      end;
    logger.info('бал-2'|| p.nbs||'/'||p.OB22);
      insert into tmp_bal
      (ID, B1, K, R,  G, NBS,  DOS, KOS,  OSTD, OSTK, SK, SR, SG, SB1, DAT)
        values  (p_id  ,l_b1  ,l_k   ,l_r    ,l_g    ,
                 p.nbs||'/'||p.OB22,
                 p.dos ,p.kos ,p.ostd ,p.ostk ,l_sk,l_sr,l_sg,l_sb1,p_dat);
  END LOOP;
logger.info('бал MM'||p_id);
commit;
end  p_bal1; 
/
show err;

PROMPT *** Create  grants  P_BAL1 ***
grant EXECUTE                                                                on P_BAL1          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BAL1          to RPBN001;
grant EXECUTE                                                                on P_BAL1          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BAL1.sql =========*** End *** ==
PROMPT ===================================================================================== 
