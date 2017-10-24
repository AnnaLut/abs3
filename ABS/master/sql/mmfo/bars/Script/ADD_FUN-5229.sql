begin
update  BARS.OPERLIST
      set   FUNCNAME='/barsroot/sberutls/importproced.aspx\S*'
           where FUNCNAME = '/barsroot/sberutls/importproced.aspx';
end;		   
/
commit;	  