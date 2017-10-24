exec bc.home;

Prompt CREATE FILE #2K
--- Действия необходимые для формирования файла #2K
--====================================================================
-- Module : Отчетность КБ 
-- Author : Овчарук
-- Date   : 09.06.2017
--====================================================================
-- Новый отчетный файл 2K - процедуры и структура показателя
--====================================================================
declare
   id_     number;
   kol_    number;
   kodf_   varchar2(2):='2K';
   kodf1_  varchar2(2):='02';
   branch_ varchar2(30);
   uuu_    varchar2(3); 
   path_o_ varchar2(35);
   zzz_    varchar2(20);

begin
---  #2K файл
    delete from kl_f00$GLOBAL where kodf=kodf_;

    select count(*) 
     into kol_ 
    from kl_f00$GLOBAL 
    where kodf='02' and a017 in ('C','G','D');

    if kol_ <> 0 then
       for k in (select aa, a017, pr_tobo 
                 from kl_f00$GLOBAL 
                 where kodf=kodf1_ and a017 in ('C','G','D'))
       loop

          begin
             select procc
              into id_
             from rep_proc
             where name = 'P_F'||kodf_||'_n'||lower(k.a017); 
          exception when no_data_found then
             select max(to_number(PROCC)) + 1 
             into id_ 
             from rep_proc;

             insert into rep_proc
             values (to_char(id_),'P_F'||kodf_||'_n'||lower(k.a017), 
                     'Дані про банківські рахунки та залишки коштів на них ФО та ЮО(санкції)');
          end;

         Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, PROCC, R, SEMANTIC, KODF_EXT, F_PREF, PR_TOBO)
         Values('2K', '09', 'C', '21', 'M', to_char(id_), '1', 'Дані про банківські рахунки та залишки коштів на них ФО та ЮО(санкції)', 
                NULL, NULL, k.pr_tobo);
       end loop;
    end if;

    commit;
exception
    when others then
        if sqlcode = -2292 then
            null;
        else 
            raise;
        end if; 
end;
/

declare
   kodf_   varchar2(2):='2K';
begin
---  #2K файл
    for f in (select kf from mv_kf)
    loop
        bc.subst_mfo(f.kf);
        
        delete from kl_f00$LOCAL where kodf=kodf_;  
        
        insert into kl_f00$LOCAL(POLICY_GROUP, BRANCH, KODF, A017, UUU, ZZZ, PATH_O, DATF, NOM, KF) 
        select POLICY_GROUP, branch, kodf_, a017, uuu, zzz, path_o, TO_DATE('30/06/2017','DD/MM/YYYY'), '1', kf
        from kl_f00$LOCAL
        where kodf='02' and a017 in ('C','G','D');

        commit;
    end loop;
end;
/

exec bc.home;

-- добавляем описание показателя
DELETE FROM FORM_STRU WHERE KODF='2K' ;

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'2K', 1, 'Код ~"DDD"', 'substr(kodp,1,3)', '1', 4, 'C'); 
INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'2K', 2, 'Код "ZZZZZZZZZZ"', 'substr(kodp,4,10)', '1', 1, 'C'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'2K', 3, 'Ознака~ідентифікаційного коду', 'substr(kodp,14,1)', '1', 2, 'C'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'2K', 4, 'Умовний порядковий~номер рядку', 'substr(kodp,15,4)', '1', 3, 'C'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'2K', 5, 'Значення~показника', 'znap', '0', NULL, 'C'); 

commit;

DECLARE 
  P_FILE_ID NUMBER;
  P_PROC_ID NUMBER;
BEGIN 
  bc.home;
  
  NBUR_FILES.SET_FILE (P_FILE_ID, '#2K', 'C', '1', 'Дані про банківські рахунки та залишки коштів на них ФО та ЮО(санкції)', 'TXT', 
    '03', '21', 'M', '1', NULL, 0, 'C', 'V_NBUR_#2K', 1);
    
  for k in (select m.kf, l.file_path, l.nbuc, l.e_address 
            from MV_KF m, NBUR_REF_FILES_LOCAL l
            where m.kf = l.kf and
                L.FILE_ID = 14850)
  loop 
     NBUR_FILES.SET_FILE_LOCAL ( k.kf, P_FILE_ID, k.file_path, k.nbuc, k.e_address);
  end loop;
  
  bc.home;
  
  NBUR_FILES.SET_FILE_PROC (P_PROC_ID, P_FILE_ID, 'O', 'Y', 'BARS',  'NBUR_P_F2K_NC', 
        '#2K схема С мiсячний', 'P_F2K v.16.001', TO_DATE('05/01/2015', 'MM/DD/YYYY'), NULL); 
        
  NBUR_FILES.SET_FILE_STC (P_FILE_ID, 1, 'Код~DDD', 'substr(kodp,1,3)', '1', 4);
  NBUR_FILES.SET_FILE_STC (P_FILE_ID, 2, 'Код~ZZZZZZZZZZ', 'substr(kodp,4,10)', '1', 1);
  NBUR_FILES.SET_FILE_STC (P_FILE_ID, 3, 'Ознака~ідент-го коду', 'substr(kodp,14,1)','1', 2);
  NBUR_FILES.SET_FILE_STC (P_FILE_ID, 4, 'Умовний порядковий~номер рядку', 'substr(kodp,15,4)', '1', 3);
  NBUR_FILES.SET_FILE_STC (P_FILE_ID, 5, 'Значення~показника', 'znap', '0', NULL);        
  
  NBUR_FILES.SET_FILE_VIEW(P_FILE_ID);
  COMMIT; 
END; 
/