---------------------------------------------------------------------------
--                     COBUMMFO-10587
--  Включение доп.реквизита D1#3M "Код мети для файлу 3МХ" в GO8                              
--------------------------------------------------------------------------

begin
  insert into op_rules(TAG,     TT  , OPT, USED4INPUT, ORD, VAL ,  NOMODIFY)
             values   ('D1#3M', 'GO8', 'O',  1,        13 , null , null    );
exception WHEN OTHERS THEN 
  update op_rules set  OPT='O', USED4INPUT=1, ORD=13, VAL=null  where TT='GO8' and TAG='D1#3M';
end;
/
commit;

