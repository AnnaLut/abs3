

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAPROS_USERS_COPY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAPROS_USERS_COPY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAPROS_USERS_COPY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAPROS_USERS_COPY 
   (	KODZ NUMBER, 
	USER_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAPROS_USERS_COPY ***
 exec bpa.alter_policies('ZAPROS_USERS_COPY');


COMMENT ON TABLE BARS.ZAPROS_USERS_COPY IS '';
COMMENT ON COLUMN BARS.ZAPROS_USERS_COPY.KODZ IS '';
COMMENT ON COLUMN BARS.ZAPROS_USERS_COPY.USER_ID IS '';



PROMPT *** Create  grants  ZAPROS_USERS_COPY ***
grant SELECT                                                                 on ZAPROS_USERS_COPY to BARSREADER_ROLE;
grant SELECT                                                                 on ZAPROS_USERS_COPY to BARS_DM;
grant SELECT                                                                 on ZAPROS_USERS_COPY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAPROS_USERS_COPY.sql =========*** End
PROMPT ===================================================================================== 
