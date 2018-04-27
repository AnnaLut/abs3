begin
    UPDATE meta_columns
      SET SHOWFORMAT = REPLACE (SHOWFORMAT, '9', '0')
    WHERE SHOWFORMAT like '%#9%';
end;
/
commit;