

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CA_STAFF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CA_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CA_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CA_STAFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CA_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CA_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CA_STAFF 
   (	USERID NUMBER, 
	FIO VARCHAR2(70), 
	DEPT NUMBER, 
	UPR NUMBER, 
	OTD NUMBER, 
	SECT NUMBER, 
	PHONE VARCHAR2(10), 
	POSADA VARCHAR2(100), 
	BIRTHDAY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CA_STAFF ***
 exec bpa.alter_policies('CA_STAFF');


COMMENT ON TABLE BARS.CA_STAFF IS '';
COMMENT ON COLUMN BARS.CA_STAFF.BIRTHDAY IS '';
COMMENT ON COLUMN BARS.CA_STAFF.USERID IS '';
COMMENT ON COLUMN BARS.CA_STAFF.FIO IS '';
COMMENT ON COLUMN BARS.CA_STAFF.DEPT IS '';
COMMENT ON COLUMN BARS.CA_STAFF.UPR IS '';
COMMENT ON COLUMN BARS.CA_STAFF.OTD IS '';
COMMENT ON COLUMN BARS.CA_STAFF.SECT IS '';
COMMENT ON COLUMN BARS.CA_STAFF.PHONE IS '';
COMMENT ON COLUMN BARS.CA_STAFF.POSADA IS '';



PROMPT *** Create  grants  CA_STAFF ***
grant SELECT                                                                 on CA_STAFF        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CA_STAFF.sql =========*** End *** ====
PROMPT ===================================================================================== 
