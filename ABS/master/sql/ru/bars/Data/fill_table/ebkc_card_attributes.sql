--
-- COBUCDMCORP-80
--

-- MOBILE_PHONE

begin
  
  update BARS.EBKC_CARD_ATTRIBUTES
     set CUST_TYPE      = 'P'
       , GROUP_ID       = 2
       , TYPE           = 'String'
       , REQUIRED       = 0
       , DESCR          = 'Мобільний телефон'
       , SORT_NUM       = 59
       , ACTION         = 'merge into customerw w using (select :p_rnk as rnk, :p_new_val as new_val, ''MPNO'' as tag from dual) o on (w.rnk = :p_rnk and w.tag= ''MPNO'') when matched then update set w.value = :p_new_val when not matched then insert (w.rnk, w.tag, w.value, w.isp) values(o.rnk,o.tag,o.new_val,0)'
       , LIST_OF_VALUES = NULL
       , PAGE_ITEM_VIEW = 'String'
   where NAME = 'MOBILE_PHONE';
  
  if ( sql%rowcount = 0 )
  then
    
    Insert
      into BARS.EBKC_CARD_ATTRIBUTES
         ( NAME, CUST_TYPE, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
         ( 'MOBILE_PHONE', 'P', 2, 'String', 0, 'Мобільний телефон', 59
         , 'merge into customerw w using (select :p_rnk as rnk, :p_new_val as new_val, ''MPNO'' as tag from dual) o on (w.rnk = :p_rnk and w.tag= ''MPNO'') when matched then update set w.value = :p_new_val when not matched then insert (w.rnk, w.tag, w.value, w.isp) values(o.rnk,o.tag,o.new_val,0)'
         , NULL, 'String' );
    
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
       , REQUIRED       = 1
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

begin
  
  update BARS.EBKC_CARD_ATTRIBUTES
     set CUST_TYPE      = 'P'
       , GROUP_ID       = 1
       , TYPE           = 'String'
       , REQUIRED       = 1
       , DESCR          = 'Ознака виключення Ідент. Код / Код за ЕДРПОУ'
       , SORT_NUM       = 17
       , ACTION         = q'[begin kl.setCustomerElement( :p_rnk, 'EXCLN', :p_new_val, 0 ); end;]'
       , LIST_OF_VALUES = q'[select '0' as ID, 'Ні' as NAME from dual union select '1' as ID, 'Так' as NAME from dual]'
       , PAGE_ITEM_VIEW = 'DropDown'
   where NAME = 'OKPO_EXCLUSION';
  
  if ( sql%rowcount = 0 )
  then
    
    Insert 
      into BARS.EBKC_CARD_ATTRIBUTES
         ( NAME, CUST_TYPE, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
        ( 'OKPO_EXCLUSION', 'P', 1, 'String', 0, 'Ознака виключення Ідент. Код / Код за ЕДРПОУ', 17
        , q'[begin kl.setCustomerElement( :p_rnk, 'EXCLN', :p_new_val, 0 ); end;]'
        , q'[select '0' as ID, 'Ні' as NAME from dual union select '1' as ID, 'Так' as NAME from dual]', 'DropDown' );
        
  end if;
  
end;
/

COMMIT;

-- K030

begin
  
  update BARS.EBKC_CARD_ATTRIBUTES
     set CUST_TYPE      = 'P'
       , GROUP_ID       = 1
       , TYPE           = 'String'
       , REQUIRED       = 1
       , DESCR          = 'Резидентність (К030)'
       , SORT_NUM       = 0
       , ACTION         = 'update CUSTOMER c set c.CODCAGENT = (select a.CODCAGENT from CODCAGENT a where a.REZID = to_number(:p_new_val) and a.CODCAGENT = (c.CUSTTYPE*2) - mod(a.CODCAGENT,2)) where c.RNK = :p_rnk'
       , LIST_OF_VALUES = 'select to_char(REZID) as ID, NAME from REZID'
       , PAGE_ITEM_VIEW = 'DropDown'
   where NAME = 'K030';
  
  if ( sql%rowcount = 0 )
  then
    
    Insert
      into BARS.EBKC_CARD_ATTRIBUTES
         ( NAME, CUST_TYPE, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
         ( 'K030', 'L', 1, 'String', 1, 'Резидентність (К030)', 0
         , 'update CUSTOMER c set c.CODCAGENT = (select a.CODCAGENT from CODCAGENT a where a.REZID = to_number(:p_new_val) and a.CODCAGENT = (c.CUSTTYPE*2) - mod(a.CODCAGENT,2)) where c.RNK = :p_rnk'
         , 'select to_char(REZID) as ID, NAME from REZID', 'DropDown' );
    
  end if;
  
end;
/

COMMIT;

-- ACTUAL_DATE

begin
  
  update BARS.EBKC_CARD_ATTRIBUTES
     set CUST_TYPE      = 'P'
       , GROUP_ID       = 1
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
      into BARS.EBKC_CARD_ATTRIBUTES
         ( NAME, CUST_TYPE, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
         ( 'ACTUAL_DATE', 'P', 1, 'Date', 0, 'Дійсний до (для ID Card)', 30
         , q'[update PERSON set ACTUAL_DATE = to_date(:p_new_val,'dd.mm.yyyy') where RNK = :p_rnk]'
         , NULL, 'Date' );
    
  end if;
  
end;
/

COMMIT;

-- EDDR_ID

begin
  
  update BARS.EBKC_CARD_ATTRIBUTES
     set CUST_TYPE      = 'P'
       , GROUP_ID       = 1
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
      into BARS.EBKC_CARD_ATTRIBUTES
         ( NAME, CUST_TYPE, GROUP_ID, TYPE, REQUIRED, DESCR, SORT_NUM, ACTION, LIST_OF_VALUES, PAGE_ITEM_VIEW )
    Values
         ( 'EDDR_ID', 'P', 1, 'String', 0, 'String', 31
         , 'update PERSON set EDDR_ID = :p_new_val where RNK = :p_rnk'
         , NULL, 'String' );
    
  end if;
  
end;
/

COMMIT;
