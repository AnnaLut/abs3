

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CA_SECT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CA_SECT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CA_SECT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CA_SECT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CA_SECT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CA_SECT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CA_SECT 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	OTD_RELATION NUMBER, 
	UPR_RELATION NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CA_SECT ***
 exec bpa.alter_policies('CA_SECT');


COMMENT ON TABLE BARS.CA_SECT IS '';
COMMENT ON COLUMN BARS.CA_SECT.ID IS '';
COMMENT ON COLUMN BARS.CA_SECT.NAME IS '';
COMMENT ON COLUMN BARS.CA_SECT.OTD_RELATION IS '';
COMMENT ON COLUMN BARS.CA_SECT.UPR_RELATION IS '';



PROMPT *** Create  grants  CA_SECT ***
grant SELECT                                                                 on CA_SECT         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CA_SECT.sql =========*** End *** =====
PROMPT ===================================================================================== 
