
Prompt   update form_stru -порядок сортировки для показателей 3KX
BEGIN
    bc.home;

    update form_stru
       set CODE_SORT =2
     where kodf='3K' and natr =1;

    update form_stru
       set CODE_SORT =1
     where kodf='3K' and natr =2;

COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/
