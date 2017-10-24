

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC_BLOB_RNK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC_BLOB_RNK ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC_BLOB_RNK (p_rnk customer.rnk%type,
                                            p_nbs varchar2,
                                            p_dat1 date,
                                            p_dat2 date,
                                            p_kv   varchar2,
                                            p_filemask out varchar2,
                                            p_blob out blob
                                           )
as
l_sql varchar2(2000);
l_blob blob;
l_txt varchar2(32000);
l_chr varchar2(2) := chr(13)||chr(10);
l_mfo varchar2(6) := f_ourmfo; 
l_dos number;   l_dosq number;
l_kos number;   l_kosq number;
l_ost number;   l_ostq number;
l_ost_t varchar2(3);
l_kv  pls_integer;
l_ number;
l_nazn varchar2(200);
 -- маска формата для преобразования char <--> number
  g_number_format constant varchar2(128) := 'FM999999999999999999999999999990.00';
  -- параметры преобразования char <--> number
  g_number_nlsparam constant varchar2(30) := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  -- маска формата для преобразования char <--> date
  g_date_format constant varchar2(30) := 'YYYY.MM.DD HH24:MI:SS';

begin

 bars_audit.info ('p_lic_blob_rnk    p_rnk='||p_rnk||l_chr||'p_nbs='||p_nbs||l_chr||'p_dat1='||to_char(p_dat1,'dd/mm/yyyy')||'p_dat2='||to_char(p_dat2,'dd/mm/yyyy')||l_chr||'p_kv='||p_kv);
  
 SELECT 'LS'||case when p_kv = 980 then '^' when p_kv = '-980' then '$' else '_' end||substr(sab ,1,3)||BARS_REPORT.FRMT_DATE(p_dat2,'MD')||'.'||substr(to_char(sysdate,'HH24MI'),2,3)
   into  p_filemask 
   FROM  customer
  where  rnk = p_rnk;


  
execute immediate 'truncate table tmp_lic';
execute immediate 'truncate table tmp_licM';

 
 


  l_sql :='
     insert into  tmp_lic (acc, nls, kv, nms)
     select acc, nls, kv, nms
       from accounts a
      where nbs is not null
        and rnk = '||p_rnk||'
        
        and (dazs is null or dazs >= to_date('''||to_char(p_dat1,'dd-mm-yyyy')||''',''dd-mm-yyyy''))
        and nbs not in (''3901'')';

