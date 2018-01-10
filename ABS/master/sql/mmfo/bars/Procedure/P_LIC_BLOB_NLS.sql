CREATE OR REPLACE procedure BARS.p_lic_blob_nls (p_rnk customer.rnk%type,
                                                 p_nls varchar2,
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
l_ost_t varchar2(6);
l_kv  pls_integer;
l_ number;
l_nazn varchar2(200);
l_nlsalt varchar2(15);
 -- ����� ������� ��� �������������� char <--> number
  g_number_format constant varchar2(128) := 'FM999999999999999999999999999990.00';
  -- ��������� �������������� char <--> number
  g_number_nlsparam constant varchar2(30) := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  -- ����� ������� ��� �������������� char <--> date
  g_date_format constant varchar2(30) := 'YYYY.MM.DD HH24:MI:SS';

begin

 bars_audit.info ('p_lic_blob_rnk    p_rnk='||p_rnk||l_chr||'p_nls='||p_nls||l_chr||'p_dat1='||to_char(p_dat1,'dd/mm/yyyy')||'p_dat2='||to_char(p_dat2,'dd/mm/yyyy')||l_chr||'p_kv='||p_kv);
  -- 'VPGRN'||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||'.'||:NLS
 SELECT 'VP'|| case when p_kv = 980 then'GRN' else 'VAL' end||'_'||BARS_REPORT.FRMT_DATE(p_dat1,'DDMM')||'_'||p_kv||'_'||p_nls||'.txt'
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
        and nls = '''||p_nls||'''
        and kv  =  '''||p_kv||'''
        and (dazs is null or dazs >= to_date('''||to_char(p_dat1,'dd-mm-yyyy')||''',''dd-mm-yyyy''))
        ';

execute immediate  l_sql;

    --  LIC_DYNSQL
    --
    --   ������������ ������� �� ������������� ������� �� ����������� REPVP_DYNSQL
    --
    --   p_date1   -  ���� �
    --   p_date2   -  ���� ��
    --   p_inform  -  �������������� ��������� (=1 - �������, =0 - �� �������)
    --   p_kv      -  (0-���)
    --   p_mltval  -  �������� (���� =2, �������� ����� � ������ � �������)
    --   p_valeqv  -  � �������������
    --   p_valrev  -  � ����������� (revaluation)
    --   p_sqlid   -  � �������. �������    �� ����������� REPVP_DYNSQL

     BARS_RPTLIC.LIC_SQLDYN(P_DATE1   =>p_dat1,
                            P_DATE2   =>p_dat2,
                            P_INFORM  =>0,
                            P_KV      =>0,
                            P_MLTVAL  =>2,
                            P_VALEQV  =>1,
                            P_VALREV  =>1,
                            P_SQLID   =>3);

   dbms_lob.createtemporary(l_blob,  true);
   l_txt := '������� �� �������� ��������� :      '||'�����������  '||to_char(sysdate,'dd/mm/yyyy  hh24:mi:ss')||l_chr;               
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
     
   l_txt := lpad('-',125,'-')||l_chr;
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
      
   l_txt := '                            ������� �� �����: '||to_char( p_dat1,'dd/mm/yyyy') ||' - '||to_char( p_dat2,'dd/mm/yyyy')||l_chr||l_chr;
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
        
   l_txt := '�� "�������� '||l_mfo||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    
   select '        '||rpad(rnk,14,' ')||'    '||nmk||l_chr into l_txt from customer where rnk = p_rnk;
   l_txt :='�볺��: '||l_txt;
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
      
   l_txt := lpad('-',125,'-')||l_chr;
   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    
      
   for x in (
   select acc, min(fdat)mfdat, max(fdat)maxfdat, nms, nmk,nls,kv from tmp_licm  --where  (acc, fdat) in (select acc,fdat from tmp_licm where rowtype = BARS_RPTLIC.G_ROWTYPE_DOC)
    group by acc,substr(nls,1,4), nls, kv, nms, nmk order by substr(nls,1,4), nls, kv
            )
 LOOP
     
    l_dos := 0; l_kos := 0; l_dosq := 0; l_kosq := 0;
    ----  Zaujkjdjr
    /*l_txt := '  '||rpad(l_mfo,18,' ')||'�� "��������'||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    */
    /*--select '  '||rpad(rnk,14,' ')||'    '||nmk||l_chr into l_txt from customer where rnk = p_rnk;
    l_txt := '  '||rpad(p_rnk,14,' ')||'    '||x.nmk||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    */
    -- select '  '||rpad(nls,14,' ')|| lpad(kv,3,' ')||' '||nms||l_chr into l_txt from accounts where acc = x.acc;
     select nlsalt into l_nlsalt from accounts where acc = x.acc;
    l_txt :='�������: '||rpad(x.nls,14,' ')||' ('||rpad(l_nlsalt,14,' ')||') '||'('||lpad(x.kv,3,' ')||') '||x.nms||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));    
    
        
    --���� �������    
    FOR h  IN (SELECT * FROM tmp_licm WHERE acc = x.acc AND fdat = x.mfdat AND ROWTYPE = BARS_RPTLIC.G_ROWTYPE_ACC)
        LOOP
            CASE WHEN h.ostf < 0
                THEN l_ost := -h.ostf; l_ost_t := ' ��:';
                    l_ostq := -h.ostfq;
                ELSE l_ost :=  h.ostf; l_ost_t := ' ��:';
                    l_ostq := h.ostfq;
            END CASE;
            
            IF l_ost=0 THEN
               l_ost_t := ' ';
            END IF;
            
            l_kv := iif(h.kv,GL.BASEVAL,1,0,1);

            IF l_kv = 1 THEN
                SELECT    LPAD (' ', 30, ' ')
                   || '����:'
                   || nominal
                   || ' '
                   || lcv
                   || ' = '
                   || TO_CHAR (gl.p_icurval (kv, nominal * 10000, gl.bd) / 10000,
                               'FM9999999999990.0000',
                               g_number_nlsparam)
                   || l_chr
                INTO l_txt
                FROM tabval
                WHERE kv = h.kv;
                DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            END IF;

            l_txt := '��������� ���� ����: '||to_char(h.dapp,'dd/mm/yyyy');
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt||l_chr));

            CASE WHEN l_kv = 0 THEN                    
                    l_txt := '��i���� ������� �� : '||to_char(h.fdat,'dd/mm/yyyy')||' '||to_char(l_ost/100, g_number_format,g_number_nlsparam)||l_ost_t||l_chr;
                 ELSE
                    l_txt := '��i���� ������� �� : '||to_char(h.fdat,'dd/mm/yyyy')||l_ost_t||lpad(to_char(l_ost/100, g_number_format,g_number_nlsparam)||' (���. '||to_char(abs(h.ostfq)/100, g_number_format,g_number_nlsparam),40,' ')||')'||l_chr;
            END CASE;
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));

            l_txt := lpad('-',125,'-')||l_chr;
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));

            l_txt := ': ��� :    �������    :  � ���-��  :    �����    :     ������   :  ���� ���������� :   ��i���� ������� :   ���i���� ������� :'||l_chr;
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            
            l_txt := lpad('-',125,'-')||l_chr;
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            
        END LOOP;
            
        --dokument
        FOR d  IN (--SELECT * FROM tmp_licm WHERE acc = x.acc AND fdat = x.fdat AND ROWTYPE = BARS_RPTLIC.G_ROWTYPE_DOC ORDER BY dk, s )
                SELECT /*a.tt, a.mfo2, a.nls2, a.nd, a.datp, fdat,ostf,s,dk,*/
                a.*, a.ostf+sum(a.s) over(partition by a.acc, a.fdat order by a.acc,a.fdat)  ostc, a.ostfq+sum(a.sq) over(partition by a.acc, a.fdat order by a.acc,a.fdat) ostcq  
                FROM tmp_licm a 
                --WHERE  ROWTYPE = 20
                WHERE acc = x.acc /*AND fdat = x.fdat*/ AND ROWTYPE = BARS_RPTLIC.G_ROWTYPE_DOC 
                ORDER BY fdat        
        )
        LOOP
            l_txt := lpad(d.mfo2,7,' ')--mfo
                   ||lpad(d.nls2,15,' ')--account
                   /*||rpad(d.ref,14,' ')*/ --ref
                   ||lpad(d.nd,12,' ')-- num doc                   
                   ||lpad(case when d.dk = 0 then to_char(-d.s/100, g_number_format,g_number_nlsparam) else '0.00' end,15,' ') --�����
                   ||lpad(case when d.dk = 1 then to_char(d.s/100, g_number_format,g_number_nlsparam) else '0.00' end,15,' ') --����� 
                   ||lpad(to_char(d.fdat,'dd/mm/yyyy'),12,' ') --���� ��������
                   ||lpad('->'||d.okpo2, 11,' ') --����
                   ||lpad(to_char(d.ostf/100 , g_number_format,g_number_nlsparam),16,' ') --��. �������
                   ||lpad(to_char(d.ostc/100, g_number_format,g_number_nlsparam),19,' ') --���. �������
                   --||rpad(d.nb2,30,' ')--���� �����
                   ||l_chr;
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            
            --l_txt := lpad(d.nmk2,90,' ')||l_chr||lpad(d.nb2,90,' ')||l_chr;
            --DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            l_txt := '       '||lpad(' ',90,' ')||substr(d.nmk2,1,30)||l_chr;
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            l_txt := '       '||lpad(' ',90,' ')||substr(d.nb2,1,30)||l_chr;
            DBMS_LOB.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            
            CASE WHEN l_kv = 0 THEN
                l_txt := '       '||lpad(' ',90,' ')||substr(d.nazn,1,30)||l_chr;
            ELSE
                l_txt := lpad('(���)',34,' ')||lpad(case when d.dk = 0 then to_char(-d.sq/100, g_number_format,g_number_nlsparam) else '0.00' end,15,' ')||lpad(case when d.dk = 1 then to_char(d.sq/100, g_number_format,g_number_nlsparam) else '0.00' end,15,' ')||'                                 '||substr(d.nazn,1,30)||l_chr;
            END CASE;

            l_nazn := substr(d.nazn,31);
            L_ := length(l_nazn);
     
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
     l_txt := lpad('-',125,'-')||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
   
    
     l_txt := '������i� �� �����:'||lpad(to_char(l_dos/100, g_number_format,g_number_nlsparam),30,' ')||lpad(to_char(l_kos/100, g_number_format,g_number_nlsparam),15,' ')||l_chr;
     dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
     
    case when l_kv = 0 then
      null;
         else
     l_txt := lpad(' ',14,' ')||'(���)'||lpad(to_char(l_dosq/100, g_number_format,g_number_nlsparam),30,' ')||lpad(to_char(l_kosq/100, g_number_format,g_number_nlsparam),15,' ')||l_chr;  
     dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));  
    end case;
    

    begin    
        SELECT ostf + ss
          INTO l_ost
          FROM (SELECT DISTINCT ostf
                  FROM tmp_licm
                 WHERE ROWTYPE = 20 AND fdat = (SELECT MAX (fdat) FROM tmp_licm WHERE ROWTYPE = 20)),
               (SELECT SUM (s) ss
                  FROM tmp_licm
                 WHERE ROWTYPE = 20 AND fdat = (SELECT MAX (fdat) FROM tmp_licm WHERE ROWTYPE = 20));
      exception when no_data_found then
          l_ost := fost(x.acc,x.maxfdat);-- l_ost := 0;
    end;
    
    IF l_ost=0 THEN
       l_ost_t := ' ';
    ELSE
        case when l_ost > 0  
            then l_ost_t := ' ��:';
            else l_ost_t := ' ��:';
        End case;
    END IF;
            
    case when l_kv = 0 
          then
     l_txt := '���i���� ������� ��: '||to_char(x.maxfdat,'dd/mm/yyyy')||'  '||to_char(l_ost/100, g_number_format,g_number_nlsparam)||l_ost_t||l_chr;
          else 
     l_ostq := fostq(x.acc,x.maxfdat);
     l_txt := '���i���� ������� ��: '||to_char(x.maxfdat,'dd/mm/yyyy')||'  '||to_char(l_ost/100, g_number_format,g_number_nlsparam)||' (���. '||to_char(l_ostq/100, g_number_format,g_number_nlsparam)||')'||l_ost_t||l_chr;
     end case;
     dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
 
     l_txt := lpad('-',125,'-')||l_chr||l_chr;
    dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
    
 end LOOP;

 p_blob := l_blob;
dbms_lob.freetemporary(l_blob);
end;
/
