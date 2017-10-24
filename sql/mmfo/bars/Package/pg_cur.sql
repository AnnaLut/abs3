
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pg_cur.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PG_CUR 
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
  
 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.1.7  21.02.2017 16:06';



 /**
 * header_version - возвращает версию заголовка пакета  
 */
function header_version return varchar2;


/**
 * body_version - возвращает версию тела пакета  
 */
function body_version   return varchar2;
   
function f_cur( p_fdat date, p_kv number) return number;


FUNCTION p_icurval ( iCur          NUMBER,
                     iSum          NUMBER,
                     dDesiredDate  DATE,
                     iType         NUMBER DEFAULT 0,
                     iDefaultValue NUMBER DEFAULT 1,    -- not used
                     iUseFuture    NUMBER DEFAULT 0,    -- not used
                     iCheck4Errors NUMBER DEFAULT 0     -- not used
                    )

RETURN NUMBER;  

procedure p_ob_sal(dat1 date
                  ,dat2 date
                  ,nbs_list varchar2
                  ,cust number       default 2
                  ,val number        default 1
                  ,p_k050 varchar2   default 0
                  ,p_rezid number    default 0);
 
procedure p_sal(   p_dir varchar2
                  ,dat1 date
                  ,dat2 date
                  ,nbs_list varchar2
                  ,cust number       default 0
                  ,val number        default 0
                  ,p_k050 varchar2   default 0
                  ,p_rezid number    default 0); 

procedure p_per_sal(   p_dir varchar2
                      ,dat1 date
					  ,dat2 date
					  ,nbs_list varchar2
					  ,cust number       default 0
					  ,val number        default 0
					  ,p_k050 varchar2   default 0
					  ,p_rezid number    default 0);				  
									
procedure rptlic_nls (p_date1   date
                     ,p_date2   date
                     ,nbs_list_ varchar2 --            default '%',
                     ,p_kv      number--            default 0,
                     ,p_isp     number              default 0
                     ,p_branch  branch.branch%type  default sys_context('bars_context','user_branch')
                     ,p_inform  smallint            default 0);
                                    
procedure p_doc_per(   p_dir varchar2
                      ,dat1 date
					  ,dat2 date);									
procedure p_doc_per2(  p_dir varchar2
                      ,dat1 date
					  ,dat2 date);
					  
procedure p_doc (    p_dir varchar2 default 'AUDIT_NBU'
                    ,p_dat date
                    );	
					
procedure p_doc2 (    p_dir varchar2 default 'AUDIT_NBU'
                    ,p_dat date
                    );					
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.PG_CUR 
is

G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'Version 1.1.10  15.03.2017 18:36';


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

   select  min(fdat) into  l_fdat from fdat where fdat >= p_fdat;

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


  IF iCur = gl.baseval OR iSum = 0 THEN
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


procedure p_ob_sal(dat1 date
                  ,dat2 date
                  ,nbs_list varchar2
                  ,cust number       default 2
                  ,val number        default 1
                  ,p_k050 varchar2   default 0
                  ,p_rezid number    default 0)
as
 dat1_ date := trunc(dat1,'mm');
 dat2_ date := add_months(trunc(dat2,'mm'),1)-1;
 dat3_ date := trunc(dat2,'mm')+31;
 nbs_list_ varchar2(4000) := nbs_list;

 l_ost   number;
 l_ostq  number;
 l_osti  number;
 l_ostiq number; 
 
 l_obl number;

 cursor c0 is select nvl(t.mfo,a.mfo) mfo,
                     nvl(t.id,a.rnk) rnk, 
                     nvl(t.acc,a.acc) acc, 
                     nvl(t.nls,a.nls) nls,
                     nvl(t.kv,a.kv) kv, 
                     nvl(t.okpo,a.okpo) okpo, 
                     a.nms nms,datp, dapp, 
                     OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ 
              from tmp_sal_rnk a left join tmp_lic t on a.acc =t.acc;
 t_c0  c0%rowtype;

