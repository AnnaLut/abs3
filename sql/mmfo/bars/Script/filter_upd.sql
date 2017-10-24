begin
UPDATE dyn_filter t
   SET t.branch = '/'
 WHERE t.where_clause LIKE
       '%(%$~~ALIAS~~$.nd%IN%(select%nd%from%nd_acc%d,%accounts%a%where%d.acc=a.acc%and%a.tip=''SG ''%and%a.ostc<>0%)%)%';
end;
/
commit;
