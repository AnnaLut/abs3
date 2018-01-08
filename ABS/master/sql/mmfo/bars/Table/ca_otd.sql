

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CA_OTD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CA_OTD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CA_OTD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CA_OTD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CA_OTD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CA_OTD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CA_OTD 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	UPR_RELATION NUMBER, 
	DEPT_RELATION NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CA_OTD ***
 exec bpa.alter_policies('CA_OTD');


COMMENT ON TABLE BARS.CA_OTD IS '';
COMMENT ON COLUMN BARS.CA_OTD.ID IS '';
COMMENT ON COLUMN BARS.CA_OTD.NAME IS '';
COMMENT ON COLUMN BARS.CA_OTD.UPR_RELATION IS '';
COMMENT ON COLUMN BARS.CA_OTD.DEPT_RELATION IS '';



PROMPT *** Create  grants  CA_OTD ***
grant SELECT                                                                 on CA_OTD          to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CA_OTD.sql =========*** End *** ======
PROMPT ===================================================================================== 
