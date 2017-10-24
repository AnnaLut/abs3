
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pack_sal.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PACK_SAL 
IS



  type tp_kv is record
      ( kv     number
       ,cur     number);
  type tb_kv is table of tp_kv index by pls_integer;
  type tp_dat is record
      ( dat       number
       ,kv        tb_kv
       );
  type tb_dat is table of tp_dat index by pls_integer;
  type tp_cur is record   ( dat     tb_dat   );
  cur_ tp_cur;

  TYPE tb_trow is record (acc    accounts.acc%type,
                          nls    accounts.nls%type,
                          kv     accounts.kv%type,
                          nms    accounts.nms%type,
                          dapp   accounts.dapp%type,
                          OSTF   number,
                          OSTFQ  number,
                          DOSQ   number,
                          KOSQ   number,
                          DOSPQ  number,
                          KOSPQ  number,
                          OSTPI  number,
                          OSTPIQ number,
						  nb     number);
  TYPE tb_row is table of tb_trow index by pls_integer;

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.1.7  16.02.2017 15:56';



 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;


/**
 * body_version - возвращает версию тела пакета
 */
function body_version   return varchar2;

function f_cur( p_fdat date, p_kv number) return number;

procedure      FOSTV_AVG (p_acc      NUMBER,
                          p_dat1     in out DATE,
						  p_dat2     in out DATE,
						  p_ost      out number,
						  p_dos      out number,
						  p_kos      out number,
						  p_ostf     out number,
						  p_ost_avg  out number,
						  p_ostq_avg out number,
						  p_kol      out number);



FUNCTION p_icurval ( iCur          NUMBER,
                     iSum          NUMBER,
                     dDesiredDate  DATE,
                     iType         NUMBER DEFAULT 0,
                     iDefaultValue NUMBER DEFAULT 1,    -- not used
                     iUseFuture    NUMBER DEFAULT 0,    -- not used
                     iCheck4Errors NUMBER DEFAULT 0     -- not used
                    )

RETURN NUMBER;



procedure set_list_acc (p_fdat    date,
                        p_listnbs varchar2,
                        p_kv      varchar2 default '%',
                        p_ob22    varchar2 default '%',
                        p_branch  varchar2 default '%'
                        );



procedure set_sal  (p_fdat1   date,
                    p_fdat2   date,
                    p_listnbs varchar2 ,
                    p_kv      varchar2 default '%',
                    p_ob22    varchar2 default '%',
                    p_branch  varchar2 default '%'
                        );

procedure set_sal_average  (p_fdat1   date,
							p_fdat2   date,
							p_listnbs varchar2 ,
							p_kv      varchar2 default '%',
							p_ob22    varchar2 default '%',
							p_branch  varchar2 default '%'
                        );
end pack_sal;
/
CREATE OR REPLACE PACKAGE BODY BARS.PACK_SAL 
is

G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'Version 1.1.7  16.02.2017 15:56';


 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header PG_CUR '||G_HEADER_VERSION||' MFO='||f_ourmfo_g;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body PG_CUR '||G_BODY_VERSION||' MFO='||f_ourmfo_g;
end body_version;

function f_cur( p_fdat date, p_kv number) return number
is

l_fdat date:= p_fdat;
dat_ number :=  TO_NUMBER(TO_CHAR(p_fdat,'j'))-2447892;
  l_branch varchar2(8);
  l_ number;

begin

      IF p_kv = 980
      THEN
         RETURN 1;
      END IF;

    --  dbms_output.put_line('..start= '|| TO_CHAR (dat_));

    IF cur_.dat.EXISTS (dat_)
      THEN
                 IF cur_.dat (dat_).kv(p_kv).kv = p_kv
                 THEN
                   -- dbms_output.put_line('..остаток1= '|| TO_CHAR (cur_.dat (dat_).kv(p_kv).cur));
                    RETURN cur_.dat(dat_).kv(p_kv).cur;
                 END IF;
      END IF;

   select  max(fdat) into  l_fdat from fdat where fdat <= p_fdat;

  l_branch:= '/'||f_ourmfo||'/';
  l_ := 0;

   --dbms_output.put_line('..red= '|| TO_CHAR (dat_));

  for x in (select * from cur_rates$base where vdate = l_fdat and branch = l_branch and official = 'Y')
  loop
      cur_.dat (dat_).kv(x.kv).kv  := x.kv;
      cur_.dat (dat_).kv(x.kv).cur := x.rate_o/x.bsum;
      if x.kv = p_kv
       then l_ := x.rate_o/x.bsum;
      end if;
  end loop;

  if l_ = 0
     then   return gl.p_icurval(p_kv, 1000000, p_fdat)/1000000;
     else   return l_;
  end if;

  exception when no_data_found then
        return gl.p_icurval(p_kv, 1000000, p_fdat)/1000000;

