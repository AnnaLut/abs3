--
-- COBUCDMCORP-71 (CIGPO )
--

begin
  
  update BARS.EBK_CARD_ATTRIBUTES
     set GROUP_ID       = 4
       , TYPE           = 'String'
       , REQUIRED       = 1
       , DESCR          = 'Статус зайнятості особи'
       , SORT_NUM       = 8
       , ACTION         = 'merge into customerw w using (select :p_rnk as rnk, :p_new_val as new_val, ''CIGPO'' as tag from dual) o on (w.rnk = o.rnk and w.tag= ''CIGPO'') when matched then update set w.value = :p_new_val when not matched then insert (w.rnk, w.tag, w.value, w.isp) values(o.rnk,o.tag,o.new_val,0)'
       , LIST_OF_VALUES = 'select kod as id, txt as name from CIG_D09'
       , PAGE_ITEM_VIEW = 'DropDown'
   where NAME = 'CIGPO';
  
  if ( sql%rowcount = 0 )
  then
    
    Insert into BARS.EBK_CARD_ATTRIBUTES
      ( NAME, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
      ( 'CIGPO', 4, 'String', 1, 'Статус зайнятості особи', 8
      , 'merge into customerw w using (select :p_rnk as rnk, :p_new_val as new_val, ''CIGPO'' as tag from dual) o on (w.rnk = o.rnk and w.tag= ''CIGPO'') when matched then update set w.value = :p_new_val when not matched then insert (w.rnk, w.tag, w.value, w.isp) values(o.rnk,o.tag,o.new_val,0)'
      , 'select kod as id, txt as name from CIG_D09', 'DropDown' );
    
  end if;
  
end;
/

COMMIT;

--
-- COBUCDMCORP-84 ( OKPO_EXCLUSION )
--

begin
  
  update BARS.EBK_CARD_ATTRIBUTES
     set GROUP_ID       = 1
       , TYPE           = 'String'
       , REQUIRED       = 0
       , DESCR          = 'Ознака виключення Ідент. Код / Код за ЕДРПОУ'
       , SORT_NUM       = 17
       , ACTION         = q'[begin kl.setCustomerElement( :p_rnk, 'EXCLN', :p_new_val, 0 ); end;]'
       , LIST_OF_VALUES = q'[select '0' as ID, 'Ні' as NAME from dual union select '1' as ID, 'Так' as NAME from dual]'
       , PAGE_ITEM_VIEW = 'DropDown'
   where NAME = 'OKPO_EXCLUSION';
  
  if ( sql%rowcount = 0 )
  then
    
    Insert 
      into BARS.EBK_CARD_ATTRIBUTES
         ( NAME, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
        ( 'OKPO_EXCLUSION', 1, 'String', 0, 'Ознака виключення Ідент. Код / Код за ЕДРПОУ', 17
        , q'[begin kl.setCustomerElement( :p_rnk, 'EXCLN', :p_new_val, 0 ); end;]'
        , q'[select '0' as ID, 'Ні' as NAME from dual union select '1' as ID, 'Так' as NAME from dual]', 'DropDown' );
        
  end if;
  
end;
/

COMMIT;

--
-- COBUCDMCORP-80 ( ACTUAL_DATE, EDDR_ID )
--

begin
  
  update BARS.EBK_CARD_ATTRIBUTES
     set GROUP_ID       = 1
       , TYPE           = 'Date'
       , REQUIRED       = 0
       , DESCR          = 'Дійсний до (для ID Card)'
       , SORT_NUM       = 30
       , ACTION         = q'[update PERSON set ACTUAL_DATE = to_date(:p_new_val,'dd.mm.yyyy') where RNK = :p_rnk]'
       , LIST_OF_VALUES = NULL
       , PAGE_ITEM_VIEW = 'Date'
   where NAME = 'ACTUAL_DATE';
  
  if ( sql%rowcount = 0 )
  then
    
    Insert 
      into BARS.EBK_CARD_ATTRIBUTES
         ( NAME, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
         ( 'ACTUAL_DATE', 1, 'Date', 0, 'Дійсний до (для ID Card)', 30
         , q'[update PERSON set ACTUAL_DATE = to_date(:p_new_val,'dd.mm.yyyy') where RNK = :p_rnk]'
         , NULL, 'Date' );
    
  end if;
  
end;
/

COMMIT;

begin
  
  update BARS.EBK_CARD_ATTRIBUTES
     set GROUP_ID       = 1
       , TYPE           = 'String'
       , REQUIRED       = 0
       , DESCR          = 'Унікальний номер запису ЄДДР'
       , SORT_NUM       = 31
       , ACTION         = 'update PERSON set EDDR_ID = :p_new_val where RNK = :p_rnk'
       , LIST_OF_VALUES = NULL
       , PAGE_ITEM_VIEW = 'String'
   where NAME = 'EDDR_ID';
  
  if ( sql%rowcount = 0 )
  then
    
    Insert 
      into BARS.EBK_CARD_ATTRIBUTES
         ( NAME, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
         ( 'EDDR_ID', 1, 'String', 0, 'String', 31
         , 'update PERSON set EDDR_ID = :p_new_val where RNK = :p_rnk'
         , NULL, 'String' );
    
  end if;
  
end;
/

COMMIT;
