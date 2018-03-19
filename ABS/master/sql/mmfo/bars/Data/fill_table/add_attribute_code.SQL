BEGIN
   bc.home;
   branch_attribute_utl.add_new_attribute_with_set(
                                                    'REPORT_CORPLIGHT_URL'
                                                  , 'URL web сервіса CorpLight (н-д: https://tbarsweb-00-01.oschadbank.ua:44302/barsroot/api/)'
                                                  , 'C'
                                                  , NULL
                                                  , NULL
                                                  , '/'
                                                  , 'https://tbarsweb-00-01.oschadbank.ua:44302/barsroot/api/' );
END;
/

COMMIT;
