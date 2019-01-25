PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_EQUIP_USERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_EQUIP_USERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_EQUIP_USERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_EQUIP_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_EQUIP_USERS 
   (	EQUIP_REF NUMBER, 
	USERROLE VARCHAR2(10), 
	USERLOGIN VARCHAR2(20), 
	USERPASSW VARCHAR2(20), 
	POSITION VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_EQUIP_USERS ***
 exec bpa.alter_policies('TELLER_EQUIP_USERS');


COMMENT ON TABLE BARS.TELLER_EQUIP_USERS IS '';
COMMENT ON COLUMN BARS.TELLER_EQUIP_USERS.EQUIP_REF IS '';
COMMENT ON COLUMN BARS.TELLER_EQUIP_USERS.USERROLE IS '';
COMMENT ON COLUMN BARS.TELLER_EQUIP_USERS.USERLOGIN IS '';
COMMENT ON COLUMN BARS.TELLER_EQUIP_USERS.USERPASSW IS '';
COMMENT ON COLUMN BARS.TELLER_EQUIP_USERS.POSITION IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_EQUIP_USERS.sql =========*** En
PROMPT ===================================================================================== 