--and nbs like '''||p_nbs||'''

         if  p_kv = '%' or p_kv = '0' then null;
      elsif  length(p_kv) >0 and instr(p_kv,'-') = 1 
                         then l_sql := l_sql||' and a.kv not in (select to_char(trim(abs(column_value))) fon from table(gettokens('''||p_kv||''')))'; 
      elsif  length(p_kv) >0 and instr(p_kv,',') = 0  
                         then l_sql := l_sql||' and a.kv = ''' ||p_kv ||''' '; 
      else                    l_sql := l_sql||' and a.kv in (select to_char(trim(column_value)) fon from table(gettokens('''||p_kv||''')))';    
      end if;
      
      if  p_nbs = '%' or p_nbs = '0' then null;
      elsif  length(p_nbs) >0 and instr(p_nbs,'-') = 1 
                         then l_sql := l_sql||' and a.nbs not in (select to_char(trim(abs(column_value))) fon from table(gettokens('''||p_nbs||''')))'; 
      elsif  length(p_nbs) >0 and instr(p_nbs,',') = 0  
                         then l_sql := l_sql||' and a.nbs like ''' ||p_nbs ||''' '; 
      else                    l_sql := l_sql||' and a.nbs in (select to_char(trim(column_value)) fon from table(gettokens('''||p_nbs||''')))';    
      end if;

execute immediate  l_sql;


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

     BARS_RPTLIC.LIC_SQLDYN(P_DATE1   =>p_dat1,
                            P_DATE2   =>p_dat2,
                            P_INFORM  =>0,
                            P_KV      =>0,
                            P_MLTVAL  =>2,
                            P_VALEQV  =>1,
                            P_VALREV  =>1,
                            P_SQLID   =>4);

   dbms_lob.createtemporary(l_blob,  true);
   l_txt := '                        Виписка з    '||to_char( p_dat1,'dd/mm/yyyy') ||' по   '||to_char( p_dat2,'dd/mm/yyyy')||l_chr;
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
   l_txt := '   --------------------------------------------------------------------------------------------'||l_chr;
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
   l_txt := '                                       Надруковано  '||to_char(sysdate,'dd/mm/yyyy  hh24:mi:ss')||l_chr;
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
   
   
   for x in (
   select acc, fdat, nms, nmk,nls,kv from tmp_licm  --where  (acc, fdat) in (select acc,fdat from tmp_licm where rowtype = BARS_RPTLIC.G_ROWTYPE_DOC)
    group by acc,fdat,substr(nls,1,4), nls, kv, nms, nmk order by substr(nls,1,4), nls, kv
            )
 LOOP
    l_dos := 0; l_kos := 0; l_dosq := 0; l_kosq := 0;
    ----  Zaujkjdjr
    l_txt := '  '||rpad(l_mfo,18,' ')||'АТ "ОЩАДБАНК'||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    
    --select '  '||rpad(rnk,14,' ')||'    '||nmk||l_chr into l_txt from customer where rnk = p_rnk;
    l_txt := '  '||rpad(p_rnk,14,' ')||'    '||x.nmk||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
   -- select '  '||rpad(nls,14,' ')|| lpad(kv,3,' ')||' '||nms||l_chr into l_txt from accounts where acc = x.acc;
    l_txt :='  '||rpad(x.nls,14,' ')|| lpad(x.kv,3,' ')||' '||x.nms||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt||l_chr));    
    
    
    for h  in (select * from tmp_licm where acc = x.acc and fdat = x.fdat and rowtype = BARS_RPTLIC.G_ROWTYPE_ACC )
    loop
    case when h.ostf< 0  
      then l_ost := -h.ostf; l_ost_t := 'ДТ:';
      else l_ost :=  h.ostf; l_ost_t := 'КТ:';
    End case;
    
    l_kv := iif(h.kv,GL.BASEVAL,1,0,1);
    
    if l_kv = 1 then
    select lpad(' ',30,' ')||'Курс:'|| nominal||' '||lcv||' = '||to_char( gl.p_icurval(kv, nominal*10000,gl.bd)/10000,'FM9999999999990.0000',g_number_nlsparam)||l_chr into l_txt from tabval where kv = h.kv;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    end if;
    
    
    case when l_kv = 0 then
    l_txt := '  '||to_char(h.fdat,'dd/mm/yyyy')||',    '||to_char(h.dapp,'dd/mm/yyyy')||'                           Вхiдний залишок '||l_ost_t||lpad(to_char(l_ost/100, g_number_format,g_number_nlsparam),24,' ')||l_chr;
         else
    l_txt := '  '||to_char(h.fdat,'dd/mm/yyyy')||',    '||to_char(h.dapp,'dd/mm/yyyy')||'       Вхiдний залишок '||l_ost_t||lpad(to_char(l_ost/100, g_number_format,g_number_nlsparam)||' ('||to_char(abs(h.ostfq)/100, g_number_format,g_number_nlsparam),40,' ')||')'||l_chr;     
    end case;                               
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    l_txt := '  '||lpad('-',95,'-')||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    l_txt := '  '||'   Референс   N Док      СКП    МФО    Контр-рах                   Сума  Дб      Сума   Кр'||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    l_txt := '  '||lpad('-',95,'-')||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    end loop;
    
    ---- dokument
    for d  in (select * from tmp_licm where acc = x.acc and fdat = x.fdat and rowtype = BARS_RPTLIC.G_ROWTYPE_DOC order by dk, s )
    loop
    l_txt := '  '||rpad(d.ref,14,' ')||lpad(d.nd,14,' ')||lpad(nvl(to_char(d.sk),' '),3,' ')||lpad(d.mfo2,7,' ')||lpad(d.nls2,16,' ')||lpad(case when d.dk = 0 then to_char(-d.s/100, g_number_format,g_number_nlsparam) else ' ' end,20,' ')||lpad(case when d.dk = 1 then to_char(d.s/100, g_number_format,g_number_nlsparam) else ' ' end,20,' ')||' '||rpad(d.nb2,30,' ')||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    case when l_kv = 0 then
    l_txt := '    '||d.tt||lpad(' ',90,' ')||substr(d.nazn,1,30)||l_chr;
    else 
    l_txt := '    '||d.tt||lpad(' ',49,' ')||lpad(case when d.dk = 0 then to_char(-d.sq/100, g_number_format,g_number_nlsparam) else ' ' end,20,' ')||lpad(case when d.dk = 1 then to_char(d.sq/100, g_number_format,g_number_nlsparam) else ' ' end,20,' ')||' '||substr(d.nazn,1,30)||l_chr;
    end case;
    
    l_nazn := substr(d.nazn,31);
    l_ := length(l_nazn);
     
    
    WHILE l_ > 0  LOOP
    l_txt := l_txt||'       '||lpad(' ',90,' ')||trim(substr(l_nazn,1,30))||l_chr;
    l_ := l_-30;
    l_nazn := substr(l_nazn,31);
    end loop; 
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    
    
    
    l_txt := l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    
     if d.dk = 0 
      then  l_dos := l_dos + -d.s; l_dosq := l_dosq + -d.sq;
     elsif d.dk = 1
      then  l_kos := l_kos + d.s;  l_kosq := l_kosq + d.sq;
     end if;
    
    end loop;
     
    -- Itog
 
     for i  in (select * from tmp_licm where acc = x.acc and fdat = x.fdat and rowtype = BARS_RPTLIC.G_ROWTYPE_ACC )
    loop
    case when i.ostf-l_dos+l_kos< 0  
      then l_ost := -(i.ostf-l_dos+l_kos); l_ostq := -(i.ostfq-l_dosq+l_kosq);     l_ost_t := 'ДТ:';
      else l_ost :=   i.ostf-l_dos+l_kos;  l_ostq :=   i.ostfq-l_dosq+l_kosq;      l_ost_t := 'КТ:';
    End case;
    
    l_txt := '  '||lpad('-',95,'-')||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
   
    
     l_txt := '  '||lpad(' ',40,' ')||'Всього оборотiв'||lpad(to_char(l_dos/100, g_number_format,g_number_nlsparam),17,' ')||'-Дб'||lpad(to_char(l_kos/100, g_number_format,g_number_nlsparam),17,' ')||'-Кр'||l_chr;
     dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
     
    case when l_kv = 0 then
      null;
         else
     l_txt := '  '||lpad(' ',40,' ')||'         (екв) '||lpad(to_char(l_dosq/100, g_number_format,g_number_nlsparam),17,' ')||'   '||lpad(to_char(l_kosq/100, g_number_format,g_number_nlsparam),17,' ')||'   '||l_chr;  
     dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));  
    end case;
 
  
     case when l_kv = 0 
          then
     l_txt := '  '||lpad(' ',40,' ')||'Вихiдний залишок '||l_ost_t||lpad(to_char((l_ost)/100, g_number_format,g_number_nlsparam),35,' ')||l_chr;
          else 
     l_txt := '  '||lpad(' ',40,' ')||'Вихiдний залишок '||l_ost_t||lpad(to_char((l_ost)/100, g_number_format,g_number_nlsparam)||' ('||to_char((l_ostq)/100, g_number_format,g_number_nlsparam)||')',35,' ')||l_chr;
     end case;
     dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
 
     l_txt := lpad('-',125,'-')||l_chr||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
 
 
   end loop;
 
  
 end LOOP;

 p_blob := l_blob;
dbms_lob.freetemporary(l_blob);
end;
/
show err;

PROMPT *** Create  grants  P_LIC_BLOB_RNK ***
grant EXECUTE                                                                on P_LIC_BLOB_RNK  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC_BLOB_RNK.sql =========*** En
PROMPT ===================================================================================== 
