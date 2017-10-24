 create or replace function f_rep_5009(p_fdat1  date
                                     ,p_fdat2  date
                                     ,p_nls varchar2
                                     ,p_kv   number)
                                     return blob
as
l_blob   blob;
l_txt    varchar2(32000);
l_separ  varchar2(1) := ';';
l_delim  varchar2(3) := ';'||chr(13);
PRAGMA AUTONOMOUS_TRANSACTION;
begin
    pul.put('file_mask',p_nls||'_'||p_kv);
    rptlic_nls(p_fdat1, p_fdat2 , p_nls, p_kv );
        
 
 dbms_lob.createtemporary(l_blob,  FALSE);

 for x in (
                SELECT 
                f_escaped (c.nmk,';') nmk , -- Найменування власника рахунку
                c.okpo , -- Ідентифікаційний номер/код власника рахунку 
                --
                v.mfo , -- Код банку власника рахунку
                f_escaped (v.nb,';') Nb, -- Банк власника рахунку
                v.nls , -- Номер рахунку
                to_char(v.kv) kv , -- Валюта рахунку
                (select value from operw where ref = v.ref and tag = 'OW_LD') datpk, 
                 fdat, --Дата операції за рахунком
                case v.dk when 0 then to_char(s*100) when 1 then to_char(s*100) else null end s, --Сума операції 
                case v.dk when 0 then to_char(sq*100) when 1 then to_char(sq*100) else null end sq, --Сума операції (UAH)
                 to_char(v.kv) kv_trans,--Валюта операції
                case v.dk when 0 then 'Дт' when 1 then 'Кт' else null end dk, --Списання (Дт) / зарахування (Кт)
                 (select 'NNNN **** **** NNNN' from dual where v.tt like'OW_') N_PK ,-- Номер ПК
                (select max(case when tag = 'W4_ELN' then value else null end)||' '||max(case when tag = 'W4_EFN' then value else null end) from accountsw where acc = 2187357 and v.tt like'OW_') nmkpk,
                 (select c.okpo from dual where v.tt like'OW_') okpo_PK ,-- Номер ПК--Ідентифікаційний номер/код держателя ПК*
                f_escaped (nazn,';') nazn, --Призначення платежу
                to_char(v.ostf*100) ostf, -- Вхідний залишок
                to_char((v.ostf- sum(v.doss*-1) over (partition by v.nls,v.kv, fdat order by v.nls,v.kv, v.fdat) + 
                 sum(v.koss) over (partition by v.nls,v.kv, v.fdat order by v.nls,v.kv, v.fdat))*100) ostc,-- Вихідний залишок
                to_char(GL.P_ICURVAL(v.kv,v.ostf*100,v.datd)) ostfq,-- Вхідний залишок (UAH)
                 to_char(GL.P_ICURVAL(v.kv,(v.ostf-sum(v.doss*-1) over (partition by v.nls,v.kv, v.fdat order by v.nls,v.kv, v.fdat)+ 
                 sum(v.koss) over (partition by v.nls,v.kv, v.fdat order by v.nls,v.kv, v.fdat))*100,v.datd)) ostcq,-- Вихідний залишок (UAH)
                 to_char(v.paydate, 'HH24:MI:SS') paytime-- Час здійснення операції
                FROM v_rptlic2 v, accounts a, customer c
                 WHERE NVL(ref, 0) = DECODE('0','0',ref,NVL(ref, 0))
                 AND bis = 0 
                 AND srt < 3
                 and a.acc = v.acc
                 and a.rnk = c.rnk
                 ORDER BY v.nls, to_char(v.kv), v.fdat, srt, dksrt, vobsrt, paydate, ref, bis
           )
    LOOP
          l_txt:=x.NMK||l_separ||x.OKPO||l_separ||x.MFO||l_separ||x.NB||l_separ||x.NLS||l_separ||x.KV||l_separ||x.DATPK||l_separ||x.FDAT||l_separ||x.S||l_separ||x.SQ||l_separ||x.KV_TRANS||l_separ||x.DK||l_separ||x.N_PK||l_separ||x.NMKPK||l_separ||x.OKPO_PK||l_separ||x.NAZN||l_separ||x.OSTF||l_separ||x.OSTC||l_separ||x.OSTFQ||l_separ||x.OSTCQ||l_separ||x.PAYTIME||l_delim;
          dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));

    END LOOP;
  commit;
  if dbms_lob.getlength(l_blob) = 0 then   dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW('Відсутні дані.')); return l_blob;
                                    else   return l_blob; 
  end if;                 
   
end; 
/
