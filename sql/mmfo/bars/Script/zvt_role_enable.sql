prompt Enabling foreign key constraints for ZVT_ROLE...
alter table ZVT_ROLE enable constraint FK_ZVTROLE_DEPARTMENT_ID;
alter table ZVT_ROLE enable constraint FK_ZVTROLE_ROLE_ID;
alter table ZVT_ROLE enable constraint FK_ZVTROLE_SECTOR_ID;
alter table ZVT_ROLE enable constraint FK_ZVTROLE_TEAM_ID;