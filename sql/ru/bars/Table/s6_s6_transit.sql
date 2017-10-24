

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_TRANSIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_TRANSIT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_TRANSIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_TRANSIT 
   (	BALS VARCHAR2(4), 
	KV NUMBER(3,0), 
	TRANSIT NUMBER(14,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_TRANSIT ***
 exec bpa.alter_policies('S6_S6_TRANSIT');


COMMENT ON TABLE BARS.S6_S6_TRANSIT IS '';
COMMENT ON COLUMN BARS.S6_S6_TRANSIT.BALS IS '';
COMMENT ON COLUMN BARS.S6_S6_TRANSIT.KV IS '';
COMMENT ON COLUMN BARS.S6_S6_TRANSIT.TRANSIT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_TRANSIT.sql =========*** End ***
PROMPT ===================================================================================== 