begin 
  execute immediate 'truncate table tmp_sal';
  execute immediate 'truncate table tmp_lic';
  execute immediate 'truncate table tmp_sal_rnk';
    
        
    /*select ko
      into l_obl
     from banks_ru o, KODOBL_REG k
    where mfo = f_ourmfo_g
      and o.ru = k.c_reg;*/
      
      select ko
      into l_obl
     from banks_ru o, KODOBL_REG k
    where mfo = decode (f_ourmfo_g, '300465', '322669', f_ourmfo_g)
      and o.ru = k.c_reg; 

    
  insert into tmp_sal(nbs) (select to_char(column_value) nbs from table(gettokens(nbs_list_)));
  
  insert  into tmp_sal_rnk (mfo,acc,nls,kv,okpo, rnk, nms)
  select /*+ parallel(6) */
        a.kf, a.acc, a.nls, a.kv, c.okpo, c.rnk, a.nms
  from  tmp_sal  p,
        accounts a, 
        customer c,
        CODCAGENT d 
  where a.nbs = p.nbs
    and a.kv in (select kv from tabval where (val = 0 and 1 = 1) or (val = 1 and kv not in (980,959, 961, 962)) or (val = 2 and kv in (959, 961, 962)) or kv = val )
    and a.rnk = c.rnk
    and c.custtype = decode(cust,0,c.custtype ,cust)
    and c.k050 = decode(p_k050,0,c.k050 , p_k050)
    and a.daos < dat3_
    and nvl(a.dazs,to_date('01-01-4000','dd-mm-yyyy'))> dat1_
    and c.codcagent=d.codcagent
    and D.REZID = decode(p_rezid,0, D.REZID,p_rezid);

  insert  into tmp_lic (mfo, id,acc, nls,kv,okpo,  dapp, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ )
  select /*+ parallel(saldoa,6) */
         a.mfo,a.rnk, a.acc, a.nls, a.kv, a.okpo,  max(s.fdat) dapp,
         null ost,
         null ostq,
         sum(dos) dos,
         sum(kos) kos,
         sum( case when dos!=0 then pg_cur.p_icurval(a.kv,dos, s.fdat) else 0 end) dosq,
         sum( case when kos!=0 then pg_cur.p_icurval(a.kv,kos, s.fdat) else 0 end) kosq,
         null osti,
         null ostiq       
    from tmp_sal_rnk a,
         saldoa s
     where  a.acc=s.acc
         and s.fdat between dat1_ and  dat2_ 
    group by a.mfo, a.rnk,a.acc, a.nls, a.nms, a.kv, a.okpo;

    open c0; 
   
     delete from  tmp_lic;
   
     loop
       fetch c0 into t_c0; 
       exit when c0%notfound;
      
       l_ost   := fost(t_c0.acc, dat1_-1);
       l_ostq  := case when l_ost = 0  then  0 else pg_cur.p_icurval(t_c0.kv, l_ost, dat1_) end;  
       l_osti  := fost(t_c0.acc, dat2_);
       l_ostiq := case when l_osti = 0 then  0 else pg_cur.p_icurval(t_c0.kv, l_osti, dat2_) end;
            
       insert into tmp_lic (mfo, id, acc, nls,kv,okpo,nms, OSTF, OSTFQ, DOSQ, KOSQ, DOSPQ, KOSPQ, OSTPI, OSTPIQ, fdat, dapp, datp, pp) 
        values(t_c0.mfo, t_c0.rnk ,t_c0.acc, t_c0.nls,t_c0.kv,t_c0.okpo, t_c0.nms, l_ost, l_ostq, t_c0.DOSQ, t_c0.KOSQ, t_c0.DOSPQ, t_c0.KOSPQ, l_osti, l_ostiQ,  dat1_, dat2_, t_c0.dapp, l_obl);
       
     end loop; 

end;


procedure p_sal(   p_dir  varchar2
                  ,dat1 date
                  ,dat2 date
                  ,nbs_list varchar2
                  ,cust number       default 0
                  ,val number        default 0
                  ,p_k050 varchar2   default 0
                  ,p_rezid number    default 0)
as
 dat1_ date := trunc(dat1,'mm');
 dat2_ date := add_months(trunc(dat2,'mm'),1)-1;
 dat3_ date := trunc(dat2,'mm')+31;
 nbs_list_ varchar2(4000) := nbs_list;

 l_ost   number;
 l_ostq  number;
 l_osti  number;
 l_ostiq number; 
 
 l_obl number;
 --p_dir varchar2(20) := 'FIN351'; 
 p_filename varchar2(200) := 'S'||f_ourmfo_g||'_'||nbs_list||'_'||to_char(dat1_,'yyyymmdd')||'.txt';
  f UTL_FILE.FILE_TYPE;
  l_chr varchar2(1) := chr(9); 
 cursor c0 is select  t.nls,
                       t.kv,
                       t.okpo,
                       t.nms,
                       nvl(s.dapp,a.dapp) dapp,
                       a.ostc + nvl(s.dosp,0) - nvl(s.kosp,0) ost,
                       nvl(s.dos,0) dos,
                       nvl(s.kos,0) kos,
                       (a.ostc + nvl(s.dosp,0) - nvl(s.kosp,0))-nvl(s.dos,0)+nvl(s.kos,0) ostf
                  from tmp_sal_rnk t join accounts a on (a.acc = t.acc)
                       left join  ( select s.acc, 
                                           sum(case when s.fdat between dat1_ and dat2_ then s.dos else 0 end) dos,
                                           sum(case when s.fdat between dat1_ and dat2_ then s.kos else 0 end) kos,
                                           sum(dos) dosp,
                                           sum(kos) kosp,
                                           min(case when s.fdat >= dat2_ then s.pdat else null end) dapp
                                      from tmp_sal_rnk t,saldoa s
                                     where s.fdat >= dat1_ and t.acc = s.acc
                                     group by s.acc) s on ( s.acc = a.acc);    
 t_c0  c0%rowtype;

