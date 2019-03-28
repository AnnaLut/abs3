CREATE OR REPLACE function BARS.f_nbur_check_for_42_cons(p_report_date in date, 
                                                    p_report_code in varchar2, 
                                                    p_kf in varchar2 default null
                                                    ) return boolean
is
  l_count       number := 0;
  l_f01_cnt     number := 0;
  l_fc5_cnt     number := 0;
  l_kf_gl       varchar2(6) := '300465';
  l_kodf        varchar2(2) := substr(p_report_code, 2, 2);
  
   PROCEDURE p_ins_log(p_mess VARCHAR2) IS
        pragma     AUTONOMOUS_TRANSACTION;
   BEGIN
       IF l_kodf IS NOT NULL AND p_mess IS NOT NULL THEN
          INSERT INTO OTCN_LOG (kodf, userid, txt)
          VALUES(l_kodf, user_id, p_mess);
          commit;
       END IF;
   END;
  
begin
  for k in (select kf from mv_kf where p_kf is null or kf = p_kf order by kf)
  loop
     bc.subst_mfo(k.kf);
     
     -- перевірка чи є дані з 01 файлу, що необхідні
     select count(*)
     into l_f01_cnt
     from NBUR_TMP_42_DATA
     where report_date = p_report_date and
        kf = k.kf;
        
     if l_f01_cnt = 0 then
        select count(*)
        into l_f01_cnt 
        from nbur_lst_files
        where report_date = p_report_date and
            kf = k.kf and
            file_name like '#01%' and
            file_status = 'FINISHED';
     end if;

     -- перевірка чи є дані з с5 файлу, що необхідні
     select count(*)
     into l_fc5_cnt
     from OTC_C5_PROC
     where datf = p_report_date and
        kf = k.kf;
        
     if l_fc5_cnt = 0 then
        select count(*)
        into l_fc5_cnt 
        from nbur_lst_files
        where report_date = p_report_date and
            kf = k.kf and
            file_name like '#C5%' and
            file_status = 'FINISHED';
            
     end if;   
     
     bc.subst_mfo(l_kf_gl);
     
     if l_f01_cnt = 0 then    
       p_ins_log ('Не сформовано файл #C5 по KF = '||k.kf||' за дату '||to_char(p_report_date, 'dd.mm.yyyy')||'!');
           
       l_count := l_count + 1;
     end if;    
            
     if l_f01_cnt = 0 then    
       p_ins_log ('Не сформовано файл #01 по KF = '||k.kf||' за дату '||to_char(p_report_date, 'dd.mm.yyyy')||'!');
           
       l_count := l_count + 1;
     end if;    
  end loop;

  return (l_count = 0);
exception
  when others then
    return false;
end f_nbur_check_for_42_cons;
/