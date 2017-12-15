BEGIN 
  update DPT_IMMOBILE_OB22
  set ob22 = 'D3'
  where r020 = '2635';
END;
/
commit;
