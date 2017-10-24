

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/D8_CUST_LINK_GROUPS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to D8_CUST_LINK_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''D8_CUST_LINK_GROUPS'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''D8_CUST_LINK_GROUPS'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table D8_CUST_LINK_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.D8_CUST_LINK_GROUPS 
   (	OKPO VARCHAR2(20), 
	LINK_GROUP NUMBER, 
	S_MAIN NUMBER, 
	LINK_CODE VARCHAR2(3), 
	GROUPNAME VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to D8_CUST_LINK_GROUPS ***
 exec bpa.alter_policies('D8_CUST_LINK_GROUPS');


COMMENT ON TABLE BARS.D8_CUST_LINK_GROUPS IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS.GROUPNAME IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS.OKPO IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS.LINK_GROUP IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS.S_MAIN IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS.LINK_CODE IS '';



PROMPT *** Create  grants  D8_CUST_LINK_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on D8_CUST_LINK_GROUPS to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on D8_CUST_LINK_GROUPS to START1;



PROMPT *** Create SYNONYM  to D8_CUST_LINK_GROUPS ***

  CREATE OR REPLACE PUBLIC SYNONYM D8_CUST_LINK_GROUPS FOR BARS.D8_CUST_LINK_GROUPS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/D8_CUST_LINK_GROUPS.sql =========*** E
PROMPT ===================================================================================== 
