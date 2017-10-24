
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

    delete from kl_f00$LOCAL where kodf=kodf_;    
    delete from kl_f00$GLOBAL where kodf=kodf_;

    BEGIN
       select path_o 
           into path_o_ 
       from kl_f00$local 
       where kodf='02' and a017 in ('C','G','D') and policy_group='FILIAL';
    EXCEPTION WHEN NO_DATA_FOUND THEN
       path_o_ := null;
    END;

    select count(*) 
     into kol_ 
    from kl_f00$GLOBAL 
    where kodf='02' and a017 in ('C','G','D');

    if kol_ = 0 then
       kodf1_ := '08';
       select count(*) 
          into kol_ 
       from kl_f00$GLOBAL 
       where kodf=kodf1_ and a017 in ('C','G','D');
    end if;

    BEGIN
       select branch, uuu, path_o, zzz 
          into branch_, uuu_, path_o_, zzz_  
       from kl_f00$local
       where kodf=kodf1_ and a017 in ('C','G','D') and policy_group='FILIAL';
    EXCEPTION WHEN NO_DATA_FOUND THEN 
       tuda;
       branch_ := '/' || F_GET_PARAMS('MFO') || '/';
       uuu_    := F_GET_PARAMS('DPA_SAB');
       path_o_ := 'C:\BANK';
       zzz_ := F_GET_PARAMS('MFO');
       suda; 
    END;

    suda;

    if kol_ <> 0 then
       for k in
       (select aa, a017, pr_tobo from kl_f00$GLOBAL 
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

     Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, 
                                    PROCC, R, SEMANTIC, KODF_EXT, F_PREF, PR_TOBO)
     Values
                                   ('2K', '09', 'C', '21', 'M', 
                                    to_char(id_), '1', 'Дані про банківські рахунки та залишки коштів на них ФО та ЮО(санкції)', NULL, NULL, k.pr_tobo);

     Insert into KL_F00$LOCAL (POLICY_GROUP, BRANCH, KODF, A017, UUU, 
                                   ZZZ, PATH_O, DATF, NOM)
     Values
                                  ('FILIAL', branch_, kodf_, 'C', uuu_, 
                                   zzz_, path_o_, TO_DATE('30/06/2017','DD/MM/YYYY'), '1');

     Insert into KL_F00$LOCAL (POLICY_GROUP, BRANCH, KODF, A017, UUU, 
                                   ZZZ, PATH_O, DATF, NOM)
     Values
                                  ('WHOLE', '/', kodf_, 'C', uuu_, 
                                  zzz_, path_o_, TO_DATE('30/06/2017', 'DD/MM/YYYY'), '1');


       end loop;
    end if;

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
 
end;
/

