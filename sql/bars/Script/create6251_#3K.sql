Prompt     CREATE FILE #3K    for 3KX

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
    delete from kl_f00$LOCAL where kodf=kodf_;  
    delete from kl_f00$GLOBAL where kodf=kodf_;

    select count(*) 
     into kol_ 
    from kl_f00$GLOBAL 
    where kodf=kodf1_ and a017 in ('C','G','D');

    if kol_ <> 0 then

          begin
             select procc
              into id_
             from rep_proc
             where name = 'P_F3KX_NC'; 
          exception when no_data_found then
             select max(to_number(PROCC)) + 1 
             into id_ 
             from rep_proc;

             insert into rep_proc
             values (to_char(id_),'P_F3KX_NC', 
                     'Дані про купівлю, продаж безготівкової іноземної валюти');
          end;

         Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, PROCC, R, SEMANTIC, KODF_EXT, F_PREF, PR_TOBO, TYPE_ZNAP)
             select  kodf_, AA, A017, '11', PERIOD, id_, R, 'xml Дані про купівлю, продаж безготівкової іноземної валюти', KODF_EXT, F_PREF, PR_TOBO, TYPE_ZNAP
               from kl_f00$GLOBAL 
              where kodf=kodf1_ and a017 in ('C','G','D');

    end if;

    commit;

---  #3K файл
--    bc.home;
        insert into kl_f00$LOCAL(POLICY_GROUP, BRANCH, KODF, A017, UUU, ZZZ, PATH_O, DATF, NOM) 
        select POLICY_GROUP, branch, kodf_, a017, uuu, zzz, path_o, TO_DATE('01/01/2018','DD/MM/YYYY'), '1'
        from kl_f00$LOCAL
        where kodf=kodf1_ and a017 in ('C','G','D');

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


begin

bc.home;

DELETE FROM FORM_STRU WHERE KODF='3K' ;

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3K', 1, 'Код xml~показника', 'substr(kodp,1,4)', '1', 1, 'C'); 
INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3K', 2, 'Умовний~порядковий~номер', 'substr(kodp,5,3)', '1', 2, 'C'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3K', 3, 'Значення~показника', 'znap', '0', NULL, 'C'); 

commit;
 
end;
/
