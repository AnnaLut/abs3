 begin
      update  BARS.OP_FIELD set BROWSER=' TagBrowse("SELECT F090,txt FROM F090 order by F090")' where tag='D1#3M';
 end;
 /
 commit;