begin 
  execute immediate 'truncate table tmp_sal';
  execute immediate 'truncate table tmp_lic';
  execute immediate 'truncate table tmp_sal_rnk';
    
        
   /* select ko
      into l_obl
     from banks_ru o, KODOBL_REG k
    where mfo = f_ourmfo_g
      and o.ru = k.c_reg;
      
      case when l_obl=0 then l_obl :=26; else null; end case;*/
    
      select ko
      into l_obl
     from banks_ru o, KODOBL_REG k
    where mfo = decode (f_ourmfo_g, '300465', '322669', f_ourmfo_g)
      and o.ru = k.c_reg;
    
    
  insert into tmp_sal(nbs) (select to_char(column_value) nbs from table(gettokens(nbs_list_)));
  
  insert  into tmp_sal_rnk (mfo,acc,nls,kv,okpo, rnk, nms)
  select /*+ parallel(6) */
        a.kf, a.acc, a.nls, a.kv, c.okpo, c.rnk, a.nms
  from  tmp_sal  p,
        accounts a, 
        customer c,
        CODCAGENT d 
  where a.nbs = p.nbs
    and a.kv in (select kv from tabval where (val = 0 and 1 = 1) or (val = 1 and kv not in (980,959, 961, 962)) or (val = 2 and kv in (959, 961, 962)) or kv = val )
    and a.rnk = c.rnk
    and c.custtype = decode(cust,0,c.custtype ,cust)
    and c.k050 = decode(p_k050,0,c.k050 , p_k050)
    and a.daos < dat3_
    and nvl(a.dazs,to_date('01-01-4000','dd-mm-yyyy'))> dat1_
    and c.codcagent=d.codcagent
    and D.REZID = decode(p_rezid,0, D.REZID,p_rezid);


   open c0; 
     f := UTL_FILE.FOPEN(p_dir, p_filename,'W'); 
      
     loop
       fetch c0 into t_c0; 
       exit when c0%notfound;
       
       UTL_FILE.PUT_LINE(f, 
       to_char(dat1_,'dd.MM.yyyy')|| l_chr ||
       to_char(dat2_,'dd.MM.yyyy')|| l_chr||
       to_char(t_c0.nls)          || l_chr ||
       to_char(t_c0.kv)           || l_chr ||
       to_char(t_c0.okpo)         || l_chr ||
       f_escaped(t_c0.nms,l_chr)  || l_chr ||
       nvl(to_char(t_c0.dapp,'dd.MM.yyyy'),' ')|| l_chr ||
       TO_CHAR(case when t_c0.ost < 0 then  -t_c0.ost else 0 end,'FM999999999999999999999999999990','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
       TO_CHAR(case when t_c0.ost > 0 then   t_c0.ost else 0 end,'FM999999999999999999999999999990','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
       TO_CHAR(t_c0.dos,'FM999999999999999999999999999990','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
       TO_CHAR(t_c0.kos,'FM999999999999999999999999999990','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
       TO_CHAR(case when t_c0.ostf < 0 then  -t_c0.ostf else 0 end,'FM999999999999999999999999999990','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
       TO_CHAR(case when t_c0.ostf > 0 then   t_c0.ostf else 0 end,'FM999999999999999999999999999990','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
       to_char(l_obl)
       );
       
     end loop;
   
     UTL_FILE.FCLOSE(f);
    
end;


procedure p_per_sal(   p_dir varchar2
                      ,dat1 date
                      ,dat2 date
                      ,nbs_list varchar2
                      ,cust number       default 0
                      ,val number        default 0
                      ,p_k050 varchar2   default 0
                      ,p_rezid number    default 0)
as
begin

for k in (select distinct trunc(fdat,'mm') fdat from fdat where fdat between dat1 and dat2)
  Loop

         p_sal(   p_dir        =>  p_dir
                  ,dat1        =>  k.fdat      
                  ,dat2        =>  add_months(trunc( k.fdat,'mm'),1)-1   
                  ,nbs_list    =>  nbs_list  
                  ,cust        =>  cust      
                  ,val         =>  val       
                  ,p_k050      =>  p_k050    
                  ,p_rezid     =>  p_rezid  ); 
                  
    end loop;    
    
end;



procedure rptlic_nls (p_date1   date
                     ,p_date2   date
                     ,nbs_list_ varchar2 --            default '%',
                     ,p_kv      number--            default 0,
                     ,p_isp     number              default 0
                     ,p_branch  branch.branch%type  default sys_context('bars_context','user_branch')
                     ,p_inform  smallint            default 0)
as
begin

execute immediate 'truncate table tmp_sal';
execute immediate 'truncate table tmp_lic';
execute immediate 'truncate table tmp_licM';


     insert into tmp_sal(nbs) (select to_char(column_value) nbs from table(gettokens(nbs_list_)));
     

     insert into  tmp_lic (acc, nls, kv, nms)
     select a.acc, a.nls, a.kv, a.nms
       from accounts a, tmp_sal t
      where (a.dazs is null or a.dazs >= p_date1) and  a.nbs=t.nbs
        and a.kv = (case when p_kv in ( 0,1) then a.kv else p_kv end )
        and a.kv != case when p_kv = 1 then 980 else 0 end ;



    --  LIC_DYNSQL
    --
    --   Формирование выписок по динамическому запросу из справочника REPVP_DYNSQL
    --
    --   p_date1   -  дата с
    --   p_date2   -  дата по
    --   p_inform  -  информационные сообщения (=1 - вносить, =0 - не вносить)
    --   p_kv      -  (0-все)
    --   p_mltval  -  вылютная (если =2, включает тогда и гривну с валютой)
    --   p_valeqv  -  с эквивалентами
    --   p_valrev  -  с переоценкой (revaluation)
    --   p_sqlid   -  № динамич. запроса    из справочника REPVP_DYNSQL
    
 

     BARS_RPTLIC.LIC_SQLDYN(P_DATE1   =>p_date1,
                            P_DATE2   =>p_date2,
                            P_INFORM  =>0,
                            P_KV      =>0,
                            P_MLTVAL  =>2,
                            P_VALEQV  =>1,
                            P_VALREV  =>1,
                            P_SQLID   =>2);


end;



procedure p_doc_per(   p_dir varchar2
                      ,dat1 date
                      ,dat2 date)
as
begin

for k in (select distinct trunc(fdat,'Q') fdat from fdat where fdat between dat1 and dat2)
  Loop

          p_doc(   p_dir        =>  p_dir
                  ,p_dat        =>  k.fdat ); 
                  
    end loop;    
    
end;

procedure p_doc_per2(   p_dir varchar2
                      ,dat1 date
                      ,dat2 date)
as
begin

for k in (select distinct trunc(fdat,'Q') fdat from fdat where fdat between dat1 and dat2)
  Loop

          p_doc2(   p_dir        =>  p_dir
                  ,p_dat        =>  k.fdat ); 
                  
    end loop;    
    
end;

procedure p_doc (    p_dir varchar2 default 'AUDIT_NBU'
                    ,p_dat date
                    )
as

cursor c29 is select * from test_oper_p29; 
t_c29  c29%rowtype;

cursor c30 is select * from test_oper_p30; 
t_c30  c30%rowtype;

cursor c31 is select * from test_oper_p31; 
t_c31  c31%rowtype;

cursor c32 is select * from test_oper_p32; 
t_c32  c32%rowtype;

cursor c67 is select * from test_oper_p67; 
t_c67  c67%rowtype;

  p_filename varchar2(200);
  f UTL_FILE.FILE_TYPE;
  l_chr varchar2(1) := ';';
  l_kv  varchar2(3) ;
  l_sq  number;
  l_fio operw.value%type;
  
Begin
/*
Дата операції
Дт (балансовий р-к)
Кт (балансовий р-к)
Сума (номінал валюти)
Сума (гривневий еквівалент)
Валюта
Дт (особовий р-к)
Найменування контрагенту Дт
Кт (особовий р-к)
Найменування контрагенту Кт
Призначення платежу

*/



execute immediate 'truncate table test_oper_p29';
execute immediate 'truncate table test_oper_p30';
execute immediate 'truncate table test_oper_p31';
execute immediate 'truncate table test_oper_p32';
execute immediate 'truncate table test_oper_p67';



execute immediate
                'insert /*+ append*/  all
                 --P29
                  --when sos = 5 and tt not in (''ЧЕК'',''ЧЕ1'') and (
                  --     (regexp_like(nlsa,''^100[1,2]'') and regexp_like(nlsb,''^26[025][053]'') and (kv!= 980 or kv2 != 980))  or
                  --     (regexp_like(nlsb,''^100[1,2]'') and regexp_like(nlsa,''^26[025][053]'') and (kv!= 980 or kv2 != 980)) ) then   into test_oper_p29  
                  when sos = 5 and tt not in (''ЧЕК'',''ЧЕ1'') and (
                       (regexp_like(nlsa,''^(1001|1002)'') and regexp_like(nlsb,''^(2600|2650|2620|2625|2924|2603)'') and (kv!= 980 and kv2 != 980))  or
                       (regexp_like(nlsa,''^(2600|2650|2620|2605|2625|2924|2630|2635)'') and regexp_like(nlsb,''^(1001|1002)'') and (kv!= 980 and kv2 != 980)) ) then   into test_oper_p29   
                           
                --P30
                  when sos = 5 and refl is null and 
                       (regexp_like(nlsa,''^2625'') and regexp_like(nlsb,''^(6|2900)'') and (kv!= 980 and kv2 != 980))   then   into test_oper_p30
                --P31
                  when sos = 5  and (
                       (regexp_like(nlsa,''^(2909|2620|2625|2605)'') and regexp_like(nlsb,''^(1500|1919)'') and (kv!= 980 and kv2 != 980))  or
                       (regexp_like(nlsa,''^(2625|2605)'') and regexp_like(nlsb,''^(2924)'') and (kv!= 980 and kv2 != 980))  or
                       (regexp_like(nlsa,''^(2924)'') and regexp_like(nlsb,''^(2625|2605)'') and (kv!= 980 and kv2 != 980)) ) then   into test_oper_p31  
                --P32
                  when sos = 5  and (
                       (regexp_like(nlsa,''^(2600|2650)'') and regexp_like(nlsb,''^(1500|1919|1600)'') and (kv= 980 and kv2 = 980))  or
                       (regexp_like(nlsa,''^(1500|1600|1919)'') and regexp_like(nlsb,''^(2909|2620|2625|2605|2603)'') and (kv= 980 and kv2 = 980))  or
                       (regexp_like(nlsa,''^(2603)'') and regexp_like(nlsb,''^(2600|2650)'') and (kv= 980 and kv2 = 980)) or
                       (regexp_like(nlsa,''^(1919)'') and regexp_like(nlsb,''^(1600|1500)'') and (kv= 980 and kv2 = 980))) then   into test_oper_p32 
                 --P67
                  when sos = 5  and  nazn not like ''%ГВФО%'' and (
                       --(regexp_like(nlsa,''^100[1,2]'') and regexp_like(nlsb,''^2[89]09''))  or
                       --(regexp_like(nlsb,''^100[1,2]'') and regexp_like(nlsa,''^2[89]09''))  or
					   (regexp_like(nlsa,''^100[1,2]'') and regexp_like(nlsb,''^2902''))  or
					   tt in (''AA3'',''AA4'',''AA5'',''AA6'',''TMP'')
					   ) then   into test_oper_p67                         
                select * from (
                 select /*+ parallel(10) */ 
                       ref,
                       nvl(bdat,trunc(pdat)) bdat,
                       pdat,
                       s,
                       sq,
                       case when dk = 0 then kv2   else kv   end kv,
                       case when dk = 0 then mfob  else mfoa end mfoa,
                       case when dk = 0 then nlsb  else nlsa end nlsa,
                       case when dk = 0 then nam_b else nam_a end nama,
                       case when dk = 1 then kv2   else kv   end kv2,
                       case when dk = 1 then mfob  else mfoa end mfob,
                       case when dk = 1 then nlsb  else nlsa end nlsb,
                       case when dk = 1 then nam_b else nam_a end namb,
                       nazn, refl, sos, tt
                     from oper partition for ( to_date('''||to_char(p_dat,'dd/mm/yyyy') ||''',''dd/mm/yyyy'') )
                     )';


commit;

 tuda;
  open c29;
    p_filename := 'D_P29_'||f_ourmfo_g||'_'||to_char(trunc(p_dat,'q'),'yyyymmdd')||'.csv';
    f := UTL_FILE.FOPEN(p_dir, p_filename,'W');     
    loop
       fetch c29 into t_c29; 
       exit when c29%notfound;
       CONTINUE WHEN t_c29.mfoa!=t_c29.mfob;

       l_kv :=  coalesce(nullif(t_c29.KVA,980),nullif(t_c29.KVB,980),980);
       UTL_FILE.PUT_LINE(f, 
                   to_char(t_c29.bdat,'dd.MM.yyyy')|| l_chr ||
                   substr(t_c29.nlsa,1,4)          || l_chr ||
                   substr(t_c29.nlsb,1,4)          || l_chr ||                   
                   TO_CHAR(t_c29.s/100, 'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   TO_CHAR(case when l_kv = 980 then t_c29.s else pg_cur.p_icurval(l_kv,t_c29.s,t_c29.bdat) end/100,'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   to_char(t_c29.kva) || l_chr ||
                   to_char(t_c29.nlsa)|| l_chr ||
                   to_char(t_c29.nama)|| l_chr ||
                   to_char(t_c29.kvb) || l_chr ||
                   to_char(t_c29.nlsb)|| l_chr ||
                   to_char(t_c29.namb)|| l_chr ||
                   f_escaped(t_c29.nazn,l_chr)  
              );
    end loop; 
     UTL_FILE.FCLOSE(f);    
  close c29; 

  open c30;
    p_filename := 'D_P30_'||f_ourmfo_g||'_'||to_char(trunc(p_dat,'q'),'yyyymmdd')||'.csv';
    f := UTL_FILE.FOPEN(p_dir, p_filename,'W');     
    loop
       fetch c30 into t_c30; 
       exit when c30%notfound;
       CONTINUE WHEN t_c30.mfoa!=t_c30.mfob;

       l_kv :=  coalesce(nullif(t_c30.KVA,980),nullif(t_c30.KVB,980),980);
       UTL_FILE.PUT_LINE(f, 
                   to_char(t_c30.bdat,'dd.MM.yyyy')|| l_chr ||
                   substr(t_c30.nlsa,1,4)          || l_chr ||
                   substr(t_c30.nlsb,1,4)          || l_chr ||                   
                   TO_CHAR(t_c30.s/100, 'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   TO_CHAR(case when l_kv = 980 then t_c30.s else pg_cur.p_icurval(l_kv,t_c30.s,t_c30.bdat) end/100,'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   to_char(t_c30.kva) || l_chr ||
                   to_char(t_c30.nlsa)|| l_chr ||
                   to_char(t_c30.nama)|| l_chr ||
                   to_char(t_c30.kvb) || l_chr ||
                   to_char(t_c30.nlsb)|| l_chr ||
                   to_char(t_c30.namb)|| l_chr ||
                   f_escaped(t_c30.nazn,l_chr)  
              );
    end loop; 
     UTL_FILE.FCLOSE(f);    
  close c30; 

    open c31;
    p_filename := 'D_P31_'||f_ourmfo_g||'_'||to_char(trunc(p_dat,'q'),'yyyymmdd')||'.csv';
    f := UTL_FILE.FOPEN(p_dir, p_filename,'W');     
    loop
       fetch c31 into t_c31; 
       exit when c31%notfound;
       CONTINUE WHEN t_c31.mfoa!=t_c31.mfob;

       l_kv :=  coalesce(nullif(t_c31.KVA,980),nullif(t_c31.KVB,980),980);
       UTL_FILE.PUT_LINE(f, 
                   to_char(t_c31.bdat,'dd.MM.yyyy')|| l_chr ||
                   substr(t_c31.nlsa,1,4)          || l_chr ||
                   substr(t_c31.nlsb,1,4)          || l_chr ||                   
                   TO_CHAR(t_c31.s/100, 'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   TO_CHAR(case when l_kv = 980 then t_c31.s else pg_cur.p_icurval(l_kv,t_c31.s,t_c31.bdat) end/100,'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   to_char(t_c31.kva) || l_chr ||
                   to_char(t_c31.nlsa)|| l_chr ||
                   to_char(t_c31.nama)|| l_chr ||
                   to_char(t_c31.kvb) || l_chr ||
                   to_char(t_c31.nlsb)|| l_chr ||
                   to_char(t_c31.namb)|| l_chr ||
                   f_escaped(t_c31.nazn,l_chr)  
              );
    end loop; 
     UTL_FILE.FCLOSE(f);    
  close c31; 
  
 
    open c32;
    p_filename := 'D_P32_'||f_ourmfo_g||'_'||to_char(trunc(p_dat,'q'),'yyyymmdd')||'.csv';
    f := UTL_FILE.FOPEN(p_dir, p_filename,'W');     
    loop
       fetch c32 into t_c32; 
       exit when c32%notfound;
       CONTINUE WHEN t_c32.mfoa!=t_c32.mfob;

       l_kv :=  coalesce(nullif(t_c32.KVA,980),nullif(t_c32.KVB,980),980);
       UTL_FILE.PUT_LINE(f, 
                   to_char(t_c32.bdat,'dd.MM.yyyy')|| l_chr ||
                   substr(t_c32.nlsa,1,4)          || l_chr ||
                   substr(t_c32.nlsb,1,4)          || l_chr ||                   
                   TO_CHAR(t_c32.s/100, 'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   TO_CHAR(case when l_kv = 980 then t_c32.s else pg_cur.p_icurval(l_kv,t_c32.s,t_c32.bdat) end/100,'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   to_char(t_c32.kva) || l_chr ||
                   to_char(t_c32.nlsa)|| l_chr ||
                   to_char(t_c32.nama)|| l_chr ||
                   to_char(t_c32.kvb) || l_chr ||
                   to_char(t_c32.nlsb)|| l_chr ||
                   to_char(t_c32.namb)|| l_chr ||
                   f_escaped(t_c32.nazn,l_chr) 
              );
    end loop; 
     UTL_FILE.FCLOSE(f);    
  close c32; 

 
    open c67;
    p_filename := 'D_P67_'||f_ourmfo_g||'_'||to_char(trunc(p_dat,'q'),'yyyymmdd')||'.csv';
    f := UTL_FILE.FOPEN(p_dir, p_filename,'W');     
    loop
       fetch c67 into t_c67; 
       exit when c67%notfound;
	   l_fio := null;
       l_kv :=  coalesce(nullif(t_c67.KVA,980),nullif(t_c67.KVB,980),980);
       l_sq :=  case when l_kv = 980 then t_c67.s else pg_cur.p_icurval(l_kv,t_c67.s,t_c67.bdat) end/100;
       l_fio := f_dop(t_c67.ref,'FIO  ');
       CONTINUE WHEN l_sq <150000;
       CONTINUE WHEN t_c67.mfoa!=t_c67.mfob;
      -- CONTINUE WHEN l_fio is null and  t_c67.nlsb like '2902%';
       
       UTL_FILE.PUT_LINE(f, 
                   to_char(t_c67.bdat,'dd.MM.yyyy')|| l_chr ||
                   substr(t_c67.nlsa,1,4)          || l_chr ||
                   substr(t_c67.nlsb,1,4)          || l_chr ||                   
                   TO_CHAR(t_c67.s/100, 'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   TO_CHAR(l_sq,'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   to_char(t_c67.kva) || l_chr ||
                   to_char(t_c67.nlsa)|| l_chr ||
                   to_char(t_c67.nama)|| l_chr ||
                   to_char(t_c67.kvb) || l_chr ||
                   to_char(t_c67.nlsb)|| l_chr ||
                   to_char(t_c67.namb)|| l_chr ||
                   f_escaped(t_c67.nazn,l_chr)|| l_chr ||  
                   l_fio
                   
              );
    end loop; 
     UTL_FILE.FCLOSE(f);    
  close c67; 
  
end;


procedure p_doc2 (    p_dir varchar2 default 'AUDIT_NBU'
                     ,p_dat date
                    )
as

sql_ varchar2(4000); 
p_dat2 date;
cursor c67 is select * from test_oper_p67; 
t_c67  c67%rowtype;

  p_filename varchar2(200);
  f UTL_FILE.FILE_TYPE;
  l_chr varchar2(1) := ';';
  l_kv  varchar2(3) ;
  l_sq  number;
  l_fio operw.value%type;
  
Begin
/*
Дата операції
Дт (балансовий р-к)
Кт (балансовий р-к)
Сума (номінал валюти)
Сума (гривневий еквівалент)
Валюта
Дт (особовий р-к)
Найменування контрагенту Дт
Кт (особовий р-к)
Найменування контрагенту Кт
Призначення платежу

*/
dbms_application_info.set_client_info ('Формування = '||to_char(p_dat,'dd/mm/yyyy'));
p_dat2 :=  add_months(p_dat,3)-1;

--execute immediate 'truncate table test_oper_p29';
--execute immediate 'truncate table test_oper_p30';
--execute immediate 'truncate table test_oper_p31';
--execute immediate 'truncate table test_oper_p32';
execute immediate 'truncate table test_oper_p67';
 tuda;

 -- REF, BDAT, PDAT, S, SQ, KVA, MFOA, NLSA, NAMA, KVB, MFOB, NLSB, NAMB, NAZN, REFL, SOS, TT
 sql_ :=
                'insert /*+ append*/  all
     --P67
                  when 1=1
					     then   into test_oper_p67                         
                   select /*+ parallel(10)*/o1.ref, o1.fdat, o2.fdat pdat, o1.s, o1.sq, a1.kv kva, '||f_ourmfo_g||' mfoa, a1.nls nlsa, substr(a1.nms,1,38) nmsa, a2.kv, '||f_ourmfo_g||' mfob, a2.nls, substr(a2.nms,1,38) nms2, o2.txt, o1.ref reffl, o1.sos, o1.tt  
					 from opldok partition for ( to_date('''||to_char(p_dat,'dd/mm/yyyy') ||''',''dd/mm/yyyy'') ) o1, accounts a1,-- saldoa s1,
						  opldok partition for ( to_date('''||to_char(p_dat,'dd/mm/yyyy') ||''',''dd/mm/yyyy'') ) o2, accounts a2--, saldoa s2
					where a1.acc = o1.acc  and o1.dk = 0 and 
						  a2.acc = o2.acc  and o2.dk = 1  
						  and o1.fdat between  to_date('''||to_char(p_dat,'dd/mm/yyyy') ||''',''dd/mm/yyyy'') and  to_date('''||to_char(p_dat2,'dd/mm/yyyy') ||''',''dd/mm/yyyy'') and a1.nbs in (''1001'',''1002'',''3800'') 
						  and substr(a1.nbs,1,1) !=substr(a2.nbs,1,1) 
						  and o2.fdat between  to_date('''||to_char(p_dat,'dd/mm/yyyy') ||''',''dd/mm/yyyy'') and  to_date('''||to_char(p_dat2,'dd/mm/yyyy') ||''',''dd/mm/yyyy'') and a2.nbs in (''1001'',''1002'',''3800'')
						  and o1.dk = 1-o2.dk 
						  and o1.fdat = o2.fdat
						  and o1.ref = o2.ref
						  and o1.stmt = o2.stmt';
--return;						  
execute immediate sql_;
commit;



 
    open c67;
    p_filename := 'D_P67k_'||f_ourmfo_g||'_'||to_char(trunc(p_dat,'q'),'yyyymmdd')||'.csv';
    f := UTL_FILE.FOPEN(p_dir, p_filename,'W');     
    loop
       fetch c67 into t_c67; 
       exit when c67%notfound;
	   l_fio := null;
       l_kv :=  coalesce(nullif(t_c67.KVA,980),nullif(t_c67.KVB,980),980);
       l_sq :=  case when l_kv = 980 then t_c67.s else pg_cur.p_icurval(l_kv,t_c67.s,t_c67.bdat) end/100;
       --l_fio := f_dop(t_c67.ref,'FIO  ');
       --CONTINUE WHEN l_sq <150000;
       --CONTINUE WHEN t_c67.mfoa!=t_c67.mfob;
      -- CONTINUE WHEN l_fio is null and  t_c67.nlsb like '2902%';
       
       UTL_FILE.PUT_LINE(f, 
                   to_char(t_c67.bdat,'dd.MM.yyyy')|| l_chr ||
                   substr(t_c67.nlsa,1,4)          || l_chr ||
                   substr(t_c67.nlsb,1,4)          || l_chr ||                   
                   TO_CHAR(t_c67.s/100, 'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   TO_CHAR(l_sq,'FM999999999999999999999999999990D00','NLS_NUMERIC_CHARACTERS = '',.''') || l_chr ||
                   to_char(t_c67.kva) || l_chr ||
                   to_char(t_c67.nlsa)|| l_chr ||
                   to_char(t_c67.nama)|| l_chr ||
                   to_char(t_c67.kvb) || l_chr ||
                   to_char(t_c67.nlsb)|| l_chr ||
                   to_char(t_c67.namb)|| l_chr ||
                   f_escaped(t_c67.nazn,l_chr)|| l_chr ||  
                   l_fio
                   
              );
    end loop; 
     UTL_FILE.FCLOSE(f);    
  close c67; 
  
end;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pg_cur.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 