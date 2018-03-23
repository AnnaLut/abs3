DECLARE
   l_id   BARS.PAYTT_NO.id%TYPE;
BEGIN
   SELECT MAX (id) + 1 INTO l_id FROM PAYTT_NO;
merge into BARS.PAYTT_NO p
    using (
select name, nbsd, nbsk, id
  from (select rownum seq, t.*
          from (SELECT 'Заборона зарахувань з 2600' NAME,
                       '2600' NBSD,
                       '2630' NBSK
                  FROM DUAL
                UNION ALL
                SELECT 'Заборона зарахувань з 2600' NAME,
                       '2600' NBSD,
                       '2635' NBSK
                  FROM DUAL
                UNION ALL
                SELECT 'Заборона зарахувань з 2605' NAME,
                       '2605' NBSD,
                       '2630' NBSK
                  FROM DUAL
                UNION ALL
                SELECT 'Заборона зарахувань з 2605' NAME,
                       '2605' NBSD,
                       '2635' NBSK
                  FROM DUAL
                UNION ALL
                SELECT 'Заборона зарахувань з 2650' NAME,
                       '2650' NBSD,
                       '2630' NBSK
                  FROM DUAL
                UNION ALL
                SELECT 'Заборона зарахувань з 2650' NAME,
                       '2650' NBSD,
                       '2635' NBSK
                  FROM DUAL
                UNION ALL
                SELECT 'Заборона зарахувань з 25' NAME,
                       '25' NBSD,
                       '2630' NBSK
                  FROM DUAL
                UNION ALL
                SELECT 'Заборона зарахувань з 25' NAME,
                       '25' NBSD,
                       '2635' NBSK
                  FROM DUAL) t) tt
  join (select rownum seq, level id from dual
         where level >= l_id
         connect by level <= l_id+10) t2
    on tt.seq = t2.seq) d
    on (trim(p.NAME) = trim(d.NAME) and trim(p.NBSD) = trim(d.NBSD) and  trim(p.nbsk) = trim(d.nbsk))
    when not matched then
        insert (p.id, p.NAME, p.NBSD, p.nbsk) values (d.id, d.NAME, d.NBSD, d.nbsk) ;

commit;
end;       
/