end;

FUNCTION p_icurval ( iCur          NUMBER,
                     iSum          NUMBER,
                     dDesiredDate  DATE,
                     iType         NUMBER DEFAULT 0,
                     iDefaultValue NUMBER DEFAULT 1,    -- not used
                     iUseFuture    NUMBER DEFAULT 0,    -- not used
                     iCheck4Errors NUMBER DEFAULT 0     -- not used
                    )

RETURN NUMBER IS         -- ToBeDone: Value, Date, Status

 fVal     NUMBER;
 dDate    DATE;

 digs_    NUMBER;

 ern         CONSTANT POSITIVE := 207;
 err         EXCEPTION;
 erm         VARCHAR2(80);

BEGIN


  IF iCur = gl.baseval OR iSum = 0 or iCur = 980 THEN
     RETURN iSum;
  END IF;

-- Get Digs for currencies
  digs_ := 0;

  fVal := f_cur(dDesiredDate, iCur);


  IF fVal = 0 THEN
     erm := '9314 - Zero rate was set for currency #('||iCur||'@'||dDesiredDate||')';
     RAISE err;
  END IF;

  IF iType = 0 THEN            -- p_icurval;
     fVal := ROUND(fVal*iSum*POWER(10,digs_));
     IF fVal =  0 THEN
        RETURN SIGN(iSum);
     ELSE
        RETURN fVal;
     END IF;
  ELSE                         -- p_ncurval
     RETURN ROUND(iSum/(fVal*POWER(10,digs_)));
  END IF;

EXCEPTION
   WHEN err   THEN
        raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
END p_icurval;



procedure set_list_acc (p_fdat    date,
                        p_listnbs varchar2,
                        p_kv      varchar2 default '%',
                        p_ob22    varchar2 default '%',
                        p_branch  varchar2 default '%'
                        )
