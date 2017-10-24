begin
UPDATE cc_tag t
   SET t.tagtype = 'CCK', t.type = 'N', t.code = 'ADD',t.name='Δελόςΰ 9129'
 WHERE t.tag = 'D9129';
end;
/
commit;
