
Prompt   update nbur_ref_files -������ ����� view ��� ��������� �� �����
BEGIN
    bc.home;

    update nbur_ref_files
       set view_nm ='V_NBUR_3KX'
     where file_code='#3K';

COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/