as
l_sql clob;
l_accounts varchar2(50) := 'saldo';
begin

  execute immediate 'truncate table tmp_sal';
  execute immediate 'truncate table tmp_sal_acc';

    if user_id = 1 then
	   l_accounts  := 'accounts';
	end if;


      l_sql :=  'insert into tmp_sal(nbs) select nbs from ps where length(trim(nbs)) = 4 ';
       if   p_listnbs =  '0' or p_listnbs =  '%'    then null;
      elsif p_listnbs != '0' and  (instr(p_listnbs,'_') > 0 or instr(p_listnbs,'%') > 0)
                          then l_sql := l_sql||' and nbs like ''' ||p_listnbs ||''' ';
      elsif p_listnbs != '0' and p_listnbs != '%' and  instr(p_listnbs,',') = 0
                         then l_sql := l_sql||' and nbs = ' ||p_listnbs ||' ';
         else                 l_sql := l_sql||' and nbs in (select to_char(trim(column_value)) nbs from table(gettokens('''||p_listnbs||''')))';
      end if;



    logger.info ('qqq '||l_sql)  ;
    execute immediate  l_sql;



   l_sql := ' insert into tmp_sal_acc (acc, nbs, nls, kv, ob22,  nms, daos, dazs, branch)
         select /*+ parallel(10)*/  a.acc, a.nbs, a.nls, a.kv,  nvl(a.ob22,''00''), substr(a.nms,1,35), a.daos, a.dazs, a.kf
           from '||l_accounts ||' a  join  tmp_sal p on a.nbs = p.nbs
          where (dazs is null or dazs >= trunc(to_date('''||to_char(p_fdat,'dd/mm/yyyy')||''',''dd/mm/yyyy''),''yyyy''))';

         if  p_ob22 = '%' then null;
      elsif  length(p_ob22) >0 and instr(p_ob22,',') = 0
                         then l_sql := l_sql||' and a.ob22 = ''' ||p_ob22 ||''' ';
         else                 l_sql := l_sql||' and a.ob22 in (select to_char(trim(column_value)) fon from table(gettokens('''||p_ob22||''')))';
      end if;

         if  p_kv = '%' or p_kv = '0' then null;
      elsif  length(p_kv) >0 and instr(p_kv,'-') = 1
                         then l_sql := l_sql||' and a.kv not in (select to_char(trim(abs(column_value))) fon from table(gettokens('''||p_kv||''')))';
      elsif  length(p_kv) >0 and instr(p_kv,',') = 0
                         then l_sql := l_sql||' and a.kv = ''' ||p_kv ||''' ';
      else                 l_sql := l_sql||' and a.kv in (select to_char(trim(column_value)) fon from table(gettokens('''||p_kv||''')))';
      end if;


      if    p_branch = '%'     then null;
      elsif p_branch != '%' and  (instr(p_branch,'_') > 0 or instr(p_branch,'%') > 0 )
                          then l_sql := l_sql||' and a.branch like ''' ||p_branch ||''' ';
      elsif p_branch != '%' and  instr(p_branch,',') = 0
                         then l_sql := l_sql||' and a.branch = ' ||p_branch ||' ';
         else                 l_sql := l_sql||' and a.branch in (select to_char(trim(abs(column_value))) nbs from table(gettokens('''||p_branch||''')))';
      end if;


      l_sql := l_sql ||' and a.kv is not null';

    logger.info ('qqq '||l_sql)  ;
    execute immediate  l_sql;


end;


procedure set_sal_snp  (p_fdat1   date,
                        p_fdat2   date
                       )
as

 dat1_ date := p_fdat1;
 dat2_ date := p_fdat2;
 dat11 date;

 l_ost   number;
 l_ostq  number;
 l_osti  number;
 l_ostiq number;

 l_rev      number;
 l_rev_dos  number;
 l_rev_kos  number;

 l_obl number;

 l_   pls_integer;

 cursor c0 is select
                     acc,
                     nls,
                     kv,
                     nms, datp, null dapp,
                     sum(nvl(ostf,0)) OSTF, sum(nvl(ostfq,0)) OSTFQ, sum(nvl(dosq,0)) DOSQ, sum(nvl(kosq,0)) KOSQ, sum(nvl(dospq,0)) DOSPQ, sum(nvl(kospq,0)) KOSPQ, sum(nvl(ostpi,0)) OSTPI, sum(nvl(ostpiq,0)) OSTPIQ, 1 nb
              from  tmp_lic group by acc, nls,
                     kv ,
                     nms, datp;
 t_c0  c0%rowtype;

begin

  select max(fdat)
   into dat11
   from fdat
   where fdat < dat1_;


  if  dat1_ = dat2_
      then l_ := 1;
      else l_ := 0;
  end if;

 if l_ = 0 then

         for x in ( select distinct nbs from TMP_SAL_ACC)
         loop
          dbms_application_info.set_client_info ('‘ормуванн€ PACK_SAL.set_sal_snp '||x.nbs);


             insert  into tmp_lic (  acc, nls, kv,  dapp, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ )
              select /*+ parallel(saldoa,6) */
                     s.acc, a.nls, a.kv,   max(s.fdat) dapp,
                     null ost,
                     null ostq,
                     sum(dos) dos,
                     sum(kos) kos,
                     sum( case when dos!=0 and a.kv != 980 then pack_sal.p_icurval(a.kv,dos, s.fdat) else 0 end) dosq,
                     sum( case when kos!=0 and a.kv != 980 then pack_sal.p_icurval(a.kv,kos, s.fdat) else 0 end) kosq,
                     null osti,
                     null ostiq
                from tmp_sal_acc a,
                     saldoa s
                 where   s.acc = a.acc and substr(a.nls,1,4) = x.nbs
                     and s.fdat between dat1_ and  dat2_
                group by    s.acc, a.nls, a.nms, a.kv ;

         end loop;
  end if;



  if l_ = 0 then
     insert  into tmp_lic (  acc, nls, kv,  dapp, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ )
          select  a.acc, a.nls, a.kv, null dapp, 0 OSTF, 0 OSTFQ, 0 DOSQ, 0 KOSQ, 0 DOSPQ, 0 KOSPQ, ost OSTPI, ostq OSTPIQ
            from TMP_SAL_ACC a, snap_balances s
           where s.acc =a.acc and  fdat = dat2_;

  else  -- в тому числ≥ ≥ обороти з сн≥мк≥b
     insert  into tmp_lic (  acc, nls, kv,  dapp, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ )
          select  a.acc, a.nls, a.kv, null dapp, 0 OSTF, 0 OSTFQ, dos DOSQ, kos KOSQ, dosq DOSPQ, kosq KOSPQ, ost OSTPI, ostq OSTPIQ
            from TMP_SAL_ACC a, snap_balances s
           where s.acc =a.acc and  fdat = dat2_;
 end if;


    open c0;

     delete from  tmp_lic;

     loop
       fetch c0 into t_c0;
       exit when c0%notfound;

           CONTINUE WHEN   abs(t_c0.ostpi)+ abs(t_c0.dosq)+ abs(t_c0.kosq) = 0;

           if l_ = 0 then  -- обороти з saldoa  без переоц≥нки
               l_ost   := t_c0.ostpi+t_c0.dosq-t_c0.kosq;
               l_ostq  := case when l_ost = 0 or t_c0.kv = 980 then  l_ost else pack_sal.p_icurval(t_c0.kv, l_ost, dat11) end;
               l_osti  := t_c0.OSTPI;
               l_ostiq := t_c0.OSTPIQ;
               l_rev := l_ostiq +  t_c0.DOSPQ - t_c0.KOSPQ - l_ostq;
               l_rev_dos   :=    least(l_rev,0);
               l_rev_kos   := greatest(l_rev,0);
               t_c0.DOSPQ :=  t_c0.DOSPQ - l_rev_dos;
               t_c0.KOSPQ :=  t_c0.KOSPQ + l_rev_kos;
           else  -- обороти з сн≥мка (вже з переоц≥нкою)
               l_ost   := t_c0.ostpi+t_c0.dosq-t_c0.kosq;
               l_ostq  := t_c0.OSTPIQ+t_c0.DOSPQ-t_c0.KOSPQ;
               l_osti  := t_c0.OSTPI;
               l_ostiq := t_c0.OSTPIQ;
           end if;

       insert into tmp_lic (  acc, nls,kv,nms, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ, fdat, datp, dapp)
        values( t_c0.acc, t_c0.nls,t_c0.kv, t_c0.nms, l_ost, l_ostq, t_c0.DOSQ, t_c0.KOSQ, t_c0.DOSPQ, t_c0.KOSPQ, l_osti, l_ostiQ,  dat1_, dat2_, t_c0.dapp);

     end loop;




end;

procedure set_sal_saldoa  (p_fdat1   date,
                           p_fdat2   date
                          )
as

 dat1_ date := p_fdat1;
 dat2_ date := p_fdat2;
 dat11 date;

 l_kf accounts.kf%type := f_ourmfo;

 l_ost   number;
 l_ostq  number;
 l_osti  number;
 l_ostiq number;

 l_rev      number;
 l_rev_dos  number;
 l_rev_kos  number;

 t_c0  tb_row;
 c0    SYS_REFCURSOR;
 l_sql varchar2(4000) := 'select /*+ parallel(10) */
                             acc, nls, kv,
                             t.nms nms, t.dapp dapp,
                             t.OSTF, t.OSTFQ, nvl(t.DOSQ,0) dosq, nvl(t.KOSQ,0) kosq, nvl(t.DOSPQ,0) dospq, nvl(t.KOSPQ,0) kospq, nvl(t.OSTPI,0 ) ostpi, t.OSTPIQ , 1 nb
                      from tmp_lic t';
 cursor c1 is select /*+ parallel(10) */
                     acc, nls, kv,
                     t.nms nms, t.dapp dapp,
                     t.OSTF, t.OSTFQ, nvl(t.DOSQ,0) dosq, nvl(t.KOSQ,0) kosq, nvl(t.DOSPQ,0) dospq, nvl(t.KOSPQ,0) kospq, nvl(t.OSTPI,0 ) ostpi, t.OSTPIQ, 1 nb
              from tmp_lic t;

begin

 select max(fdat)
   into dat11
   from fdat
   where fdat < dat1_;


for x in ( select distinct nbs, ob22 from TMP_SAL_ACC)
 loop
  dbms_application_info.set_client_info ('‘ормуванн€ PACK_SAL.set_sal_saldoa '||x.nbs||' ob22 = '||x.ob22);

 insert  into tmp_lic (  acc, nls, kv, nms,  dapp, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ )
  select /*+ parallel(6) */
           a.acc, a.nls, a.kv, a.nms,  max(case when s.fdat<= dat2_ then s.fdat else a.dapp end) dapp,
         null ost,
         null ostq,
         sum(case when s.fdat between dat1_ and dat2_ then s.dos else 0 end) dos,
         sum(case when s.fdat between dat1_ and dat2_ then s.kos else 0 end) kos,
         sum( case when s.dos!=0 and a.kv != 980 and s.fdat between dat1_ and dat2_ then pack_sal.p_icurval(a.kv,s.dos, s.fdat) when s.dos!=0 and a.kv = 980 and s.fdat between dat1_ and dat2_ then s.dos else 0 end) dosq,
         sum( case when s.kos!=0 and a.kv != 980 and s.fdat between dat1_ and dat2_ then pack_sal.p_icurval(a.kv,s.kos, s.fdat) when s.kos!=0 and a.kv = 980 and s.fdat between dat1_ and dat2_ then s.kos else 0 end) kosq,
         a.ostc+nvl(sum(case when s.fdat > dat2_ then s.dos-s.kos else 0 end),0) osti,
         null ostiq
    from tmp_sal_acc t
         join accounts a on (a.acc = t.acc)--t.branch and a.nls  = t.nls and a.kv = t.kv )
         --(select * from  accounts  where (acc) in ( select  acc from TMP_SAL_ACC where nbs = x.nbs))  a
         left join saldoa  s on (s.acc = a.acc  and s.fdat >= dat1_)
         where t.nbs = x.nbs and t.ob22 = x.ob22
    group by   a.acc, a.nls, a.nms, a.kv, a.ostc ;
end loop;



   OPEN c0 FOR l_sql;
     delete from  tmp_lic;

    LOOP

       fetch c0 BULK COLLECT INTO t_c0 LIMIT 100000;
       EXIT WHEN t_c0.COUNT = 0;

      FOR i IN 1 .. t_c0.COUNT
        LOOP

            CONTINUE WHEN   abs(t_c0(i).ostpi)+ abs(t_c0(i).dosq)+ abs(t_c0(i).kosq) = 0;

        l_rev       := 0;
        l_rev_dos   := 0;
        l_rev_kos   := 0;

       l_ost   := t_c0(i).ostpi+t_c0(i).dosq-t_c0(i).kosq;
       l_ostq  := case when l_ost = 0 or t_c0(i).kv = 980 then  l_ost else pack_sal.p_icurval(t_c0(i).kv, l_ost, dat11) end;
       l_osti  := t_c0(i).ostpi;
       l_ostiq := case when l_osti = 0 or t_c0(i).kv = 980 then  l_osti else pack_sal.p_icurval(t_c0(i).kv, l_osti, dat2_) end;

       l_rev := l_ostiq +  t_c0(i).DOSPQ - t_c0(i).KOSPQ - l_ostq;
       l_rev_dos   :=    least(l_rev,0);
       l_rev_kos   := greatest(l_rev,0);
       t_c0(i).DOSPQ :=  t_c0(i).DOSPQ - l_rev_dos;
       t_c0(i).KOSPQ :=  t_c0(i).KOSPQ + l_rev_kos;

       insert into tmp_lic (  acc, nls,kv,nms, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ, fdat, datp, dapp)
        values( t_c0(i).acc, t_c0(i).nls,t_c0(i).kv, t_c0(i).nms, l_ost, l_ostq, t_c0(i).DOSQ, t_c0(i).KOSQ, t_c0(i).DOSPQ, t_c0(i).KOSPQ, l_osti, l_ostiQ,  dat1_, dat2_, t_c0(i).dapp);
      end loop;
     end loop;



end;




procedure set_sal  (p_fdat1   date,
                    p_fdat2   date,
                    p_listnbs varchar2 ,
                    p_kv      varchar2 default '%',
                    p_ob22    varchar2 default '%',
                    p_branch  varchar2 default '%'
                        )
as

 dat1_ date := p_fdat1;
 dat2_ date := p_fdat2;
 dat11 date;
 l_    pls_integer;


begin

  select max(fdat)
    into dat1_
    from fdat
   where fdat <= dat1_;

  select max(fdat)
    into dat2_
    from fdat
   where fdat <= dat2_;

execute immediate 'truncate table tmp_lic';

 set_list_acc (p_fdat    => p_fdat1    ,
               p_listnbs => p_listnbs,
               p_kv      => p_kv ,
               p_ob22    => p_ob22    ,
               p_branch  => p_branch  );


 begin
   select 1
     into  l_
    from snap_balances
   where fdat = dat2_
     and rownum = 1;
 exception when no_data_found then
      l_ :=0;
 end;

  if l_ = 0 then

        set_sal_saldoa  (p_fdat1   => dat1_,
                         p_fdat2   => dat2_);

  else

        set_sal_snp  (p_fdat1   => dat1_,
                      p_fdat2   => dat2_);
  end if;


end;


procedure      FOSTV_AVG (p_acc      NUMBER,
                          p_dat1     in out DATE,
						  p_dat2     in out DATE,
						  p_ost      out number,
						  p_dos      out number,
						  p_kos      out number,
						  p_ostf     out number,
						  p_ost_avg  out number,
						  p_ostq_avg out number,
						  p_kol      out number)
IS
-- Повертає середньо - арифметичний залишов в номіналі по рахунку за період (календарних днів)
-- За кожний день періоду береться залишок в номіналі на кінець дня. Всі ці залишки додаються і
-- діляться на кількість днів періоду. Результат заокруглюється до цілих копійок.

  l_sum   NUMBER;
  l_sumq  NUMBER;
  l_count NUMBER;
  l_daos  date;
  l_dat1  date;
  l_dazs  date;
  l_dat2  date;
  l_dos   number := 0;
  l_kos   number := 0;
  l_ostc  number := 0;
  l_ostf  number := 0;
  l_dapp   date;
  l_kv     accounts.kv%type;
  DAT      DATE;
  CURSOR CUR1 IS
    SELECT * FROM SALDOA WHERE ACC=p_acc AND FDAT>=p_dat1 ORDER BY FDAT DESC;

  REC CUR1%ROWTYPE;
BEGIN
  IF p_dat1 > p_dat2 THEN
     p_ost      := 0;
	 p_dos      := 0;
	 p_kos      := 0;
	 p_ostf     := 0;
	 p_ost_avg  := 0;
     p_ostq_avg := 0;
	 p_kol      := 0;
     RETURN;
   END IF;

  -- получим текущий остаток и дату последнего движения
  select ostc,   dapp, kv,  daos, dazs
  into   l_ostc, l_dapp, l_kv, l_daos, l_dazs
  from accounts where acc = p_acc;

  l_dat1 := greatest(p_dat1, l_daos);
  l_dat2 :=    least(p_dat2, nvl(l_dazs, to_date('01-01-4000','dd-mm-yyyy')));
  l_ostf := l_ostc;

  -- если дата последнего движения меньше заданного периода, возвращаем остаток
  if l_dapp < l_dat1 then
     p_ost      := l_ostc;
	 p_dos      := 0;
	 p_kos      := 0;
	 p_ostf     := l_ostc;
     p_ost_avg  := l_ostc;
	 l_sumq := 0;
	 l_count := 0;
	DAT := l_dat2;
	WHILE DAT >= l_dat1 LOOP
		l_sumq  := l_sumq + pack_sal.p_icurval(l_kv, l_ostc, DAT);
		l_count := l_count + 1;
		DAT     := DAT - 1;
    END LOOP;

	 p_ostq_avg := ROUND(l_sumq /greatest(l_count,1));
	 p_kol      := l_count;

	return;
  end if;

  l_sum := 0;
  l_sumq := 0;
  l_count := 0;

  DAT := l_dat2;
  OPEN CUR1;
  FETCH CUR1 INTO REC;
  WHILE (CUR1%FOUND) LOOP

    if REC.FDAT between  l_dat1 and l_dat2 then
	    l_dos := l_dos + REC.DOS;
		l_kos := l_kos + REC.KOS;
	end if;

    IF REC.FDAT > l_dat2 THEN
      l_ostc := l_ostc - (REC.KOS - REC.DOS);
	  l_ostf := l_ostc;
    ELSE
      WHILE DAT >= REC.FDAT LOOP
        l_sum := l_sum + l_ostc;
		l_sumq := l_sumq + pack_sal.p_icurval(l_kv, l_ostc, DAT);
        l_count := l_count + 1;
        DAT := DAT - 1;
      END LOOP;
      l_ostc := l_ostc - (REC.KOS - REC.DOS);

    END IF;
    FETCH CUR1 INTO REC;
  END LOOP;

  WHILE DAT >= l_dat1 LOOP
    l_sum   := l_sum + l_ostc;
	l_sumq  := l_sumq + pack_sal.p_icurval(l_kv, l_ostc, DAT);
    l_count := l_count + 1;
    DAT     := DAT - 1;
  END LOOP;

     p_ost      := l_ostf+l_dos-l_kos;
	 p_dos      := l_dos;
	 p_kos      := l_kos;
	 p_ostf     := l_ostf;
     p_ost_avg  := ROUND(l_sum/greatest(l_count,1));
	 p_ostq_avg := ROUND(l_sumq/greatest(l_count,1));
     p_kol      := l_count;

    p_dat1 := l_dat1;
    p_dat2 := l_dat2;
END FOSTV_AVG;


procedure set_sal_average  (p_fdat1   date,
							p_fdat2   date,
							p_listnbs varchar2 ,
							p_kv      varchar2 default '%',
							p_ob22    varchar2 default '%',
							p_branch  varchar2 default '%'
                        )
as

 dat1_ date := p_fdat1;
 dat2_ date := p_fdat2;
 dat11 date;
 l_    pls_integer;

 l_ost   number;
 l_ostq  number;
 l_osti  number;
 l_ostiq number;

 t_c0  tb_row;
 c0    SYS_REFCURSOR;

 l_sql varchar2(4000) := 'select /*+ parallel(10) */
                             acc, nls, kv,
                             t.nms nms, t.dapp dapp,
                             0 OSTF, 0 OSTFQ, 0 dosq, 0 kosq, 0 dospq, 0 kospq, 0 ostpi, 0 OSTPIQ, 0 nb
                      from tmp_sal_acc t';

begin



execute immediate 'truncate table tmp_lic';

 set_list_acc (p_fdat    => p_fdat1    ,
               p_listnbs => p_listnbs,
               p_kv      => p_kv ,
               p_ob22    => p_ob22    ,
               p_branch  => p_branch  );



  OPEN c0 FOR l_sql;


    LOOP

       fetch c0 BULK COLLECT INTO t_c0 LIMIT 100000;
       EXIT WHEN t_c0.COUNT = 0;

      FOR i IN 1 .. t_c0.COUNT
        LOOP
          dat1_  := p_fdat1;
          dat2_  := p_fdat2;
        fostv_avg(p_acc        =>  t_c0(i).acc       ,
                  p_dat1       =>   dat1_,
                  p_dat2       =>   dat2_,
                  p_ost        =>  l_ost,
                  p_dos        =>  t_c0(i).DOSQ,
                  p_kos        =>  t_c0(i).KOSQ,
                  p_ostf       =>  l_osti,
                  p_ost_avg    =>  l_ostq,
                  p_ostq_avg   =>  l_ostiQ,
				  p_kol        =>  t_c0(i).nb
                  );

		CONTINUE WHEN   abs(l_ost)+ abs(t_c0(i).dosq)+ abs(t_c0(i).kosq)+ abs(l_osti)  = 0;

       insert into tmp_lic (  acc, nls,kv,nms, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ, fdat, datp, dapp, nb)
        values( t_c0(i).acc, t_c0(i).nls,t_c0(i).kv, t_c0(i).nms, l_ost, l_ostq, t_c0(i).DOSQ, t_c0(i).KOSQ, t_c0(i).DOSPQ, t_c0(i).KOSPQ, l_osti, l_ostiQ,  dat1_, dat2_, t_c0(i).dapp, t_c0(i).nb);
      end loop;
     end loop;

 /*
  select acc, nls,kv,nms,
                          OSTF,   -- вх номінал
                          DOSQ,   -- ДТ ном
						  KOSQ,   -- КТ ном
						  OSTPI,  -- вих Зал ном
						  OSTFQ,  -- середньбоденний номіеал
						  OSTPIQ, -- середньоденний еквівалент
						  fdat, -- початок періода
						  datp, -- кінець періода
						  dapp,
						  nb   - кількість днів
   from tmp_lic
  */


end;

end pack_sal;
/
 show err;
 
PROMPT *** Create  grants  PACK_SAL ***
grant EXECUTE                                                                on PACK_SAL        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pack_sal.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 