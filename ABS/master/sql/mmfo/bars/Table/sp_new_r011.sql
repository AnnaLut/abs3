

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_NEW_R011.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_NEW_R011 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_NEW_R011'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_NEW_R011'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_NEW_R011'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_NEW_R011 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_NEW_R011 
   (	R020 CHAR(4), 
	R020R011 CHAR(4), 
	R011 CHAR(1), 
	R011_2 CHAR(1), 
	S181 CHAR(1), 
	TXT VARCHAR2(192), 
	PR_RED CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_NEW_R011 ***
 exec bpa.alter_policies('SP_NEW_R011');


COMMENT ON TABLE BARS.SP_NEW_R011 IS 'Классификатор параметра R011 (SP_NEW_R011)';
COMMENT ON COLUMN BARS.SP_NEW_R011.R020 IS '';
COMMENT ON COLUMN BARS.SP_NEW_R011.R020R011 IS '';
COMMENT ON COLUMN BARS.SP_NEW_R011.R011 IS '';
COMMENT ON COLUMN BARS.SP_NEW_R011.R011_2 IS '';
COMMENT ON COLUMN BARS.SP_NEW_R011.S181 IS '';
COMMENT ON COLUMN BARS.SP_NEW_R011.TXT IS '';
COMMENT ON COLUMN BARS.SP_NEW_R011.PR_RED IS '';



PROMPT *** Create  grants  SP_NEW_R011 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_NEW_R011     to ABS_ADMIN;
grant SELECT                                                                 on SP_NEW_R011     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_NEW_R011     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_NEW_R011     to BARS_DM;
grant SELECT                                                                 on SP_NEW_R011     to START1;
grant SELECT                                                                 on SP_NEW_R011     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_NEW_R011     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_NEW_R011.sql =========*** End *** =
PROMPT ===================================================================================== 
