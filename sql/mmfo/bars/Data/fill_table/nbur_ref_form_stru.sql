SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

---------
-- #01 --
---------

declare
  l_file_id   nbur_ref_files.id%type;
begin
  
  l_file_id := NBUR_FILES.GET_FILE_ID('#01');
  
  NBUR_FILES.SET_FILE_STC
  ( p_file_id       => l_file_id
  , p_seg_num       => 1
  , p_seg_code      => 'DD'
  , p_seg_nm        => 'Тип~залишку'
  , p_seg_rule      => 'substr(kodp,1,2)'
  , p_key_attr      => 1
  , p_sort_attr     => 1
  );

  NBUR_FILES.SET_FILE_STC
  ( p_file_id       => l_file_id
  , p_seg_num       => 2
  , p_seg_code      => 'BBBB'
  , p_seg_nm        => 'Балансовий~рахунок~R020'
  , p_seg_rule      => 'substr(kodp,3,4)'
  , p_key_attr      => 1
  , p_sort_attr     => 2
  );

  NBUR_FILES.SET_FILE_STC
  ( p_file_id       => l_file_id
  , p_seg_num       => 3
  , p_seg_code      => 'VVV'
  , p_seg_nm        => 'Код~валюти~R030'
  , p_seg_rule      => 'substr(kodp,7,3)'
  , p_key_attr      => 1
  , p_sort_attr     => 3
  );

  NBUR_FILES.SET_FILE_STC
  ( p_file_id       => l_file_id
  , p_seg_num       => 4
  , p_seg_code      => 'R'
  , p_seg_nm        => 'Резиден~тність~K030'
  , p_seg_rule      => 'substr(kodp,10,1)'
  , p_key_attr      => 1
  , p_sort_attr     => 4
  );

  NBUR_FILES.SET_FILE_STC
  ( p_file_id       => l_file_id
  , p_seg_num       => 5
  , p_seg_code      => 'VALUE'
  , p_seg_nm        => 'Значення~показника'
  , p_seg_rule      => 'ZNAP'
  , p_key_attr      => 0
  , p_sort_attr     => null
  );

  NBUR_FILES.SET_FILE_VIEW( l_file_id );

end;
/

commit;
