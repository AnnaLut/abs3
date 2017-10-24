declare ff ACCOUNTS_FIELD%rowtype;
begin   SUDA;
   ff.USE_IN_ARCH  := 0;

   ff.tag  := 'TERM_LIM'      ;      ff.name := 'День міс.перегляду ліміту(КБ=20,ММСБ=10)';
   update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

   ff.tag  := 'NOT_ZAL'       ;      ff.name := 'Угода без забеспечення';
   update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

   ff.tag  := 'DEL_LIM'      ;       ff.name := 'Max допустимий % відхилення нового ліміту від попереднього';
   update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

   ff.tag  := 'EXIT_ZN'      ;       ff.name := 'Тільки Ручний вихід із "сірої" =1';
   update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;
   commit;
----------------------------------------
   bc.go('322669'); insert into accountsw (ACC, TAG, VALUE)  select acc, 'TERM_LIM', 10  from accounts A  where tip ='OVN' 
                                                             AND NOT EXISTS (SELECT 1 FROM  accountsw WHERE ACC = A.ACC AND TAG = 'TERM_LIM' ) ;

                    insert into accountsw (ACC, TAG, VALUE)  select acc, 'EXIT_ZN',  1   from accounts a where tip ='OVN'
                                                             AND NOT EXISTS (SELECT 1 FROM  accountsw WHERE ACC = A.ACC AND TAG = 'EXIT_ZN' ) ;

                    insert into accountsw (ACC, TAG, VALUE)  select acc, 'DEL_LIM',  0   from accounts a  where tip ='OVN'
                                                             AND NOT EXISTS (SELECT 1 FROM  accountsw WHERE ACC = A.ACC AND TAG = 'DEL_LIM' ) ;

   bc.go('300465'); insert into accountsw (ACC, TAG, VALUE)  select acc, 'TERM_LIM', 20  from accounts A where tip ='OVN'
                                                             AND NOT EXISTS (SELECT 1 FROM  accountsw WHERE ACC = A.ACC AND TAG = 'TERM_LIM' ) ;

                    insert into accountsw (ACC, TAG, VALUE)  select acc, 'EXIT_ZN',  0   from accounts A where tip ='OVN'
                                                             AND NOT EXISTS (SELECT 1 FROM  accountsw WHERE ACC = A.ACC AND TAG = 'EXIT_ZN' ) ;

                    insert into accountsw (ACC, TAG, VALUE)  select acc, 'DEL_LIM',  10  from accounts A where tip ='OVN'
                                                             AND NOT EXISTS (SELECT 1 FROM  accountsw WHERE ACC = A.ACC AND TAG = 'DEL_LIM' ) ;
SUDA;
end;
/

commit ;
