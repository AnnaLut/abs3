
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/gethostipadress.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETHOSTIPADRESS ( hname varchar2 ) RETURN varchar2
IS
  hostip    varchar2(16);
  hsname    varchar2(30);
  pos       number;

BEGIN

  hsname := hname;
  WHILE ascii(substr(hsname, -1)) = 0 LOOP
    hsname := substr(hsname, 1, length(hsname)-1);
  END LOOP;

  pos    := instr(hsname,'\');
  IF pos <> 0 THEN
       hsname := rtrim(upper(substr(hsname,pos+1,length(hsname)-(pos))));
  ELSE
       hsname := rtrim(upper(hsname));
  END IF;
  hostip := '';

  BEGIN
      SELECT ip INTO hostip FROM host_ip_adres WHERE upper(hostname)=hsname;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
          hostip := '';
  END;

  RETURN hostip;
END GetHostIpAdress;
 
/
 show err;
 
PROMPT *** Create  grants  GETHOSTIPADRESS ***
grant EXECUTE                                                                on GETHOSTIPADRESS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETHOSTIPADRESS to START1;
grant EXECUTE                                                                on GETHOSTIPADRESS to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/gethostipadress.sql =========*** En
 PROMPT ===================================================================================== 
 