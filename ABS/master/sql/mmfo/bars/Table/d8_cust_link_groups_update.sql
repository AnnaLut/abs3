

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/D8_CUST_LINK_GROUPS_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to D8_CUST_LINK_GROUPS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''D8_CUST_LINK_GROUPS_UPDATE'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''D8_CUST_LINK_GROUPS_UPDATE'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''D8_CUST_LINK_GROUPS_UPDATE'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table D8_CUST_LINK_GROUPS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.D8_CUST_LINK_GROUPS_UPDATE 
   (	OKPO VARCHAR2(14), 
	LINK_GROUP NUMBER, 
	S_MAIN NUMBER, 
	LINK_CODE VARCHAR2(3), 
	CHGDATE DATE, 
	CHGACTION VARCHAR2(1), 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER(38,0), 
	EFFECTDATE DATE, 
	GLOBALBD DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to D8_CUST_LINK_GROUPS_UPDATE ***
 exec bpa.alter_policies('D8_CUST_LINK_GROUPS_UPDATE');


COMMENT ON TABLE BARS.D8_CUST_LINK_GROUPS_UPDATE IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.OKPO IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.LINK_GROUP IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.S_MAIN IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.LINK_CODE IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.D8_CUST_LINK_GROUPS_UPDATE.GLOBALBD IS '';



PROMPT *** Create  grants  D8_CUST_LINK_GROUPS_UPDATE ***
grant DELETE,INSERT                                                          on D8_CUST_LINK_GROUPS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on D8_CUST_LINK_GROUPS_UPDATE to BARS_DM;
grant DELETE,INSERT                                                          on D8_CUST_LINK_GROUPS_UPDATE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/D8_CUST_LINK_GROUPS_UPDATE.sql =======
PROMPT ===================================================================================== 
