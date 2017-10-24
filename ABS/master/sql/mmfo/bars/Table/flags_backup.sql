

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FLAGS_BACKUP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FLAGS_BACKUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FLAGS_BACKUP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FLAGS_BACKUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FLAGS_BACKUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FLAGS_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.FLAGS_BACKUP 
   (	CODE NUMBER, 
	NAME VARCHAR2(105), 
	EDIT NUMBER, 
	OPT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FLAGS_BACKUP ***
 exec bpa.alter_policies('FLAGS_BACKUP');


COMMENT ON TABLE BARS.FLAGS_BACKUP IS '';
COMMENT ON COLUMN BARS.FLAGS_BACKUP.CODE IS '';
COMMENT ON COLUMN BARS.FLAGS_BACKUP.NAME IS '';
COMMENT ON COLUMN BARS.FLAGS_BACKUP.EDIT IS '';
COMMENT ON COLUMN BARS.FLAGS_BACKUP.OPT IS '';



PROMPT *** Create  grants  FLAGS_BACKUP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FLAGS_BACKUP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FLAGS_BACKUP    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FLAGS_BACKUP    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FLAGS_BACKUP.sql =========*** End *** 
PROMPT ===================================================================================== 
