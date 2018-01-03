CREATE OR REPLACE PACKAGE "PKG_CONTEXT" IS

PROCEDURE set_ctx(p_name in VARCHAR2, p_value in VARCHAR2);
--PROCEDURE get_ctx (p_name in VARCHAR2, p_value out VARCHAR2);
FUNCTION get_ctx ( p_name in VARCHAR2 ) RETURN VARCHAR2;
procedure clear_context (p_client_id in varchar2); 
END;

 
 
 
/
CREATE OR REPLACE PACKAGE BODY "PKG_CONTEXT" IS


--===============================================
PROCEDURE set_ctx(p_name in VARCHAR2, p_value in VARCHAR2) IS
BEGIN
  dbms_session.set_context('User_ctx',p_name,p_value,user,substr(sys_context('userenv', 'client_identifier'), 1, 64));
END set_ctx;
--===============================================
/*PROCEDURE get_ctx (p_name in VARCHAR2, p_value out VARCHAR2)
is
begin
     sys.dbms_session.set_identifier(user);
     p_value:= sys_context('User_ctx',p_name); 
end; */


 FUNCTION get_ctx ( p_name in VARCHAR2 ) RETURN VARCHAR2
   IS
   BEGIN
    --  sys.dbms_session.set_identifier(user);
      RETURN sys_context('User_ctx',p_name); 
   END;
   
  procedure clear_context (p_client_id in varchar2) is
  begin
  sys.dbms_session.clear_context('User_ctx', p_client_id);
  end;    

END;
/
