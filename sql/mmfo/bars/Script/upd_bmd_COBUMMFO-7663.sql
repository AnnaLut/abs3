begin
  -- bmd 'тл. гАЁЦ оео аюгнбхи'
  update operlist 
     set funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=V_FINMON_PUBLIC_CUSTOMERS'
   where funcname = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1'||chr(38)||'sPar=FINMON_PUBLIC_CUSTOMERS';
  commit;
end;
/
