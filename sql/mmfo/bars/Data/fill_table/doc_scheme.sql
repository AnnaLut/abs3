SET DEFINE OFF;

exec bc.home;

begin
  insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
  values ('WB_CREATE_DEPOSIT', 'гюъбйю опн б╡дйпхрръ деонгхрс вепег ныюд 24/7', 0, null, null,null, null, null, 1, 'WB_CREATE_DEPOSIT.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='гюъбйю опн б╡дйпхрръ деонгхрс вепег ныюд 24/7', FILE_NAME='WB_CREATE_DEPOSIT.frx' where id ='WB_CREATE_DEPOSIT';
end;
/

begin
  insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
  values ('WB_DENY_AUTOLONGATION', 'гюъбйю опн б╡длнбс б╡д юбрнлюрхвмн╞ опнцнкнмцюж╡╞ деонгхрс вепег ныюд 24/7', 0, null, null,null, null, null, 1, 'WB_DENY_AUTOLONGATION.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='гюъбйю опн б╡длнбс б╡д юбрнлюрхвмн╞ опнцнкнмцюж╡╞ деонгхрс вепег ныюд 24/7', FILE_NAME='WB_DENY_AUTOLONGATION.frx' where id ='WB_DENY_AUTOLONGATION';
end; 
/

begin
  insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
  values ('WB_CHANGE_ACCOUNT', 'гюъбйю опн гл╡мс пюусмйс бхокюрх р╡кю рю б╡дянрй╡б он деонгхрс вепег ныюд 24/7', 0, null, null,null, null, null, 1, 'WB_CHANGE_ACCOUNT.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='гюъбйю опн гл╡мс пюусмйс бхокюрх р╡кю рю б╡дянрй╡б он деонгхрс вепег ныюд 24/7', FILE_NAME='WB_CHANGE_ACCOUNT.frx' where id ='WB_CHANGE_ACCOUNT';
end;
/

commit;

begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_NLS_P', 'лляа гЮЪБЮ МЮ БЁДЙП. ПЮУ. тно', 0, 0 );
exception
  when dup_val_on_index then
    update DOC_SCHEME
       set NAME = 'лляа гЮЪБЮ МЮ БЁДЙП. ПЮУ. тно'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_NLS_P';
end;
/

begin
  Insert into DOC_SCHEME ( ID, NAME, PRINT_ON_BLANK, FR )
  Values ( 'RSRV_ACC_NLS_L', 'лляа гЮЪБЮ МЮ БЁДЙП. ПЮУ. чн', 0, 0 );
exception
  when dup_val_on_index then 
    update DOC_SCHEME
       set NAME = 'лляа гЮЪБЮ МЮ БЁДЙП. ПЮУ. чн'
         , PRINT_ON_BLANK = 0
         , FR = 0
     where ID = 'RSRV_ACC_NLS_L';
end;
/

COMMIT;