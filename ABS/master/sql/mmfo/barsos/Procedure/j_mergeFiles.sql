create or replace procedure j_mergeFiles( p_dirPath in varchar2, p_mask in varchar2, p_mergedFileName in varchar2 )
as language java
name 'MergeFiles.merge(java.lang.String, java.lang.String, java.lang.String)';