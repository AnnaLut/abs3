
BEGIN
  -- создать копию таблицы, перед изменением данных
  EXECUTE IMMEDIATE 'CREATE TABLE tmp_VIP_FLAGS AS SELECT * FROM VIP_FLAGS';
  -- изменить неправильные значения кодов менеджеров
  FOR vip_rec IN (SELECT DISTINCT vip.mfo
                    FROM bars.VIP_FLAGS     vip)
  LOOP
    bc.go(vip_rec.mfo);
    UPDATE bars.VIP_FLAGS mvip
       SET mvip.account_manager =
           (SELECT au.user_id
              FROM bars.staff_ad_user au
             WHERE upper(regexp_substr(mvip.mail_manager
                                      ,'[^@]+')) =
                   regexp_substr(au.active_directory_name
                                ,'[^\]+$')
            )
     WHERE mvip.account_manager IS NOT NULL;    
  END LOOP;
  COMMIT;
END;
/