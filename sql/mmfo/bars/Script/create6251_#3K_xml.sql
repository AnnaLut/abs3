exec bc.home;

Prompt     CREATE FILE #3K    for 3KX
-- Действия необходимые для формирования файла #3K
--    для подключения в NBUR xml-файла 3KX
declare
   id_     number;
   kol_    number;
   kodf_   varchar2(2)   := '3K';        --#3K  в  kl_f00
   kodf1_  varchar2(2)   := 'D3';        --#D3  в  kl_f00
   branch_ varchar2(30);
   uuu_    varchar2(3); 
   path_o_ varchar2(35);
   zzz_    varchar2(20);

begin
---  #3K файл
    delete from kl_f00$GLOBAL where kodf=kodf_;

    select count(*) 
     into kol_ 
    from kl_f00$GLOBAL 
    where kodf=kodf1_ and a017 in ('C','G','D');

    if kol_ <> 0 then

         Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, PROCC, R, SEMANTIC, KODF_EXT, F_PREF, PR_TOBO, TYPE_ZNAP)
             select  kodf_, AA, A017, '11', PERIOD, PROCC, R, 'xml 3K Дані про купівлю/продаж безготівкової іноземної валюти', KODF_EXT, F_PREF, PR_TOBO, TYPE_ZNAP
               from kl_f00$GLOBAL 
              where kodf=kodf1_ and a017 in ('C','G','D');

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
   kodf_   varchar2(2)   := '3K';
   kodf1_  varchar2(2)   := 'D3';        --#D3  в  kl_f00
begin
---  #3K файл
    for f in (select kf from mv_kf)
    loop
        bc.subst_mfo(f.kf);
        
        delete from kl_f00$LOCAL where kodf=kodf_;  
        
        insert into kl_f00$LOCAL(POLICY_GROUP, BRANCH, KODF, A017, UUU, ZZZ, PATH_O, DATF, NOM, KF) 
        select POLICY_GROUP, branch, kodf_, a017, uuu, zzz, path_o, TO_DATE('01/01/2018','DD/MM/YYYY'), '1', kf
        from kl_f00$LOCAL
        where kodf=kodf1_ and a017 in ('C','G','D');

        commit;
    end loop;
end;
/

exec bc.home;

DECLARE 
  P_FILE_ID NUMBER;
  P_PROC_ID NUMBER;
BEGIN 
  bc.home;
  
  NBUR_FILES.SET_FILE (P_FILE_ID, '#3K', 'C', '1', '(xml) Дані про купівлю/продаж безготівкової іноземної валюти',
         'XML', '03', '11', 'D', '1', '', 4, 'C', 'V_XML_3K', 0);
    
  for k in (select m.kf, l.file_path, l.nbuc, l.e_address 
              from MV_KF m, NBUR_REF_FILES_LOCAL l
             where m.kf = l.kf and
                   L.FILE_ID = (select id from nbur_ref_files where file_code='#D3')
            )
  loop 
     NBUR_FILES.SET_FILE_LOCAL ( k.kf, P_FILE_ID, k.file_path, k.nbuc, k.e_address);
  end loop;
  
  bc.home;
  
  NBUR_FILES.SET_FILE_PROC (P_PROC_ID, P_FILE_ID, 'O', 'Y', 'BARS',  'NBUR_P_F3KX_NC', 
        '3K XML-формат', 'v.18.001', TO_DATE('01/01/2018', 'MM/DD/YYYY'), NULL); 
        
  COMMIT; 
END; 
/
